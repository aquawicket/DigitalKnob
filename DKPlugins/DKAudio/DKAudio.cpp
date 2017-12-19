#include "DK/stdafx.h"
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
		DKClass::CallFunc("DKSDLAudio::PlaySound", &file, NULL);
		return;
	}
	if(DKClass::HasFunc("DKSDLWav::PlaySound")){
		DKClass::CallFunc("DKSDLWav::PlaySound", &file, NULL);
		return;
	}
	if (DKClass::HasFunc("DKOSGAudio::PlaySound")) {
		DKClass::CallFunc("DKOSGAudio::PlaySound", &file, NULL);
		return;
	}
	DKLog("DKAudio::PlaySound(): No PlaySound funtion available \n", DKERROR);
}

///////////////////////////////////////
void DKAudio::OpenMusic(DKString& file)
{
	if(DKClass::HasFunc("DKSDLAudio::OpenMusic")){
		DKClass::CallFunc("DKSDLAudio::OpenMusic", &file, NULL);
		return;
	}
	if(DKClass::HasFunc("DKSDLWav::OpenMusic")){
		DKClass::CallFunc("DKSDLWav::OpenMusic", &file, NULL);
		return;
	}
	if (DKClass::HasFunc("DKOSGAudio::OpenMusic")) {
		DKClass::CallFunc("DKOSGAudio::OpenMusic", &file, NULL);
		return;
	}
	DKLog("DKAudio::OpenMusic(): No OpenMusic funtion available \n", DKERROR);
}

///////////////////////////////////
void DKAudio::Pause(DKString& file)
{
	if(DKClass::HasFunc("DKSDLAudio::Pause")){
		DKClass::CallFunc("DKSDLAudio::Pause", &file, NULL);
		return;
	}
	if(DKClass::HasFunc("DKSDLWav::Pause")){
		DKClass::CallFunc("DKSDLWav::Pause", &file, NULL);
		return;
	}
	if (DKClass::HasFunc("DKOSGAudio::Pause")) {
		DKClass::CallFunc("DKOSGAudio::Pause", &file, NULL);
		return;
	}
	DKLog("DKAudio::Pause(): No Pause funtion available \n", DKERROR);
}

////////////////////////////////////
void DKAudio::Resume(DKString& file)
{
	if(DKClass::HasFunc("DKSDLAudio::Resume")){
		DKClass::CallFunc("DKSDLAudio::Resume", &file, NULL);
		return;
	}
	if(DKClass::HasFunc("DKSDLWav::Resume")){
		DKClass::CallFunc("DKSDLWav::Resume", &file, NULL);
		return;
	}
	if (DKClass::HasFunc("DKOSGAudio::Resume")) {
		DKClass::CallFunc("DKOSGAudio::Resume", &file, NULL);
		return;
	}
	DKLog("DKAudio::Resume(): No Resume funtion available \n", DKERROR);
}

/////////////////////
void DKAudio::Mute()
{
	if(DKClass::HasFunc("DKSDLAudio::Mute")){
		DKClass::CallFunc("DKSDLAudio::Mute", NULL, NULL);
		return;
	}
	if(DKClass::HasFunc("DKSDLWav::Mute")){
		DKClass::CallFunc("DKSDLWav::Mute", NULL, NULL);
		return;
	}
	if (DKClass::HasFunc("DKOSGAudio::Mute")){
		DKClass::CallFunc("DKOSGAudio::Mute", NULL, NULL);
		return;
	}
	DKLog("DKAudio::Mute(): No Mute funtion available \n", DKERROR);
}

//////////////////////
void DKAudio::UnMute()
{
	if(DKClass::HasFunc("DKSDLAudio::UnMute")){
		DKClass::CallFunc("DKSDLAudio::UnMute", NULL, NULL);
		return;
	}
	if(DKClass::HasFunc("DKSDLWav::UnMute")){
		DKClass::CallFunc("DKSDLWav::UnMute", NULL, NULL);
		return;
	}
	if (DKClass::HasFunc("DKOSGAudio::UnMute")){
		DKClass::CallFunc("DKOSGAudio::UnMute", NULL, NULL);
		return;
	}
	DKLog("DKAudio::UnMute(): No UnMute funtion available \n", DKERROR);
}

