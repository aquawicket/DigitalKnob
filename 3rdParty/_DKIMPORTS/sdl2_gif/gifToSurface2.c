#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <errno.h>
#include <SDL.h>
#include "SDL2_gifToSurface.h"
#include "SDL2_gif.h"



void CEV_GifFillSurface(uint8_t *pixels, CEV_gifFile* gif, int index)
{/*fills pixel fields / consecutive*/

    CEV_gifImage imageAct = gif->image[index]; /*used for easy rw*/

    uint32_t *ptr = (uint32_t*)pixels;

    CEV_gifColor *ColorTable = NULL;

    uint8_t  alphaColor = imageAct.control.alphaColorIndex;

    unsigned int i;

    unsigned int height,/*used for easy rw*/
                 width; /*used for easy rw*/

    switch (imageAct.descriptor.imgPack.usesLocalColor)
    {/*selecting which color table to use*/
        case 0 :/*global*/
            ColorTable = gif->globalColor.table;
        break;

        case 1 :/*local*/
            ColorTable = imageAct.localColor.table;
        break;

        default :/*shits happen..*/
            fprintf(stderr,"Err/ In function GifFillSurface : color table undefined.\n");
        break;
    }

    height  = imageAct.descriptor.height;/*rw purpose*/
    width   = imageAct.descriptor.width; /*rw purpose*/

    for (i = 0 ; i< height * width ; i++)
    {
       CEV_gifColor tempColor = ColorTable[imageAct.imageData[i]]; /*used for easy rw*/

            if (imageAct.control.packField.alphaFlag && (alphaColor == imageAct.imageData[i]))
            {/*if color has index designed to be alpha*/
               tempColor.a = 0;
            }

            *(ptr++) = CEV_GifColorToInt(tempColor);
    }
}


void CEV_GifFillSurfaceInterlace(uint8_t *pixels, CEV_gifFile* gif, int index)
{/*fills pixel field / interlaced*/

/** interlace method values :

    pass1   = (height+7)/8,             temp = 8*i
    pass2   = pass1 + (height+3)/8,     temp = 8*i + 4
    pass3   = pass2 + (height+1)/4,     temp = 4*i + 2
    pass4   = pass3 + (height)/2        temp = 2*i + 1
*/

    CEV_gifImage imageAct = gif->image[index];/*used for easy rw*/

    uint32_t *ptr = (uint32_t*)pixels;

    uint8_t  alphaColor = imageAct.control.alphaColorIndex;

    CEV_gifColor *ColorTable;

    int i;
	unsigned int j;
	unsigned int pass;

    unsigned int height  = imageAct.descriptor.height, /*used for easy rw*/
                 width   = imageAct.descriptor.width;  /*used for easy rw*/

    switch (imageAct.descriptor.imgPack.usesLocalColor)
    {/*selecting which color table to use*/
        case 0 :/*global*/
            ColorTable = gif->globalColor.table;
        break;

        case 1 :/*local*/
            ColorTable = gif->image[index].localColor.table;
        break;

        default :/*shits happen...*/
            fprintf(stderr,"Err/ In function GifFillSurfaceInterlace : color table undefined.\n");
        break;
    }

    int factor = 8, tempAdd = 8,
        passMin = 0, passMax, passAdd = 7;

    for (pass=0; pass<4; pass++)
    {
        passMax = (passMin + (height + passAdd)/factor);

        for (i=passMin ; i<passMax ; i++)
        {
            int temp = factor*(i-passMin) + (tempAdd * (pass>0));

            for (j=0 ; j<width; j++)
            {
                CEV_gifColor tempColor = ColorTable[imageAct.imageData[i*width+j]];

                /*if color index is to be alpha*/
                if (imageAct.control.packField.alphaFlag && (alphaColor == imageAct.imageData[i*width+j]))
                    tempColor.a = 0;

                ptr[temp*width +j]= CEV_GifColorToInt(tempColor);
            }
        }
        passMin = passMax;
        tempAdd/=2;
        passAdd/=2;
        factor /=(pass)? 2 : 1;
    }
}


