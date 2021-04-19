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

#include "packet_feeder.h"

#include "common.h"
#include "config_sdl.h"
#include "config_ffmpeg.h"

#include "waave_engine_flags.h"


/*********************************************/
/*  The packet feeder feed a dynamic         */
/*  number of queues. We first define this   */
/*  type.                                    */
/*********************************************/

/* an PacketQueueElement* can be easely recasted in a AVPacket* !!! */
typedef struct PacketQueueElement{  
  AVPacket pkt;
  struct PacketQueueElement* nextPkt;
}PacketQueueElement;


typedef struct PacketQueue{
  PacketQueueElement *firstPkt, *lastPkt;  
  int nbPackets;
  int size;         // the size of the queue
  
  /* wait */
  int waitFlag;
  SDL_mutex* mutex;
  SDL_cond * queueUpdated;    //WAIT (client) : "Hey ! the queue is empty !"
                              //SIGNAL (feeder) : "I have put a packet in this queue"
}PacketQueue;


/*********************************************/
/* The feeder works like a state machine so  */
/* here the internal variables               */
/*********************************************/


static int stateUpdatedFlag = 0;        //Feeder stop working if all the queues are full
static SDL_mutex* stateUpdatedMutex;// and if no command was send (see later)
static SDL_cond*  stateUpdated;    //WAIT (feeder):"I have nothing to do, wait for client getting 
                                    //               pkt or sending command"
                                    //SIGNAL (client) : "A commans was send" or "A pkt was get"


/***********************************************/
/* Here the functions to manipulate the queues */
/***********************************************/

/* !!! alloc space for the structure before calling !!!*/
static int packetQueueInit(PacketQueue* newQueue)
{
  /* init internal variables */
  newQueue->nbPackets = 0;
  newQueue->size = 0;
  newQueue->waitFlag = 0;
  newQueue->mutex = SDL_CreateMutex();
  newQueue->queueUpdated = SDL_CreateCond();

  return 0;
}


/* feeder space function */
/* doesn't wait ! if the queue is full return -1 (without forceFlag) */
/* the feeder need to send a PacketQueueElement to avoid useless copy */
/* if force flag is set the queue size can be greater than PACKET_FEEDER_MAX_QUEUE_SIZE */
static int packetQueuePut(PacketQueue* queue, PacketQueueElement* inPkt, int forceFlag)
{
  /* this is the last pkt */
  inPkt->nextPkt = NULL;

  /* lock the mutex and ckeck if not space is available for the pkt */
  SDL_mutexP(queue->mutex);
  if(!forceFlag){
    if(queue->nbPackets + 1 > WV_PACKET_FEEDER_MAX_QUEUE_SIZE){
      SDL_mutexV(queue->mutex);
      return -1;     //the queue is full !
    }
  }

  /* else */
  /* put the pkt in the queue */
  if(queue->nbPackets == 0){
    queue->firstPkt = inPkt;
    queue->lastPkt = inPkt;
  }
  else{
    queue->lastPkt->nextPkt = inPkt;  //change the last pkt
    queue->lastPkt = inPkt;
  }

  /* update count */
  queue->nbPackets++;
  queue->size += ((AVPacket*)inPkt)->size;
  
  /* realease the mutex and signal the client that the queue is updated */
  SDL_mutexV(queue->mutex);
  SDL_CondSignal(queue->queueUpdated);

  return 0;
}


