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

#include "video_decoder.h"

#include "common.h"
#include "config_sdl.h"
#include "config_ffmpeg.h"


#include "waave_engine_flags.h"
#include "waave_ffmpeg.h"
#include "packet_feeder.h"
#include "sync_object.h"
#include "eof_signal.h"
#include "streaming_object.h"


/**************************/
/* the decoder manupilate */
/*  video streams         */
/**************************/

/* refresh status used in the struct */
#define NO_REFRESH 0
#define REFRESH_LAUNCHED 1
#define REFRESH_DONE 2


/* slot flag */
/* say how it is treated by refresh */
#define SLOT_FLAG_NONE 0
#define SLOT_FLAG_ALLOC 1
#define SLOT_FLAG_SKIP 2


typedef struct VideoBitStream{

  /* stream params */
  WVQueueHandle queueHdl;               //where we need getting packets 
  AVCodecContext* codec;                //the ffmpef codec needed to decode packets
  AVRational timeBase;                  //time base used for pts ans dts
  WVSyncObject* VSync;                  //the reference clock used for sync

  /* the streaming object */
  /* desc the streaming methods */
  WVStreamingObject* streamObj;
  int getInRefreshFlag;      //if get need to be done by the main thread (no thread safe)
  int LRInRefreshFlag;     //if lock need to be done by the main thread
  int getInDecodeFlag;     //decode thread (case thread safe)
  int LRInDecodeFlag;

 
  /* the frame that receive the decoded frame */
  AVFrame* decodedFrame;

  /* the swscale context */
  /* needed to load the frame buffers */
  struct SwsContext* swsCtx;


  /* the frame buffer list */
  int refreshPos;            //the buffer we need to refresh
  int writePos;              //the buffer we need to wrire 
  int fullVoidFlag;          //when writePos == refreshPos this say if the list is void (=0)
                             //or full (=1) 
  int writeAccessFlag;       //when async refresh is set, this say if we can load the 
                             //frame before refreshPos
  int refreshStatus;         //give the refresh status, NO_REFRESH, REFRESH_LAUNCHED, REFRESH_DONE
  SDL_TimerID lastTimer;

  WVStreamingBuffer* frameBuffer;     //the frame buffer list, one per slot
  uint32_t* slotFlag;         //set specials flags SLOT_FLAG_NONE, SLOT_FLAG_ALLOC, SLOT_FLAG_SKIP

  /* count the stream change */
  int modIdx; 
  int eofPos;    //eof pos, say when increase modIdx

  /* the refresh duration list */
  /* used to do delay strategy */
  int refreshDWritePos;
  uint32_t refreshDurationList[WV_REFRESH_DURATION_LIST_SIZE];
  uint32_t sortedDurationList[WV_REFRESH_DURATION_LIST_SIZE];

  /* the pts of the frames */
  int64_t* framePts;

  /* timer */
  uint32_t startTimerT; //when the timer was launched, used to compute refresh duration 
  uint32_t timerDelay;  //the delay given to the timer

  /* seek */
  int seekingDoneFlag;
  
  /* eof */
  int eofSignalPos;
  void* eofSignalHandle;

 }VideoBitStream;


/*********************/
/* timer granularity */
/*********************/
static uint32_t timerGranularity = WV_TIMER_GRANULARITY; //TODO need to be dynamically determined  

  
/***********************/
/* this the main mutex */
/***********************/
static int stateUpdatedFlag;    
static SDL_mutex* stateUpdatedMutex;
static SDL_cond*  stateUpdated;   //WAIT (decoder):"I have nothing to do, wait for command, 
                                  //               open access for writing or refresh done"
                                  //SIGNAL (event or cli): "A commans was send" or "refresh done"

/* used when clock want signal event to the decoder */
void WV_videoDecoderSignal(void)
{
  SDL_mutexP(stateUpdatedMutex);
  stateUpdatedFlag = 1;
  SDL_mutexV(stateUpdatedMutex);
  SDL_CondSignal(stateUpdated);
}


/*********************/
/* the swscale flags */
/*********************/
static int swsFlags = WV_VIDEO_DECODER_SCALE_FILTER; //TODO dynamic




/***************************/
/* the video streams       */ 
/* decoded simultaneoustly */
/***************************/ 
static VideoBitStream* videoStreams[WV_VIDEO_DECODER_MAX_STREAMS];

static int nbVideoStream;






/**********************************/
/*||||||||||||||||||||||||||||||||*/
/*       TIME FUNCTIONS           */
/*||||||||||||||||||||||||||||||||*/
/**********************************/


/* add a duration to the duration list */
static void addRefreshDuration(VideoBitStream* videoStream, uint32_t refreshDuration)
{
  /* updated vars */
  uint32_t* refreshDurationList = videoStream->refreshDurationList;
  uint32_t* sortedDurationList = videoStream->sortedDurationList;
  int refreshDWritePos = videoStream->refreshDWritePos;

  /* add the duration and save the last duration */
  uint32_t lastDuration = refreshDurationList[refreshDWritePos]; 
  refreshDurationList[refreshDWritePos] = refreshDuration;
  refreshDWritePos++;

  if(refreshDWritePos >= WV_REFRESH_DURATION_LIST_SIZE)
    refreshDWritePos = 0;

  /**************************/
  /* update the sorted list */
  /**************************/

  /* maybe nothing to do */
  if(refreshDuration == lastDuration)
    return;

  int i;
  
  /* the case of the removed is before the added */
  if(lastDuration < refreshDuration){
    i=0;
    /* search the removed */
    while(sortedDurationList[i] != lastDuration)
      i++;
    
    /* go after it */
    i++;

    /* shift the list while needed */
    while(i < WV_REFRESH_DURATION_LIST_SIZE){
      if(sortedDurationList[i] < refreshDuration)
	sortedDurationList[i-1] = sortedDurationList[i];
      
      else{
	/* it's time to put the new duration */
	sortedDurationList[i-1] = refreshDuration;
	break;
      }

      i++;
    }

    /* may the new value is the greater */
    if(i == WV_REFRESH_DURATION_LIST_SIZE)
      sortedDurationList[i-1] = refreshDuration;
  }

      
  /* the case the removed is after the added */
  else{
    i = WV_REFRESH_DURATION_LIST_SIZE - 1;
    
    /* search the removed */
    while(sortedDurationList[i] != lastDuration)
      i--;

    /* go after it */
    i--;

    /* shift the list while needed */
    while(i >= 0){
      if(sortedDurationList[i] > refreshDuration)
	sortedDurationList[i+1] = sortedDurationList[i];

      else{
	/*it's time to put the new duration */
	sortedDurationList[i+1] = refreshDuration;
	break;
      }

      i--;
    }
     
    /* may the new duration is the first of the list */
    if(i == -1)
      sortedDurationList[i+1] = refreshDuration;
  }

  /* reset vars */
  videoStream->refreshDWritePos = refreshDWritePos;

}



