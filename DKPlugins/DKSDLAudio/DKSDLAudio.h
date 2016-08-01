//https://gist.github.com/armornick/3447121

#pragma once
#ifndef DKSDLAudio_H
#define DKSDLAudio_H
#include "DK.h"
#include "SDL.h"
#include "SDL_mixer.h"

struct track{
	DKString file;
	Mix_Music* snd;
	int position;
};

///////////////////////////////////////////////
class DKSDLAudio : public DKObjectT<DKSDLAudio>
{
public:
	void Init();
	void End();

	void* PlaySound(void* data); //One Shot

	void* OpenMusic(void* data);
	void* Pause(void* data);
	void* Resume(void* data);
	void* Mute(void* data);
	void* UnMute(void* data);
	void* GetVolume(void* data);
	void* SetVolume(void* data);
	void Process();

	int volume;
	track trk;
	unsigned int lastTime;
};


REGISTER_OBJECT(DKSDLAudio, true);

#endif //DKSDLAudio_H