AVPacket* WV_packetQueueGet(WVQueueHandle queueHdl, int waitFlag) 
{
  PacketQueue* queue = (PacketQueue*)queueHdl; //recast the void* handle

  /* get access to the queue */
  SDL_mutexP(queue->mutex);

  /* wait for pkt if needed */
  if(waitFlag){
    while(queue->nbPackets == 0){  
      /* put the wait flag */
      queue->waitFlag = 1;
      
      /* signal to the feeder */
      SDL_mutexP(stateUpdatedMutex);    //change the state flag
      stateUpdatedFlag = 1;
      SDL_mutexV(stateUpdatedMutex);
      
      SDL_CondSignal(stateUpdated);

      /* wait for packet */
      SDL_CondWait(queue->queueUpdated, queue->mutex);
      queue->waitFlag = 0;                                           
                                        
    }
    
  }
  else{
    if(queue->nbPackets == 0){
      SDL_mutexV(queue->mutex);
      return NULL;
    }
  }
  

  /* read the packet */
  PacketQueueElement* previousFirst = queue->firstPkt;
    
  /* get the packet out of the queue */
  queue->nbPackets--;
  queue->size -= ((AVPacket*)previousFirst)->size;
  if(queue->nbPackets != 0)
    queue->firstPkt = previousFirst->nextPkt;
  //else, nothing to do
  
  /* release the queue */
  SDL_mutexV(queue->mutex);
  
  /* signal that state is updated */
  SDL_mutexP(stateUpdatedMutex);    //change the state flag
  stateUpdatedFlag = 1;
  SDL_mutexV(stateUpdatedMutex);

  SDL_CondSignal(stateUpdated);  //say to the feeder that it can restart feeding
                                 //if all the queues was full. See the declaration
                                 //of stateUpdate

  return (AVPacket*)previousFirst;  //we give a pointer to a PacketQueueElement
                                    //but it is not a problem for the user
}




/* empty a queue without sending any signal */
/* !!! DOESN'T lock the queue! must be applied to an unused queue !!!*/
void emptyQueue(PacketQueue* queue)
{
  if(queue->nbPackets == 0)
    return;                   //the job is already done

  /* free the elements of the queue */
  PacketQueueElement* currentPkt;
  PacketQueueElement* nextFreedPkt;
  
  currentPkt = queue->firstPkt;
 
  while(currentPkt->nextPkt){
    nextFreedPkt = currentPkt->nextPkt; //save the pkt for later freed
    /* free the current element */
    av_free_packet((AVPacket*)currentPkt);  //the ffmpeg function doesn't free the structure !
    free(currentPkt);                    //free the container
    
    /* go to the next */
    currentPkt = nextFreedPkt;
  }

  /* free the last pkt */
  av_free_packet((AVPacket*)currentPkt);
  free(currentPkt);

  /* reset the queues variables */
  queue->nbPackets = 0;
  queue->size = 0;
}


/* !!! doesn't free the PacketQueue structure  !!!*/
/* !!! if the queue is not empty all the pkt will be lost !!!*/
int packetQueueClose(PacketQueue* queue)
{
  /* empty the queue if needed */
  if(queue->nbPackets)
    emptyQueue(queue);

  /* release mutex and cond */
  SDL_DestroyMutex(queue->mutex);
  SDL_DestroyCond(queue->queueUpdated);

  return 0;
}


/*************************************************************/
/* The feeder can read packets from multiple files and each  */
/* file can have multiple streams (video stream, audio...)   */
/* So the feeder will have one context per file (AVFormatCtx)*/
/* This context will say according to the pkt stream index   */
/* in witch queue the pkt need to be send. Each context has  */
/* his own queues.                                           */
/*************************************************************/

typedef struct PacketFeederContext{
  AVFormatContext* formatCtx; //to read the pkts
  int nbPipe;                 //a pipe send the pkts of a stream to the correponding queue
  int currentPipe;
  int fullFlag;         //when a queue is full and when the next pkt is 
                        //for this queue we cannot fill the other queues
                        //of the context !
  
  
  int* streamIdx;              //the streams indexes
  PacketQueue** queue;         //and the corresponding queues

  PacketQueueElement* pkt;   //the current pkt is saved if 
                             //we cannot put it in the queue
  
  PacketQueue* destQueue;      //where we need to put the saved pkt (avoid search again)     
}PacketFeederContext;



/**************************************************/
/* now state variables relative to feeder context */
/**************************************************/
static int nbFeederContext;
static PacketFeederContext* feederCtx[WV_PACKET_FEEDER_MAX_CONTEXT];



/*************************************************/
/* The client manipulate feeder context by a set */
/* of commands                                   */
/*************************************************/
#define PACKET_FEEDER_NO_COMMAND 0
#define PACKET_FEEDER_ADD_CONTEXT 1
#define PACKET_FEEDER_DEL_CONTEXT 2
#define PACKET_FEEDER_DEL_QUEUE 3 
#define PACKET_FEEDER_SEEK 4 
#define PACKET_FEEDER_QUIT 5

static int feederCommand;    //where the client put the command

