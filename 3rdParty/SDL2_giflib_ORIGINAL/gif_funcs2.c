#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <SDL.h>
#include "SDL2_gifRwtypes.h"
#include "SDL2_gifDecomp.h"
#include "SDL2_gifToSurface.h"
#include "SDL2_gif.h"





CEV_gifFile *CEV_LoadGIF(const char* fileName)
{/*create gif handler*/

    FILE *file = NULL;
    CEV_gifFile *gif = NULL;

    unsigned char
                endOfFile=0;

    readWriteErr = 0;

    /*openning file*/
    file = fopen(fileName, "rb");
    if(!file)
    {/*on error*/
        fprintf(stderr,"Err / CEV_LoadGIF : unable to open file %s.\n",fileName);
        goto end;
    }

    /*creating new gif structure*/
    gif = CEV_newGif();

    if (!gif)
    {/*on error*/
        fprintf(stderr,"Err / CEV_LoadGIF : unable to create gif structure.\n");
        goto err1;
    }

    CEV_GifFillHeader(&gif->header, file);  /*Mandatory / function checked*/
    CEV_GifFillLSD(&gif->lsd, file);        /*Mandatory / function checked*/

    /*Global color table reading*/
    if (gif->lsd.packField.usesGlobalColor)
        CEV_GifFillColorTab(gif->lsd.packField.numOfColors, &gif->globalColor, file);    /*function checked*/



    while(!endOfFile && !readWriteErr)
    {
        uint8_t dataType = read_u8(file);

        switch(dataType)
        {/*switch next data type*/

            case 0x21 : /*file extensions*/
                CEV_GifFillExt(gif, file);
            break;

            case 0x2C : /*Image Descriptor*/
                CEV_GifNewImg(gif, file);
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
    fclose(file);

end:
    return gif;
}


int CEV_GifFillExt(CEV_gifFile *gif, FILE *file)
{/*fills misc extension blocks*/

    switch(read_u8(file))
    {/*switch file extension type*/

        case 0xf9 : /*Graphics Control Extension*/
            CEV_GifFillGCE(&gif->gce, file);/*vérifié*/
        break;

        /* TODO (cedric#1#): eventually to be taken into consideration but why ? */
        case 0x01 :/*Plain Text extension*/
        case 0xff :/*Application Extension*/
            CEV_GifBlockSkip(file);
        break;

        case 0xfe :/*Comment Extension*/
            CEV_GifFillComExt(&gif->comExt, file);
        break;

        default :
            fprintf(stderr,"Err / CEV_GifFillExt : Unknow file extension type has occured\n");
        break;
    }


    if(readWriteErr)
        fprintf(stderr,"CEV_GifFillExt : W/R error occured.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


CEV_gifFile *CEV_newGif()
{/*allocates and fills new structure*/

    CEV_gifFile *newgif = NULL;

    newgif = malloc(sizeof(*newgif));

    if(!newgif)
    {
        fprintf(stderr,"Err /CEV_GifFile Unable to malloc : %s\n", strerror(errno));
        return NULL;
    }

    /*initializing values & pointers*/
    newgif->imgNum                  = 0;
    newgif->image                   = NULL;
    newgif->globalColor.numOfColors = 0;
    newgif->globalColor.table       = NULL;

    /*init header*/
    CEV_GifInitHeader(&newgif->header);

    /*init graphic control extension*/
    CEV_GifInitGce(&newgif->gce);

    /*init lsd*/
    CEV_GifInitLsd(&newgif->lsd);

    /*init comment extension*/
    CEV_GifInitComExt(&newgif->comExt);

    return newgif;
}


void CEV_GifInitHeader(CEV_gifHeader *header)
{/*header file init*/

    memset(header->signature, 0, sizeof(header->signature));
    memset(header->version, 0, sizeof(header->version));
}


void CEV_GifInitGce(CEV_gifGCE *gce)
{/*gce file init*/

    gce->alphaColorIndex = 0;
    gce->byteSize        = 0;
    gce->delayTime       = 0;
    gce->used            = 0;

    gce->packField.alphaFlag      = 0;
    gce->packField.disposalMethod = 0;
    gce->packField.res            = 0;
    gce->packField.userInput      = 0;
}


void CEV_GifInitLsd (CEV_gifLSD *lsd)
{/*lsd file init*/

    lsd->bckgrdColorIndex = 0;
    lsd->height           = 0;
    lsd->pxlAspectRatio   = 0;
    lsd->width            = 0;

    lsd->packField.colorRes         = 0;
    lsd->packField.numOfColors      = 0;
    lsd->packField.sorted           = 0;
    lsd->packField.usesGlobalColor  = 0;
}


void CEV_GifInitComExt(CEV_gifComExt* comment)
{/*comment extension init*/

    comment->numOfBlocks = 0;
    comment->text        = NULL;
}


void CEV_GifNewImg(CEV_gifFile *gif, FILE *file)
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
        fprintf(stderr, "Err / CEV_GifNewImg : unable to allocate :%s\n", strerror(errno));
        gif->imgNum --;
        return;
    }

    if(gif->gce.used)
    {/*if graphic Control Extension was read before*/
        gif->image[frameIndex].control = gif->gce; /*store into new picture*/
    }

    /*fills Image Descriptor*/
    CEV_GifFillID(&gif->image[frameIndex].descriptor, file);

    if (gif->image[frameIndex].descriptor.imgPack.usesLocalColor)
    {/*if there is a local color table*/
        CEV_GifFillColorTab(gif->image[frameIndex].descriptor.imgPack.colorTabSize, &gif->image[frameIndex].localColor, file);
    }
    else
    {/*default values*/
        gif->image[frameIndex].localColor.numOfColors    = 0;
        gif->image[frameIndex].localColor.table          = NULL;
    }

    /*restores raw data into pixels table*/
    CEV_GifFillData(gif, file);
}


void CEV_GifFreeFile(CEV_gifFile *gif)
{/*free all gif structure allocations*/
    int i;

    for(i=0; i<gif->imgNum; i++)
    {
        free(gif->image[i].localColor.table);
        free(gif->image[i].imageData);
    }

    free(gif->image);
    free(gif);
}


void CEV_GifFillData(CEV_gifFile *gif, FILE *file)
{/*read raw data sublock and send it thru lzw decompression*/

    uint8_t
            *rawData    = NULL, /*data field only*/
            *temp       = NULL; /*temporary*/

    unsigned char
                LZWminiCodeSize = 0, /*min code size*/
                subBlockSize    = 0; /*size of data sub block*/

    size_t rawDataSize = 0; /*raw data full size in bytes*/

    LZWminiCodeSize = read_u8(file);

    while((subBlockSize=read_u8(file)) && !readWriteErr) /*a size of 0 means no data to follow*/
    {/*fill rawData with subBlocks datas*/

        temp = realloc(rawData, rawDataSize + subBlockSize);/*alloc/realloc volume for new datas*/

        if (temp)/*realloc is ok*/
            rawData = temp;
        else
        {/*on error*/
            fprintf(stderr, "Err / CEV_fillImgData : realloc error. %s\n", strerror(errno));
            goto err;
        }

        /*fetch datas from file*/
        if(fread(&rawData[rawDataSize], 1, subBlockSize, file)!=subBlockSize)
           readWriteErr++;
        rawDataSize +=  subBlockSize;   /*increase datasize by blocksize*/
    }
    /*pass data through lzw decomp*/
    CEV_GifLzw(rawData, gif, LZWminiCodeSize);

err :
    free(rawData);
}


int CEV_GifFillHeader(CEV_gifHeader* header, FILE* file)
{/*fills header**/

    if (fread(header->signature, 1, 3, file) != 3)
        readWriteErr++;

    if (fread(header->version, 1, 3, file) != 3)
        readWriteErr++;

    header->signature[3] = header->version[3] = '\0';

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Header.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


int CEV_GifFillComExt(CEV_gifComExt *ext, FILE* file)
{/*fills comment extension*/

    uint8_t temp;

    temp = read_u8(file);
    temp+=1;

    ext->text = malloc(temp * sizeof(char));
    if(ext->text == NULL)
        return FUNC_ERR;

    if(fread(ext->text, 1, temp, file) != temp)
        readWriteErr++;

    ext->text[temp]='\0';

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Comment Extention.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


int CEV_GifFillLSD(CEV_gifLSD* lsd, FILE* file)
{/*fills Logical Screen Descriptor*/

    uint8_t temp;

    lsd->width  = read_u16le(file);
    lsd->height = read_u16le(file);

    CEV_GifFillLSDPack(&lsd->packField, file);

/* TODO (cedric#1#): background color unused ? W8&C if it ever becomes a problem */
    lsd->bckgrdColorIndex   = read_u8(file);
    temp                    = read_u8(file);/*useless info*/
    lsd->pxlAspectRatio     = (temp + 15) / 64;

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Logical Screen Descriptor.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


int CEV_GifFillLSDPack(CEV_gifLSDpack* pack, FILE* file)
{/*extract LSD's packed flags*/

    uint8_t temp = read_u8(file);

    pack->usesGlobalColor   = (temp & 0x80)? 1 :0 ;
    pack->colorRes          = ((temp & 0x70)>>4) + 1;
    pack->sorted            = (temp & 0x08)? 1: 0;
    pack->numOfColors       = 1 << ((temp & 0x07)+1);

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Logical Screen Descriptor Pack.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


int CEV_GifFillColorTab(unsigned int numOfColor, CEV_gifColorTable *colors, FILE* file)
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
        colors->table[i].r = read_u8(file);
        colors->table[i].g = read_u8(file);
        colors->table[i].b = read_u8(file);
        colors->table[i].a = 0xff;
    }

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Color table.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


int CEV_GifFillGCE(CEV_gifGCE* gce, FILE* file)
{/*fills Graphic Control Extention*/

    gce->byteSize         = read_u8(file);
    CEV_GifFillGCEPack(&gce->packField, file);
    gce->delayTime        = read_u16le(file);
    gce->alphaColorIndex  = read_u8(file);
    read_u8(file); /*read garbage byte*/
    gce->used = 1;

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Graphic Contol Extention._n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


int CEV_GifFillGCEPack(CEV_gifGCEPack* pack, FILE* file)
{/*extract Graphic Control Extention's packed flags*/

    uint8_t temp;

    temp = read_u8(file);

    pack->res               = (temp & 0xE0)>>5;
    pack->disposalMethod    = (temp & 0x1C)>>2;
    pack->userInput         = (temp & 0x02)>>1;
    pack->alphaFlag         = temp & 0x01;

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Graphic Contol Extention Pack.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


int CEV_GifFillID(CEV_gifID* gifid, FILE* file)
{/*fills Image Descriptor*/

    gifid->leftPos   = read_u16le(file);
    gifid->topPos    = read_u16le(file);
    gifid->width     = read_u16le(file);
    gifid->height    = read_u16le(file);

    CEV_GifFillIDPack(&gifid->imgPack, file);

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Image Descriptor.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


int CEV_GifFillIDPack(CEV_gifIDpack* IDpack, FILE* file)
{/*extract Image Descriptor's packed flag*/

    uint8_t temp;

    temp = read_u8(file);

    IDpack->usesLocalColor  = (temp & 0x80)? 1 : 0;
    IDpack->interlace       = (temp & 0x40)? 1 : 0;
    IDpack->sorted          = (temp & 0x20)? 1 : 0;
    IDpack->res             = (temp & 0x18)? 1 : 0;
    IDpack->colorTabSize    = 1 << ((temp & 0x07)+1);

    if(readWriteErr)
        fprintf(stderr,"R/W error while filling Image Descriptor Pack.\n");

    return (readWriteErr)? FUNC_ERR : FUNC_OK;
}


void CEV_GifBlockSkip(FILE* file)
{/*skip useless subBlock in file*/

    uint8_t temp;

    while (temp=read_u8(file))
        fseek(file, temp, SEEK_CUR);
}


void CEV_GifLzw(void *codeStream, CEV_gifFile *gif, unsigned int lzwMinCode)
{/*LZW Decompression*/

    /*** DECLARATIONS ***/

    unsigned int bitPtr     = 0,   /*actual bit position in codestream*/
                 count      = 0,   /*count of index output*/
                 indexNum   = gif->image[gif->imgNum-1].descriptor.width * gif->image[gif->imgNum-1].descriptor.height;

    uint8_t *indexStream    =  NULL; /*result*/

    size_t maskSize = lzwMinCode +1; /*size of mask used to read bitstream in code Stream*/

    uint16_t
            actCodeValue    = 0,/*actual code value*/
            prevCodeValue   = 0;/*previous code value*/

    const uint16_t
            resetCode       = 1<<lzwMinCode,
            EOICode         = resetCode + 1;

    CEV_gifDico codeTable;
    CEV_gifDicoEntry prevString;

    /*** PRL ***/

    indexStream = malloc(indexNum *sizeof(uint8_t));

    if(!indexStream)
    {
        fprintf(stderr, "gifLZW : unable to allocate indexStream : %s\n", strerror(errno));
        return;
    }

    /*** EXECUTION ***/

    while(count<indexNum)
    {/*starts loop*/

        /*read value in code stream*/
        actCodeValue  = CEV_GetBitFieldValue16(codeStream, &bitPtr, maskSize);

        if(actCodeValue == resetCode)
        {/*reinit dico if reset code*/

            CEV_GifInitDico(&codeTable, resetCode); /*CodeTable init*/
            maskSize    = lzwMinCode +1;            /*maskSize init*/

            actCodeValue =  CEV_GetBitFieldValue16(codeStream, &bitPtr, maskSize);

            prevString = codeTable.entry[actCodeValue];
            prevCodeValue = actCodeValue;
            CEV_ValueOutput(actCodeValue, indexStream, &count, indexNum);

            continue;
        }

        if(actCodeValue == EOICode)
        {
            fprintf(stderr,"received EOI at %d; should be %d\n", count, indexNum);
            break;
        }

        if(actCodeValue < codeTable.actSize)
        {/**is CODE in the code table? Yes:**/

            uint8_t string0 = CEV_GetFirstOfString(&codeTable, codeTable.entry[actCodeValue]);
            /*output {CODE} to index stream */
            CEV_StringOutput(&codeTable, codeTable.entry[actCodeValue], indexStream, &count, indexNum);

            codeTable.entry[codeTable.actSize].prev  = prevCodeValue;
            codeTable.entry[codeTable.actSize].value = string0;

            prevCodeValue = actCodeValue;

            prevString = codeTable.entry[actCodeValue];
            codeTable.actSize++;
        }
        else
        {/**is CODE in the code table? No:**/

            uint8_t prevString0 = CEV_GetFirstOfString(&codeTable, prevString);

            CEV_StringOutput(&codeTable, prevString, indexStream, &count, indexNum);
            CEV_ValueOutput(prevString0, indexStream, &count, indexNum);

            codeTable.entry[codeTable.actSize].prev = prevCodeValue;
            codeTable.entry[codeTable.actSize].value = prevString0;
            prevCodeValue   = codeTable.actSize;
            prevString      = codeTable.entry[codeTable.actSize];
            codeTable.actSize++;
        }

        if (codeTable.actSize == (1<<(maskSize)))
        {/*if index reaches max value for actMask*/

            maskSize++; /*maskSize increase*/

            if (maskSize>=13) /*max gif mask is 12 bits by spec*/
                maskSize = 12;/*limited to 12*/
        }
    }

    /** POST **/

    /*image data =  index stream*/
    gif->image[gif->imgNum-1].imageData = indexStream;
}


uint16_t CEV_GetBitFieldValue16(void *data, unsigned int *bitStart, size_t maskSize)
{
    uint32_t value  = 0,
             mask   = (1<<maskSize) - 1;

    uint8_t* ptr    = data;

    if (maskSize > 16 || !data)
        return 0;

    ptr +=(*bitStart) /8;

    value = ((*(uint32_t*)ptr) >> ((*bitStart)%8)) & mask;

    (*bitStart) += maskSize ;

    return (uint16_t)value;
}


void CEV_GifInitDico(CEV_gifDico * dico, unsigned int code)
{/*init dictionnary*/
    int i;

    dico->actSize = code+2;

    for(i=0; i< code; i++)
    {
        dico->entry[i].prev  = -1;
        dico->entry[i].value = (uint8_t)i;
    }
}


uint8_t CEV_GetFirstOfString(CEV_gifDico *dico, CEV_gifDicoEntry entry)
{
    int16_t index = entry.prev ;

    if (index == -1)
        return entry.value;

    while(dico->entry[index].prev != -1)
        index = dico->entry[index].prev;

    return dico->entry[index].value;
}


void CEV_StringOutput(CEV_gifDico *dico, CEV_gifDicoEntry string, uint8_t *out, unsigned int *count, unsigned int maxCount)
{
    CEV_RepeatedlyOutput(dico, string.prev, out, count, maxCount);
    CEV_ValueOutput(string.value, out, count, maxCount);
}


void CEV_RepeatedlyOutput(CEV_gifDico *dico, int16_t index, uint8_t *out, unsigned int *count, unsigned int maxCount)
{
    if(index==-1)
        return ;

    CEV_RepeatedlyOutput(dico, dico->entry[index].prev, out, count, maxCount);
    CEV_ValueOutput(dico->entry[index].value, out, count, maxCount);
    return ;
}


void CEV_ValueOutput(uint8_t value, uint8_t *out, unsigned int *count, unsigned int maxCount)
{
    if (*count == maxCount)
        return;

    out[(*count)++] = value;

    return;
}