/* get the median refresh duration */
static uint32_t getRefreshDuration(VideoBitStream* videoStream)
{
  return videoStream->sortedDurationList[WV_REFRESH_DURATION_MED_POS];
}    


/* get the pts closk of the frame at refreshPos */
static uint32_t getPtsClock(VideoBitStream* videoStream)
{
  /* this say that we don't have valid pts */
  if(videoStream->framePts[videoStream->refreshPos] == AV_NOPTS_VALUE)
    return UINT32_MAX;

  double framePts = (double)(videoStream->framePts[videoStream->refreshPos]);
  
  framePts *= av_q2d(videoStream->timeBase);
  framePts *= 1000;

  return (uint32_t)framePts;
}



      
/**********************************/
/*||||||||||||||||||||||||||||||||*/
/*       REFRESH TIMER            */
/*||||||||||||||||||||||||||||||||*/
/**********************************/


/* the timer will call this function */
/* to refresh the frame by push an event */
/* the param is the VideoBitStream pointer */
static uint32_t refreshTimerCallback(uint32_t delay, void* param)
{
  /* push the REFRESH_EVENT */
  SDL_Event event;
  
  event.type = WV_REFRESH_EVENT;
  event.user.data1 = param;
  event.user.code = 0; //just a refresh

  SDL_PushEvent(&event);

  /* the timer doesn't loop */
  return 0;
}


/* used for no delay refresh (!specialFlag) */
/* or for alloc or skip (specialFlag) */ 
static void launchRefreshImmediately(VideoBitStream* videoStream, int specialFlag)
{
  /* push the event */
  SDL_Event event;
  
  event.type = WV_REFRESH_EVENT;
  event.user.data1 = videoStream;
  event.user.code = specialFlag; //say if is a special refresh (alloc or skip)

  /* launch */
  videoStream->refreshStatus = REFRESH_LAUNCHED;
  SDL_PushEvent(&event);
}


/* the main timer function */
/* it compute the timer delay to display */
/* the frame at the right time */
static void launchRefreshTimer(VideoBitStream* videoStream)
{
  /* save when the timer start to compute refresh duration */
  videoStream->startTimerT = SDL_GetTicks();
  

  /***********************/
  /* check the ref clock */
  /***********************/
  WVReferenceClock refClock;
  WVSyncObject* VSync = videoStream->VSync;

  /* give getRefClock input */
  uint32_t ptsClock = getPtsClock(videoStream);
  refClock.clock = ptsClock;
  refClock.modIdx = videoStream->modIdx;

  /* get the reference clock */
  VSync->getRefClock(VSync, &refClock);
  
  /* don't refresh if the video modIdx is after the clock modIdx */
  if(videoStream->modIdx > refClock.modIdx)
    return;
  
  /* if the video is in late refresh immediately */
  if(videoStream->modIdx < refClock.modIdx){
    videoStream->timerDelay = 0;
    launchRefreshImmediately(videoStream, 0);
    return;
  }

  /* don't refresh if clock is paused */
  if(refClock.pauseFlag)
    return;
  


  /*********************/
  /* delay computation */
  /*********************/
  
  /* TARGET DELAY */
  /* the delay we ideally want */
  uint32_t targetDelay;

  /* get median refresh duration */
  uint32_t refreshDuration = getRefreshDuration(videoStream);

  /* if we doesn't have a valid pts use the last delay */
  if(ptsClock == UINT32_MAX)
    targetDelay = videoStream->timerDelay;
    
  /* else compute */
  else{  
    uint32_t subT = refClock.clock + refreshDuration + 1; //time to remove to get delay 
                                                      //the +1 is because the timer is launched at
                                                      //the next ms
    /* if needed refresh immediately */
    if(subT > ptsClock){
      videoStream->timerDelay = 0;
      launchRefreshImmediately(videoStream, 0);
      return;
    }

  
    /* else compute target delay */
    targetDelay = ptsClock - subT;
  }

  /* TIMER DELAY */
  /* compute the timer delay */
  /* timer granularity do that it differ of target delay */
  uint32_t timerDelay;
  uint32_t delayQ = targetDelay/timerGranularity;
  uint32_t delayR = targetDelay%timerGranularity;


  timerDelay = timerGranularity*delayQ;

  if(delayR <= (timerGranularity/2))  //take the nearest delay 
    timerDelay += 0;
  else
    timerDelay += timerGranularity;


  /* we need to give the delay to sdl with the +1 delay for timer launching */
  timerDelay++;
  
  /* save the delay and launch the timer */
  videoStream->refreshStatus = REFRESH_LAUNCHED;
  videoStream->timerDelay = timerDelay;
  videoStream->lastTimer = SDL_AddTimer(timerDelay, refreshTimerCallback, (void*)videoStream);
  
}




/**********************************/
/*||||||||||||||||||||||||||||||||*/
/*       REFRESH EVENT            */
/*||||||||||||||||||||||||||||||||*/
/**********************************/

/* the refresh event do two things */
/* if async GLR is set it open access to the frame before refreshPos */
/* it refresh the frame and save the refresh duration */


