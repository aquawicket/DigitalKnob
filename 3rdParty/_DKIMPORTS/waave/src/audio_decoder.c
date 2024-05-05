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

#include "audio_decoder.h"

#include "common.h"
#include "config_sdl.h"
#include "config_ffmpeg.h"


#include "waave_engine_flags.h"
#include "waave_ffmpeg.h"
#include "packet_feeder.h"
#include "sync_object.h"
#include "audio_decoder_stops.h"
#include "audio_decoder_eofs.h"
#include "audio_decoder_mods.h"
#include "eof_signal.h"


/**********************************/
/* the audio decoder decode audio */
/* pkts in raw bit streams.       */
/**********************************/

typedef struct AudioBitStream{
  WVQueueHandle queueHdl;  //the queue where we get pkts
  AVCodecContext* codec;   //the codec needed to decode pkts
  AVRational timeBase;     //need to read pts values
  double volume;           //the volume of the stream
   

  int16_t* data;           //where we decoding the pkts
  
  AVFrame* decodedFrame;     //to store the decoded frame
  struct SwrContext* swrCtx; //to fill data


  unsigned int nbBlocks;//the number of audio blocks decoded
  int lackingFlag;      //ONLY USED BY THE DECODER to store when we have a lack of pkt
                        //0=no lack; 1=only 1 block; 2=no blocks

  int mixingFlag;       //the number of audio streams mixed (the no-paused)
                        //ONLY USED BY THE MIXER (decoder can read)

  int16_t* streamEnd;   //when we restart writing at the begining of the buffer
  int16_t* writePos;    //the writing position
  unsigned int bytePos; //the writing position in byte after the begining
  unsigned int decodedBytes; //for counting the number of decoded blocks

  int16_t* readPos;      //the reading position for the mixer

  /* stops */
  WVADStopList* stopL;   //this is a list of stream position where the reader need to stop
  
  /* seek */
  int seekingDoneFlag;  //to know if the decoder have already seek
  int blockingSeekFlag; //if this flag is set, a paused stream stay paused after the seek

  /* decoding */
  AVPacket* pkt;           //the pkt we actually decoding
  uint8_t* srcPktData;     //the initial pkt data pointer
  int srcPktSize;          //the number of byte needed to be decoded

  /* clock */
  uint32_t audioClockRef;         //the base time to compute the audio clock (first pts in ms)
  uint32_t audioStartTime;        //the time when the audio start playing (second callback)
  unsigned int nbMixedBlocks;     //the number of mixed block 
  unsigned int noMixingCallbacks; //nb callback that play silence, to calibrate the filter
  unsigned int modIdx;            //count the number of mod encounted 
  WVSyncObject* AVSync;           //when we have A/V sync,
                                  //the audio clock need to signal audio events
  int defaultLoopingFlag;         //if AVSync is not given we need to know the loopingFlag
  

  /* mods */
  WVADModList* modL;
  int16_t* saveClockModPos;  //to say when we need to add a mod (NULL = no adding)
  
  /* eof signal */
  WVADEOFList* eofL;
  void* eofSignalHandle;

}AudioBitStream;

  
/*********************************************/
/* The decoder works like a state machine so */
/* here the internal variables               */
/*********************************************/


//the size of the audio block 
static unsigned int audioBlockSize;   //the audio block size we get when we init the audio 


//this is the space needed to decode one audio frame 
//in the case where we can have a partial block in the buffer
#define DECODE_SEGMENT_SIZE (WV_DECODE_TARGET_SIZE + audioBlockSize)

//the decoder need two segment 
#define AUDIO_DECODER_BUFFER_SIZE 2*DECODE_SEGMENT_SIZE

//this is the byte limit where the decoder need to return to the beginning of the buffer
//because we don't have enough space to decode a frame
#define AUDIO_DECODER_RETURN_LIMIT (DECODE_SEGMENT_SIZE + audioBlockSize)



/**************************/
/* denoise callback times */
/**************************/

/* store the callback times */ 
static uint32_t* callbackTimes;
static int callbackTWritePos;
static int callbackTSize;


/* avoid round error */
static uint32_t getBlockDuration(int nbBlocks)
{
  unsigned int blockSamples = audioBlockSize/2;       //we use int16_t
  unsigned int nbSamples = nbBlocks * blockSamples;   //the overflow is after 13 hour
                                                      // with 32 bit ints

  unsigned int stereoSampleRate = WV_DECODER_SAMPLE_RATE * 2;
  
  /* we need to avoid averflow so compute seconds first */
  uint32_t blockTimeSec = nbSamples / stereoSampleRate;
  uint32_t samplesRem = nbSamples % stereoSampleRate;
  
  /* compute the ms */
  uint32_t blockTimeMs = (samplesRem*1000)/stereoSampleRate;
  
  /* now the block time */
  return  blockTimeSec*1000 + blockTimeMs; //the block time in ms
}  

/* to init the filter size */
static void initCallbackFilter(void)
{
  uint32_t blockDuration = getBlockDuration(1);
  uint32_t filterDuration = WV_CALLBACK_DENOISE_FILTER_SIZE;

  int filterSize = filterDuration / blockDuration;

  /* the size need to be odd */
  if(filterSize%2 == 0)
    filterSize++;

  /* alloc the buffer */
  callbackTSize = filterSize;
  callbackTWritePos = 0;
  callbackTimes = (uint32_t*)malloc(filterSize*sizeof(uint32_t));
  
  int i;
  for(i=0; i<filterSize; i++)
    callbackTimes[i] = 0;
}


/* mean filter calculation */
static uint32_t getMeanCallbackT(void)
{
  int i;
  double sum = 0;
  double size = (double)callbackTSize;

  for(i=0; i<callbackTSize; i++)
    sum += (double)callbackTimes[i]/size;

  return (uint32_t)sum;
}


/* give the audio drift : drift -> standard */
static int getAudioDrift(AudioBitStream* audioStream)
{
  /* if noMixingCallbacks > 1 the audio is not playing */
  if(audioStream->noMixingCallbacks > 1)
    return 0;

  /* check if we have enough callbacks for this stream */
  /* to fill the mean filter */ 
  if(audioStream->nbMixedBlocks < callbackTSize)
    return 0; //not enough blocks
  
  /************************************************/
  /* compute the "theorical" time (with data use) */
  /************************************************/
  int midSize = callbackTSize/2;
  int filterCenter = audioStream->nbMixedBlocks + audioStream->noMixingCallbacks;
  filterCenter -= midSize;
  filterCenter -= 2;  //the audio start when nb=2
  
  if(filterCenter < 0)   //can be negative if filter size = 1
    return 0;

  uint32_t linearTime = audioStream->audioStartTime;
  linearTime += getBlockDuration(filterCenter); //the center of the filter


  /*******************************/
  /* compute the "filtered" time */
  /*******************************/
  uint32_t meanTime = getMeanCallbackT();



  /******************/
  /* give the drift */
  /******************/
  return (long int)linearTime - (long int)meanTime;
}





/***********************/
/* this the main mutex */
/***********************/
static int stateUpdatedFlag;    
static SDL_mutex* stateUpdatedMutex;
static SDL_cond*  stateUpdated;   //WAIT (decoder):"I have nothing to do, wait for mixer getting 
                                  //               blocks or client sending command"
                                  //SIGNAL (Mix or cli) : "A commans was send" or "A pkt was get"