////////////////////////
int DKAudio::GetVolume()
{
	int output;
	if(DKClass::HasFunc("DKSDLAudio::GetVolume")){
		DKClass::CallFunc("DKSDLAudio::GetVolume", NULL, &output);
	}
	if(DKClass::HasFunc("DKSDLWav::GetVolume")){
		DKClass::CallFunc("DKSDLWav::GetVolume", NULL, &output);
	}
	if (DKClass::HasFunc("DKOSGAudio::GetVolume")) {
		DKClass::CallFunc("DKOSGAudio::GetVolume", NULL, &output);
	}

	DKLog("DKAudio::GetVolume(): No GetVolume funtion available \n", DKERROR);
	return 0;
}

////////////////////////////////////
void DKAudio::SetVolume(int& volume)
{
	if(DKClass::HasFunc("DKSDLAudio::SetVolume")){
		DKClass::CallFunc("DKSDLAudio::SetVolume", &volume, NULL);
		return;
	}
	if(DKClass::HasFunc("DKSDLWav::SetVolume")){
		DKClass::CallFunc("DKSDLWav::SetVolume", &volume, NULL);
		return;
	}
	if (DKClass::HasFunc("DKOSGAudio::SetVolume")) {
		DKClass::CallFunc("DKOSGAudio::SetVolume", &volume, NULL);
		return;
	}
	DKLog("DKAudio::SetVolume(): No SetVolume funtion available \n", DKERROR);
}

///////////////////////////////////
void DKAudio::SetTime(int& seconds)
{
	if(DKClass::HasFunc("DKSDLAudio::SetTime")){
		DKClass::CallFunc("DKSDLAudio::SetTime", &seconds, NULL);
		return;
	}
	if(DKClass::HasFunc("DKSDLWav::SetTime")){
		DKClass::CallFunc("DKSDLWav::SetTime", &seconds, NULL);
		return;
	}
	if (DKClass::HasFunc("DKOSGAudio::SetTime")) {
		DKClass::CallFunc("DKOSGAudio::SetTime", &seconds, NULL);
		return;
	}
	DKLog("DKAudio::SetTime(): No SetTime funtion available \n", DKERROR);
}

//////////////////////
int DKAudio::GetTime()
{
	int seconds;
	if(DKClass::HasFunc("DKSDLAudio::GetTime")){
		DKClass::CallFunc("DKSDLAudio::GetTime", NULL, &seconds);
	}
	if(DKClass::HasFunc("DKSDLWav::GetTime")){
		DKClass::CallFunc("DKSDLWav::GetTime", NULL, &seconds);
	}
	if (DKClass::HasFunc("DKOSGAudio::GetTime")) {
		DKClass::CallFunc("DKOSGAudio::GetTime", NULL, &seconds);
	}

	DKLog("DKAudio::GetTime(): No GetTime funtion available \n", DKERROR);
	return 0;
}

//////////////////////////
int DKAudio::GetDuration()
{
	int seconds;
	if(DKClass::HasFunc("DKSDLAudio::GetDuration")){
		DKClass::CallFunc("DKSDLAudio::GetDuration", NULL, &seconds);
	}
	if(DKClass::HasFunc("DKSDLWav::GetDuration")){
		DKClass::CallFunc("DKSDLWav::GetDuration", NULL, &seconds);
	}
	if (DKClass::HasFunc("DKOSGAudio::GetDuration")) {
		DKClass::CallFunc("DKOSGAudio::GetDuration", NULL, &seconds);
	}

	DKLog("DKAudio::GetDuration(): No GetDuration funtion available \n", DKERROR);
	return 0;
}