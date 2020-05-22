#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <errno.h>
#include <SDL.h>
#include "SDL2_gifRwtypes.h"
#include "SDL2_gifDecomp.h"
#include "SDL2_gifToSurface.h"
#include "SDL2_gif.h"




SDL_GifAnim * SDL_GIFAnimLoad(const char* filename, SDL_Renderer *renderer)
{/* TODO (cedric#1#): check errors / fitness */
    int i;
    uint8_t * pixels        = NULL;
    CEV_gifFile *gif        = NULL;
    SDL_GifAnim *anim       = NULL;
    SDL_Texture *newTexture = NULL;

    /**perform compatibiliy control**/
    /* TODO (cedric#1#): à implémenter */


    anim = malloc(sizeof(SDL_GifAnim));
    if (!anim)
        goto err_exit;

    readWriteErr = 0;

    /*extracting datas from gif file*/
    gif = CEV_LoadGIF(filename);

    if(!gif)
        goto err_1;

    /*CREATING MAIN TEXTURE AKA the user one*/
    newTexture =SDL_CreateTexture(renderer,
                                SDL_PIXELFORMAT_ABGR8888,
                                SDL_TEXTUREACCESS_STREAMING,
                                gif->lsd.width,
                                gif->lsd.height);


    if(!newTexture)
    {
        fprintf(stderr,"Err / SDL_GIFAnimLoad : %s\n", SDL_GetError());
        goto err_2;
    }
    else
    {
        anim->display.surface = newTexture;
        anim->display.pos.h = gif->lsd.height;
        anim->display.pos.w = gif->lsd.width;
    }

    /**Starting to create every pic, one by one*/

    if (CEV_InitAnim(anim, gif))
        goto err_3;

    for (i=0; i<anim->status.imgNum; i++)
    {
        pixels = malloc(gif->image[i].descriptor.width * gif->image[i].descriptor.height * 4);

        if(pixels)
        {
            switch (gif->image[i].descriptor.imgPack.interlace)
            {
                case 0:
                    CEV_GifFillSurface(pixels, gif, i);
                break;

                case 1:
                    CEV_GifFillSurfaceInterlace(pixels, gif, i);
                break;

                default:
                break;
            }
        }
        else
        {
            fprintf(stderr,"Err / SDL_GIFAnimLoad : %s\n", strerror(errno));
            goto err_3;
        }


        anim->pictures[i].pixels    = pixels;
        anim->pictures[i].pos.x      = gif->image[i].descriptor.leftPos;
        anim->pictures[i].pos.y      = gif->image[i].descriptor.topPos;
        anim->pictures[i].pos.h      = gif->image[i].descriptor.height;
        anim->pictures[i].pos.w      = gif->image[i].descriptor.width;
        anim->pictures[i].dispMethod = gif->image[i].control.packField.disposalMethod;
        anim->pictures[i].time       = gif->image[i].control.delayTime*10;

        /*get sure frame rects fit into surface rect*/
        CEV_FitBoxInto(&anim->pictures[i].pos, &anim->display.pos);
    }

    CEV_GifFreeFile(gif);

    /*be ready to display first logical frame in case of no call to SDL_GIFAnimAuto*/
    CEV_Blit(anim);

    if(readWriteErr)/*well.. wait and see if it's a problem*/
        fprintf(stderr,"Info / SDL_GIFAnimLoad : some R/W err has occured, file may be unstable\n");

    return anim;

    /**error management from here**/
err_3 :
    SDL_GIFAnimFree(anim);
    anim = NULL; /*security for err_1*/

err_2 :
    CEV_GifFreeFile(gif);

err_1 :
    free(anim);

err_exit :
    return NULL;
}