/*************************************/
/* the streams used by the decoder   */
/* to send decoded data to the mixer */
/*************************************/

static AudioBitStream* audioStreams[WV_AUDIO_DECODER_MAX_STREAMS];

static int nbAudioStream;

static SDL_mutex* audioStreamMutex;
static SDL_cond* audioStreamUpdated;




  


/******************************/
/*                            */
/*  the audio clock function  */
/*                            */
/******************************/

WVReferenceClock WV_getAudioClock(WVAudioStreamHandle streamHdl)
{
  AudioBitStream* stream = (AudioBitStream*)streamHdl;
  

  WVReferenceClock newClock;


  /* get the current mod idx */
  newClock.modIdx = stream->modIdx;
  

  /*************/
  /* get ticks */
  /*************/
  uint32_t currentTime = SDL_GetTicks();
  
  
  /* lock*/
  SDL_mutexP(audioStreamMutex);

  /****************************/
  /* the audio is not played  */
  /* while nbMixedBlocks != 2 */
  /****************************/
  if(stream->nbMixedBlocks < 2){
    SDL_mutexV(audioStreamMutex);
    newClock.clock = stream->audioClockRef;
    newClock.pauseFlag = 1;
    return newClock;
  }

  /* we know assume that audio is playing */
  newClock.pauseFlag = 0;

  /****************************************/
  /* get the clamp value                  */
  /* for a given nbMixedBlocks            */
  /* the audio can't play after this time */
  /****************************************/
  uint32_t maxTime = stream->audioStartTime + getBlockDuration(stream->nbMixedBlocks) - 1;
  

  /***********************/
  /* get the audio drift */
  /***********************/
  int audioDrift = getAudioDrift(stream);

  
  /***********************/
  /* apply drift to time */
  /***********************/
  if(audioDrift >= 0)
    currentTime += (uint32_t)audioDrift;
  else{
    audioDrift = -audioDrift;
    if((uint32_t)audioDrift <= currentTime)
      currentTime -= (uint32_t)audioDrift;
  }

  /*******************************************/
  /*               clamp                     */
  /* and check if the audio is really paused */
  /*******************************************/
  if(currentTime > maxTime){
    currentTime = maxTime;
    
    /* check pause */
    if(WVAD_firstStop(stream->stopL) == stream->readPos)
      newClock.pauseFlag = 1;  //the audio really stop playing
    
  }

  
  /***********************/
  /* compute audio clock */
  /***********************/
  uint32_t audioClock;
  
  /* elapsed time */
  if(currentTime >= stream->audioStartTime)
    audioClock = currentTime - stream->audioStartTime; //can be neg due to drift
  else
    audioClock = 0;

  /* clock */
  audioClock += stream->audioClockRef;
  newClock.clock = audioClock; 
   

  /* unlock and return */
  SDL_mutexV(audioStreamMutex);
  return newClock;
} 
    
     
  
 
/*******************************************/
/*|||||||||||||||||||||||||||||||||||||||||*/
/*               THE MIXER                 */
/*|||||||||||||||||||||||||||||||||||||||||*/
/*******************************************/


/* the mixer use double for the calculation */
static inline int16_t floatClamp(double srcVal)
{
  if(srcVal > (double)INT16_MAX)
    return INT16_MAX;
  else if(srcVal < (double)INT16_MIN)
    return INT16_MIN;
  else
    return (int16_t)srcVal;
}


/***********************************************************/
/* this flag is for know if the mixer have started his job */
/***********************************************************/
static int playFlag;               //protected by the audioStreamMutex
static SDL_cond* playingFinished;  //decoder may want to wait for playing finished


/**************************/
/* buffer for calculation */
/**************************/
static double* calcBuffer;  //same nb of double than int in the audio buffer 