/* this function open access the the previous frame */
static void openAccess(VideoBitStream* videoStream)
{
  /* useless to lock data with a mutex, R/W are sequencials */
  videoStream->writeAccessFlag = 1;
  
  /* signal state change */
  SDL_mutexP(stateUpdatedMutex);
  stateUpdatedFlag = 1;
  SDL_mutexV(stateUpdatedMutex);
  SDL_CondSignal(stateUpdated);

}


/* to signal that refresh is done and save refresh duration */
static void refreshDone(VideoBitStream* videoStream, uint32_t refreshDoneT)
{
  /* save the refresh duration */
  uint32_t startTimerT = videoStream->startTimerT;
  uint32_t timerDelay = videoStream->timerDelay;
  addRefreshDuration(videoStream, refreshDoneT - startTimerT - timerDelay);
  
  /* set the refresh flag */
  videoStream->refreshStatus = REFRESH_DONE;

  /* signal state change */
  SDL_mutexP(stateUpdatedMutex);
  stateUpdatedFlag = 1;
  SDL_mutexV(stateUpdatedMutex);
  SDL_CondSignal(stateUpdated);
}


/* do alloc or skip when event.user.code is set */
static void specialRefresh(SDL_Event* event)
{
  VideoBitStream* videoStream = event->user.data1;
  WVStreamingObject* streamObj = videoStream->streamObj;
  int refreshPos = videoStream->refreshPos;
  int writePos = videoStream->writePos;
  WVStreamingBuffer* frameBuffer = videoStream->frameBuffer;

  /* check for alloc */
  if((videoStream->slotFlag[writePos] & SLOT_FLAG_ALLOC)){
      
    /* alloc */
    if(videoStream->getInRefreshFlag)
      frameBuffer[writePos] = streamObj->getBuffer(streamObj, writePos);
    
    if(streamObj->lockBuffer && videoStream->LRInRefreshFlag)
      streamObj->lockBuffer(streamObj, writePos);
    
    videoStream->slotFlag[writePos] ^= SLOT_FLAG_ALLOC;
  }

  /* check for skip */
  if((videoStream->slotFlag[refreshPos] & SLOT_FLAG_SKIP)){
    
    /* skip */
    if(streamObj->releaseBuffer && videoStream->LRInRefreshFlag)
      streamObj->releaseBuffer(streamObj, refreshPos);
    
    videoStream->slotFlag[refreshPos] ^= SLOT_FLAG_SKIP;
    videoStream->slotFlag[refreshPos] ^= SLOT_FLAG_ALLOC;
  }

  /* ok refresh done */
  videoStream->refreshStatus = NO_REFRESH; //we don't encrease refreshPos

  /* signal */
  SDL_mutexP(stateUpdatedMutex);
  stateUpdatedFlag = 1;
  SDL_mutexV(stateUpdatedMutex);
  SDL_CondSignal(stateUpdated);
}



/* now the public function that refresh the current frame */
/* and open access to the previous */
/* it take care to Get/Lock/Release if there are not thread safe */
void WV_refreshVideoFrame(SDL_Event* event)
{
  /*************************/
  /* check special refresh */
  /*************************/
  if(event->user.code){
    specialRefresh(event);
    return;
  }
  
  
  /***********/
  /* refresh */
  /***********/
  /* get the stream , the streamingObject and the frame buffer list  */
  VideoBitStream* videoStream = event->user.data1;
  WVStreamingObject* streamObj = videoStream->streamObj;
  WVStreamingBuffer* frameBuffer = videoStream->frameBuffer;
  
  /* get the current frame and the previous frame indexes */
  int refreshPos = videoStream->refreshPos;
  int nbSlots = streamObj->nbSlots;
  
  int prevPos = refreshPos;
  prevPos--;
  if(prevPos < 0)
    prevPos = nbSlots - 1;

  
  /***************************/
  /* open the previous slot  */
  /***************************/
  if(streamObj->GLRMethod == WV_ASYNC_GLR){  //only done in async GLR
    
    /* if alloc is needed  */
    if( videoStream->slotFlag[prevPos] & SLOT_FLAG_ALLOC ){

      /* get buffer : previous */
      //if LR is not thread safe we need to do GET here, even if it is thread safe 
      if(videoStream->getInRefreshFlag){
	frameBuffer[prevPos] = streamObj->getBuffer(streamObj, prevPos);  //get the buffer pointer
      }

      /* lock buffer : previous */
      if(streamObj->lockBuffer && videoStream->LRInRefreshFlag){
	streamObj->lockBuffer(streamObj, prevPos);
      }

      videoStream->slotFlag[prevPos] ^= SLOT_FLAG_ALLOC;
    }

    /* open access : previous */
    openAccess(videoStream);
  }
  
  
  /***************************/
  /* close the current slot  */
  /***************************/
  //useless to check slotFlag
  if(videoStream->getInRefreshFlag || videoStream->LRInRefreshFlag){
    if(streamObj->releaseBuffer && videoStream->LRInRefreshFlag){
      streamObj->releaseBuffer(streamObj, refreshPos);
    }

    videoStream->slotFlag[refreshPos] |= SLOT_FLAG_ALLOC;
  }
  


  /****************************/
  /* refresh the current slot */
  /****************************/
  if(streamObj->refreshFrame){
    streamObj->refreshFrame(streamObj, refreshPos);
  }


  /**************************/
  /* save refresh done time */
  /**************************/
  uint32_t refreshDoneT = SDL_GetTicks();

  

  /*************************/
  /* open the current slot */
  /*************************/
  if(streamObj->GLRMethod == WV_SYNC_GLR){

    /* if alloc is needed  */
    if( videoStream->slotFlag[refreshPos] & SLOT_FLAG_ALLOC ){

      /* get buffer : current */
      //if LR is not thread safe we need to do GET here, even if it is thread safe 
      if(videoStream->getInRefreshFlag){
	frameBuffer[refreshPos] = streamObj->getBuffer(streamObj, refreshPos); 
      }
    

      /* lock buffer : current */
      if(streamObj->lockBuffer && videoStream->LRInRefreshFlag){
	streamObj->lockBuffer(streamObj, refreshPos);
      }
      
      
      videoStream->slotFlag[refreshPos] ^= SLOT_FLAG_ALLOC;
    }
  }


  /****************/
  /* refresh done */
  /****************/
  refreshDone(videoStream, refreshDoneT);
}