static SDL_mutex* cmdMutex;
static SDL_cond* cmdExecuted;  //the client need to wait for command execution 
                               //before continuing
                               //WAIT (client) : "I have sent you a command say me 
                               //                 the work is done"
                               //SIGNAL (feeder) : "Well, command terminated"

/* here the command parameters */
static int removingCtxIdx;       //for DEL_CONTEXT
                                 //the index of the context that the client wants to remove
                                 //it is recognized by his AVFormatContext (see below)


static int delQueueCtxIdx;      //for DEL_QUEUE
static int delQueueIdx;
static WVQueueHandle delQueueHdl;



static int seekingCtxIdx;         //for SEEK, the context where we seek
static int seekingStreamIdx;
static uint64_t seekingTimestamp;    //the time timestamp where we seek
static int seekingFlags;

static PacketFeederContext* freeingCtx; //the feeder let the client freeing the context
                                        //for minimal disturbance of the feeder


/* !!! very important function !!! */
/* used each time we send a command to the feeder */
/* send a command, signal state change, and wait for execution */
static void sendFeederCommand(int cmd)
{
  /* send the command to the feeder */
  SDL_mutexP(cmdMutex);
  feederCommand = cmd;
  
  /* signal that state is updated */
  SDL_mutexP(stateUpdatedMutex);    //change the state flag
  stateUpdatedFlag = 1;
  SDL_mutexV(stateUpdatedMutex);

  SDL_CondSignal(stateUpdated);  //say to the feeder that it can thread commands
                                 //or restart feeding queues                                 
                                 //if he was waiting (all the queues are full)
  
  /* wait for command execution */
  SDL_CondWait(cmdExecuted, cmdMutex); 
  
  /* release command variable  */
  SDL_mutexV(cmdMutex);
}


/************************************************/
/* Here the client space functions for building */
/* a context before sending the command         */
/************************************************/ 

static PacketFeederContext* buildingCtx; //the context we are building

/* first the user create the context while giving the */
/* number of streams he want to send to the queues    */

int WV_buildFeederContext(AVFormatContext* formatCtx, int nbStreams)
{
  if(nbFeederContext >= WV_PACKET_FEEDER_MAX_CONTEXT)
    return -1;
  
  /* alloc space for the structure, the stream indexes, the queue pointers, and the queues */
  int structSize = sizeof(PacketFeederContext);
  int streamIdxSize = nbStreams*sizeof(int);
  int queuePtSize = nbStreams*sizeof(PacketQueue*);
  int queuesSize = nbStreams*sizeof(PacketQueue);

  int contextSize = structSize + streamIdxSize + queuePtSize + queuesSize;
  
  buildingCtx = (PacketFeederContext*)malloc(contextSize);

  /* set the pointers */
  //void* calcP = (void*)buildingCtx;
  PacketFeederContext* calcP = buildingCtx;

  calcP += structSize;                    //after the structure
  buildingCtx->streamIdx = (int*)calcP;  //we have the stream Idxs

  calcP += streamIdxSize;                            //after the stream idxs
  buildingCtx->queue = (PacketQueue**)calcP;         //we have the queue pointers

  calcP += queuePtSize;                                    //after the queue pointers
  int i;                                                   //we have the queues
  for(i=0; i<nbStreams; i++){
    buildingCtx->queue[i] = (PacketQueue*)calcP;
    calcP += sizeof(PacketQueue);
  }

  /* fill the structure */
  buildingCtx->formatCtx = formatCtx;
  buildingCtx->nbPipe = nbStreams;
  buildingCtx->currentPipe = 0;
  buildingCtx->fullFlag = 0;
  buildingCtx->pkt = NULL;

  return 0;
}

/* next the user give the stream indexes the feeder need to send */
/* to the queues. !!! this function need to be called            */
/* nbStreams times !!! the feeder return the correponding        */
/* queue Handle while building the queues                        */

WVQueueHandle WV_getStreamQueue(int streamIdx)
{
  /* build the queue at the actual position */
  /* the feeder doesn't access this memory space for now */
  packetQueueInit(buildingCtx->queue[buildingCtx->currentPipe]); 
  
  /* save the stream in the context */
  buildingCtx->streamIdx[buildingCtx->currentPipe] = streamIdx;
  
  /* prepare to the next pipe */
  buildingCtx->currentPipe++;
    
  /* it is just a void* cast */
  return (WVQueueHandle)buildingCtx->queue[buildingCtx->currentPipe - 1];
}