/**********************/
/* the mixer function */
/**********************/
/* mix all the streams and send it to the audio device */
static void mixerCallback(void* userdata, Uint8* buffer, int bufferSize)
{
  
  /* first save the actual time */
  /* SDL call this function when it start to read the previous block */
  uint32_t callTime = SDL_GetTicks();
  
  
  /* this flag is used when the the decoder need to be relaunched */
  int relaunchDecoderFlag = 0;


  /* now we check if we need to play silence (no streams or all streams paused) */
  /* we check if all the playing streams have at least one block */
      
  /*____________________________*/
  /* !!! we lock the streams !!!*/
  SDL_mutexP(audioStreamMutex);
  
  /**********************************/
  /* save time for mean calculation */
  /**********************************/
  callbackTimes[callbackTWritePos] = callTime;
  callbackTWritePos++;
  if(callbackTWritePos >= callbackTSize)
    callbackTWritePos = 0;


  /* loop while we can't play silence and we have a lack of block */
  int noBlockFlag;    //a stream we want mix have no block
  int nbMixingStream; //the no paused streams 
  int snbAudioStream; //save the nb (see below)
  int streamIdx;
  AudioBitStream* currStream;
 
  while(1){
    noBlockFlag = 0; 
    nbMixingStream = 0;
    snbAudioStream = nbAudioStream;      //we save nbAudioStream
                                         //the user can add a stream during mixing
                                         //but this stream will not be mixed this time 

    for(streamIdx=0; streamIdx<snbAudioStream; streamIdx++){
      currStream = audioStreams[streamIdx];
    
      /* check if paused */
      /* is the first stop equal to the actual reading position ? */
      if(WVAD_firstStop(currStream->stopL) == currStream->readPos){
	currStream->mixingFlag = 0;  //no mix this stream
      }
      else{
	currStream->mixingFlag = 1;  //mix this stream
	nbMixingStream++;
	/* check if we have block to do */
	if(currStream->nbBlocks == 0)
	  noBlockFlag = 1;
      }
    }
    
    /* if there are a lack of block we wait before recheck */
    if(noBlockFlag){  //there are a lack of blocks on a playing stream
      SDL_CondWait(audioStreamUpdated, audioStreamMutex);
      /* we recheck */
    }
    else{
      break; //we can mix the streams or play silence
    }
  }

  
  /**********************/
  /* now the clock part */
  /**********************/
  for(streamIdx=0; streamIdx<snbAudioStream; streamIdx++){
    currStream = audioStreams[streamIdx];
    
    /* check for clock reference modificator */
    if(WVAD_needRefMod(currStream->modL, currStream->readPos)){
      
      /* apply the mod */
      currStream->audioClockRef = WVAD_refMod(currStream->modL);  //apply the mod
      currStream->nbMixedBlocks = 1;        //reset nbMixedBlocks, the mods are placed 
                                            //after the first new stream mixing block
      currStream->noMixingCallbacks = 0;
      
      currStream->modIdx++;               //increase the mod count 
    
    }


    
    /* update nbMixedBlocks and noMixingCallBacks */
    if(currStream->mixingFlag){  
      currStream->nbMixedBlocks++;
      currStream->noMixingCallbacks = 0;

      /* check if the audio or a mod really start playing */
      /* a playing stream really start playing when nbMixedBlocks = 2 */
      if(currStream->nbMixedBlocks == 2){
	currStream->audioStartTime = callTime;
	
	WVSyncObject* AVSync = currStream->AVSync;
	if(AVSync)
	  AVSync->signalStateChange(AVSync);  //signal that a new clock start
      }
    }
    else
      currStream->noMixingCallbacks++;
    
  }
  

  /***********************/
  /* now is time to play */
  /***********************/
  if(nbMixingStream)
    playFlag = 1;
  
  SDL_mutexV(audioStreamMutex);
  /*______________________________*/
  /*!!! we release the streams !!!*/



  /* the mixer works with 16 bits int */
  int len = bufferSize/2;
  int16_t* mixedStream = (int16_t*)buffer;
  int16_t* srcData;  
  int i;

  /*------------------------*/
  /* now the different case */
  /*------------------------*/

  /* if we have no streams or if all the streams are paused, play silence */
  if(nbMixingStream == 0){
    for(i=0; i<len; i++)
      mixedStream[i] = 0;
  }
  
  /* if we have just one stream */
  else if(nbMixingStream == 1){
    AudioBitStream* playingStream;
    int searchIdx = 0;
    
    /* search for the playing stream */
    while(!audioStreams[searchIdx]->mixingFlag)
      searchIdx++;

    playingStream = audioStreams[searchIdx];
    srcData = playingStream->readPos;
    

    /* if volume ~= 1.0 just copy the data */
    double playingVolume = playingStream->volume;
    
    if(playingVolume <= WV_VOLUME_SKIP_HIGH_THRESHOLD  &&\
       playingVolume >= WV_VOLUME_SKIP_LOW_THRESHOLD){
      for(i=0; i<len; i++)
	mixedStream[i] = srcData[i];
    }
    /* else apply volume */
    else{
      for(i=0; i<len; i++)
	mixedStream[i] = floatClamp((double)(srcData[i])*playingVolume);
    }
  }

  /* else we need a full mixing calculation */
  else{
    double playingVolume;

    /* we load the first playing stream */
    streamIdx = 0;
    while(!audioStreams[streamIdx]->mixingFlag)
      streamIdx++;

    playingVolume = audioStreams[streamIdx]->volume;
    srcData = audioStreams[streamIdx]->readPos;
    if(playingVolume <= WV_VOLUME_SKIP_HIGH_THRESHOLD  &&\
       playingVolume >= WV_VOLUME_SKIP_LOW_THRESHOLD){
      for(i=0; i<len; i++)
	calcBuffer[i] = (double)srcData[i];
    }
    else{
      for(i=0; i<len; i++)
	calcBuffer[i] = (double)srcData[i]*playingVolume;
    }

    /* we mix with the other streams */
    streamIdx++;
    while(streamIdx<snbAudioStream){
      currStream = audioStreams[streamIdx];
      if(currStream->mixingFlag){
	playingVolume = currStream->volume;
	srcData = currStream->readPos;
	
	if(playingVolume <= WV_VOLUME_SKIP_HIGH_THRESHOLD  &&\
	   playingVolume >= WV_VOLUME_SKIP_LOW_THRESHOLD){
	  for(i=0; i<len; i++)
	    calcBuffer[i] += (double)srcData[i];
	}
	else{
	  for(i=0; i<len; i++)
	    calcBuffer[i] += (double)srcData[i]*playingVolume;
	}
      }
      streamIdx++;
    }

    /* now we send to the audio buffer */
    for(i=0; i<len; i++)
      mixedStream[i] = floatClamp(calcBuffer[i]);
  }

  


  /*_____________________*/
  /* we lock the streams */
  SDL_mutexP(audioStreamMutex);


  /*********************************************/
  /* now we update the stream reading position */
  /*********************************************/
  for(streamIdx=0; streamIdx<snbAudioStream; streamIdx++){
    currStream = audioStreams[streamIdx];
    
    /* if the stream was played */
    if(currStream->mixingFlag){
      currStream->readPos += len;  // we update the reading position
      
      /* we check if the pointer need to return at start */
      if(currStream->readPos == currStream->streamEnd)
	currStream->readPos = currStream->data;

      /* check if we need to signal eof */
      if(WVAD_firstEOF(currStream->eofL) == currStream->readPos){
	if(currStream->eofSignalHandle){
	  WV_signalEOF(currStream->eofSignalHandle);
	}
	WVAD_deleteFirstEOF(currStream->eofL);
      }

    }
  }
  


  /* playing is finished */
  playFlag = 0;
  SDL_CondSignal(playingFinished); //if the decoder wait 

  
  /* we decrease the number of blocks */
  //if a stream have less than 2 blocks the decoder
  //need to be relaunched

  for(streamIdx=0; streamIdx<snbAudioStream; streamIdx++){
    currStream = audioStreams[streamIdx];
    if(currStream->mixingFlag){
      currStream->nbBlocks--;
      if(currStream->nbBlocks < 2)
	relaunchDecoderFlag = 1;
    }
  }

  SDL_mutexV(audioStreamMutex);
  /*________________________*/
  /* we release the streams */


  /* signal if the decoder need to be relaunched */
  if(relaunchDecoderFlag){
    SDL_mutexP(stateUpdatedMutex);
    stateUpdatedFlag = 1;
    SDL_mutexV(stateUpdatedMutex);
    SDL_CondSignal(stateUpdated);
  }
}


/*!!! to now if the mixer actually mixing a stream !!!*/
/* !!! lock the audioStreams first !!! */
static int streamIsMixed(AudioBitStream* stream)
{
  if(!playFlag || (playFlag && !stream->mixingFlag))
    return 0;
  else 
    return 1;
}



/****************************************/
/*||||||||||||||||||||||||||||||||||||||*/
/*        THE AUDIO DECODER             */
/*||||||||||||||||||||||||||||||||||||||*/
/****************************************/


/*********************************************************/
/* first the user function to prepare seeking            */
/* !!! this function need to be called before sending !!!*/
/* !!! seeking pkt and before sending the seeking cmd !!!*/
/*********************************************************/

/*blocking flag say if a paused stream need to stay paused after seeking */
void WV_startAudioSeeking(WVAudioStreamHandle streamHdl, int blockingFlag)
{
  AudioBitStream* seekingStream = (AudioBitStream*)streamHdl;
  
  seekingStream->seekingDoneFlag = 0;
  seekingStream->blockingSeekFlag = blockingFlag;
}


/********************************************/
/* the audio decoder seeking function       */
/* it remove all the availiable blocks      */
/* and reset the pointers ans the stops     */
/********************************************/