/*******************************/
/* ||||||||||||||||||||||||||| */
/*          SEEKING            */
/* ||||||||||||||||||||||||||| */
/*******************************/

void WV_startVideoSeeking(WVVideoStreamHandle streamHdl)
{
  VideoBitStream* seekingStream = (VideoBitStream*)streamHdl;
  
  seekingStream->seekingDoneFlag = 0;
}


/* clean the frame list */
static void seekVideoStream(VideoBitStream* videoStream)
{
  /* put seeking done */
  videoStream->seekingDoneFlag = 1;
  

  /**********************************/
  /* increase the mod count         */
  /* all the frame will be skipped  */
  /**********************************/
  videoStream->modIdx++;

  /* delete eof vars */
  videoStream->eofPos = -1;
    

  /* free the codec internal buffers */
  avcodec_flush_buffers(videoStream->codec);

  WVStreamingObject* streamObj = videoStream->streamObj;
  int nbSlots = streamObj->nbSlots;  

  
  /* if the list is void, nothing to do */
  if(videoStream->refreshPos == videoStream->writePos && videoStream->fullVoidFlag == 0)
    return;

  /* try to remove the last timer */
  /* we let sdl see if the timer already done */
  SDL_bool timerFreeFlag;

  if(videoStream->refreshStatus == REFRESH_LAUNCHED){
    //!!! on some systems, Remove timer return false event if the timer is removed ??
    timerFreeFlag = SDL_RemoveTimer(videoStream->lastTimer);
    videoStream->refreshStatus = NO_REFRESH;
  }
  else{
    timerFreeFlag = SDL_TRUE;
    
    /* go to the next refreshPos */
    if(videoStream->refreshStatus == REFRESH_DONE){
      videoStream->refreshPos++;
      /* check for return */
      if(videoStream->refreshPos >= nbSlots)
	videoStream->refreshPos = 0;
      /* check for void */
      if(videoStream->refreshPos == videoStream->writePos)
	videoStream->fullVoidFlag = 0; //void
      
      videoStream->writeAccessFlag = 0; //lock access (for async)
      videoStream->refreshStatus = NO_REFRESH;
    }
  }

  /* reset */
  if(timerFreeFlag == SDL_TRUE){
    videoStream->writePos = videoStream->refreshPos;
    videoStream->fullVoidFlag = 0; //void
  }
  else{
    videoStream->writePos = videoStream->refreshPos + 1;
    if(videoStream->writePos >= nbSlots)
      videoStream->writePos = 0;
  }

  
    
}

  

 
/**********************************/
/*||||||||||||||||||||||||||||||||*/
/*       VIDEO DECODER            */
/*||||||||||||||||||||||||||||||||*/
/**********************************/

/* the decoder need to know if he can write to the frame buffer */
static int canWrite(VideoBitStream* videoStream)
{
  /* check if the list is full/void */
  if(videoStream->writePos == videoStream->refreshPos){
    if(videoStream->fullVoidFlag == 1)
      return 0;                         //if the list is full we can't write
    else
      return 1;                         //if the list is void, writePos != refreshPos-1
  }

  /* in the async case, check the slot before refreshPos */
  if(videoStream->streamObj->GLRMethod == WV_ASYNC_GLR){
    int prevPos;
    prevPos = videoStream->refreshPos;
    prevPos --;
    if(prevPos < 0)
      prevPos = videoStream->streamObj->nbSlots - 1;

    if(videoStream->writePos == prevPos && !videoStream->writeAccessFlag)
      return 0;
  }

  return 1;
}
  

/* check the loading method */
static void loadVideoFrame(VideoBitStream* videoStream, AVFrame* decodedFrame)
{
  WVStreamingObject* streamObj = videoStream->streamObj;
  
  /******************************/
  /*   check getBuffer method   */
  /******************************/
  //can't use getInRefreshFlag because may we don't do get at all 
  if(videoStream->getInDecodeFlag){
    videoStream->frameBuffer[videoStream->writePos] = streamObj->getBuffer(streamObj, videoStream->writePos);
  }
  
  /*********************/
  /* check lock method */
  /*********************/
  if(streamObj->lockBuffer && videoStream->LRInDecodeFlag){
    streamObj->lockBuffer(streamObj, videoStream->writePos);
  }

  /********/
  /* load */
  /********/
  WVStreamingBuffer* outputBuffer = &(videoStream->frameBuffer[videoStream->writePos]); 
  
  /* check if we can use the context */
  /* we see that we can change buffer size and format */
  videoStream->swsCtx = sws_getCachedContext(videoStream->swsCtx,	\
					     videoStream->codec->width,	\
					     videoStream->codec->height,\
					     videoStream->codec->pix_fmt, \
					     outputBuffer->width,\
					     outputBuffer->height,\
					     outputBuffer->format,\
					     swsFlags, NULL, NULL, NULL);

  /* scale */
  sws_scale(videoStream->swsCtx,\
	    (const uint8_t* const*)decodedFrame->data, decodedFrame->linesize,\
	    0, videoStream->codec->height,\
	    outputBuffer->data, outputBuffer->linesize);


  /***********************/
  /* check buffer filter */
  /***********************/
  if(streamObj->filterBuffer)
    streamObj->filterBuffer(streamObj, videoStream->writePos, outputBuffer);



  /************************/
  /* check release method */
  /************************/
  if(streamObj->releaseBuffer && videoStream->LRInDecodeFlag){
    streamObj->releaseBuffer(streamObj, videoStream->writePos);
  }


}


