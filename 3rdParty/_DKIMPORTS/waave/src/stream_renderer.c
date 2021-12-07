/*
 *  waave, a modular audio/video engine
 * 
 *  Copyright (C) 2012  Baptiste Pellegrin
 * 
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 */

#if HAVE_CONFIG_H
#  include <config.h>
#endif

#include "stream_renderer.h"

#include "common.h"
#include "config_sdl.h"

#include "streaming_object.h"

/*!!!!!!!!!!!!!!!!!!!!!!!*/
/*    only for SDL >2.0  */
/*!!!!!!!!!!!!!!!!!!!!!!!*/
#if SDL_VERSION_ATLEAST(2,0,0)

typedef struct StreamRendererPrivate{
  /* user params */
  SDL_Renderer* targetRenderer;
  SDL_Rect userDestRect;
  int updateFlag;
  
  /* the object textures */
  SDL_Rect targetRect;
  SDL_Texture** slotTexture;
}StreamRendererPrivate;


/* !!! need objPrivate->targetRenderer, objPrivate->userDestRect !!! */
/* !!! and an initialized streaming object for srcWidth and srcHeight !!! */
static void setOutputRect(WVStreamingObject* streamObj)
{
  StreamRendererPrivate* objPrivate = (StreamRendererPrivate*)streamObj->objPrivate;
  
  /* compute ratios */
  int outputWidth;
  int outputHeight;

  if(objPrivate->userDestRect.w && objPrivate->userDestRect.h){ //user give rect ?
    outputWidth = objPrivate->userDestRect.w;
    outputHeight = objPrivate->userDestRect.h;
  }
  else{
    /* use renderer target */
    SDL_Rect rendererRect;
    SDL_RenderGetViewport(objPrivate->targetRenderer, &rendererRect);
    outputWidth = rendererRect.w;
    outputHeight = rendererRect.h;
  }

  double vidRatio = (double)streamObj->srcWidth/(double)streamObj->srcHeight;
  double outputRatio = (double)outputWidth/(double)outputHeight;
  int rem;
  
  if(vidRatio >= outputRatio){
    objPrivate->targetRect.w = outputWidth;
    vidRatio = (double)outputWidth / vidRatio; //the corresponding height
    objPrivate->targetRect.h = (int)vidRatio;

    rem = outputHeight - objPrivate->targetRect.h;
    rem /= 2;
    
    if(objPrivate->userDestRect.w && objPrivate->userDestRect.h){ //user give rect ?
      objPrivate->targetRect.x = objPrivate->userDestRect.x;
      objPrivate->targetRect.y = objPrivate->userDestRect.y + rem;
    }
    else{
      objPrivate->targetRect.x = 0;
      objPrivate->targetRect.y = rem;
    }
  }
  else{
    objPrivate->targetRect.h = outputHeight;
    vidRatio *= (double)outputHeight;    //the corresponding width
    objPrivate->targetRect.w = (int)vidRatio;

    rem = outputWidth - objPrivate->targetRect.w;
    rem /= 2;
    
    if(objPrivate->userDestRect.w && objPrivate->userDestRect.h){ //user give rect ?
      objPrivate->targetRect.y = objPrivate->userDestRect.y;
      objPrivate->targetRect.x = objPrivate->userDestRect.x + rem;
    }
    else{
      objPrivate->targetRect.y = 0;
      objPrivate->targetRect.x = rem;
    }
  }
}
  
    

static int init_streamRenderer(WVStreamingObject* streamObj)
{
  StreamRendererPrivate* objPrivate = (StreamRendererPrivate*)streamObj->objPrivate;
  
  /* set output rect */
  setOutputRect(streamObj);

  /* alloc space for the textures */
  objPrivate->slotTexture = (SDL_Texture**)malloc(streamObj->nbSlots*sizeof(SDL_Texture*));
  
  /* create textures */
  int i;
  for(i=0; i<streamObj->nbSlots; i++){
    objPrivate->slotTexture[i] = SDL_CreateTexture(objPrivate->targetRenderer, \
						SDL_PIXELFORMAT_YV12,	\
						SDL_TEXTUREACCESS_STREAMING, \
						streamObj->srcWidth,	\
						streamObj->srcHeight);
  }

  return 0;
}