void seekAudioStream(AudioBitStream* seekingStream)
{
  /*_________*/
  /* we lock */
  SDL_mutexP(audioStreamMutex);
  
  
  unsigned int blockLen = audioBlockSize/2;

  /***********************************/
  /* we delete all the stops         */
  /* or we keep the actual depending */
  /* of blockingSeekFlag             */
  /***********************************/
  int needResetStopFlag = 0;            //if the stream was paused and blockingSeek is set 
                                        //we will put a stop after the seek
  if(seekingStream->blockingSeekFlag){
    /* is the stream is not mixed we check the actual reading position */
    if(!streamIsMixed(seekingStream)){
      if(WVAD_firstStop(seekingStream->stopL) == seekingStream->readPos){
	needResetStopFlag = 1;
      }
    }
    
    /* else we check the position after the mix */
    else{
      if(WVAD_firstStop(seekingStream->stopL) == (seekingStream->readPos + blockLen)){
	needResetStopFlag = 1;
      }
    }
  }

  /* delete all the stops */
  WVAD_deleteStops(seekingStream->stopL);


  /**********************/
  /* delete all the eof */
  /**********************/
  WVAD_deleteEOFS(seekingStream->eofL);

  
  /*****************************/
  /* if we have mod apply only */
  /* the index incrementation  */
  /*****************************/

  /* may the mod not already saved */
  if(seekingStream->saveClockModPos){
    seekingStream->modIdx++;
    seekingStream->saveClockModPos = NULL;
  }
  
  /* the saved mods */
  while(WVAD_haveMod(seekingStream->modL)){
    seekingStream->audioClockRef = WVAD_refMod(seekingStream->modL);
    seekingStream->modIdx++;
  }


  /* if the mixer doesn't mixing a block */
  /* remove all the blocks */
  if(!streamIsMixed(seekingStream)){
    seekingStream->nbBlocks = 0;
    seekingStream->streamEnd = NULL; 
    seekingStream->writePos = seekingStream->data;
    seekingStream->bytePos = 0;
    seekingStream->decodedBytes = 0;
    seekingStream->readPos = seekingStream->data;
  }

  /* else we keep the last block and check */
  /* if we can decode after it */
  else{
    seekingStream->nbBlocks = 1;
    seekingStream->decodedBytes = 0;

    seekingStream->writePos = seekingStream->readPos + blockLen;  //after the last block
    seekingStream->bytePos = (uint8_t*)seekingStream->writePos - (uint8_t*)seekingStream->data;
    /* time to return ? */
    if(seekingStream->bytePos > AUDIO_DECODER_RETURN_LIMIT){
      seekingStream->streamEnd = seekingStream->writePos;  //we are at the end of a block
      seekingStream->writePos = seekingStream->data;
      seekingStream->bytePos = 0;
    }
    else
      seekingStream->streamEnd = NULL;
  }


  /* free the stream pkt if needed */
  if(seekingStream->pkt){
    av_free_packet(seekingStream->pkt);
    free(seekingStream->pkt);
    seekingStream->pkt = NULL;
  }


  /* free the codec internal buffers */
  avcodec_flush_buffers(seekingStream->codec);
  
  
  /* if we need to reset a stop */
  /* we do it now */
  if(needResetStopFlag)
    WVAD_putStop(seekingStream->stopL, seekingStream->writePos);


  /* we will put a mod at the next block */
  seekingStream->saveClockModPos = seekingStream->writePos + (audioBlockSize/2); //writePos is at a block start
  
    

  /* ok seeking is done */
  /* say it and release the streams */
  seekingStream->seekingDoneFlag = 1;
  SDL_mutexV(audioStreamMutex);

  /*_________________*/
  /*streams released */
  

  /* now we can restart decoding audio pkts */
}
    



  

/*********************************************/
/* this is the function that decode the pkts */
/* and return audio blocks for the feeder    */

/* if the decoder read a eof pkt and is looping flag is not set */
/* he put a stop at the last block */

/* if the decoder read a seek pkt he flush as possible */
/* the blocks (the mixer may read some of them) */

/* this return the number of audio block obtained */
/* !!! this is always greater or egual to 1 if there are no errors !!!*/
/*********************************************/
static int decodeAudio(AudioBitStream* decodingStream)
{
  /*****************************************/
  /* we decode while we not have new block */
  /*****************************************/
  int newBlocks = 0;
  
  while(newBlocks == 0){
  
    /* first if writePos is at the start of the buffer */
    /* we need to copy the rest of the data of the last */
    /* decoding. To streamEnd to streamEnd + decodedBytes */
    int i;
    int16_t* writePos = decodingStream->writePos;
    
    if(writePos == decodingStream->data){  
      int16_t* streamEnd = decodingStream->streamEnd;
      unsigned int decodedInts = (decodingStream->decodedBytes)/2;
      for(i=0; i<decodedInts; i++)
	writePos[i] = streamEnd[i];
      decodingStream->writePos += decodedInts;
      decodingStream->bytePos = decodedInts*2;
    }


    /*********************************/
    /* we get pkts and decode        */
    /* while we doesn't have a frame */
    /*********************************/
    int gotFrame = 0;
        
    while(!gotFrame){
    
      /* we need to have a pkt to decode  */
      /* ->maybe we already have one          */
      /* ->if not, get pkts until we have not */
      /*   a special pkt                      */
      if(!decodingStream->pkt){
      
	/* we get a new packet */
	AVPacket* pkt = WV_packetQueueGet(decodingStream->queueHdl, WV_QUEUE_GET_WAIT);

	/* we check if is a speciak pkt */
	/* if this is the case, do the corresponding job */
	while(pkt->data == NULL){
	  
	  /*--------------*/
	  /* the eof case */
	  /*--------------*/
	  if(pkt->flags == WV_PACKET_FLAG_EOF){
	    
	    /* flush codec */
	    avcodec_flush_buffers(decodingStream->codec);

	    /****************/
	    /* thread stops */
	    /****************/

	    /* get the looping flag */
	    int loopingFlag;
	    if(decodingStream->AVSync)
	      loopingFlag = decodingStream->AVSync->loopingFlag;
	    else
	      loopingFlag = decodingStream->defaultLoopingFlag;

	    /* if looping flag is set just ignore that pkt */
	    /* else we complete the block with silence and put a stop at the end */
	    if( loopingFlag == WV_BLOCKING_STREAM ){
	      /* complete the last block if needed*/
	      if(decodingStream->decodedBytes){//! need decodedBytes is less than one block here(ok)
		int lackingInts = (audioBlockSize - decodingStream->decodedBytes)/2;
		writePos = decodingStream->writePos;
		for(i=0; i<lackingInts; i++)
		  writePos[i] = 0;
	
		/* return to buffer start if needed */
		decodingStream->decodedBytes = audioBlockSize; //we have now a complete block
		decodingStream->bytePos += lackingInts*2;
		if(decodingStream->bytePos > AUDIO_DECODER_RETURN_LIMIT){
		  decodingStream->streamEnd = decodingStream->writePos;//we're at the end of a block
		  decodingStream->writePos = decodingStream->data;
		  decodingStream->bytePos = 0;
		}
		else
		  decodingStream->writePos += lackingInts;
	      }
	      
	      /* now set the stop */
	      /* the write position is at the end of a block */
	      WVAD_putStop(decodingStream->stopL, decodingStream->writePos); //we can set this 
                                                                             //stop without lock
	    }

	    /**********************/
	    /* thread eof signals */
	    /**********************/

	    /* check if the current block is not completed */
	    unsigned int blockShift = decodingStream->bytePos % audioBlockSize;
	    if(blockShift)
	      blockShift = audioBlockSize - blockShift;
	    
	    
	    /* save eof signal pos */
	    WVAD_putEOF(decodingStream->eofL, decodingStream->writePos + (blockShift/2));
	    
	    
	    /***************/
	    /* thread mods */
	    /***************/
	    /* we need to put a mod at the next block now */
	    /* if loopingFlag is not set, writePos is not */
	    /* at a beginning of a block */
	    
	    /* go to the next block */
	    blockShift += audioBlockSize;

	    /* save the position */
	    decodingStream->saveClockModPos = decodingStream->writePos + (blockShift/2);
	  }
	  
	  /*---------------*/
	  /* the seek case */
	  /*---------------*/
	  if(pkt->flags == WV_PACKET_FLAG_SEEK){
	    seekAudioStream(decodingStream);  //it's useless to check if seekingDone
	                                      //is set because if the seeking is done by a command
	                                      //the seeking pkt is removed
	  }
	  
	  /****************************************/
	  /* if the mod is after the return limit */
	  /* this will be corrected later         */
	  /****************************************/
	  

	  /* free the special pkt and get another */
	  //don't use av_free_packet !!!
	  free(pkt);
	  pkt = WV_packetQueueGet(decodingStream->queueHdl, WV_QUEUE_GET_WAIT);
	}

	/* now put own new pkt in the stream struct */
	decodingStream->pkt = pkt;
	decodingStream->srcPktData = pkt->data; //seems we need to restore the pkt to free it
	decodingStream->srcPktSize = pkt->size;
      }


      /*************************/
      /* THREAD CLOCK REF MODS */
      /*************************/
      /* if we have a mod to save, do it now */
      if(decodingStream->saveClockModPos){
	/* get the clock given by the pts */
	double newRefClock;
	newRefClock = (double)(decodingStream->pkt->pts);
	newRefClock *= av_q2d(decodingStream->timeBase);
	newRefClock *= 1000;

	/* compute the time shift if we not decode a the beginning of a block */
	int lackingSamples = decodingStream->saveClockModPos - decodingStream->writePos;
	lackingSamples -= audioBlockSize/2; 

	if(lackingSamples > 0){
	  double lackingTime = lackingSamples / (double)(WV_DECODER_SAMPLE_RATE * 2);
	  lackingTime *= 1000;
	  newRefClock += lackingTime;
	}

	/* save the mod */
	uint32_t modValue = (uint32_t)newRefClock;
	WVAD_saveRefMod(decodingStream->modL,\
			decodingStream->saveClockModPos,\
			modValue);
	
	/* ok it's saved */
	decodingStream->saveClockModPos = NULL;
      }
	
      
  
      /********************/
      /* DECODING THE PKT */
      /********************/
      int decodedBytes = 0;
      AVPacket* pkt = decodingStream->pkt;

      /* set output frame */
      /* try direct rendering */
      WV_getDecodeFrame(decodingStream->codec, decodingStream->decodedFrame, decodingStream->writePos);
      
      /* decode */
      decodedBytes = WV_decodeAudio(decodingStream->codec, decodingStream->decodedFrame, &gotFrame, pkt);


      /* check decode */
      if(decodedBytes < 0)
	pkt->size = 0;  //error
      else{
	pkt->data += decodedBytes;
	pkt->size -= decodedBytes;
      }

      
      /**************************/
      /* free the pkt if needed */
      /**************************/
      if(pkt->size == 0){
	/* restore pkt */
	pkt->data = decodingStream->srcPktData;
	pkt->size = decodingStream->srcPktSize;
	/* free the packet */
	av_free_packet(decodingStream->pkt);
	free(decodingStream->pkt);
	decodingStream->pkt = NULL;
      }
    }
    

    /***************/
    /*   RESAMPLE  */
    /***************/
    /* do nothing if direct rendering */
    /* but return frame size in samples */
    
    int frameSize;

    frameSize = WV_resampleAudio(decodingStream->swrCtx, (uint8_t*)decodingStream->writePos, decodingStream->decodedFrame);
    
     
    if(frameSize < 0)
      continue;

    /* the size in bytes */
    frameSize *= WV_DECODER_CHANNELS; //stereo
    frameSize *= 2;                   //s16 audio
    

    /**********************/
    /* update stream vars */
    /**********************/
    
    /* stream writing variables */
    decodingStream->writePos += frameSize/2;
    decodingStream->bytePos += frameSize;
    decodingStream->decodedBytes += frameSize;
      
    /* maybe we need to restart at the begining of the buffer */
    if(decodingStream->bytePos > AUDIO_DECODER_RETURN_LIMIT){
      //compute the number of bytes after the last block
      unsigned int decreaseByte = decodingStream->bytePos % audioBlockSize;
      //and set stream end 
      decodingStream->streamEnd = decodingStream->writePos - (decreaseByte/2);
      decodingStream->writePos = decodingStream->data;
      decodingStream->bytePos = 0;
	
      /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
      /* some mods, eof or stops may be invalid now (those = or after streamEnd) */
      WVAD_updateStops(decodingStream->stopL, decodingStream->data, decodingStream->streamEnd);
      WVAD_updateEOFS(decodingStream->eofL, decodingStream->data, decodingStream->streamEnd);
      WVAD_updateMods(decodingStream->modL, decodingStream->data, decodingStream->streamEnd);
    }

    
    /*******************************************/
    /* now check if we have decoded new blocks */
    /*******************************************/
    newBlocks = decodingStream->decodedBytes/audioBlockSize;
    decodingStream->decodedBytes = decodingStream->decodedBytes % audioBlockSize;
  }

  /*************************/
  /* now return the result */
  /*************************/
  return newBlocks;
}
 
 