/***************************************************/
/*  The first command : PACKET_FEEDER_ADD_CONTEXT  */
/*  -first the user space function                 */
/*  -next the feeder space function                */
/***************************************************/

int WV_addFeederContext(void)
{
  /* save the builded context */
  feederCtx[nbFeederContext] = buildingCtx; //the feeder doesn't access on this space
  
  /* send the command to the feeder */
  sendFeederCommand( PACKET_FEEDER_ADD_CONTEXT );

  // the feeder update and nbFeederContext
  
  /* it's ok, return  */
  return 0;
}


/* the feeder part of the job */
/* just update nbFeederContext */
static void packetFeederAddContext(void)
{
  /* update the context count */
  nbFeederContext++;
}


/**************************************************/
/* The command : PACKET_FEEDER_DEL_CONTEXT        */
/* -first how free the context                    */
/* -next the user space function                  */
/* -next the feeder space function                */
/**************************************************/
/* !!! be sure you stop getting packet before deleting context */
static void freeFeederContext(PacketFeederContext* pfCtx)
{
  /* close the feeder context queues */
  if(pfCtx->nbPipe){     //if there are queues
    int i;
    for(i=0; i<pfCtx->nbPipe; i++)
      packetQueueClose(pfCtx->queue[i]);  
  }

  /* free the stored pkt if needed */
  if(pfCtx->pkt){
    av_free_packet((AVPacket*)(pfCtx->pkt)); //this ffmpeg function doesn't free the structure
    free(pfCtx->pkt);
  }

  /* now free the structure */
  /* the structure, the streamIdx, the queue pointers and queues was allocated in one time */
  free(pfCtx);
}


int WV_delFeederContext(AVFormatContext* formatCtx)
{
  /* search for the feeder context containing the formatCtx */
  /*!!! we suppose we can read while the feeder use the context !!!*/
  /*!!! maybe we can do this with the feeder !!!*/
  int i = 0;
  while(feederCtx[i]->formatCtx != formatCtx && i<nbFeederContext)
    i++;

  /* found ? */
  if(i == nbFeederContext)
    return -1;              //cannot find the format context
  //else the context is in feederCtx[i]
  
  /* the command param */
  removingCtxIdx = i;
  
  /* Send the command to the feeder */
  sendFeederCommand(PACKET_FEEDER_DEL_CONTEXT);
  
  // the feeder remove the context of the list while not letting holes
  // he doesn't free the structure, he just put its pointer in freeingCtx
  // This is for minimal disturbing of the feeder

  /* free the feeder context */
  freeFeederContext(freeingCtx);

  /* it's ok, return */
  return 0;
}


/* the feeder side */
static void packetFeederDelContext(void)
{
  /* save the struct pointer, the user will free the structure */
  freeingCtx = feederCtx[removingCtxIdx];
  
  /* remove the context given in the cmd param of the list */
  /* by shifting the contexts */
  /* we use the variable removingCtxIdx to do the job */
  nbFeederContext--;     //update the context count now !
  while(removingCtxIdx < nbFeederContext){  //shift the list  
    feederCtx[removingCtxIdx] = feederCtx[removingCtxIdx+1];
    removingCtxIdx++;
  }

  /*  it's ok, let the user free the context */
}


/**************************************************/
/* The command : PACKET_FEEDER_DEL_QUEUE          */
/* -first the user space function                 */
/* -next the feeder space function                */
/**************************************************/
int WV_delFeederQueue(AVFormatContext* formatCtx, WVQueueHandle queueHdl)
{
  delQueueHdl = queueHdl;


  /**************/
  /*   search   */
  /**************/

  /* search for the context */
  int i = 0;
  while(feederCtx[i]->formatCtx != formatCtx && i<nbFeederContext)
    i++;

  /* found ? */
  if(i == nbFeederContext)
    return -1;            //cannot found the context


  delQueueCtxIdx = i;


  /* search for the queue in the context */
  PacketFeederContext* fCtx = feederCtx[i];

  i=0;
  while(fCtx->queue[i] != (PacketQueue*)queueHdl && i<fCtx->nbPipe)
    i++;

  /* found  ? */
  if(i == fCtx->nbPipe)
    return -1;           ///cannot found the queue

  
  delQueueIdx = i;


  /* if this is the only queue */
  /* delete the context */
  if( fCtx->nbPipe ==  1){
    return WV_delFeederContext(formatCtx);
  }


  /****************/
  /* send command */
  /****************/

  /* Send the command to the feeder */
  sendFeederCommand(PACKET_FEEDER_DEL_QUEUE);
  
  //the feeder remove the queue without realloc the struct 

  /* it's ok, return */
  return 0;
}


