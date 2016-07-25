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
	if(DKAvailable("DKSDLWav")){
		DKCreate("DKSDLWav");
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
	if(DKClass::HasFunc("DKSDLWav::PlaySound")){
		DKClass::CallFunc("DKSDLWav::PlaySound", static_cast<void*>(&file));
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
	if(DKClass::HasFunc("DKSDLWav::PlayMusic")){
		DKClass::CallFunc("DKSDLWav::PlayMusic", static_cast<void*>(&file));
		return;
	}
	if (DKClass::HasFunc("DKOSGAudio::PlayMusic")) {
		DKClass::CallFunc("DKOSGAudio::PlayMusic", static_cast<void*>(&file));
		return;
	}
	DKLog("DKAudio::PlayMusic(): No play funtion available \n", DKERROR);
}

///////////////////////////////////
void DKAudio::Pause(DKString& file)
{
	if(DKClass::HasFunc("DKSDLAudio::Pause")){
		DKClass::CallFunc("DKSDLAudio::Pause", static_cast<void*>(&file));
		return;
	}
	if(DKClass::HasFunc("DKSDLWav::Pause")){
		DKClass::CallFunc("DKSDLWav::Pause", static_cast<void*>(&file));
		return;
	}
	if (DKClass::HasFunc("DKOSGAudio::Pause")) {
		DKClass::CallFunc("DKOSGAudio::Pause", static_cast<void*>(&file));
		return;
	}
	DKLog("DKAudio::Pause(): No play funtion available \n", DKERROR);
}

////////////////////////////////////
void DKAudio::Resume(DKString& file)
{
	if(DKClass::HasFunc("DKSDLAudio::Resume")){
		DKClass::CallFunc("DKSDLAudio::Resume", static_cast<void*>(&file));
		return;
	}
	if(DKClass::HasFunc("DKSDLWav::Resume")){
		DKClass::CallFunc("DKSDLWav::Resume", static_cast<void*>(&file));
		return;
	}
	if (DKClass::HasFunc("DKOSGAudio::Resume")) {
		DKClass::CallFunc("DKOSGAudio::Resume", static_cast<void*>(&file));
		return;
	}
	DKLog("DKAudio::Resume(): No play funtion available \n", DKERROR);
}