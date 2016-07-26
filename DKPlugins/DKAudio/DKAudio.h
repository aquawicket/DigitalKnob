#pragma once
#ifndef DKAudio_H
#define DKAudio_H
#include "DK.h"

/////////////////////////////////////////
class DKAudio : public DKObjectT<DKAudio>
{
public:
	void Init();
	void End();
	static void PlaySound(DKString& file);
	static void PlayMusic(DKString& file);
	static void Pause(DKString& file);
	static void Resume(DKString& file);
	static void Mute();
	static void UnMute();
	static int GetVolume();
	static void SetVolume(int& volume);

};

REGISTER_OBJECT(DKAudio, true);

#endif //DKAudio_H