SDL_GifAnim * SDL_GIFAnimLoad_RW(SDL_RWops* rwops, SDL_Renderer *renderer)
{/* TODO (cedric#1#): check errors / fitness */
    int i;
    uint8_t * pixels        = NULL;
    CEV_gifFile *gif        = NULL;
    SDL_GifAnim *anim       = NULL;
    SDL_Texture *newTexture = NULL;

    /**perform compatibiliy control**/
    /* TODO (cedric#1#): à implémenter */


    anim = malloc(sizeof(SDL_GifAnim));
    if (!anim)
        goto err_exit;

    readWriteErr = 0;

    /*extracting datas from gif file*/
    gif = CEV_LoadGIF_RW(rwops);

    if(!gif)
        goto err_1;

    /*CREATING MAIN TEXTURE AKA the user one*/
    newTexture =SDL_CreateTexture(renderer,
                                SDL_PIXELFORMAT_ABGR8888,
                                SDL_TEXTUREACCESS_STREAMING,
                                gif->lsd.width,
                                gif->lsd.height);


    if(!newTexture)
    {
        fprintf(stderr,"Err / SDL_GIFAnimLoad : %s\n", SDL_GetError());
        goto err_2;
    }
    else
    {
        anim->display.surface = newTexture;
        anim->display.pos.h = gif->lsd.height;
        anim->display.pos.w = gif->lsd.width;
    }

    /**Starting to create every pic, one by one*/

    if (CEV_InitAnim(anim, gif))
        goto err_3;

    for (i=0; i<anim->status.imgNum; i++)
    {
        pixels = malloc(gif->image[i].descriptor.width * gif->image[i].descriptor.height * 4);

        if(pixels)
        {
            switch (gif->image[i].descriptor.imgPack.interlace)
            {
                case 0:
                    CEV_GifFillSurface(pixels, gif, i);
                break;

                case 1:
                    CEV_GifFillSurfaceInterlace(pixels, gif, i);
                break;

                default:
                break;
            }
        }
        else
        {
            fprintf(stderr,"Err / SDL_GIFAnimLoad : %s\n", strerror(errno));
            goto err_3;
        }


        anim->pictures[i].pixels    = pixels;
        anim->pictures[i].pos.x      = gif->image[i].descriptor.leftPos;
        anim->pictures[i].pos.y      = gif->image[i].descriptor.topPos;
        anim->pictures[i].pos.h      = gif->image[i].descriptor.height;
        anim->pictures[i].pos.w      = gif->image[i].descriptor.width;
        anim->pictures[i].dispMethod = gif->image[i].control.packField.disposalMethod;
        anim->pictures[i].time       = gif->image[i].control.delayTime*10;

        /*get sure frame rects fit into surface rect*/
        CEV_FitBoxInto(&anim->pictures[i].pos, &anim->display.pos);
    }

    CEV_GifFreeFile(gif);

    /*be ready to display first logical frame in case of no call to SDL_GIFAnimAuto*/
    CEV_Blit(anim);

    if(readWriteErr)/*well.. wait and see if it's a problem*/
        fprintf(stderr,"Info / SDL_GIFAnimLoad : some R/W err has occured, file may be unstable\n");

    return anim;

    /**error management from here**/
err_3 :
    SDL_GIFAnimFree(anim);
    anim = NULL; /*security for err_1*/

err_2 :
    CEV_GifFreeFile(gif);

err_1 :
    free(anim);

err_exit :
    return NULL;
}

char *SDL_GIFComment(SDL_GifAnim *anim)
{
    return anim->status.comment;
}


char *SDL_GIFVersion(SDL_GifAnim *anim)
{
    return anim->status.version;
}


char *SDL_GIFsignature(SDL_GifAnim *anim)
{
    return anim->status.signature;
}


SDL_Texture *SDL_GIFTexture(SDL_GifAnim *anim)
{
    return anim->display.surface;
}


int SDL_GIFFrameNum(SDL_GifAnim *anim)
{
    return anim->status.imgNum;
}


void SDL_GIFNextFrame(SDL_GifAnim *anim)
{
    CEV_Blit(anim);
}


void SDL_GIFSpeedSet(SDL_GifAnim *anim, int num, int speed)
{
    int i;

    if ((num >= anim->status.imgNum) || num < GIF_ALL)
        return;/*nothing to be done*/

    else if (num >=0 )
        anim->pictures[num].time = (uint16_t)speed;/*the num one only*/

    else/*all frames*/
        for(i=0; i<anim->status.imgNum; i++)
            anim->pictures[i].time = (uint16_t)speed;
}