static void packetFeederDelQueue(void)
{
  
  PacketFeederContext* fCtx =feederCtx[delQueueCtxIdx];
  int queueIdx = delQueueIdx;


  /*********************/
  /*  free the queue   */
  /*********************/

  packetQueueClose(fCtx->queue[queueIdx]);
  
  /* check the packet */
  if(fCtx->destQueue == (PacketQueue*)delQueueHdl){
    av_free_packet((AVPacket*)fCtx->pkt);
    free(fCtx->pkt);
    fCtx->pkt = NULL;
    fCtx->destQueue = NULL;
    fCtx->fullFlag = 0;
  }


  /******************/
  /* shift the list */
  /******************/
  fCtx->nbPipe--;
  
  while(queueIdx < fCtx->nbPipe){    
    fCtx->queue[queueIdx] = fCtx->queue[queueIdx+1];
    fCtx->streamIdx[queueIdx] = fCtx->streamIdx[queueIdx+1];
  }

}




/**************************************************/
/* The command : PACKET_FEEDER_SEEK               */
/* -first the user space function                 */
/* -next the feeder space function                */
/**************************************************/
int WV_contextSeek(AVFormatContext* formatCtx, int streamIdx, uint64_t timestamp, int flags)
{
  /* search for the feeder context containing the formatCtx */
  /*!!! we suppose we can read while the feeder use the context !!!*/
  /*!!! maybe we can do this with the feeder !!!*/
  int i = 0;
  while(feederCtx[i]->formatCtx != formatCtx && i<nbFeederContext)
    i++;

  /* found ? */
  if(i == nbFeederContext)
    return -1;              //cannot find the format context
  //else the context is in feederCtx[i]

  /* set the command params */
  seekingCtxIdx = i;
  seekingStreamIdx = streamIdx;
  seekingTimestamp = timestamp;
  seekingFlags = flags;

  /* and send the command */
  sendFeederCommand(PACKET_FEEDER_SEEK);

  /* return */
  return 0;
}


static void packetFeederSeek(void)
{
  /* read cmd parameter */
  PacketFeederContext* seekingCtx = feederCtx[seekingCtxIdx];
  
  int currIdx;
  PacketQueue* currQ;
  
  /* empty all the queue */
  for(currIdx=0; currIdx<seekingCtx->nbPipe; currIdx++){
    currQ = seekingCtx->queue[currIdx];
    
    SDL_mutexP(currQ->mutex);
    emptyQueue(currQ);
    SDL_mutexV(currQ->mutex);
  }    

  /* free the stored pkt in the context if needed */
  if(seekingCtx->pkt){
    av_free_packet((AVPacket*)(seekingCtx->pkt));
    free(seekingCtx->pkt);
  }

  /* reset the feeder context variables */
  seekingCtx->fullFlag = 0;
  seekingCtx->pkt = NULL;

  /* send a seeking pkt to all the queue */
  PacketQueueElement* seekingPkt;
  for(currIdx=0; currIdx<seekingCtx->nbPipe; currIdx++){
    /* build a seeking pkt */
    seekingPkt = (PacketQueueElement*)malloc(sizeof(PacketQueueElement));
    ((AVPacket*)seekingPkt)->data = NULL;
    ((AVPacket*)seekingPkt)->flags = WV_PACKET_FLAG_SEEK;
    ((AVPacket*)seekingPkt)->size = 0;
    
    /*send to the queue */
    packetQueuePut(seekingCtx->queue[currIdx], seekingPkt, 1); //we force pkt put (useless, void queues)
  }
  
  /* now seek */
  /*!!!*/
  if(av_seek_frame(seekingCtx->formatCtx, seekingStreamIdx, seekingTimestamp, seekingFlags) < 0){
    av_seek_frame(seekingCtx->formatCtx, -1, 0, AVSEEK_FLAG_BACKWARD); //on error seek to 0
  }
}
  
  