static int decodeVideo(VideoBitStream* videoStream)
{
  /*******************************/
  /* --------------------------- */
  /* decode while we get a frame */
  /* --------------------------- */
  /*******************************/

  int got_picture = 0;
  AVFrame* decodedFrame = videoStream->decodedFrame;
  
  while(!got_picture){
  
    /*******************/
    /* get a video pkt */
    /*******************/
    AVPacket* pkt = WV_packetQueueGet(videoStream->queueHdl, WV_QUEUE_GET_WAIT);

    /* we check if is a speciak pkt */
    /* if this is the case, do the corresponding job */
    while(pkt->data == NULL){
    
      /*--------------*/
      /* the eof case */
      /*--------------*/
      if(pkt->flags == WV_PACKET_FLAG_EOF){
	videoStream->eofPos = videoStream->writePos; //when we increase modIdx
	avcodec_flush_buffers(videoStream->codec);
      }
      
      /*---------------*/
      /* the seek case */
      /*---------------*/
      if(pkt->flags == WV_PACKET_FLAG_SEEK){
	seekVideoStream(videoStream);    //it's useless to check if seekingDone
                                         //is set because if the seeking is done by a command
                                         //the seeking pkt is removed
      }
      
      
      /* free the special pkt and get another */
      //don't use av_free_packet !!!
      free(pkt);
      pkt = WV_packetQueueGet(videoStream->queueHdl, WV_QUEUE_GET_WAIT);
    }


    /******************/
    /* decode the pkt */
    /******************/
    WV_decodeVideo(videoStream->codec, decodedFrame, &got_picture, pkt);
    

    /******************/
    /*  free the pkt  */
    /******************/
    av_free_packet(pkt);  //seem ffmpeg never need partials pkts
    free(pkt);
  }

  
  /**********************/
  /* ------------------ */
  /* get the pts of the */
  /* frame and save it  */
  /* ------------------ */
  /**********************/
  
  videoStream->framePts[videoStream->writePos] = WV_getFramePts(decodedFrame);
  //if we have AV_NOPTS_VALUE, the getPtsClock function will return UINT32_MAX
    

  /**************************/
  /* now scale and save the */
  /* output frame           */
  /**************************/
  loadVideoFrame(videoStream, decodedFrame);

  /* done */
  return 0;
}
   

  
  


/********************************/
/*||||||||||||||||||||||||||||||*/
/*     THE DECODER  COMMANDS    */
/*||||||||||||||||||||||||||||||*/
/********************************/

/* the list of decoder commands */
#define VIDEO_DECODER_NO_COMMAND 0
#define VIDEO_DECODER_ADD_STREAM 1
#define VIDEO_DECODER_DEL_STREAM 2
#define VIDEO_DECODER_SEEK 3
//pauseVideo doesn't need to send a command to the decoder
//playVideo  doesn't need to send a command to the decoder
#define VIDEO_DECODER_QUIT 4

static int decoderCommand;    //where the client put the command

static SDL_mutex* cmdMutex;
static SDL_cond* cmdExecuted;  //the client need to wait for command execution 
                               //before continuing
                               //WAIT (client) : "I have sent you a command say me 
                               //                 the work is done"
                               //SIGNAL (decoder) : "Well, command terminated"


static int deleteStreamIdx;               //when we delete we give the stream idx to the decoder
static WVVideoStreamHandle seekingStreamHandle;  //when we seek we give the stream to the decoder 



/* !!! very important function !!! */
/* used each time we send a command to the decoder */
/* send a command, signal state change, and wait for execution */
static void sendDecoderCommand(int cmd)
{
  /* send the command to the decoder */
  SDL_mutexP(cmdMutex);
  decoderCommand = cmd;
  
  /* signal that state is updated */
  SDL_mutexP(stateUpdatedMutex);    //change the state flag
  stateUpdatedFlag = 1;
  SDL_mutexV(stateUpdatedMutex);

  SDL_CondSignal(stateUpdated);  //say to the decoder that it can thread commands
                                 //or restart decoding                                  
                                 //if he was waiting 
  
  /* wait for command execution */
  SDL_CondWait(cmdExecuted, cmdMutex); 
  
  /* release command variable  */
  SDL_mutexV(cmdMutex);
}





/***************************************************/
/*  The first command : VIDEO_DECODER_ADD_STREAM   */
/*  -first the user space function                 */
/*  -next the decoder space function               */
/***************************************************/

/* return a stream handle */
WVVideoStreamHandle WV_addVideoStream(WVQueueHandle queueHdl,   \
				      AVCodecContext* codec,    \
				      AVRational timeBase,      \
				      WVStreamingObject* streamObj,	\
				      WVSyncObject* VSync)
  