void SDL_GIFLoopMode(SDL_GifAnim *anim, unsigned int loopMode)
{
    if(loopMode > GIF_STOP)
        return;/*nothing to be done*/

    anim->status.loopMode = loopMode;

    switch (loopMode)
    {
        case GIF_REPEAT_REV :/*modes starting from last frame*/
        case GIF_ONCE_REV :
            anim->status.imgAct = anim->status.imgNum-1;
        break;

        default:/*other modes*/
            anim->status.imgAct = 0;
        break;
    }

    anim->status.refresh = 1;               /*force refreshing*/
    anim->status.time    = SDL_GetTicks();  /*restart from now*/
}

void SDL_GIFLoopReset(SDL_GifAnim *anim)
{
    switch (anim->status.loopMode)
    {
        case GIF_REPEAT_FOR :
        case GIF_ONCE_FOR :
        case GIF_FORTH_BACK:
            anim->status.imgAct = 0;
            anim->status.loopDone = 0;
        break;

        case GIF_REPEAT_REV :
        case GIF_ONCE_REV :
            anim->status.imgAct = anim->status.imgNum-1;
            anim->status.loopDone = 0;
        break;

        default:
        break;
    }

    anim->status.refresh = 1;               /*force refreshing*/
    anim->status.time    = SDL_GetTicks();  /*restart from now*/
}


char SDL_GIFAnimAuto(SDL_GifAnim *anim)
{
    char sts = 0;

    unsigned int actTime,
                 now = SDL_GetTicks();

    int imgAct = anim->status.imgAct;

    if(!anim)
        return 0;

    /*if first call*/
    if(!anim->status.time)
        anim->status.time = now;

    /*since last time ?*/
    actTime = now - anim->status.time;

    if((actTime >= anim->pictures[imgAct].time) || anim->status.refresh)
    {/*it's time or it's forced by else function*/
        sts = CEV_Blit(anim);
        anim->status.time = now;
    }

    return sts;
}


void SDL_GIFReverse(SDL_GifAnim *anim)
{
    switch (anim->status.loopMode)
    {
        case GIF_REPEAT_FOR :
             anim->status.loopMode = GIF_REPEAT_REV;
        break;

        case GIF_REPEAT_REV :
             anim->status.loopMode = GIF_REPEAT_FOR;
        break;

        case GIF_ONCE_FOR :
            anim->status.loopMode = GIF_ONCE_REV;
        break;

        case GIF_ONCE_REV :
            anim->status.loopMode = GIF_ONCE_FOR;
        break;

        case GIF_FORTH_BACK :
            anim->status.direction ^= 1;
        break;

        default:
        break;
    }
}


void SDL_GIFAnimFree(SDL_GifAnim *anim)
{
    int i;

    for(i=0; i<anim->status.imgNum; i++)
        free(anim->pictures[i].pixels);     /*every pixels table*/

    free(anim->pictures);                   /*the frames table*/
    free(anim->status.comment);             /*comments if some*/
    SDL_DestroyTexture(anim->display.surface); /*main surface*/
    free(anim);                             /*and itself*/
}


char SDL_GifLoopStatus(SDL_GifAnim* anim)
{
    return !(anim->status.loopDone || (anim->status.loopMode==GIF_STOP));
}


char SDL_GifMethod(SDL_GifAnim* anim, uint8_t num)
{
    if(num>anim->status.imgNum-1)
        num = 0;

    return (char)anim->pictures[num].dispMethod;
}


void SDL_GifMethodSet(SDL_GifAnim* anim, int num, uint8_t method)
{
    int i;

    if(num > anim->status.imgNum-1 || num < GIF_ALL)
        return;

    else if (num==GIF_ALL)
    {
        for(i=0; i<anim->status.imgNum; i++)
            anim->pictures[i].dispMethod = method;
    }
    else
        anim->pictures[num].dispMethod = method;
}

