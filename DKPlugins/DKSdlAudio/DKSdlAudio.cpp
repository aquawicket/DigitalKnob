/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DKSdlAudio/DKSdlAudio.h"


bool DKSdlAudio::Init(){
	DKDEBUGFUNC();
	if(SDL_Init(SDL_INIT_AUDIO) < 0)
		return DKERROR("Could not Init SDL_Audio\n");
	//Initialize SDL_mixer 
	if(Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 2, 4096) == -1)
		return DKERROR("DKSdlAudio::Init(): could not load mixer\n");

	_volume = 128;

	DKClass::RegisterFunc("DKSdlAudio::GetDuration", &DKSdlAudio::GetDuration, this);
	DKClass::RegisterFunc("DKSdlAudio::GetTime", &DKSdlAudio::GetTime, this);
	DKClass::RegisterFunc("DKSdlAudio::GetVolume", &DKSdlAudio::GetVolume, this);
	DKClass::RegisterFunc("DKSdlAudio::Mute", &DKSdlAudio::Mute, this);
	DKClass::RegisterFunc("DKSdlAudio::OpenMusic", &DKSdlAudio::OpenMusic, this);
	DKClass::RegisterFunc("DKSdlAudio::Pause", &DKSdlAudio::Pause, this);
	DKClass::RegisterFunc("DKSdlAudio::PlaySound", &DKSdlAudio::PlaySound, this);
	DKClass::RegisterFunc("DKSdlAudio::Resume", &DKSdlAudio::Resume, this);
	DKClass::RegisterFunc("DKSdlAudio::SetTime", &DKSdlAudio::SetTime, this);
	DKClass::RegisterFunc("DKSdlAudio::SetVolume", &DKSdlAudio::SetVolume, this);
	DKClass::RegisterFunc("DKSdlAudio::UnMute", &DKSdlAudio::UnMute, this);
	DKApp::AppendLoopFunc(&DKSdlAudio::Process, this);
	return true;
}

bool DKSdlAudio::End(){
	DKDEBUGFUNC();
	DKApp::RemoveLoopFunc(&DKSdlAudio::Process, this);
	Mix_CloseAudio();
	return true;
}

bool DKSdlAudio::GetDuration(const void* input, void* output){
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

bool DKSdlAudio::GetTime(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	int val = trk.position;
	*(int*)output = val;
	return true;
}

bool DKSdlAudio::GetVolume(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	int volume = Mix_VolumeMusic(-1);
	*(int*)output = volume;
	return true;
}

bool DKSdlAudio::Mute(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	_volume = Mix_VolumeMusic(-1);
	Mix_VolumeMusic(0);
	return true;
}

bool DKSdlAudio::OpenMusic(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	DKString path = *(DKString*)input;
	if(!DKFile::VerifyPath(path))
		return DKERROR("DKFile::VerifyPath() failed! \n");
	trk.file = path;
	trk.snd = Mix_LoadMUS(path.c_str());
	trk.position = 0;
	lastTime = SDL_GetTicks();
	if(!trk.snd)
		return DKERROR("DKSdlAudio::OpenMusic(): could not load file\n");
	if(Mix_PlayMusic(trk.snd, 0) == -1)
		return DKERROR("DKSdlAudio::OpenMusic(): error playing file\n");
	Mix_PauseMusic();

	return true;
}

bool DKSdlAudio::Pause(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	DKString path = *(DKString*)input;
	Mix_PauseMusic();
	return true;
}

bool DKSdlAudio::PlaySound(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	DKString path = *(DKString*)input;
	if(!DKFile::VerifyPath(path))
		return DKERROR("DKFile::VerifyPath() failed! \n");
	Mix_Chunk* snd = Mix_LoadWAV(path.c_str());
	if(!snd)
		return DKERROR("snd is invlid! \n");
	if(Mix_PlayChannel(-1, snd, 0) == -1)
		return DKERROR("Mix_PlayChannel() failed! \n");
	return true;
}

bool DKSdlAudio::Resume(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	DKString path = *(DKString*)input;
	trk.position = 0;
	lastTime = SDL_GetTicks();
	Mix_RewindMusic();
	Mix_ResumeMusic();
	return true;
}

bool DKSdlAudio::SetTime(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	int time = *(int*)input;
	Mix_SetMusicPosition(time);
	return true;
}

bool DKSdlAudio::SetVolume(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	int volume = *(int*)input;
	Mix_VolumeMusic(volume);
	return true;
}

bool DKSdlAudio::UnMute(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	Mix_VolumeMusic(_volume);
	return true;
}

void DKSdlAudio::Process(){
	//DKDEBUGFUNC();  //EXCESSIVE LOGGING
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