{
  /****************************/
  /* fill the streamObj struct*/
  /* there values are needed  */
  /* by init()                */
  /****************************/
  streamObj->srcWidth = codec->width;
  streamObj->srcHeight = codec->height;
  streamObj->srcFormat = codec->pix_fmt;

  /* now init the streaming obj */
  if(streamObj->init)
    streamObj->init(streamObj);

  /**********************/
  /*  to do             */
  /* case nbSlots == 0  */
  /**********************/
  

  int nbSlots = streamObj->nbSlots;
  

  /*******************/
  /* alloc a stream  */
  /*******************/
  VideoBitStream* newStream;
  
  int structSize = sizeof(VideoBitStream);
  int frameBufferSize = nbSlots * sizeof(WVStreamingBuffer);
  int slotFlagSize = nbSlots * sizeof(int);
  int framePtsSize = nbSlots * sizeof(int64_t);
  
  int totalSize =  structSize + frameBufferSize + slotFlagSize + framePtsSize; 

  newStream = (VideoBitStream*)malloc(totalSize);

  
  /*******************/
  /* fill the struct */
  /*******************/
 
  /* user params */
  newStream->queueHdl = queueHdl;
  newStream->codec = codec;
  newStream->timeBase = timeBase;
  newStream->VSync = VSync;
  
  newStream->streamObj = streamObj;

  /* the frame to decode */
  newStream->decodedFrame = avcodec_alloc_frame();

  /* the swscale context */
  newStream->swsCtx = NULL;  //use getCatchedContext
  
     
  /******************************/
  /* init the frame buffer list */
  /******************************/
  newStream->refreshPos = 0;  
  newStream->writePos = 0;
  newStream->fullVoidFlag = 0; //void 

  newStream->writeAccessFlag = 0;
  newStream->refreshStatus = NO_REFRESH;

  /* after the struct we put the frame buffers desc */
  //void* structP = (void*)newStream;
  VideoBitStream* structP = newStream;

  structP += structSize;
  newStream->frameBuffer = (WVStreamingBuffer*)structP;

  /* after the frame buffers, the flags */
  structP += frameBufferSize;
  newStream->slotFlag = (uint32_t*)structP;


  /*****************************/
  /* if we have static buffers */
  /* get it now                */
  /*****************************/
  int i;

  if(streamObj->getBuffer && streamObj->getBufferMethod == WV_STATIC_GET){
    for(i=0; i<streamObj->nbSlots; i++){
      newStream->frameBuffer[i] = streamObj->getBuffer(streamObj, i);
    }
  }

  /****************************/
  /* check if get or lock are */
  /* not thread safe          */
  /****************************/
  newStream->LRInRefreshFlag = 0;  //check if lock in done in refresh (no thread safe)
  newStream->getInRefreshFlag = 0;   //if dynamic get and  if lock or get are no thread safe
  newStream->LRInDecodeFlag = 0;
  newStream->getInDecodeFlag = 0;
  

  /* lock in refresh */
  if((streamObj->lockBuffer || streamObj->releaseBuffer)&&\
     streamObj->LRThreadSafety != WV_THREAD_SAFE){
    newStream->LRInRefreshFlag = 1;
  }
  
  /* get in refresh */
  if(streamObj->getBuffer &&\
     streamObj->getBufferMethod == WV_DYNAMIC_GET &&\
     (streamObj->getThreadSafety != WV_THREAD_SAFE || (streamObj->lockBuffer && streamObj->LRThreadSafety != WV_THREAD_SAFE))){
    newStream->getInRefreshFlag = 1;
  }

  
  /* lock in decode */
  if((streamObj->lockBuffer || streamObj->releaseBuffer) &&	\
     streamObj->LRThreadSafety == WV_THREAD_SAFE){
    newStream->LRInDecodeFlag = 1;
  }

  /* get in decode */
  if(streamObj->getBuffer &&				\
     streamObj->getBufferMethod == WV_DYNAMIC_GET &&\
     streamObj->getThreadSafety == WV_THREAD_SAFE && \
     (!streamObj->lockBuffer || (streamObj->LRThreadSafety == WV_THREAD_SAFE))){
    newStream->getInDecodeFlag = 1;
  }


  /*******************************/
  /* init the buffer if get or   */
  /* lock are not thread safe    */
  /*******************************/
  
  /* alloc the first is needed */
  if(newStream->getInRefreshFlag)
    newStream->frameBuffer[0] = streamObj->getBuffer(streamObj, 0);

  if(streamObj->lockBuffer && newStream->LRInRefreshFlag)
    streamObj->lockBuffer(streamObj, 0);

  if(newStream->getInRefreshFlag || newStream->LRInRefreshFlag)
    newStream->slotFlag[0] = SLOT_FLAG_NONE;
  
  
  /* the other slots are not allocated now  */
  /* we doesn't want wasting time to alloc */
  /* all the buffers */
  
  /* the last is treated separately */
  if(newStream->getInRefreshFlag || newStream->LRInRefreshFlag){
    for(i=1; i<streamObj->nbSlots; i++){ 
      newStream->slotFlag[i] = SLOT_FLAG_ALLOC; //this erase the other bits 
    }
  }

    
  /**************/
  /* the modIdx */
  /**************/
  
  /* the stream directly try to play */
  /* so we put mod idx to 1 */
  newStream->modIdx = 1;
  newStream->eofPos = -1;
  

  /*****************************/
  /* the refresh duration list */
  /*****************************/
  newStream->refreshDWritePos = 0;

  for(i=0; i<WV_REFRESH_DURATION_LIST_SIZE; i++){
    newStream->refreshDurationList[i] = 0;
    newStream->sortedDurationList[i] = 0;
  }


  /****************/
  /* the pts list */
  /****************/
  
  /* after the struct and the frame buffers */
  structP += slotFlagSize;

  newStream->framePts = (int64_t*)structP;

  for(i=0; i<streamObj->nbSlots; i++)
    newStream->framePts[i] = AV_NOPTS_VALUE;
 
  /* timer */
  newStream->startTimerT = 0;
  newStream->timerDelay = 0;

  /* eof */
  newStream->eofSignalPos = -1;
  newStream->eofSignalHandle = NULL;
 
  /******************************/
  /* add the stream to the list */
  /******************************/
  videoStreams[nbVideoStream] = newStream;

  /* send the command */
  sendDecoderCommand(VIDEO_DECODER_ADD_STREAM);

  // the decoder increase nbVideoStream

  /* it's ok return the new stream */
  return (WVVideoStreamHandle)newStream;
}


static void videoDecoderAddStream(void)
{
  /* update the stream count */
  nbVideoStream++;
}




/***************************************************/
/*  The command : VIDEO_DECODER_DEL_STREAM         */
/*  -first freeing method                          */
/*  -next the user space function                  */
/*  -next the decoder space function               */
/***************************************************/
static void freeVideoStream(VideoBitStream* deletedStream)
{
  /* remove the last timer if needed */
  if(deletedStream->refreshStatus == REFRESH_LAUNCHED){
    //!!! on some systems, Remove timer return false event if the timer is removed !!
    SDL_RemoveTimer(deletedStream->lastTimer);
    deletedStream->refreshStatus = NO_REFRESH;
  }

  /* !!! can't close the streaming obj !!! */
  /* !!! this need to be done by the   !!! */
  /* !!! main thread                   !!! */
  //WVStreamingObject* closingObj = deletedStream->streamObj;
  //closingObj->close(closingObj);

  /* free the decoded frame */
  av_free(deletedStream->decodedFrame);

  /* free the swscale context */
  if(deletedStream->swsCtx)
    sws_freeContext(deletedStream->swsCtx);

  /* free the stream struct */
  /* it was allocated in one time */
  free(deletedStream);
}



