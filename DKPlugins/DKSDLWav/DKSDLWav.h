//https://gist.github.com/armornick/3447121
#pragma once
#ifndef DKSDLWav_H
#define DKSDLWav_H

#include "SDL.h"
#include "DK/DK.h"

///////////////////////////////////////////
class DKSDLWav : public DKObjectT<DKSDLWav>
{
public:
	bool Init();
	bool End();

	bool EndAudio();
	bool InitAudio();
	bool OpenMusic(const char* filename, int volume);
	bool PlaySound(const char* filename, int volume);

	bool OpenMusic(const void* input, void* output);
	bool PlaySound(const void* input, void* output);
};


REGISTER_OBJECT(DKSDLWav, true);

#endif //DKSDLWav_H

