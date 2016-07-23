#include "stdafx.h"
#include "DKSDLAudio.h"
#include "DKFile.h"
#include "SDL_mixer.h"

///////////////////////
void DKSDLAudio::Init()
{
	if(SDL_Init(SDL_INIT_AUDIO) < 0){
		DKLog("Could not Init SDL_Audio. \n",DKERROR);
		return;
	}	

	//Initialize SDL_mixer 
	if(Mix_OpenAudio(22050, MIX_DEFAULT_FORMAT, 2, 4096) == -1){
		DKLog("DKSDLAudio::Init(): could not load mixer \n",DKERROR);
	}

	DKClass::RegisterFunc("DKSDLAudio::PlaySound", &DKSDLAudio::PlaySound, this);
	DKClass::RegisterFunc("DKSDLAudio::PlayMusic", &DKSDLAudio::PlayMusic, this);
	DKApp::AddLoopFunc("RENDER", &DKSDLAudio::Process, this);
}

//////////////////////
void DKSDLAudio::End()
{
	DKApp::RemoveLoopFunc(&DKSDLAudio::Process, this);
	Mix_CloseAudio();
}

///////////////////////////////////////
void* DKSDLAudio::PlaySound(void* data)
{
	DKString path = *static_cast<DKString*>(data);
	if(!DKFile::VerifyPath(path)){ return 0; }
	
	Mix_Chunk *snd = Mix_LoadWAV(path.c_str());
	if(!snd){
		DKLog("DKSDLAudio::PlaySound(): could not load file \n", DKERROR);
	}

	if(Mix_PlayChannel(-1, snd, 0) == -1){
		DKLog("DKSDLAudio::PlaySound(): error playing file \n", DKERROR);
	}

	return NULL;
}

///////////////////////////////////////
void* DKSDLAudio::PlayMusic(void* data)
{
	DKString path = *static_cast<DKString*>(data);
	if(!DKFile::VerifyPath(path)){ return 0; }
	
	Mix_Music *snd = Mix_LoadMUS(path.c_str());
	if(!snd){
		DKLog("DKSDLAudio::PlayMusic(): could not load file \n", DKERROR);
	}

	if(Mix_PlayMusic(snd, -1) == -1){
		DKLog("DKSDLAudio::PlayMusic(): error playing file \n", DKERROR);
	}

	return NULL;
}

//////////////////////////
void DKSDLAudio::Process()
{
	Mix_PlayingMusic();
}
