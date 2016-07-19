#include "stdafx.h"
#include "DKAudio.h"

////////////////////
void DKAudio::Init()
{
	DKCreate("DKAudioJS");
	if(DKAvailable("DKSDLAudio")){
		DKCreate("DKSDLAudio");
		return;
	}
	if(DKAvailable("DKOSGAudio")){
		DKCreate("DKOSGAudio");
		return;
	}
	DKLog("DKAudio::Init(): No audio interface available \n", DKERROR);
}

//////////////////////////////////
void DKAudio::Play(DKString& file)
{
	if(DKClass::HasFunc("DKSDLAudio::Play")){
		DKClass::CallFunc("DKSDLAudio::Play", static_cast<void*>(&file));
		return;
	}
	if (DKClass::HasFunc("DKOSGAudio::Play")) {
		DKClass::CallFunc("DKOSGAudio::Play", static_cast<void*>(&file));
		return;
	}
	DKLog("DKAudio::Play(): No play funtion available \n", DKERROR);
}