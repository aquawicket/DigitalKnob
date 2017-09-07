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
	
	static int GetVolume();
	static void Mute();
	static void OpenMusic(DKString& file);
	static void Pause(DKString& file);
	static void PlaySound(DKString& file); //one shot
	static void Resume(DKString& file);
	static void SetVolume(int& volume);
	static void UnMute();
};

REGISTER_OBJECT(DKAudio, true);

#endif //DKAudio_H

