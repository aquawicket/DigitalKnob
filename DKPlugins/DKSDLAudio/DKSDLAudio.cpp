#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DKSDLAudio/DKSDLAudio.h"

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
	volume = 128;

	DKClass::RegisterFunc("DKSDLAudio::GetVolume", &DKSDLAudio::GetVolume, this);
	DKClass::RegisterFunc("DKSDLAudio::Mute", &DKSDLAudio::Mute, this);
	DKClass::RegisterFunc("DKSDLAudio::OpenMusic", &DKSDLAudio::OpenMusic, this);
	DKClass::RegisterFunc("DKSDLAudio::Pause", &DKSDLAudio::Pause, this);
	DKClass::RegisterFunc("DKSDLAudio::PlaySound", &DKSDLAudio::PlaySound, this);
	DKClass::RegisterFunc("DKSDLAudio::Resume", &DKSDLAudio::Resume, this);
	DKClass::RegisterFunc("DKSDLAudio::SetVolume", &DKSDLAudio::SetVolume, this);
	DKClass::RegisterFunc("DKSDLAudio::UnMute", &DKSDLAudio::UnMute, this);
	DKApp::AppendLoopFunc(&DKSDLAudio::Process, this);
}

//////////////////////
void DKSDLAudio::End()
{
	DKApp::RemoveLoopFunc(&DKSDLAudio::Process, this);
	Mix_CloseAudio();
}

/////////////////////////////////////////////////////
bool DKSDLAudio::PlaySound(void* input, void* output)
{
	DKString path = *(DKString*)input;
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

/////////////////////////////////////////////////////
bool DKSDLAudio::OpenMusic(void* input, void* output)
{
	DKString path = *(DKString*)input;
	if(!DKFile::VerifyPath(path)){ return 0; }
	
	trk.file = path;
	trk.snd = Mix_LoadMUS(path.c_str());
	trk.position = 0;
	lastTime = SDL_GetTicks();

	if(!trk.snd){
		DKLog("DKSDLAudio::OpenMusic(): could not load file \n", DKERROR);
	}

	if(Mix_PlayMusic(trk.snd, 0) == -1){
		DKLog("DKSDLAudio::OpenMusic(): error playing file \n", DKERROR);
	}
	Mix_PauseMusic(); //pause 

	return NULL;
}

/////////////////////////////////////////////////
bool DKSDLAudio::Pause(void* input, void* output)
{
	DKString path = *(DKString*)input;
	Mix_PauseMusic();
	return NULL;
}

//////////////////////////////////////////////////
bool DKSDLAudio::Resume(void* input, void* output)
{
	DKString path = *(DKString*)input;
	trk.position = 0;
	lastTime = SDL_GetTicks();
	Mix_RewindMusic();
	Mix_ResumeMusic();
	return NULL;
}

////////////////////////////////////////////////
bool DKSDLAudio::Mute(void* input, void* output)
{
	Mix_VolumeMusic(0);
	return NULL;
}

//////////////////////////////////////////////////
bool DKSDLAudio::UnMute(void* input, void* output)
{
	Mix_VolumeMusic(volume);
	return NULL;
}

/////////////////////////////////////////////////////
bool DKSDLAudio::GetVolume(void* input, void* output)
{
	int val = Mix_VolumeMusic(-1);
	return static_cast<void*>(new int(val));
}

/////////////////////////////////////////////////////
bool DKSDLAudio::SetVolume(void* input, void* output)
{
	volume = *(int*)input;
	Mix_VolumeMusic(volume);
	return NULL;
}


//////////////////////////
void DKSDLAudio::Process()
{
	if(Mix_PlayingMusic() && !Mix_PausedMusic()){
		if(((SDL_GetTicks() - lastTime) / 1000) > (unsigned int)trk.position){
			trk.position = (SDL_GetTicks() - lastTime) / 1000;
			//DKLog("trk.position = "+toString(trk.position)+"\n", DKDEBUG);
			DKEvent::SendEvent("DKAudio", "position", toString(trk.position));
		}
	}
	else if(!Mix_PlayingMusic()){
		//FIXME: !!!  PlaySound will call this constantly !!!
		//DKLog("!Mix_PlayingMusic()\n", DKDEBUG);
		Mix_RewindMusic();
		if(trk.file.empty()){ return; }
		Mix_PlayMusic(trk.snd, 0);
		Mix_PauseMusic();
		trk.position = 0;
		lastTime = SDL_GetTicks();
		DKEvent::SendEvent("DKAudio", "finnished", trk.file);
	}
}