int WV_delVideoStream(WVVideoStreamHandle streamHdl)
{
  /* find the stream */
  int i = 0;
  while(videoStreams[i] != streamHdl && i<nbVideoStream)
    i++;

  /* found ? */
  if(i == nbVideoStream)
    return -1;              //cannot find the stream
  //else the stream is in videoStreams[i]

  /* give the command parameter */
  deleteStreamIdx = i;

  /* ! save the streaming object  ! */
  /* ! to later closing           ! */
  VideoBitStream* deletedStream = (VideoBitStream*)streamHdl;
  WVStreamingObject* closingObj = deletedStream->streamObj;
  
  /* and send the command */
  sendDecoderCommand(VIDEO_DECODER_DEL_STREAM);
  
  /* ! now we can close the streaming object  ! */
  if(closingObj->close)
    closingObj->close(closingObj);

  /* ok the stream is deleted */
  return 0;
}

static void videoDecoderDelStream(void)
{
  /* get the deleted stream */
  VideoBitStream* deletedStream = videoStreams[deleteStreamIdx];
  
  /* free the stream */
  freeVideoStream(deletedStream);

  /* now shift the other streams */
  /* we use the variable deleteStreamIdx to do the job */
  nbVideoStream--;     //update the stream count now !
  while(deleteStreamIdx < nbVideoStream){  //shift the list  
    videoStreams[deleteStreamIdx] = videoStreams[deleteStreamIdx+1];
    deleteStreamIdx++;
  }

}



/*****************************/
/* EOF signal                */
/* set the EOF signal handle */
/*****************************/
void WV_setVideoEOFSignalHandle(WVVideoStreamHandle streamHdl, void* eofSignalHandle)
{
  VideoBitStream* videoStream = (VideoBitStream*)streamHdl;

  /* set */
  videoStream->eofSignalHandle = eofSignalHandle;
}
  

void WV_stopVideoEOFSignalHandle(WVVideoStreamHandle streamHdl)
{
  VideoBitStream* videoStream = (VideoBitStream*)streamHdl;

  /* unset */
  videoStream->eofSignalHandle = NULL;
}



/***************************************************/
/*  The command : VIDEO_DECODER_SEEK               */
/*  -first the user space function                 */
/*  -next the decoder space function               */
/***************************************************/

/* this command is used to speed up the seek */
/* if the decoder doesn't have read the seek pkt */
/* this command force the seek */

int WV_seekVideo(WVVideoStreamHandle streamHdl)
{
  /* recast the pointer */
  seekingStreamHandle = streamHdl;

  /* send the command */
  sendDecoderCommand(VIDEO_DECODER_SEEK);

  //the decoder remove the seeking pkt (if needed)
  // and seek (if not already done)

  /* ok, return */
  return 0;
}


static void videoDecoderSeek(void)
{
  /* read command parameter */
  VideoBitStream* seekingStream = (VideoBitStream*)seekingStreamHandle; 
  
  /* if seeking is already done by reading a seeking pkt return */
  if(seekingStream->seekingDoneFlag)
    return;

  /* else */
  /* remove the seeking pkt */
  /*!!! the seeking pkt is the first pkt of the queue !!!*/
  /*!!! see how we seek in the packet feeder          !!!*/
  
  AVPacket* seekingPkt = WV_packetQueueGet(seekingStream->queueHdl, WV_QUEUE_GET_DOESNT_WAIT);
  //TODO assert we have a pkt
  //TODO assert that is a seeking pkt
  free(seekingPkt);

  /* now seek */
  seekVideoStream(seekingStream);

}





/***************************************************/
/*  The command : VIDEO_DECODER_QUIT               */
/*  -first the user space function                 */
/*  -next the decoder space function               */
/***************************************************/

int WV_videoDecoderShutdown(void)
{
  /* ! save all the streaming objects ! */
  /* ! for later close                ! */
  WVStreamingObject** decoderObj = (WVStreamingObject**)malloc(nbVideoStream * sizeof(WVStreamingObject*));
  int nbDecoderObj = nbVideoStream;

  int i;
  for(i=0; i<nbDecoderObj; i++)
    decoderObj[i] = videoStreams[i]->streamObj;

  /* send directly the command */
  sendDecoderCommand(VIDEO_DECODER_QUIT);

  //the decoder free all the streams,
  //and stop his thread

  /* ! free the saved streaming objects ! */
  WVStreamingObject* closingObj;

  for(i=0; i<nbDecoderObj; i++){
    closingObj = decoderObj[i];
    if(closingObj->close)
      closingObj->close(closingObj);
  }

  free(decoderObj);

  /* now close thread communication */
  SDL_DestroyMutex(stateUpdatedMutex);
  SDL_DestroyCond(stateUpdated);

  SDL_DestroyMutex(cmdMutex);
  SDL_DestroyCond(cmdExecuted);

  /* it's ok */
  return 0;
}

static void videoDecoderQuit(void)
{
  /* free all the streams */
  int i;
  for(i=0; i<nbVideoStream; i++)
    freeVideoStream(videoStreams[i]);
}





/************************************/
/*||||||||||||||||||||||||||||||||||*/
/*       THE DECODER THREAD         */
/*||||||||||||||||||||||||||||||||||*/
/************************************/

