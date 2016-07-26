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

///////////////////
void DKAudio::End()
{
	DKClose("DKAudioJS");
	DKClose("DKSDLAudio");
	DKClose("DKSDLWav");
	DKClose("DKOSGAudio");
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
	DKLog("DKAudio::PlaySound(): No PlaySound funtion available \n", DKERROR);
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
	DKLog("DKAudio::PlayMusic(): No PlayMusic funtion available \n", DKERROR);
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
	DKLog("DKAudio::Pause(): No Pause funtion available \n", DKERROR);
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
	DKLog("DKAudio::Resume(): No Resume funtion available \n", DKERROR);
}

/////////////////////
void DKAudio::Mute()
{
	if(DKClass::HasFunc("DKSDLAudio::Mute")){
		DKClass::CallFunc("DKSDLAudio::Mute");
		return;
	}
	if(DKClass::HasFunc("DKSDLWav::Mute")){
		DKClass::CallFunc("DKSDLWav::Mute");
		return;
	}
	if (DKClass::HasFunc("DKOSGAudio::Mute")){
		DKClass::CallFunc("DKOSGAudio::Mute");
		return;
	}
	DKLog("DKAudio::Mute(): No Mute funtion available \n", DKERROR);
}

//////////////////////
void DKAudio::UnMute()
{
	if(DKClass::HasFunc("DKSDLAudio::UnMute")){
		DKClass::CallFunc("DKSDLAudio::UnMute");
		return;
	}
	if(DKClass::HasFunc("DKSDLWav::UnMute")){
		DKClass::CallFunc("DKSDLWav::UnMute");
		return;
	}
	if (DKClass::HasFunc("DKOSGAudio::UnMute")){
		DKClass::CallFunc("DKOSGAudio::UnMute");
		return;
	}
	DKLog("DKAudio::UnMute(): No UnMute funtion available \n", DKERROR);
}

////////////////////////
int DKAudio::GetVolume()
{
	if(DKClass::HasFunc("DKSDLAudio::GetVolume")){
		return *static_cast<int*>(DKClass::CallFunc("DKSDLAudio::GetVolume"));
	}
	if(DKClass::HasFunc("DKSDLWav::GetVolume")){
		return *static_cast<int*>(DKClass::CallFunc("DKSDLWav::GetVolume"));
	}
	if (DKClass::HasFunc("DKOSGAudio::GetVolume")) {
		return *static_cast<int*>(DKClass::CallFunc("DKOSGAudio::GetVolume"));
	}

	DKLog("DKAudio::GetVolume(): No GetVolume funtion available \n", DKERROR);
	return NULL;
}

////////////////////////////////////
void DKAudio::SetVolume(int& volume)
{
	if(DKClass::HasFunc("DKSDLAudio::SetVolume")){
		DKClass::CallFunc("DKSDLAudio::SetVolume", static_cast<void*>(&volume));
		return;
	}
	if(DKClass::HasFunc("DKSDLWav::SetVolume")){
		DKClass::CallFunc("DKSDLWav::SetVolume", static_cast<void*>(&volume));
		return;
	}
	if (DKClass::HasFunc("DKOSGAudio::SetVolume")) {
		DKClass::CallFunc("DKOSGAudio::SetVolume", static_cast<void*>(&volume));
		return;
	}
	DKLog("DKAudio::SetVolume(): No SetVolume funtion available \n", DKERROR);
}