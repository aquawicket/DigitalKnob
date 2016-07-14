#include "stdafx.h"
#include "DKSDLAudio.h"
#include "DKFile.h"

Uint8* DKSDLAudio::audio_pos; // global pointer to the audio buffer to be played
Uint32 DKSDLAudio::audio_len; // remaining length of the sample we have to play
Uint32 DKSDLAudio::wav_length; // length of our sample
Uint8* DKSDLAudio::wav_buffer; // buffer containing our audio file
SDL_AudioSpec DKSDLAudio::wav_spec; // the specs of our piece of music
	
///////////////////////
void DKSDLAudio::Init()
{
	if(SDL_Init(SDL_INIT_AUDIO) < 0){
		DKLog("Could not Init SDL_Audio. \n",DKERROR);
		return;
	}	

	DKClass::RegisterFunc("DKSDLAudio::Play", &DKSDLAudio::Play, this);
}

//////////////////////
void DKSDLAudio::End()
{

}

//////////////////////////////////
void* DKSDLAudio::Play(void* data)
{
	DKString path = *static_cast<DKString*>(data);
	if(!DKFile::VerifyPath(path)){ return 0; }

	DKLog("Playng file: "+path+"\n", DKINFO);
	// Load the WAV
	// the specs, length and buffer of our wav are filled
	if(SDL_LoadWAV(path.c_str(), &wav_spec, &wav_buffer, &wav_length) == NULL){
		DKLog("SDL_LoadWAV() filed to load file. \n", DKERROR);
		return 0;
	}
	// set the callback function
	wav_spec.callback = DKSDLAudio::Callback;
	wav_spec.userdata = NULL;
	// set our global static variables
	audio_pos = wav_buffer; // copy sound buffer
	audio_len = wav_length; // copy file length
	
	// Open the audio device
	if ( SDL_OpenAudio(&wav_spec, NULL) < 0 ){
	  fprintf(stderr, "Couldn't open audio: %s\n", SDL_GetError());
	  exit(-1);
	}
	
	// Start playing
	SDL_PauseAudio(0);

	// wait until we're don't playing
	while ( audio_len > 0 ) {
		SDL_Delay(100); 
	}
	
	// shut everything down
	SDL_CloseAudio();
	SDL_FreeWAV(wav_buffer);
	return NULL;
}

/////////////////////////////////////////////////////////////////
void DKSDLAudio::Callback(void *userdata, Uint8 *stream, int len)
{
	if(audio_len ==0){ return; }

	len = ((unsigned int)len > audio_len ? audio_len : (unsigned int)len );
	//SDL_memcpy (stream, audio_pos, len); 					// simply copy from one buffer into the other
	SDL_MixAudio(stream, audio_pos, len, SDL_MIX_MAXVOLUME);// mix from one buffer into another
	audio_pos += len;
	audio_len -= len;
}