int CEV_GifColorToInt(CEV_gifColor color)
{/*color struct to int*/
    int result = 0;

    if (SDL_BYTEORDER == SDL_BIG_ENDIAN)
        result = color.r<<24 | color.g<<16 | color.b<<8 | color.a;

    else
        result = color.a<<24 | color.b<<16 | color.g<<8 | color.r;

    return result;
}


void CEV_TextureRedraw(const uint8_t *pixels, const SDL_Rect* blitPos, SDL_Texture *dstTex)
{/*redraw method, anything off the frame rect is made full alpha*/

    int x, y,
        width,  /*rw purpose*/
        height, /*rw purpose*/
        pitch;  /*rw purpose*/

    void *access;

    uint32_t *src = (uint32_t*)pixels,
             *dst;

    SDL_QueryTexture(dstTex, NULL, NULL, &width, &height);

    SDL_LockTexture(dstTex, NULL, &access, &pitch);

    dst = (uint32_t*)access;

    /* TODO (cedric#1#): could be done linearly with 1 loop, but not so understandable, W8&C if slow */
    for(y =0; y < height; y++)
    {
        for(x =0; x < width; x++)
        {
            dst[y*pitch/sizeof(uint32_t) + x] = (CEV_IsInBox(x, y, blitPos))? src[(y-blitPos->y)*blitPos->w + x-blitPos->x] : (uint32_t)0x0;
        }
    }

    SDL_UnlockTexture(dstTex);
}


void CEV_TextureOverlay(const uint8_t *pixels, const SDL_Rect* blitPos, SDL_Texture *dstTex)
{/*overlay method, only frame rect is copied to surface*/

    int i, j,
        pitch; /*rw purpose*/

    uint32_t *src = (uint32_t*)pixels,
             *dst;

    void* access;
    /***Error handeling to do**/

    SDL_LockTexture(dstTex, NULL, &access, &pitch);

    dst = (uint32_t*)access;

    for(i=0 ; i<blitPos->h; i++)
    {
        for(j=0 ; j< blitPos->w; j++)
        {
            int dstX = blitPos->x + j,/*rw purpose*/
                dstY = blitPos->y + i;/*rw purpose*/

            uint32_t color  = src[i*blitPos->w + j];/*rw purpose*/

            if(COLOR_A(color))
                dst[dstY*pitch/sizeof(uint32_t) + dstX] = color;
        }
    }

    SDL_UnlockTexture(dstTex);
}


char CEV_IsInBox(int x, int y, const SDL_Rect *rect)
{/*is this point in this Rect ?*/
    return ((x >= rect->x)
            && (x < (rect->x + rect->w))
            && (y >= rect->y)
            && (y <(rect->y+rect->h)));
}



char CEV_Blit(SDL_GifAnim *anim)
{

    if(!anim->status.refresh)/*if not refresh only*/
        CEV_SelectNxt(anim); /*select next frame*/

    int imgAct      = anim->status.imgAct;              /*rw purpose*/
    char dispMethod = anim->pictures[imgAct].dispMethod;/*rw purpose*/

    switch (dispMethod)
    {/*select disposal method*/

        default:/*default uses redraw, tests make it more appropriate, deal with it...*/

        case METHOD_REDRAW : /*redraws full surface*/
            CEV_TextureRedraw(anim->pictures[imgAct].pixels, &anim->pictures[imgAct].pos, anim->display.surface);
        break;

        case METHOD_OVERWRITE : /*overwrites frame surface*/
            CEV_TextureOverlay(anim->pictures[imgAct].pixels, &anim->pictures[imgAct].pos, anim->display.surface);
        break;
    }
    anim->status.refresh    = 0;

    return(1);
}



char CEV_AddModulo(int mode,int* val,int num)
{/*incrément / décrément de val par modulo***VALIDE***/

    char result = 0;

    switch (mode)
    {
        case 0 : /*incremental*/
            if ((*val+1)<num)
                *val +=1;
            else
            {
                *val   = 0;
                result = 1;/*modulo reached*/
            }
        break;

        case 1 : /*decremental*/
            if (*val-1 >= 0)
                *val -=1;
            else
            {
                *val   = num-1;
                result = 1;/*modulo reached*/
            }
        break;

        default :/*avoid warning, unlikely*/
        break;
    }

    return result;
}


