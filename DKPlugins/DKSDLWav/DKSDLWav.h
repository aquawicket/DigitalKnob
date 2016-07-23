//https://gist.github.com/armornick/3447121

#pragma once
#ifndef DKSDLWav_H
#define DKSDLWav_H
#include "DK.h"
#include "SDL.h"


///////////////////////////////////////////
class DKSDLWav : public DKObjectT<DKSDLWav>
{
public:
	void Init();
	void End();

	void initAudio();
	void endAudio();
	void playSound(const char * filename, int volume);
	void playMusic(const char * filename, int volume);

	void* PlaySound(void* data);
	void* PlayMusic(void* data);
};


REGISTER_OBJECT(DKSDLWav, true);

#endif //DKSDLWav_H