/********************************/
/*||||||||||||||||||||||||||||||*/
/*     THE DECODER  COMMANDS    */
/*||||||||||||||||||||||||||||||*/
/********************************/

/* the list of decoder commands */
#define AUDIO_DECODER_NO_COMMAND 0
#define AUDIO_DECODER_ADD_STREAM 1
#define AUDIO_DECODER_DEL_STREAM 2
#define AUDIO_DECODER_SEEK 3
//pauseStream doesn't need to send a command to the decoder
//playStream doesn't need to send a command to the decoder
#define AUDIO_DECODER_QUIT 4

static int decoderCommand;    //where the client put the command

static SDL_mutex* cmdMutex;
static SDL_cond* cmdExecuted;  //the client need to wait for command execution 
                               //before continuing
                               //WAIT (client) : "I have sent you a command say me 
                               //                 the work is done"
                               //SIGNAL (decoder) : "Well, command terminated"


static int deleteStreamIdx;               //when we delete we give the stream idx to the decoder
static WVAudioStreamHandle seekingStreamHandle;  //when we seek we give the stream to the decoder 

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
/*  The first command : AUDIO_DECODER_ADD_STREAM   */
/*  -first the user space function                 */
/*  -next the decoder space function               */
/***************************************************/

/* return a stream handle */
WVAudioStreamHandle WV_addAudioStream(WVQueueHandle queueHdl,\
				      AVCodecContext* codec, \
				      AVRational timeBase,   \
				      double volume)				
{
  
  /* alloc space for the structure */
  AudioBitStream* newStream;

  int structSize = sizeof(AudioBitStream);        //size of the structure 
  int dataSize = AUDIO_DECODER_BUFFER_SIZE;       //size of the stream->data, already in bytes
  int stopListSize = sizeof(WVADStopList);        //size of the stop list
  int eofListSize = sizeof(WVADEOFList);
  int modListSize = sizeof(WVADModList);          //size of the mod list 

  int totalSize = structSize + dataSize + stopListSize + eofListSize + modListSize;
  newStream = (AudioBitStream*)malloc(totalSize);

  /* set the pointers */
  //void* currP = (void*)newStream;
  AudioBitStream* currP = newStream;
  
  currP += structSize;                //after the structure 
  newStream->data = (int16_t*)currP;  //we have the decoder buffer
  
  currP += dataSize;
  newStream->stopL = (WVADStopList*)currP;
  
  currP += stopListSize;
  newStream->eofL = (WVADEOFList*)currP;

  currP += eofListSize;
  newStream->modL = (WVADModList*)currP;

  /* set the structure variables */
  newStream->queueHdl = queueHdl;
  newStream->codec = codec;
  newStream->timeBase = timeBase;
  newStream->volume = volume;
    
  /* init the frame to receive decoded data */
  newStream->decodedFrame = avcodec_alloc_frame();

  /* init audio resample context */
  newStream->swrCtx = WV_getResampleContext(codec);

  /* other vars */
  newStream->nbBlocks = 0;

  newStream->streamEnd = NULL;
  newStream->writePos = newStream->data;
  newStream->bytePos = 0;
  newStream->decodedBytes = 0;

  newStream->readPos = newStream->data;

  WVAD_initStops(newStream->stopL);

  newStream->seekingDoneFlag = 0;
  newStream->blockingSeekFlag = 0;
  
  newStream->pkt = NULL;
  newStream->srcPktData = NULL;
  newStream->srcPktSize = 0;

  
  /* !!! at start the stream is paused !!! */
  WVAD_putStop(newStream->stopL, newStream->readPos);


  /* clock variables */
  newStream->audioClockRef = 0;
  newStream->audioStartTime = 0;
  newStream->nbMixedBlocks = 0;
  newStream->noMixingCallbacks = 0;
  newStream->modIdx = 0;
  newStream->AVSync = NULL;    //at start we doesn't have A/V sync
  newStream->defaultLoopingFlag = WV_BLOCKING_STREAM;
   
  /* init the mod list */
  WVAD_deleteMods(newStream->modL); //delete works
  
  
  /* a mod will be put at the end of the first block */
  /* it is at this position than audio start playing */
  int16_t* nextBlock = newStream->writePos;
  nextBlock += audioBlockSize/2;
  
  newStream->saveClockModPos = nextBlock; //the decoder will put the mod
  
 
  /* init eof */
  WVAD_initEOFS(newStream->eofL);
  newStream->eofSignalHandle = NULL;
  

  /* put the stream on te list */
  audioStreams[nbAudioStream] = newStream; //the decoder doesn't access this space

  /* send the command */
  sendDecoderCommand(AUDIO_DECODER_ADD_STREAM);

  // the decoder increase nbAudioStream

  /* it's ok return the new stream */
  return (WVAudioStreamHandle)newStream;
}