/**************************************************/
/* The command : PACKET_FEEDER_QUIT               */
/* -first the user space function                 */
/* -next the feeder space function                */
/**************************************************/

int WV_packetFeederShutdown(void)
{
  /* send the command to the feeder */
  sendFeederCommand(PACKET_FEEDER_QUIT);

  //the feeder destroy all the contexts and stop his thread 
  
  /* we can now destroy the mutex and cond */
  SDL_DestroyMutex(cmdMutex);
  SDL_DestroyMutex(stateUpdatedMutex);
  SDL_DestroyCond(stateUpdated);
  SDL_DestroyCond(cmdExecuted);

  /*it's ok, return */
  return 0;
}

/* the return that stop the thread is in the feeder loop */
static void packetFeederQuit(void)
{
  /* free all the contexts */
  if(nbFeederContext){
    int i;
    for(i=0; i<nbFeederContext; i++)
      freeFeederContext(feederCtx[i]);
  }
}


/**********************************************/
/**********************************************/
/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
/*      now the feeder main loop              */
/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
/**********************************************/
/**********************************************/
static int packetFeederThread(void* opaque)
{
  int fullQueueFlag = 1;  //when one queue is full per context
                          //or when there are no queue to feed 
                          //wait !
  
  while(1){
    /***********************/
    /* ckeck for waiting   */
    /***********************/
    SDL_mutexP(stateUpdatedMutex);
    if(fullQueueFlag && !stateUpdatedFlag){ //if we have see that all the queues are full
                                            // and if nothing append since the last loop
      SDL_CondWait(stateUpdated, stateUpdatedMutex); //wait for state change
    }
    
    fullQueueFlag = 1;             //we will see if if a queue isn't full
    stateUpdatedFlag = 0;          //state return to 0
    SDL_mutexV(stateUpdatedMutex);


    /**************************/
    /* check for user command */
    /**************************/
    SDL_mutexP(cmdMutex);
    
    if(feederCommand){   //if we have a command execute it 
      switch(feederCommand){
	
      case PACKET_FEEDER_ADD_CONTEXT:
	packetFeederAddContext();
	break;

      case PACKET_FEEDER_DEL_CONTEXT:
	packetFeederDelContext();
	break;

      case PACKET_FEEDER_DEL_QUEUE:
	packetFeederDelQueue();
	break;

      case PACKET_FEEDER_SEEK:
	packetFeederSeek();
	break;
	
      case PACKET_FEEDER_QUIT:
	packetFeederQuit();
	feederCommand = PACKET_FEEDER_NO_COMMAND;
	SDL_mutexV(cmdMutex);
	SDL_CondSignal(cmdExecuted);
	return 0;                  //get out of this loop !!!
	break;
      }
      
      /*the command is executed, say this to the client */
      feederCommand = PACKET_FEEDER_NO_COMMAND;
      SDL_mutexV(cmdMutex);                     
      SDL_CondSignal(cmdExecuted);
    }
    else{    //else just release the cmd mutex 
      SDL_mutexV(cmdMutex);
    }
    
  
    /*********************/
    /*  feed the queues  */
    /*********************/
    
    int fdIdx;
    PacketFeederContext* currFCtx;
    PacketQueueElement* currPkt;


    /* for each context */
    for(fdIdx=0; fdIdx<nbFeederContext; fdIdx++){
      currFCtx = feederCtx[fdIdx];

      /**************************/
      /* force packet put if a  */
      /* client waiting fot pkt */
      /**************************/
      int idx;
      int forceFlag = 0;
      for(idx=0; idx<currFCtx->nbPipe; idx++){
	PacketQueue* currQ = currFCtx->queue[idx];
	if(currQ->waitFlag  && currQ->nbPackets == 0){
	  forceFlag = 1;
	  break;
	}
      }

      
      /*************************************/
      /* if we can't put the pkt last time */
      /* try to reput the pkt we have saved*/
      /*************************************/
      if(currFCtx->fullFlag){
	/* retry */
	if(packetQueuePut(currFCtx->destQueue, currFCtx->pkt, forceFlag)>= 0){  //if the pkt was put
	  currFCtx->fullFlag = 0;  //the context is not full anymore
  	  currFCtx->pkt = NULL;    //this say that no pkt are waiting
	  fullQueueFlag = 0;       //no wait at the end of the loop !
	  
	}  //else fullFlags stay to 1
      }
      /******************************/
      /* else we need to read a pkt */
      /******************************/
      else{
	/* get the next pkt */
	currPkt = (PacketQueueElement*)malloc(sizeof(PacketQueueElement));
	
	if(av_read_frame(currFCtx->formatCtx, (AVPacket*)currPkt)<0){
	    
	  /*________________________*/
	  /* if we can't read a pkt */
	  /* 1) send a eof pkt to all the queues */
	  /* TODO error type check */
	  free(currPkt);
	  
	  int sendIdx;
	  PacketQueueElement* eofPkt;
	  for(sendIdx=0; sendIdx<currFCtx->nbPipe; sendIdx++){
	    /* build the eof pkt */
	    eofPkt = (PacketQueueElement*)malloc(sizeof(PacketQueueElement));
	    ((AVPacket*)eofPkt)->data = NULL;
	    ((AVPacket*)eofPkt)->flags = WV_PACKET_FLAG_EOF;
	    ((AVPacket*)eofPkt)->size = 0; 
	    /* send to the queue */
	    packetQueuePut(currFCtx->queue[sendIdx], eofPkt, 1); //we force packet put
	  }

	  /* 2) seek to the file start */
	  av_seek_frame(currFCtx->formatCtx, -1, 0, AVSEEK_FLAG_BACKWARD);
	  fullQueueFlag = 0;   //we can now read the first pkt

	  /* go to the next context */
	  continue; 
	}
	  

	/* we have a pkt */
	/* check if is was allocated */
	//TODO error handling
	av_dup_packet((AVPacket*)currPkt);   //absolutely mandatory

	
	/* and */
	/* search for the queue */
	int searchStream = ((AVPacket*)currPkt)->stream_index;
	int searchIdx;
	for(searchIdx=0; searchIdx<currFCtx->nbPipe; searchIdx++)
	  if(currFCtx->streamIdx[searchIdx] == searchStream)
	    break;

	/* found ? */
	if(searchIdx == currFCtx->nbPipe){            //if not 
	  av_free_packet((AVPacket*)currPkt);  //free the pkt
	  free(currPkt);
	  fullQueueFlag = 0;                //this context is not full !!!
	  continue;                         //!!! go to the next context
	}

	/*************************************************/
	/* now put the packet in the corresponding queue */
	/*************************************************/
	PacketQueue* sendingQueue = currFCtx->queue[searchIdx];
	if(packetQueuePut(sendingQueue, currPkt, forceFlag)< 0){ //if we can't put the pkt
	  /* save the pkt */
	  currFCtx->fullFlag = 1;  //this context is full !
	  currFCtx->pkt = currPkt;
	  currFCtx->destQueue = sendingQueue;
	}
	else{
	  fullQueueFlag = 0;       //no wait at the end of the loop !
                                   //this context is not full
	}
      }
      
      /* go to the next context */
    }
    /* all the context are feeded */	
  }
}	      
		      

/********************************************************/
/*||||||||||||||||||||||||||||||||||||||||||||||||||||||*/
/*  Now the user functions to launch the packet feeder  */
/*||||||||||||||||||||||||||||||||||||||||||||||||||||||*/
/********************************************************/

void WV_initPacketFeeder(void)
{
  /* init state variables (in the case where the feeder is restarted) */
  stateUpdatedFlag = 0;
  nbFeederContext = 0;
  feederCommand = PACKET_FEEDER_NO_COMMAND;

  /* init thread communication */
  stateUpdatedMutex = SDL_CreateMutex();
  stateUpdated = SDL_CreateCond();

  cmdMutex = SDL_CreateMutex();
  cmdExecuted = SDL_CreateCond();
  
  /* launch the feeder thread */
  #if SDL_VERSION_ATLEAST(2,0,0)
  SDL_CreateThread(packetFeederThread, "packetThread", NULL);
  #else
  SDL_CreateThread(packetFeederThread, NULL);
  #endif

}
   


