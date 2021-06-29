#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <SDL.h>
#include "SDL2_gif.h"
#include "SDL2_gifrwtypes.h"
#include "SDL2_gifDecomp.h"
#include "SDL2_gifToSurface.h"



CEV_gifFile *CEV_LoadGIF_RW(SDL_RWops* file)
{/*create gif handler*/


    CEV_gifFile *gif = NULL;

    unsigned char
                endOfFile=0;

    readWriteErr = 0;

    /*creating new gif structure*/
    gif = CEV_newGif();

    if (!gif)
    {/*on error*/
        fprintf(stderr,"Err / CEV_LoadGIF : unable to create gif structure.\n");
        goto err1;
    }

    CEV_GifFillHeader_RW(&gif->header, file);  /*Mandatory / function checked*/
    CEV_GifFillLSD_RW(&gif->lsd, file);        /*Mandatory / function checked*/

    /*Global color table reading*/
    if (gif->lsd.packField.usesGlobalColor)
        CEV_GifFillColorTab_RW(gif->lsd.packField.numOfColors, &gif->globalColor, file);    /*function checked*/



    while(!endOfFile && !readWriteErr)
    {
        uint8_t dataType = SDL_Readu8(file);

        switch(dataType)
        {/*switch next data type*/

            case 0x21 : /*file extensions*/
                CEV_GifFillExt_RW(gif, file);
            break;

            case 0x2C : /*Image Descriptor*/
                CEV_GifNewImg_RW(gif, file);
            break;

            case 0x3B :/*EOF*/
                endOfFile = 1;
            break;

            default :
                fprintf(stderr,"Err / CEV_LoadGif : Unexpected value :%d\n", dataType);
                readWriteErr++;
            break;
        }
    }

err1:
/* TODO (cedric#1#): verifier si pas doublon avec le free de mon buffer fichier (voir revolver) */
    SDL_FreeRW(file);

    return gif;
}


