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

	DKClass::RegisterFunc("DKSDLAudio::PlaySound", &DKSDLAudio::PlaySound, this);
	DKClass::RegisterFunc("DKSDLAudio::PlayMusic", &DKSDLAudio::PlayMusic, this);
}

//////////////////////
void DKSDLAudio::End()
{

}

///////////////////////////////////////
void* DKSDLAudio::PlaySound(void* data)
{
	DKString path = *static_cast<DKString*>(data);
	if(!DKFile::VerifyPath(path)){ return 0; }
	//playSound(path.c_str(), SDL_MIX_MAXVOLUME);
	return NULL;
}

///////////////////////////////////////
void* DKSDLAudio::PlayMusic(void* data)
{
	DKString path = *static_cast<DKString*>(data);
	if(!DKFile::VerifyPath(path)){ return 0; }
	//playMusic(path.c_str(), SDL_MIX_MAXVOLUME);
	return NULL;
}
