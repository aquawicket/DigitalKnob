#ifndef GIFTOSURFACE_H_INCLUDED
#define GIFTOSURFACE_H_INCLUDED

#include <SDL.h>
#include "SDL2_gifDecomp.h"

#define METHOD_OVERWRITE 1
#define METHOD_REDRAW 2


typedef struct CEV_Frame
{
    uint8_t dispMethod,
            *pixels;

    uint16_t time;

    SDL_Rect pos;
}
CEV_Frame;

typedef struct CEV_MainSurf
{
    SDL_Rect pos;
    SDL_Texture *surface;
}
CEV_MainSurf;

typedef struct CEV_gifInfo
{
    char *comment,
         signature[4],
         version[4],
         loopDone,
         direction,
         refresh;

    uint8_t loopMode;
    unsigned int time,
                timeAct;
    int         imgNum,
                imgAct;

}CEV_gifInfo;


typedef struct SDL_GifAnim
{

    CEV_gifInfo status;
    CEV_MainSurf display;
    CEV_Frame *pictures;
}
SDL_GifAnim;


void CEV_GifFillSurface(uint8_t *pixels, CEV_gifFile* gif, int index);

void CEV_GifFillSurfaceInterlace(uint8_t *pixels, CEV_gifFile* gif, int index);

int CEV_GifColorToInt(CEV_gifColor color);

void CEV_TextureRedraw(const uint8_t*, const SDL_Rect* , SDL_Texture*);

void CEV_TextureOverlay(const uint8_t*, const SDL_Rect* , SDL_Texture*);

char CEV_IsInBox(int , int , const SDL_Rect*);

char CEV_Blit(SDL_GifAnim *anim);

void CEV_SelectNxt(SDL_GifAnim *anim);

char CEV_AddModulo(int mode,int* val,int num);

char CEV_AddLim(int mode, int *val, int num);

void CEV_FitBoxInto(SDL_Rect*, const SDL_Rect*);

char CEV_InitAnim(SDL_GifAnim*, CEV_gifFile*);

#endif // GIFTOSURFACE_H_INCLUDED
