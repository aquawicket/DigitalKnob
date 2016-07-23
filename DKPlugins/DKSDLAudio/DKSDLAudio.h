//https://gist.github.com/armornick/3447121

#pragma once
#ifndef DKSDLAudio_H
#define DKSDLAudio_H
#include "DK.h"
#include "SDL.h"


///////////////////////////////////////////////
class DKSDLAudio : public DKObjectT<DKSDLAudio>
{
public:
	void Init();
	void End();

	void* PlaySound(void* data);
	void* PlayMusic(void* data);
	void Process();
};


REGISTER_OBJECT(DKSDLAudio, true);

#endif //DKSDLAudio_H

