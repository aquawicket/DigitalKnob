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

	bool GetVolume(void* input, void* output);
	bool Mute(void* input, void* output);
	bool OpenMusic(void* input, void* output);
	bool Pause(void* input, void* output);
	bool PlaySound(void* input, void* output);
	bool Resume(void* input, void* output);
	bool SetVolume(void* input, void* output);
	bool UnMute(void* input, void* output);
	void Process();

	int volume;
	track trk;
	unsigned int lastTime;
};


REGISTER_OBJECT(DKSDLAudio, true);

#endif //DKSDLAudio_H

