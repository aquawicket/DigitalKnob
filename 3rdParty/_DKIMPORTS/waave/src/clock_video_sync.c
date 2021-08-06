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

#include "clock_video_sync.h"

#include "common.h"
#include "config_sdl.h"

#include "sync_object.h"
#include "video_decoder.h"


typedef struct CVSyncPrivate{
  
  uint32_t baseTime;
  uint32_t baseClock;
  int pauseFlag;
  int modIdx;
  int seekCount;

}CVSyncPrivate;



static void CVSync_signalStateChange(WVSyncObject* sync)
{
  WV_videoDecoderSignal();
}



static void CVSync_getRefClock(WVSyncObject* sync, WVReferenceClock* refClock) 
{

  /* private contain time information */
  CVSyncPrivate* objPrivate = (CVSyncPrivate*)sync->objPrivate;

  /* get ticks */
  uint32_t currentTime = SDL_GetTicks();


  /*************************/
  /* build reference clock */
  /*************************/
   
  refClock->pauseFlag = objPrivate->pauseFlag;
  
  /****************/
  /* check modIdx */
  /****************/
  /* reajust the clock if modIdx have changed */
  if(refClock->modIdx > objPrivate->modIdx && refClock->clock != UINT32_MAX){
    
    /* check if mod change is SEEK or EOF */
    objPrivate->seekCount--;
    if(objPrivate->seekCount < 0){

      /* this was eof */
      if(sync->loopingFlag == WV_BLOCKING_STREAM){
	objPrivate->pauseFlag = 1;
	refClock->pauseFlag = 1;
      }
      objPrivate->seekCount++;
    }

    /* set the clock to the clock given by the slave */
    objPrivate->baseTime = currentTime;
    objPrivate->baseClock = refClock->clock;
    objPrivate->modIdx = refClock->modIdx;
  }
  else{
    refClock->modIdx = objPrivate->modIdx;
  }

  /* compute clock */    
  if(refClock->pauseFlag)
    refClock->clock = objPrivate->baseClock;
  else
    refClock->clock = objPrivate->baseClock + (currentTime - objPrivate->baseTime);

}



int CVSync_play(WVSyncObject* sync)
{
  CVSyncPrivate* objPrivate = (CVSyncPrivate*)sync->objPrivate;

  if(!objPrivate->pauseFlag)
    return -1;

  uint32_t currentTime = SDL_GetTicks();
  
  objPrivate->baseTime = currentTime;
  
  objPrivate->pauseFlag = 0;


  /* signal */
  sync->signalStateChange(sync);
  
  
  return 0;
}



int CVSync_pause(WVSyncObject* sync)
{
  CVSyncPrivate* objPrivate = (CVSyncPrivate*)sync->objPrivate;

  if(objPrivate->pauseFlag)
    return -1; 
 

  uint32_t currentTime = SDL_GetTicks();
  uint32_t currentClock = objPrivate->baseClock + (currentTime - objPrivate->baseTime);

  objPrivate->pauseFlag = 1;
  objPrivate->baseClock = currentClock;

  /* signal is useless */
  return 0;
}


int CVSync_seek(WVSyncObject* sync, uint32_t clock, int seekFlag)
{
  CVSyncPrivate* objPrivate = (CVSyncPrivate*)sync->objPrivate;

  /* increase count */
  objPrivate->seekCount++;

  /* check seekFlag */
  if(seekFlag == WV_PLAYING_SEEK)
    objPrivate->pauseFlag = 0;
  //useless to change base time, this will be done by getRefClock

  /* signal */
  sync->signalStateChange(sync);

  return 0;
}



WVSyncObject* WV_getCVSyncObj(void)
{
  /* alloc the struct */
  WVSyncObject* syncObj;
  
  int structSize = sizeof(WVSyncObject);
  int privateSize = sizeof(CVSyncPrivate);


  syncObj = (WVSyncObject*)malloc(structSize + privateSize);

  //void* structP = (void*)syncObj;
  WVSyncObject* structP = syncObj;

  structP += structSize;
  syncObj->objPrivate = structP;


  CVSyncPrivate* objPrivate = (CVSyncPrivate*)syncObj->objPrivate;
  
  /* fill struct */
  syncObj->signalStateChange = &CVSync_signalStateChange;
  syncObj->getRefClock = &CVSync_getRefClock;
  syncObj->play = &CVSync_play;
  syncObj->pause = &CVSync_pause;
  syncObj->seek = &CVSync_seek;
  objPrivate->baseTime = 0;
  objPrivate->baseClock = 0;
  objPrivate->pauseFlag = 1;
  objPrivate->modIdx = 0;
  objPrivate->seekCount = 0;


  /* return */
  return syncObj;
}


void WV_freeCVSyncObj(WVSyncObject* sync)
{
  free(sync);
}