static int videoDecoderThread(void* opaque)
{
  int needRelaunchFlag = 0; //at start we don't have streams

  while(1){

    /*********************/
    /* check for waiting */
    /*********************/
    SDL_mutexP(stateUpdatedMutex);

    if(!stateUpdatedFlag && !needRelaunchFlag){
      /* if nothing append and we have no lacking, wait */
      SDL_CondWait(stateUpdated, stateUpdatedMutex);
    }
    

    /* reinit state variables */
    stateUpdatedFlag = 0;            //we will see if something append during the loop
    needRelaunchFlag = 0;       

    SDL_mutexV(stateUpdatedMutex);
    
    
    /**************************/
    /* check for user command */
    /**************************/
    SDL_mutexP(cmdMutex);
    
    if(decoderCommand){
      switch(decoderCommand){
	
      case VIDEO_DECODER_ADD_STREAM:
	videoDecoderAddStream();
	break;

      case VIDEO_DECODER_DEL_STREAM:
	videoDecoderDelStream();
	break;
	
      case VIDEO_DECODER_SEEK:
	videoDecoderSeek();
	break;
	
      case VIDEO_DECODER_QUIT:
	videoDecoderQuit();
	decoderCommand = VIDEO_DECODER_NO_COMMAND;
	SDL_mutexV(cmdMutex);
	SDL_CondSignal(cmdExecuted);
	return 0;                  //get out of this loop !!!
	break;
      }
      
      /* the command is executed, say this to the client */
      decoderCommand = VIDEO_DECODER_NO_COMMAND;
      SDL_mutexV(cmdMutex);                     
      SDL_CondSignal(cmdExecuted);
    }
    else{    //else just release the cmd mutex 
      SDL_mutexV(cmdMutex);
    }


    /***************************/
    /* ----------------------- */
    /*     check all streams   */
    /* ----------------------- */
    /***************************/
    
    int i;
    VideoBitStream* currStream;
    
    for(i=0; i<nbVideoStream; i++){
      currStream = videoStreams[i];
      
      /*********************/
      /* check for refresh */
      /*********************/
      
      /* if refresh is done go to next frame */
      if(currStream->refreshStatus == REFRESH_DONE){
	currStream->refreshPos++;
	/* check for return */
	if(currStream->refreshPos >= currStream->streamObj->nbSlots)
	  currStream->refreshPos = 0;
	
	/* check for void */
	if(currStream->refreshPos == currStream->writePos)
	  currStream->fullVoidFlag = 0; //void

	/* check for eof */
	if(currStream->refreshPos == currStream->eofPos){
	  /* encrease modIdx */
	  currStream->modIdx++;
	  
	  /* signal eof */
	  if(currStream->eofSignalHandle){
	    WV_signalEOF(currStream->eofSignalHandle);
	  }

	  /* reset */
	  currStream->eofPos = -1;
	}

	/* done */
	currStream->writeAccessFlag = 0; //lock access (for async)
	currStream->refreshStatus = NO_REFRESH;
      }

      
      /* if the current frame is not refreshed, try to launch refresh */
      /* check if the frame is skipped */
      if(currStream->refreshStatus == NO_REFRESH){
	
	/* if the list is not void */
	if(currStream->refreshPos != currStream->writePos ||	\
	   currStream->fullVoidFlag != 0){
	  
	  /*  check skip (if needed) */
	  if((currStream->getInRefreshFlag || currStream->LRInRefreshFlag)&& \
	     (currStream->slotFlag[currStream->refreshPos] & SLOT_FLAG_SKIP)){
	    
	    /* skip */
	    launchRefreshImmediately(currStream, 1); //put refreshFlag to REFRESH_LAUNCHED on success
	  }

	  /* try to launch refresh */
	  /* it can be fail if the ref clock is paused or */
	  /* if the current frame doesn't have the right idx */ 
	  else{
	    launchRefreshTimer(currStream); //put refreshFlag to REFRESH_LAUNCHED on success
	  }
	  
	}
      }
	    

      /**********************/
      /* check for decoding */
      /**********************/
      int allocFlag = 0;
      
      if(canWrite(currStream)){
	
	/* check allocation (if needed) */
	if((currStream->getInRefreshFlag || currStream->LRInRefreshFlag)&& \
	   (currStream->slotFlag[currStream->writePos] & SLOT_FLAG_ALLOC)){
	  /* alloc */
	  launchRefreshImmediately(currStream, 1);
	  allocFlag = 1;
	}
	
	else{
	/* decode */
	  if(decodeVideo(currStream)>=0){
	    currStream->writePos++;
	    /* check for return */
	    if(currStream->writePos >= currStream->streamObj->nbSlots)
	      currStream->writePos = 0;
	    /* check for full */
	    if(currStream->writePos == currStream->refreshPos)
	      currStream->fullVoidFlag = 1; //full
	  }
	}
	
      }
	  
      
      /*************************************/
      /* check if we can continue decoding */
      /*************************************/
      if(canWrite(currStream) && !allocFlag)
	needRelaunchFlag = 1;

      /***************************/
      /* check if we can refresh */
      /***************************/
      if(currStream->refreshStatus == NO_REFRESH){
	
	/* if the list is not void */
	if(currStream->refreshPos != currStream->writePos ||	\
	   currStream->fullVoidFlag != 0){
	  
	  needRelaunchFlag = 1; 
	}
      }


    }
  }
}





/************************************/
/*||||||||||||||||||||||||||||||||||*/
/*        the init function         */
/*||||||||||||||||||||||||||||||||||*/
/************************************/

int WV_initVideoDecoder(void)
{
  
  /*****************************/
  /* init communication system */
  /*****************************/
  stateUpdatedMutex = SDL_CreateMutex();
  stateUpdated = SDL_CreateCond();
  stateUpdatedFlag = 0;   //wait at start

  cmdMutex = SDL_CreateMutex();
  cmdExecuted = SDL_CreateCond();
    
  /************************/
  /* init state variables */
  /************************/
  nbVideoStream = 0;
  decoderCommand = VIDEO_DECODER_NO_COMMAND;

  /*****************************/
  /* launch the decoder thread */
  /*****************************/
  #if SDL_VERSION_ATLEAST(2,0,0)
  SDL_CreateThread(videoDecoderThread, "videoThread", NULL);
  #else
  SDL_CreateThread(videoDecoderThread, NULL);
  #endif

  

  
  /* all is ok */
  return 0;
}



    
	
	
      




