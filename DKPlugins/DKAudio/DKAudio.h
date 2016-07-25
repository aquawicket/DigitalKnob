#pragma once
#ifndef DKAudio_H
#define DKAudio_H
#include "DK.h"

/////////////////////////////////////////
class DKAudio : public DKObjectT<DKAudio>
{
public:
	void Init();
	void End(){};
	static void PlaySound(DKString& file);
	static void PlayMusic(DKString& file);
	static void Pause(DKString& file);
	static void Resume(DKString& file);
};

REGISTER_OBJECT(DKAudio, true);

#endif //DKAudio_H

