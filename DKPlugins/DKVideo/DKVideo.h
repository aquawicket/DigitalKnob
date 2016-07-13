#pragma once
#ifndef DKVideo_H
#define DKVideo_H
#include "DK.h"

/////////////////////////////////////////
class DKVideo : public DKObjectT<DKVideo>
{
public:
	void Init(){
		DKCreate("DKOSGVideo");
		DKCreate("DKSDLVideo");
	};
	void End(){};

	//////////////////
	static void Play(DKString& file){
		DKClass::CallFunc("DKOSGVideo::Play", static_cast<void*>(&file));
		DKClass::CallFunc("DKSDLVideo::Play", static_cast<void*>(&file));
	}
};

REGISTER_OBJECT(DKVideo, true);
#endif //DKVideo_H

