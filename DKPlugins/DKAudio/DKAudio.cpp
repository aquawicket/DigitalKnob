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

///////////////////////////////////////
void DKAudio::PlaySound(DKString& file)
{
	if(DKClass::HasFunc("DKSDLAudio::PlaySound")){
		DKClass::CallFunc("DKSDLAudio::PlaySound", static_cast<void*>(&file));
		return;
	}
	if (DKClass::HasFunc("DKOSGAudio::PlaySound")) {
		DKClass::CallFunc("DKOSGAudio::PlaySound", static_cast<void*>(&file));
		return;
	}
	DKLog("DKAudio::PlaySound(): No play funtion available \n", DKERROR);
}

///////////////////////////////////////
void DKAudio::PlayMusic(DKString& file)
{
	if(DKClass::HasFunc("DKSDLAudio::PlayMusic")){
		DKClass::CallFunc("DKSDLAudio::PlayMusic", static_cast<void*>(&file));
		return;
	}
	if (DKClass::HasFunc("DKOSGAudio::PlayMusic")) {
		DKClass::CallFunc("DKOSGAudio::PlayMusic", static_cast<void*>(&file));
		return;
	}
	DKLog("DKAudio::PlayMusic(): No play funtion available \n", DKERROR);
}