static WVStreamingBuffer getBuffer_streamRenderer(WVStreamingObject* streamObj, int slotIdx)
{
  StreamRendererPrivate* objPrivate = (StreamRendererPrivate*)streamObj->objPrivate;

  /* get the texture */
  SDL_Texture* currentTexture = objPrivate->slotTexture[slotIdx];
  
  /* lock for pixel access */
  uint8_t* pixels;
  int pitch;
  SDL_LockTexture(currentTexture, NULL, (void**)&pixels, &pitch);

  /*********************/
  /* create the buffer */
  /*********************/
  WVStreamingBuffer newBuff;
  unsigned int frameSize = pitch*streamObj->srcHeight; //the texture have the
                                                      //same size

  /* the format */
  newBuff.width = streamObj->srcWidth;
  newBuff.height = streamObj->srcHeight;
  newBuff.format = PIX_FMT_YUV420P;
  
  /* fill frame plane */
  newBuff.data[0] = pixels;
  pixels += frameSize;
  newBuff.data[2] = pixels;
  pixels += frameSize/4;
  newBuff.data[1] = pixels;

  /* fill plane linesize */
  newBuff.linesize[0] = pitch;
  newBuff.linesize[1] = pitch/2;
  newBuff.linesize[2] = pitch/2;

  /* return the buffer */
  return newBuff;
}


static int releaseBuffer_streamRenderer(WVStreamingObject* streamObj, int slotIdx)
{
  StreamRendererPrivate* objPrivate = (StreamRendererPrivate*)streamObj->objPrivate;

  /* release the textures */
  SDL_UnlockTexture(objPrivate->slotTexture[slotIdx]);

  return 0;
}


static int refreshFrame_streamRenderer(WVStreamingObject* streamObj, int slotIdx)
{
  StreamRendererPrivate* objPrivate = (StreamRendererPrivate*)streamObj->objPrivate;

  /* render texture */
  SDL_RenderCopy(objPrivate->targetRenderer,\
		 objPrivate->slotTexture[slotIdx],	\
		 NULL,				\
		 &objPrivate->targetRect);

  /* show */
  if(objPrivate->updateFlag)
    SDL_RenderPresent(objPrivate->targetRenderer);
  
  return 0;
}


static int close_streamRenderer(WVStreamingObject* streamObj)
{
  StreamRendererPrivate* objPrivate = (StreamRendererPrivate*)streamObj->objPrivate;
  
  /* close all the textures */
  int i;
  for(i=0; i<streamObj->nbSlots; i++){
    if(objPrivate->slotTexture[i]){
      SDL_DestroyTexture(objPrivate->slotTexture[i]);
      objPrivate->slotTexture[i] = NULL;
    }
  }

  /* free the textures buffer */
  free(objPrivate->slotTexture);

  return 0;
}


WVStreamingObject* WV_getStreamRendererObj(SDL_Renderer* targetRenderer, SDL_Rect* userDestRect, int updateFlag)
{
  /* alloc the struct */
  WVStreamingObject* streamObj;
  streamObj = (WVStreamingObject*)malloc(sizeof(WVStreamingObject) + sizeof(StreamRendererPrivate));
  
  //void* structP = (void*)streamObj;
  WVStreamingObject* structP = streamObj;

  structP += sizeof(WVStreamingObject);
  streamObj->objPrivate = structP;

  
  /* save user params */
  StreamRendererPrivate* objPrivate = (StreamRendererPrivate*)streamObj->objPrivate;
  
  objPrivate->targetRenderer = targetRenderer;
  if(userDestRect)
    objPrivate->userDestRect = *userDestRect;
  else{
    objPrivate->userDestRect.w = 0; //this say we doesn't have a user rect
    objPrivate->userDestRect.h = 0;
  }

  objPrivate->updateFlag = updateFlag;

  /**********************/
  /* fill object params */
  /**********************/
  
  /* we use 3 slots */
  streamObj->nbSlots = 3;
  
  /* methods params */
  streamObj->getBufferMethod = WV_DYNAMIC_GET;  
  streamObj->GLRMethod = WV_ASYNC_GLR;            //async
  streamObj->getThreadSafety = WV_NO_THREAD_SAFE;
  streamObj->LRThreadSafety = WV_NO_THREAD_SAFE;   
  
  
  /* methods */
  streamObj->init = &init_streamRenderer;
  streamObj->getBuffer = &getBuffer_streamRenderer;
  streamObj->lockBuffer = NULL;
  streamObj->filterBuffer = NULL;
  streamObj->releaseBuffer = &releaseBuffer_streamRenderer;
  streamObj->refreshFrame = &refreshFrame_streamRenderer;
  streamObj->close = &close_streamRenderer;


  /*********************/
  /* return the object */
  /*********************/
  return streamObj;
}


void WV_freeStreamRendererObj(WVStreamingObject* streamObj)
{
  free(streamObj);
}


void WV_resetStreamRendererOutput(WVStreamingObject* streamObj, SDL_Renderer* targetRenderer, SDL_Rect* userDestRect)
{
  StreamRendererPrivate* objPrivate = (StreamRendererPrivate*)streamObj->objPrivate;
  
  objPrivate->targetRenderer = targetRenderer;
  if(userDestRect)
    objPrivate->userDestRect = *userDestRect;
  else{
    objPrivate->userDestRect.w = 0; //this say we doesn't have a user rect
    objPrivate->userDestRect.h = 0;
  }
  
  /* reset output rect */
  setOutputRect(streamObj);
}


#endif



 