int CEV_GifFillExt_RW(CEV_gifFile *gif, SDL_RWops* file)
{/*fills misc extension blocks*/

    switch(SDL_Readu8(file))
    {/*switch file extension type*/

        case 0xf9 : /*Graphics Control Extension*/
            CEV_GifFillGCE_RW(&gif->gce, file);/*vérifié*/
        break;

        /* TODO (cedric#1#): eventually to be taken into consideration but why ? */
        case 0x01 :/*Plain Text extension*/
        case 0xff :/*Application Extension*/
            CEV_GifBlockSkip_RW(file);
        break;

        case 0xfe :/*Comment Extension*/
            CEV_GifFillComExt_RW(&gif->comExt, file);
        break;

        default :
            fprintf(stderr,"Err / CEV_GifFillExt : Unknow file extension type has occured\n");
        break;
    }


    if(readWriteErr)
        fprintf(stderr,"CEV_GifFillExt : W/R error occured.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}

void CEV_GifNewImg_RW(CEV_gifFile *gif, SDL_RWops* file)
{/*allocate and fills image information*/

    int frameIndex = gif->imgNum;/*rw purpose*/

    /*temporay image data*/
    CEV_gifImage *temp = NULL;

    /*one more frame to come*/
    gif->imgNum ++;

    temp = realloc(gif->image, gif->imgNum * sizeof(CEV_gifImage));

    if (temp)
        gif->image = temp;
    else
    {/*on error*/
        fprintf(stderr, "Err / CEV_GifNewImg_RW : unable to allocate :%s\n", strerror(errno));
        gif->imgNum --;
        return;
    }

    if(gif->gce.used)
    {/*if graphic Control Extension was read before*/
        gif->image[frameIndex].control = gif->gce; /*store into new picture*/
    }

    /*fills Image Descriptor*/
    CEV_GifFillID_RW(&gif->image[frameIndex].descriptor, file);

    if (gif->image[frameIndex].descriptor.imgPack.usesLocalColor)
    {/*if there is a local color table*/
        CEV_GifFillColorTab_RW(gif->image[frameIndex].descriptor.imgPack.colorTabSize, &gif->image[frameIndex].localColor, file);
    }
    else
    {/*default values*/
        gif->image[frameIndex].localColor.numOfColors    = 0;
        gif->image[frameIndex].localColor.table          = NULL;
    }

    /*restores raw data into pixels table*/
    CEV_GifFillData_RW(gif, file);
}



void CEV_GifFillData_RW(CEV_gifFile *gif, SDL_RWops* file)
{/*read raw data sublock and send it thru lzw decompression*/

    uint8_t
            *rawData    = NULL, /*data field only*/
            *temp       = NULL; /*temporary*/

    unsigned char
                LZWminiCodeSize = 0, /*min code size*/
                subBlockSize    = 0; /*size of data sub block*/

    size_t rawDataSize = 0; /*raw data full size in bytes*/

    LZWminiCodeSize = SDL_Readu8(file);

    while((subBlockSize = SDL_Readu8(file)) && !readWriteErr) /*a size of 0 means no data to follow*/
    {/*fill rawData with subBlocks datas*/

        temp = realloc(rawData, rawDataSize + subBlockSize);/*alloc/realloc volume for new datas*/

        if (temp)/*realloc is ok*/
            rawData = temp;
        else
        {/*on error*/
            fprintf(stderr, "Err / CEV_fillImgData : realloc error. %s\n", strerror(errno));
            goto err;
        }

        /*fetch datas from SDL_RWops*/
        SDL_RWread(file, &rawData[rawDataSize], 1, subBlockSize);

        rawDataSize +=  subBlockSize;   /*increase datasize by blocksize*/
    }
    /*pass data through lzw decomp*/
    CEV_GifLzw(rawData, gif, LZWminiCodeSize);

err :
    free(rawData);
}


int CEV_GifFillHeader_RW(CEV_gifHeader* header, SDL_RWops* file)
{/*fills header**/

    int i;

    for(i=0; i<3; i++)
        header->signature[i] = SDL_Readu8(file);

    for(i=0; i<3; i++)
        header->version[i] = SDL_Readu8(file);


    header->signature[3] = header->version[3] = '\0';

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Header.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


int CEV_GifFillComExt_RW(CEV_gifComExt *ext, SDL_RWops* file)
{/*fills comment extension*/

    uint8_t temp;

    temp = SDL_Readu8(file);
    temp+=1;

    ext->text = malloc(temp * sizeof(char));
    if(ext->text == NULL)
        return FUNC_ERR;

    if(SDL_RWread(file, ext->text, 1, temp) != temp)

        readWriteErr++;

    ext->text[temp]='\0';

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Comment Extention.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


int CEV_GifFillLSD_RW(CEV_gifLSD* lsd, SDL_RWops* file)
{/*fills Logical Screen Descriptor*/

    uint8_t temp;

    lsd->width  = SDL_ReadLE16(file);
    lsd->height = SDL_ReadLE16(file);

    CEV_GifFillLSDPack_RW(&lsd->packField, file);

/* TODO (cedric#1#): background color unused ? W8&C if it ever becomes a problem */
    lsd->bckgrdColorIndex   = SDL_Readu8(file);
    temp                    = SDL_Readu8(file);/*useless info*/
    lsd->pxlAspectRatio     = (temp + 15) / 64;

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Logical Screen Descriptor.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


int CEV_GifFillLSDPack_RW(CEV_gifLSDpack* pack, SDL_RWops* file)
{/*extract LSD's packed flags*/

    uint8_t temp = SDL_Readu8(file);

    pack->usesGlobalColor   = (temp & 0x80)? 1 :0 ;
    pack->colorRes          = ((temp & 0x70)>>4) + 1;
    pack->sorted            = (temp & 0x08)? 1: 0;
    pack->numOfColors       = 1 << ((temp & 0x07)+1);

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Logical Screen Descriptor Pack.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


int CEV_GifFillColorTab_RW(unsigned int numOfColor, CEV_gifColorTable *colors, SDL_RWops* file)
{/*fills color table*/

    int i;

    colors->table = malloc(numOfColor*sizeof(CEV_gifColor));

    if (!colors->table)
    {
        fprintf(stderr, "Err CEV_fillColorTab : unable to allocate memory :%s\n", strerror(errno));
        return FUNC_ERR;
    }

    colors->numOfColors = numOfColor;

    for(i= 0; i<numOfColor; i++)
    {
        colors->table[i].r = SDL_Readu8(file);
        colors->table[i].g = SDL_Readu8(file);
        colors->table[i].b = SDL_Readu8(file);
        colors->table[i].a = 0xff;
    }

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Color table.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


int CEV_GifFillGCE_RW(CEV_gifGCE* gce, SDL_RWops* file)
{/*fills Graphic Control Extention*/

    gce->byteSize         = SDL_Readu8(file);
    CEV_GifFillGCEPack_RW(&gce->packField, file);
    gce->delayTime        = SDL_ReadLE16(file);
    gce->alphaColorIndex  = SDL_Readu8(file);
    SDL_Readu8(file); /*read garbage byte*/
    gce->used = 1;

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Graphic Contol Extention._n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


int CEV_GifFillGCEPack_RW(CEV_gifGCEPack* pack, SDL_RWops* file)
{/*extract Graphic Control Extention's packed flags*/

    uint8_t temp;

    temp = SDL_Readu8(file);

    pack->res               = (temp & 0xE0)>>5;
    pack->disposalMethod    = (temp & 0x1C)>>2;
    pack->userInput         = (temp & 0x02)>>1;
    pack->alphaFlag         = temp & 0x01;

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Graphic Contol Extention Pack.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


int CEV_GifFillID_RW(CEV_gifID* gifid, SDL_RWops* file)
{/*fills Image Descriptor*/

    gifid->leftPos   = SDL_ReadLE16(file);
    gifid->topPos    = SDL_ReadLE16(file);
    gifid->width     = SDL_ReadLE16(file);
    gifid->height    = SDL_ReadLE16(file);

    CEV_GifFillIDPack_RW(&gifid->imgPack, file);

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Image Descriptor.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


int CEV_GifFillIDPack_RW(CEV_gifIDpack* IDpack, SDL_RWops* file)
{/*extract Image Descriptor's packed flag*/

    uint8_t temp;

    temp = SDL_Readu8(file);

    IDpack->usesLocalColor  = (temp & 0x80)? 1 : 0;
    IDpack->interlace       = (temp & 0x40)? 1 : 0;
    IDpack->sorted          = (temp & 0x20)? 1 : 0;
    IDpack->res             = (temp & 0x18)? 1 : 0;
    IDpack->colorTabSize    = 1 << ((temp & 0x07)+1);

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Image Descriptor Pack.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


void CEV_GifBlockSkip_RW(SDL_RWops* file)
{/*skip useless subBlock in SDL_RWops*/

    uint8_t temp;

    while (temp = SDL_Readu8(file))
        SDL_RWseek(file, temp, RW_SEEK_CUR);
}

