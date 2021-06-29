#ifndef USER_H_INCLUDED
#define USER_H_INCLUDED

#include <SDL.h>
#include "SDL2_gifToSurface.h"

#define GIF_ALL        -1
#define GIF_REPEAT_FOR 0
#define GIF_ONCE_FOR   1
#define GIF_FORTH_BACK 2
#define GIF_REPEAT_REV 3
#define GIF_ONCE_REV   4
#define GIF_STOP       5

#define GIF_FORWARD     0
#define GIF_BACKWARD    1

#define VERB 0

enum{FATAL_ERR =-1, FUNC_OK =0, FUNC_ERR =1};

typedef SDL_GifAnim SDL_GifAnim ;

SDL_GifAnim * SDL_GIFAnimLoad(const char*, SDL_Renderer *);

SDL_GifAnim * SDL_GIFAnimLoad_RW(SDL_RWops*, SDL_Renderer *);

char *SDL_GIFComment(SDL_GifAnim*);

char *SDL_GIFVersion(SDL_GifAnim*);

char *SDL_GIFSignature(SDL_GifAnim*);

SDL_Texture *SDL_GIFTexture(SDL_GifAnim*);

void SDL_GIFNextFrame(SDL_GifAnim*);

void SDL_GIFSpeedSet(SDL_GifAnim*, int , int );

void SDL_GIFLoopMode(SDL_GifAnim*, unsigned int );

void SDL_GIFLoopReset(SDL_GifAnim*);

char SDL_GIFAnimAuto(SDL_GifAnim*);

void SDL_GIFReverse(SDL_GifAnim*);

int SDL_GIFFrameNum(SDL_GifAnim*);

void SDL_GIFAnimFree(SDL_GifAnim*);

char SDL_GifLoopStatus(SDL_GifAnim*);

char SDL_GifMethod(SDL_GifAnim*, uint8_t);

void SDL_GifMethodSet(SDL_GifAnim*, int, uint8_t);

#endif // USER_H_INCLUDED
