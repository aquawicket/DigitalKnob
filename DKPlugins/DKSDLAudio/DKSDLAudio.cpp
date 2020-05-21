#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DKSDLAudio/DKSDLAudio.h"

///////////////////////
bool DKSDLAudio::Init()
{
	DKDEBUGFUNC();
	if(SDL_Init(SDL_INIT_AUDIO) < 0){
		DKERROR("Could not Init SDL_Audio\n");
		return false;
	}	

	//Initialize SDL_mixer 
	if(Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 2, 4096) == -1){
		DKERROR("DKSDLAudio::Init(): could not load mixer\n");
	}

	_volume = 128;

	DKClass::RegisterFunc("DKSDLAudio::GetDuration", &DKSDLAudio::GetDuration, this);
	DKClass::RegisterFunc("DKSDLAudio::GetTime", &DKSDLAudio::GetTime, this);
	DKClass::RegisterFunc("DKSDLAudio::GetVolume", &DKSDLAudio::GetVolume, this);
	DKClass::RegisterFunc("DKSDLAudio::Mute", &DKSDLAudio::Mute, this);
	DKClass::RegisterFunc("DKSDLAudio::OpenMusic", &DKSDLAudio::OpenMusic, this);
	DKClass::RegisterFunc("DKSDLAudio::Pause", &DKSDLAudio::Pause, this);
	DKClass::RegisterFunc("DKSDLAudio::PlaySound", &DKSDLAudio::PlaySound, this);
	DKClass::RegisterFunc("DKSDLAudio::Resume", &DKSDLAudio::Resume, this);
	DKClass::RegisterFunc("DKSDLAudio::SetTime", &DKSDLAudio::SetTime, this);
	DKClass::RegisterFunc("DKSDLAudio::SetVolume", &DKSDLAudio::SetVolume, this);
	DKClass::RegisterFunc("DKSDLAudio::UnMute", &DKSDLAudio::UnMute, this);
	DKApp::AppendLoopFunc(&DKSDLAudio::Process, this);
	return true;
}

//////////////////////
bool DKSDLAudio::End()
{
	DKDEBUGFUNC();
	DKApp::RemoveLoopFunc(&DKSDLAudio::Process, this);
	Mix_CloseAudio();
	return true;
}



/////////////////////////////////////////////////////////////
bool DKSDLAudio::GetDuration(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);
	//FIXME - TODO
	return false;

	/*
	Uint32 points = 0; 
	Uint32 frames = 0; 
	int freq = 0; 
	Uint16 fmt = 0;  
	int chans = 0;  
	// Chunks are converted to audio device format... 
	if (!Mix_QuerySpec(&freq, &fmt, &chans)){ return false; } // never called Mix_OpenAudio()?!

	if(!trk.snd){ return false; }
	points = (trk.snd / (fmt & 0xFF)); // bytes / samplesize == sample points  
	frames = (points / chans);  // sample points / channels == sample frames 
	int val = ((frames * 1000) / freq); // (sample frames * 1000) / frequency == play length in ms 

	*(int*)output = val;
	return true;
	*/
}

/////////////////////////////////////////////////////////
bool DKSDLAudio::GetTime(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);
	int val = trk.position;
	*(int*)output = val;
	return true;
}

///////////////////////////////////////////////////////////
bool DKSDLAudio::GetVolume(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);
	int volume = Mix_VolumeMusic(-1);
	*(int*)output = volume;
	return true;
}

//////////////////////////////////////////////////////
bool DKSDLAudio::Mute(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);
	_volume = Mix_VolumeMusic(-1);
	Mix_VolumeMusic(0);
	return true;
}

///////////////////////////////////////////////////////////
bool DKSDLAudio::OpenMusic(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);
	DKString path = *(DKString*)input;
	if(!DKFile::VerifyPath(path)){ return 0; }
	
	trk.file = path;
	trk.snd = Mix_LoadMUS(path.c_str());
	trk.position = 0;
	lastTime = SDL_GetTicks();

	if(!trk.snd){
		DKERROR("DKSDLAudio::OpenMusic(): could not load file\n");
		return false;
	}

	if(Mix_PlayMusic(trk.snd, 0) == -1){
		DKERROR("DKSDLAudio::OpenMusic(): error playing file\n");
		return false;
	}
	Mix_PauseMusic();

	return true;
}

///////////////////////////////////////////////////////
bool DKSDLAudio::Pause(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);
	DKString path = *(DKString*)input;
	Mix_PauseMusic();
	return true;
}

///////////////////////////////////////////////////////////
bool DKSDLAudio::PlaySound(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);
	DKString path = *(DKString*)input;
	if(!DKFile::VerifyPath(path)){ return false; }
	
	Mix_Chunk* snd = Mix_LoadWAV(path.c_str());
	if(!snd){
		DKERROR("DKSDLAudio::PlaySound(): could not load file\n");
		return false;
	}

	if(Mix_PlayChannel(-1, snd, 0) == -1){
		DKERROR("DKSDLAudio::PlaySound(): error playing file\n");
		return false;
	}

	return true;
}

////////////////////////////////////////////////////////
bool DKSDLAudio::Resume(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);
	DKString path = *(DKString*)input;
	trk.position = 0;
	lastTime = SDL_GetTicks();
	Mix_RewindMusic();
	Mix_ResumeMusic();
	return true;
}

/////////////////////////////////////////////////////////
bool DKSDLAudio::SetTime(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);
	int time = *(int*)input;
	Mix_SetMusicPosition(time);
	return true;
}

///////////////////////////////////////////////////////////
bool DKSDLAudio::SetVolume(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);
	int volume = *(int*)input;
	Mix_VolumeMusic(volume);
	return true;
}


////////////////////////////////////////////////////////
bool DKSDLAudio::UnMute(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);
	Mix_VolumeMusic(_volume);
	return true;
}



//////////////////////////
void DKSDLAudio::Process()
{
	//DKDEBUGFUNC();
	/*
	if(Mix_PlayingMusic() && !Mix_PausedMusic()){
		if(((SDL_GetTicks() - lastTime) / 1000) > (unsigned int)trk.position){
			trk.position = (SDL_GetTicks() - lastTime) / 1000;
			//DKINFO("trk.position = "+toString(trk.position)+"\n");
			DKEvent::SendEvent("window", "timeupdate", "");
		}
	}
	else 
	*/
	if(!Mix_PlayingMusic()){
		//FIXME: !!!  PlaySound will call this constantly !!!
		//DKINFO("!Mix_PlayingMusic()\n");
		Mix_RewindMusic();
		if(trk.file.empty()){ return; }
		Mix_PlayMusic(trk.snd, 0);
		Mix_PauseMusic();
		trk.position = 0;
		lastTime = SDL_GetTicks();
		DKEvents::SendEvent("window", "ended", "");
	}
}