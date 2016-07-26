#include "stdafx.h"
#include "DKSDLAudio.h"
#include "DKFile.h"


///////////////////////
void DKSDLAudio::Init()
{
	if(SDL_Init(SDL_INIT_AUDIO) < 0){
		DKLog("Could not Init SDL_Audio. \n",DKERROR);
		return;
	}	

	//Initialize SDL_mixer 
	if(Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 2, 4096) == -1){
		DKLog("DKSDLAudio::Init(): could not load mixer \n",DKERROR);
	}

	DKClass::RegisterFunc("DKSDLAudio::PlaySound", &DKSDLAudio::PlaySound, this);
	DKClass::RegisterFunc("DKSDLAudio::PlayMusic", &DKSDLAudio::PlayMusic, this);
	DKClass::RegisterFunc("DKSDLAudio::Pause", &DKSDLAudio::Pause, this);
	DKClass::RegisterFunc("DKSDLAudio::Resume", &DKSDLAudio::Resume, this);
	//DKApp::AddLoopFunc("RENDER", &DKSDLAudio::Process, this);
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
	
	track trk;
	trk.file = path;
	trk.snd = Mix_LoadMUS(path.c_str());
	trk.position = 0;
	tracks.push_back(trk);

	//Mix_Music *snd = Mix_LoadMUS(path.c_str());
	if(!trk.snd){
		DKLog("DKSDLAudio::PlayMusic(): could not load file \n", DKERROR);
	}

	if(Mix_PlayMusic(trk.snd, -1) == -1){
		DKLog("DKSDLAudio::PlayMusic(): error playing file \n", DKERROR);
	}

	return NULL;
}

///////////////////////////////////
void* DKSDLAudio::Pause(void* data)
{
	DKString path = *static_cast<DKString*>(data);
	//DKLog("DKSDLAudio::Pause(): not implemnted. \n",DKERROR);
	Mix_PauseMusic();
	return NULL;
}

////////////////////////////////////
void* DKSDLAudio::Resume(void* data)
{
	DKString path = *static_cast<DKString*>(data);
	//DKLog("DKSDLAudio::Resume(): not implemnted. \n",DKERROR);
	Mix_ResumeMusic();
	return NULL;
}

//////////////////////////
void DKSDLAudio::Process()
{
	//Mix_PlayingMusic();
}