static void audioDecoderAddStream(void)
{
  /* update the stream count */
  nbAudioStream++;
}


/***************************************************/
/*  The command : AUDIO_DECODER_DEL_STREAM         */
/*  -the freeing method                            */ 
/*  -the user space function                       */
/*  -the decoder space function                    */
/***************************************************/

static void freeAudioStream(AudioBitStream* audioStream)
{
  /* free the stream packet if needed */
  if(audioStream->pkt){
    av_free_packet(audioStream->pkt);
    free(audioStream->pkt);
    audioStream->pkt = NULL;
  }    

  /* free the swr context */
  if(audioStream->swrCtx)
    WV_freeResampleContext(&audioStream->swrCtx);

  /* free decoded frame */
  WV_freeDecodeFrame(audioStream->decodedFrame);
  audioStream->decodedFrame = NULL;

  /* free the stream, it was allocated in one time */
  free(audioStream);
}


int WV_delAudioStream(WVAudioStreamHandle streamHdl)
{
  /* find the stream */
  AudioBitStream* searchedStream = (AudioBitStream*)streamHdl;
  
  int i = 0;
  while(audioStreams[i] != searchedStream && i<nbAudioStream)
    i++;

  /* found ? */
  if(i == nbAudioStream)
    return -1;              //cannot find the stream
  //else the stream is in audioStreams[i]

  /* give the command parameter */
  deleteStreamIdx = i;

  /* and send the command */
  sendDecoderCommand(AUDIO_DECODER_DEL_STREAM);
  
  /* ok the stream is deleted */
  return 0;
}

static void audioDecoderDelStream(void)
{
  AudioBitStream* deletedStream = audioStreams[deleteStreamIdx];

  /* first we wait if the stream is mixed */
  SDL_mutexP(audioStreamMutex);
  if(streamIsMixed(deletedStream))
    SDL_CondWait(playingFinished, audioStreamMutex);
  
  /* free the stream */
  freeAudioStream(deletedStream);

  /* now shift the other streams */
  /* we use the variable deleteStreamIdx to do the job */
  nbAudioStream--;     //update the stream count now !
  while(deleteStreamIdx < nbAudioStream){  //shift the list  
    audioStreams[deleteStreamIdx] = audioStreams[deleteStreamIdx+1];
    deleteStreamIdx++;
  }

  /* ok the stream is deleted */
  SDL_mutexV(audioStreamMutex);
}



/********************************/
/* AVSync                       */
/* set the A/V synchronisation  */
/********************************/
void WV_setAudioMasterSync(WVAudioStreamHandle streamHdl, WVSyncObject* AVSync)
{
  AudioBitStream* stream = (AudioBitStream*)streamHdl;

  /* set the AVSync */
  SDL_mutexP(audioStreamMutex);
  
  stream->AVSync = AVSync;

  SDL_mutexV(audioStreamMutex);

}

void WV_stopAudioMasterSync(WVAudioStreamHandle streamHdl)
{
  AudioBitStream* stream = (AudioBitStream*)streamHdl;

  /* set the AVSync */
  SDL_mutexP(audioStreamMutex);
  
  stream->AVSync = NULL;

  SDL_mutexV(audioStreamMutex);

}

/************************************/
/* Default looping flag             */
/* if audio master sync is not set  */
/************************************/
void setAudioDefaultLoopingFlag(WVAudioStreamHandle streamHdl, int loopingFlag)
{
  AudioBitStream* stream = (AudioBitStream*)streamHdl;

  /* set the default looping flag  */
  SDL_mutexP(audioStreamMutex);
  
  stream->defaultLoopingFlag = loopingFlag;

  SDL_mutexV(audioStreamMutex);
}



/*****************************/
/* EOF signal                */
/* set the EOF signal handle */
/*****************************/

void WV_setAudioEOFSignalHandle(WVAudioStreamHandle streamHdl, void* eofSignalHandle)
{
  AudioBitStream* stream = (AudioBitStream*)streamHdl;

  /* set the eof handle */
  SDL_mutexP(audioStreamMutex);
  
  stream->eofSignalHandle = eofSignalHandle;

  SDL_mutexV(audioStreamMutex);
}





void WV_stopAudioEOFSignalHandle(WVAudioStreamHandle streamHdl)
{
AudioBitStream* stream = (AudioBitStream*)streamHdl;

  /* set the AVSync */
  SDL_mutexP(audioStreamMutex);
  
  stream->eofSignalHandle = NULL;

  SDL_mutexV(audioStreamMutex);
}






/***************************************************/
/*  The command : AUDIO_DECODER_SEEK               */
/*  -first the user space function                 */
/*  -next the decoder space function               */
/***************************************************/

/* this command is used to speed up the seek */
/* if the decoder doesn't have read the seek pkt */
/* this command force the seek */

int WV_seekAudio(WVAudioStreamHandle streamHdl)
{
  /* recast the pointer */
  seekingStreamHandle = streamHdl;

  /* send the command */
  sendDecoderCommand(AUDIO_DECODER_SEEK);

  //the decoder remove the seeking pkt (if needed)
  // and seek (if not already done)

  /* ok, return */
  return 0;
}