char CEV_AddLim(int mode, int *val, int num)
{
    switch (mode)
    {
        case 0 :/*incremental*/
            if (*val+1 < num)
                *val += 1;
        break;

        case 1 :/*decremental*/
            if (*val-1 >=0)
                *val -= 1;
        break;
    }

    return (char)(*val==0 || *val==num-1);/*limit reached*/
}


void CEV_SelectNxt(SDL_GifAnim *anim)
{/*selects next frame to be displayed*/

    int *imgAct = &anim->status.imgAct;

    switch (anim->status.loopMode)
    {
        case GIF_ONCE_FOR :

            if(!anim->status.loopDone && CEV_AddLim(0, imgAct, anim->status.imgNum))
                anim->status.loopDone = 1;
        break;

        case GIF_REPEAT_FOR :
            CEV_AddModulo(0, imgAct, anim->status.imgNum);

        break;

        case GIF_ONCE_REV :

            if(!anim->status.loopDone && CEV_AddLim(1, imgAct, anim->status.imgNum))
                anim->status.loopDone = 1;
        break;

        case GIF_REPEAT_REV :
            CEV_AddModulo(1, imgAct, anim->status.imgNum);
        break;

        case GIF_FORTH_BACK :
            switch(anim->status.direction)
            {
                case GIF_FORWARD :
                    if(*imgAct+1 == (anim->status.imgNum-1))
                        anim->status.direction = GIF_BACKWARD;

                    if (*imgAct+1 <= (anim->status.imgNum-1))
                        *imgAct += 1;

                break;

                case GIF_BACKWARD :
                    if(*imgAct-1 == 0)
                        anim->status.direction = GIF_FORWARD;

                    if (*imgAct-1 >= 0)
                        *imgAct -= 1;
                break;
            }
        break;

        case GIF_STOP :
            *imgAct = 0;
        break;

        default :
        break;

    }

    return;
}

void CEV_FitBoxInto(SDL_Rect *adapt , const SDL_Rect *ref)
{/*fits adapt into ref*/
    if (adapt->x <0)
        adapt->x = 0;

    if (adapt->x + adapt->w > ref->w)
        adapt->w = ref->w - adapt->x;

    if (adapt->y <0)
        adapt->y = 0;

    if(adapt->y+adapt->h > ref->h)
        adapt->h = ref->h-adapt->y;
}


char CEV_InitAnim(SDL_GifAnim * anim, CEV_gifFile* gif)
{
    int i;
    SDL_Rect base = {0, 0, 0, 0};/*lazy me..*/

    /*filling animation informations from gif file*/
    anim->pictures          = NULL;
    anim->status.imgNum     = gif->imgNum;
    anim->status.comment    = gif->comExt.text;
    anim->status.imgAct     = 0;
    anim->status.time       = 0;
    anim->status.loopMode   = GIF_STOP;
    anim->status.loopDone   = 0;
    anim->status.refresh    = 0;
    anim->status.direction  = GIF_FORWARD;

    strcpy(anim->status.signature, gif->header.signature);
    strcpy(anim->status.version, gif->header.version);

    /*allocating frames table*/
    anim->pictures = malloc(anim->status.imgNum * sizeof(CEV_Frame));

    if (!anim->pictures)
    {/*on error*/
        fprintf(stderr,"Err / CEV_InitAnim : Unable to allocate :%s\n",strerror(errno));
        return FUNC_ERR;
    }

    for(i=0; i<anim->status.imgNum; i++)
    {
        anim->pictures[i].dispMethod    = 0;
        anim->pictures[i].pixels        = NULL;
        anim->pictures[i].pos           = base;/*yeah, lazy...*/
        anim->pictures[i].time          = 0;
    }

    return FUNC_OK;
}




