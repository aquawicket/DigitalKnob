#pragma once
#ifndef DKAudio_H
#define DKAudio_H

#include "DK/DK.h"

/////////////////////////////////////////
class DKAudio : public DKObjectT<DKAudio>
{
public:
	bool Init();
	void End();
	
	static bool GetVolume(int& volume);
	static bool Mute();
	static bool OpenMusic(DKString& file);
	static bool Pause(DKString& file);
	static bool PlaySound(DKString& file); //one shot
	static bool Resume(DKString& file);
	static bool SetVolume(int& volume);
	static bool UnMute();
	static bool SetTime(int& seconds);
	static bool GetTime(int& time);
	static bool GetDuration(int& duration);
};

REGISTER_OBJECT(DKAudio, true);

#endif //DKAudio_H

