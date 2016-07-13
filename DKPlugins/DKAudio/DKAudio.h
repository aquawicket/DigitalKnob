#pragma once
#ifndef DKAudio_H
#define DKAudio_H
#include "DK.h"

/////////////////////////////////////////
class DKAudio : public DKObjectT<DKAudio>
{
public:
	void Init(){
		DKCreate("DKAudioJS");
		DKCreate("DKOSGAudio");
		DKCreate("DKSDLAudio");
	};
	void End(){};

	//////////////////
	static void Play(DKString& file){
		DKClass::CallFunc("DKOSGAudio::Play", static_cast<void*>(&file));
		DKClass::CallFunc("DKSDLAudio::Play", static_cast<void*>(&file));
	}
};

REGISTER_OBJECT(DKAudio, true);

#endif //DKAudio_H

