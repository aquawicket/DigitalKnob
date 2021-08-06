#pragma once
#ifndef DKAudio_H
#define DKAudio_H

#include "DK/DK.h"

/////////////////////////////////////////
class DKAudio : public DKObjectT<DKAudio>
{
public:
	bool Init();
	bool End();
	
	static bool GetDuration(int& duration);
	static bool GetTime(int& time);
	static bool GetVolume(int& volume);
	static bool Mute();
	static bool OpenMusic(DKString& file);
	static bool Pause(DKString& file);
	static bool PlaySound(const DKString& file);
	static bool Resume(DKString& file);
	static bool SetTime(int& seconds);
	static bool SetVolume(int& volume);
	static bool UnMute();
};

REGISTER_OBJECT(DKAudio, true);

#endif //DKAudio_H

