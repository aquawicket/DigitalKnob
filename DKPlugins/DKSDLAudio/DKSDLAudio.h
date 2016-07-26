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

	void* PlaySound(void* data);
	void* PlayMusic(void* data);
	void* Pause(void* data);
	void* Resume(void* data);
	void Process();

	std::vector<track> tracks;
};


REGISTER_OBJECT(DKSDLAudio, true);

#endif //DKSDLAudio_H

