//https://gist.github.com/armornick/3447121
#pragma once
#ifndef DKSDLAudio_H
#define DKSDLAudio_H

#include "SDL.h"
#include "SDL_mixer.h"
#include "DK/DK.h"

////////////
struct track
{
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

	bool GetDuration(const void* input, void* output);
	bool GetTime(const void* input, void* output);
	bool GetVolume(const void* input, void* output);
	bool Mute(const void* input, void* output);
	bool OpenMusic(const void* input, void* output);
	bool Pause(const void* input, void* output);
	bool PlaySound(const void* input, void* output);
	bool Resume(const void* input, void* output);
	bool SetTime(const void* input, void* output);
	bool SetVolume(const void* input, void* output);
	bool UnMute(const void* input, void* output);
	void Process();

	int _volume;
	track trk;
	unsigned int lastTime;
};


REGISTER_OBJECT(DKSDLAudio, true);

#endif //DKSDLAudio_H