static void audioDecoderSeek(void)
{
  /* read command parameter */
  AudioBitStream* seekingStream = (AudioBitStream*)seekingStreamHandle; 
  
  /* if seeking is already done by reading a seeking pkt return */
  if(seekingStream->seekingDoneFlag)
    return;

  /* else */
  /* remove the seeking pkt */
  /*!!! the seeking pkt is the first pkt of the queue !!!*/
  /*!!! see how we seek in the packet feeder          !!!*/
  
  AVPacket* seekingPkt = WV_packetQueueGet(seekingStream->queueHdl, WV_QUEUE_GET_DOESNT_WAIT);
  //TODO assert that is a seeking pkt 
  free(seekingPkt);

  /* now seek */
  seekAudioStream(seekingStream);
}


/**************************************/
/* The PAUSE command                  */
/* -> only executed by the user       */
/*    no command sended to the decoder*/
/**************************************/
int WV_pauseAudio(WVAudioStreamHandle streamHdl)
{
  AudioBitStream* pausingStream = (AudioBitStream*)streamHdl;
  
  /* lock the stream */
  SDL_mutexP(audioStreamMutex);
  
  
  /* if the stream is not mixed, put the stop directly at readPos */
  if(!streamIsMixed(pausingStream))
    WVAD_putStopAtStart(pausingStream->stopL, pausingStream->readPos);
  
  /* else we put the stop at the next block */
  else{
    uint8_t* pausePos;
    pausePos = (uint8_t*)(pausingStream->readPos) + audioBlockSize;
    WVAD_putStopAtStart(pausingStream->stopL, (int16_t*)pausePos);
  }

  /* release the stream */
  /* and signal in the case the mixer is waiting for blocks */
  SDL_mutexV(audioStreamMutex);

  /* signal to the mixer */
  SDL_CondSignal(audioStreamUpdated);  //in the case where callback waiting for pkt

  /* useless to signal to the decoder */
  /* the mixer will do it when we can stop the audio */
  
  return 0;
}


/*******************************************************/
/* The PLAY command                                    */
/* try to remove a stop at the actual reading position */
/* -> if a stop is removed return 0                    */
/* -> else return -1                                   */
/*******************************************************/

int WV_playAudio(WVAudioStreamHandle streamHdl)
{
  AudioBitStream* playingStream = (AudioBitStream*)streamHdl;
  
  /* lock the stream */
  SDL_mutexP(audioStreamMutex);
  int stopDeletedFlag = 0;

  /* if the stream is not mixed just check the readPos for stops */
  if(!streamIsMixed(playingStream)){
    if(WVAD_firstStop(playingStream->stopL) == playingStream->readPos){
      WVAD_deleteFirstStop(playingStream->stopL);
      stopDeletedFlag = 1;
    }
  }

  /* if the stream is mixed check at readPos + block size */
  else{
    uint8_t* pausePos;
    pausePos = (uint8_t*)(playingStream->readPos) + audioBlockSize;
    if(WVAD_firstStop(playingStream->stopL) == (int16_t*)pausePos){
      WVAD_deleteFirstStop(playingStream->stopL);
      stopDeletedFlag = 1;
    }
  }


  /* if audio was paused */
  /* we need to update refClock and nbBlocks */
  if(stopDeletedFlag){
    
    /*****************/
    /* check for mod */
    /*****************/
    int modNextBlockFlag = 0;
    uint32_t modNextBlockValue = 0;

    if(WVAD_haveMod(playingStream->modL)){
      int16_t* checkPos = playingStream->readPos + (audioBlockSize/2);
      if(checkPos == playingStream->streamEnd)
	checkPos = playingStream->data;
      
      /* if we have a mod at next block */
      if(checkPos == WVAD_firstModPos(playingStream->modL)){       
	modNextBlockFlag = 1;
	modNextBlockValue = WVAD_firstModValue(playingStream->modL);
      }
    }

    /**********/
    /* update */
    /**********/
    if(!modNextBlockFlag){
      playingStream->audioClockRef += getBlockDuration(playingStream->nbMixedBlocks);
    }
    else{
      playingStream->audioClockRef = modNextBlockValue;
    }
    
    playingStream->nbMixedBlocks = 0;
  }

    
  /* release the stream */
  SDL_mutexV(audioStreamMutex);

  /* signal to the decoder if a stop is deleted */
  if(stopDeletedFlag){
    SDL_CondSignal(stateUpdated);
    return 0;
  }
  
  /* else return -1 */
  else
    return -1;  
}
 

/*******************************************************/
/* The setVolume command                               */
/*******************************************************/
int WV_setAudioVolume(WVAudioStreamHandle streamHdl, double volume)
{
  AudioBitStream* audioStream = (AudioBitStream*)streamHdl;
  
  /* lock the stream */
  SDL_mutexP(audioStreamMutex);

  audioStream->volume = volume;

  /* release the stream */
  SDL_mutexV(audioStreamMutex);

  return 0;
}

  




/***************************************************/
/*  The command : AUDIO_DECODER_QUIT               */
/*  -first the user space function                 */
/*  -next the decoder space function               */
/***************************************************/

int WV_audioDecoderShutdown(void)
{
  /* send directly the command */
  sendDecoderCommand(AUDIO_DECODER_QUIT);

  //the decoder free all the streams,
  //close the audio,
  //and stop his thread

  /* now close thread communication */
  SDL_DestroyMutex(stateUpdatedMutex);
  SDL_DestroyCond(stateUpdated);

  SDL_DestroyMutex(audioStreamMutex);
  SDL_DestroyCond(audioStreamUpdated);

  SDL_DestroyCond(playingFinished);

  SDL_DestroyMutex(cmdMutex);
  SDL_DestroyCond(cmdExecuted);
  

  /* the mixer was stopped by the decoder we can free the calcBuffer */
  free(calcBuffer);

  /* the callback filter */
  free(callbackTimes);

  /* it's ok */
  return 0;
}

void audioDecoderQuit(void)
{
  /* close the audio */
  SDL_CloseAudio();

  /* free all the streams */
  int i;
  for(i=0; i<nbAudioStream; i++)
    freeAudioStream(audioStreams[i]);
}



/************************************/
/*||||||||||||||||||||||||||||||||||*/
/*       THE DECODER THREAD         */
/*||||||||||||||||||||||||||||||||||*/
/************************************/
static int audioRunningFlag;  //the decoder start/pause the audio

