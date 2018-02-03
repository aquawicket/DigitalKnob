//https://gist.github.com/armornick/3447121
#pragma once
#ifndef DKSDLAudio_H
#define DKSDLAudio_H

#include "SDL.h"
#include "SDL_mixer.h"
#include "DK/DK.h"

struct track{
	DKString file;
	Mix_Music* snd;
	int position;
};

///////////////////////////////////////////////
class DKSDLAudio : public DKObjectT<DKSDLAudio>
{
public:
	bool Init();
	bool End();

	bool GetVolume(void* input, void* output);
	bool Mute(void* input, void* output);
	bool OpenMusic(void* input, void* output);
	bool Pause(void* input, void* output);
	bool PlaySound(void* input, void* output);
	bool Resume(void* input, void* output);
	bool SetVolume(void* input, void* output);
	bool UnMute(void* input, void* output);
	bool GetTime(void* input, void* output);
	bool SetTime(void* input, void* output);
	bool GetDuration(void* input, void* output);
	void Process();

	int _volume;
	track trk;
	unsigned int lastTime;
};


REGISTER_OBJECT(DKSDLAudio, true);

#endif //DKSDLAudio_H