static int audioDecoderThread(void* opaque)
{
  int streamLackingFlag = 0;  //when a stream have less than 2 blocks we need to decode
                              //At start we have no streams so there are no lacking

  while(1){
    /*********************/
    /* check for waiting */
    /*********************/
    SDL_mutexP(stateUpdatedMutex);

    if(!stateUpdatedFlag){
      /* if nothing append during the last loop, we can mix ! */
      /* signal if the mixer is waiting */
      SDL_CondSignal(audioStreamUpdated);

      if(!streamLackingFlag){
	/* if nothing append and we have no lacking, wait */
	SDL_CondWait(stateUpdated, stateUpdatedMutex);
      }
    }

    /* reinit state variables */
    stateUpdatedFlag = 0;            //we will see if something append during the loop
    streamLackingFlag = 0;       

    SDL_mutexV(stateUpdatedMutex);
    
    
    /**************************/
    /* check for user command */
    /**************************/
    SDL_mutexP(cmdMutex);
    
    if(decoderCommand){
      switch(decoderCommand){
	
      case AUDIO_DECODER_ADD_STREAM:
	audioDecoderAddStream();
	break;

      case AUDIO_DECODER_DEL_STREAM:
	audioDecoderDelStream();
	break;

      case AUDIO_DECODER_SEEK:
	audioDecoderSeek();
	break;

      case AUDIO_DECODER_QUIT:
	audioDecoderQuit();
	decoderCommand = AUDIO_DECODER_NO_COMMAND;
	SDL_mutexV(cmdMutex);
	SDL_CondSignal(cmdExecuted);
	return 0;                  //get out of this loop !!!
	break;
      }
      
      /* the command is executed, say this to the client */
      decoderCommand = AUDIO_DECODER_NO_COMMAND;
      SDL_mutexV(cmdMutex);                     
      SDL_CondSignal(cmdExecuted);
    }
    else{    //else just release the cmd mutex 
      SDL_mutexV(cmdMutex);
    }

    
    /*****************************************************************************/
    /*                       THE DECODE STAGE                                    */
    /* if nothing append, all the no paused streams wille have one block or more */
    /* if it can, the decoder put two blocks or more in all the streams          */
    /*****************************************************************************/


    /******************************/
    /*----------------------------*/
    /* we check the audio streams */
    /*----------------------------*/
    /******************************/
    int i;
    AudioBitStream* currStream;
    
    SDL_mutexP(audioStreamMutex);
    

    /***************************************************/
    /* first check if we need to start/pause the audio */
    /***************************************************/
    /* for clock computation we need to stop the audio */
    /* when the stream is paused and stopLatency is set*/
    /* by the mixer                                    */

    int streamToPlayFlag = 0;
    
    i=0;
    while(i<nbAudioStream){
      currStream = audioStreams[i];
      /* if stream not paused */
      if(WVAD_firstStop(currStream->stopL) != currStream->readPos){
	streamToPlayFlag = 1;             //we need running the audio
	break;
      }

      i++;
    }
    
    /* if we need to play and the audio system not running, start the audio */
    if(streamToPlayFlag && !audioRunningFlag){
      SDL_PauseAudio(0);
      audioRunningFlag = 1;
    }
    
    /*if we have nothing to play and the audio system is running, stop the audio */
    else if(!streamToPlayFlag && audioRunningFlag){
      SDL_PauseAudio(1);
      audioRunningFlag = 0;
    }
    
    /********************************************/
    /* now check whitch stream need decoding    */
    /********************************************/
    int priorizedDecodingFlag = 0;  //if streams have no block and no paused
    int noPriorizedDecodingFlag = 0; //if streams have exactly 1 block, or O block and paused

    /* !!! we put stream->lackingFlag to 1 for no prorized */
    /* !!! we put stream->lackingFlag to 2 for priorized */
    /* !!! else stream->lackingFlag is set to 0 */

    
    for(i=0; i<nbAudioStream; i++){
      currStream = audioStreams[i];
      
      /* have no block and no paused */
      if(currStream->nbBlocks == 0 && (WVAD_firstStop(currStream->stopL)!=currStream->readPos)){
	currStream->lackingFlag = 2;
	priorizedDecodingFlag = 1;
      }
      /* need decoding */
      else if(currStream->nbBlocks < 2){
	currStream->lackingFlag = 1;
	noPriorizedDecodingFlag = 1;
      }
      else
	currStream->lackingFlag = 0;
	
    }

    SDL_mutexV(audioStreamMutex);


    /**************/
    /* now decode */
    /**************/

    /* decode only if needed */
    if(priorizedDecodingFlag || noPriorizedDecodingFlag){
      
      /* say witch stream->lackingFlag we need to decode */
      int decoderTarget;
      if(priorizedDecodingFlag)
	decoderTarget = 2;
      else
	decoderTarget = 1;

      /* ckeck all the stream for decoding */
      int newBlocks;
      
      for(i=0; i<nbAudioStream; i++){
	currStream = audioStreams[i];
	
	/* if it is a decoding target */
	if(currStream->lackingFlag == decoderTarget){
	  
	  /* decode */
	  newBlocks = decodeAudio(currStream);
	  
	  /* update blocks count */
	  SDL_mutexP(audioStreamMutex);

	  currStream->nbBlocks += newBlocks;
	  if(currStream->nbBlocks < 2)
	    streamLackingFlag = 1;    //if we don't get enough blocks
                                      //we need to decode enother time

	  SDL_mutexV(audioStreamMutex);
	}
      }

      /* check if the decoder let lacking streams */
      /* it is the case when we priorize decoding and have streams with 1 block */
      if(priorizedDecodingFlag && noPriorizedDecodingFlag)
	streamLackingFlag = 1;
    }

  }
}	  
    

    
       
  
    


/************************************/
/*||||||||||||||||||||||||||||||||||*/
/*        the init function         */
/*||||||||||||||||||||||||||||||||||*/
/************************************/

int WV_initAudioDecoder(void)
{
  /*******************************/
  /* first init the audio system */
  /*******************************/
  playFlag = 0;  //can do this after opening the audio

  /* set audio parameters */
  SDL_AudioSpec desiredSpec;
  SDL_AudioSpec obtainedSpec;

  desiredSpec.freq = WV_DECODER_SAMPLE_RATE;
  desiredSpec.format = AUDIO_S16SYS;               //we use only 16bit samples
  desiredSpec.channels = WV_DECODER_CHANNELS;                        //stereo
  desiredSpec.samples = WV_WANTED_AUDIO_BLOCK_SIZE/(WV_DECODER_CHANNELS * 2); //size is in byte
  desiredSpec.callback = mixerCallback;
  desiredSpec.userdata = NULL;

  /* open audio */
  if(SDL_OpenAudio(&desiredSpec, &obtainedSpec) < 0){
    fprintf(stderr, "Couldn't open audio: %s\n", SDL_GetError());
    return -1;
  }

  /* check obtained */
  /* only block size can be as the system want */
  if(obtainedSpec.freq != WV_DECODER_SAMPLE_RATE ||\
     obtainedSpec.format != AUDIO_S16SYS ||\
     obtainedSpec.channels != 2){
    printf("Couldn't get the requiered audio sytem\n");
    return -1;
  }

  /* save the block size calculated by OpenAudio */
  audioBlockSize = obtainedSpec.size;

  /* compute block samples */
  unsigned int nbSamples = audioBlockSize/2;   //we use int16_t samples
    
  
  /* audio is not running yet */
  audioRunningFlag = 0;

  /*****************************/
  /* init communication system */
  /*****************************/
  stateUpdatedMutex = SDL_CreateMutex();
  stateUpdated = SDL_CreateCond();
  stateUpdatedFlag = 0;   //wait at start

  audioStreamMutex = SDL_CreateMutex();
  audioStreamUpdated = SDL_CreateCond();

  playingFinished = SDL_CreateCond();

  cmdMutex = SDL_CreateMutex();
  cmdExecuted = SDL_CreateCond();
    
  
  /*******************************/
  /* init the calculation buffer */
  /* used by the mixer           */
  /*******************************/
  calcBuffer = (double*)malloc(nbSamples*sizeof(double));
  
  /********************/
  /* init mean filter */
  /********************/
  initCallbackFilter();
  

  /************************/
  /* init state variables */
  /************************/
  nbAudioStream = 0;
  decoderCommand = AUDIO_DECODER_NO_COMMAND;

  
  /*****************************/
  /* launch the decoder thread */
  /*****************************/
  #if SDL_VERSION_ATLEAST(2,0,0)
  SDL_CreateThread(audioDecoderThread, "audioThread", NULL);
  #else
  SDL_CreateThread(audioDecoderThread, NULL);
  #endif


  

  
  /* all is ok */
  return 0;
}

  

  


  
     

     





