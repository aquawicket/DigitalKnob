#include "DK/stdafx.h"
#include "DKAudio.h"

////////////////////
bool DKAudio::Init()
{
	DKCreate("DKAudioJS");
	if(DKAvailable("DKSDLAudio")){
		DKCreate("DKSDLAudio");
		return false;
	}
	if(DKAvailable("DKSDLWav")){
		DKCreate("DKSDLWav");
		return false;
	}
	if(DKAvailable("DKOSGAudio")){
		DKCreate("DKOSGAudio");
		return false;
	}
	DKLog("DKAudio::Init(): No audio interface available \n", DKERROR);
	return true;
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
bool DKAudio::PlaySound(DKString& file)
{
	if(DKClass::HasFunc("DKSDLAudio::PlaySound")){
		return DKClass::CallFunc("DKSDLAudio::PlaySound", &file, NULL);
	}
	if(DKClass::HasFunc("DKSDLWav::PlaySound")){
		return DKClass::CallFunc("DKSDLWav::PlaySound", &file, NULL);
	}
	if (DKClass::HasFunc("DKOSGAudio::PlaySound")) {
		return DKClass::CallFunc("DKOSGAudio::PlaySound", &file, NULL);
	}
	DKLog("DKAudio::PlaySound(): No PlaySound funtion available \n", DKERROR);
	return false;
}

///////////////////////////////////////
bool DKAudio::OpenMusic(DKString& file)
{
	if(DKClass::HasFunc("DKSDLAudio::OpenMusic")){
		return DKClass::CallFunc("DKSDLAudio::OpenMusic", &file, NULL);
	}
	if(DKClass::HasFunc("DKSDLWav::OpenMusic")){
		return DKClass::CallFunc("DKSDLWav::OpenMusic", &file, NULL);
	}
	if (DKClass::HasFunc("DKOSGAudio::OpenMusic")) {
		return DKClass::CallFunc("DKOSGAudio::OpenMusic", &file, NULL);
	}
	DKLog("DKAudio::OpenMusic(): No OpenMusic funtion available \n", DKERROR);
	return false;
}

///////////////////////////////////
bool DKAudio::Pause(DKString& file)
{
	if(DKClass::HasFunc("DKSDLAudio::Pause")){
		return DKClass::CallFunc("DKSDLAudio::Pause", &file, NULL);
	}
	if(DKClass::HasFunc("DKSDLWav::Pause")){
		return DKClass::CallFunc("DKSDLWav::Pause", &file, NULL);
	}
	if (DKClass::HasFunc("DKOSGAudio::Pause")) {
		return DKClass::CallFunc("DKOSGAudio::Pause", &file, NULL);
	}
	DKLog("DKAudio::Pause(): No Pause funtion available \n", DKERROR);
	return false;
}

////////////////////////////////////
bool DKAudio::Resume(DKString& file)
{
	if(DKClass::HasFunc("DKSDLAudio::Resume")){
		return DKClass::CallFunc("DKSDLAudio::Resume", &file, NULL);
	}
	if(DKClass::HasFunc("DKSDLWav::Resume")){
		return DKClass::CallFunc("DKSDLWav::Resume", &file, NULL);
	}
	if (DKClass::HasFunc("DKOSGAudio::Resume")) {
		return DKClass::CallFunc("DKOSGAudio::Resume", &file, NULL);
	}
	DKLog("DKAudio::Resume(): No Resume funtion available \n", DKERROR);
	return false;
}

////////////////////
bool DKAudio::Mute()
{
	if(DKClass::HasFunc("DKSDLAudio::Mute")){
		return DKClass::CallFunc("DKSDLAudio::Mute", NULL, NULL);
	}
	if(DKClass::HasFunc("DKSDLWav::Mute")){
		return DKClass::CallFunc("DKSDLWav::Mute", NULL, NULL);
	}
	if (DKClass::HasFunc("DKOSGAudio::Mute")){
		return DKClass::CallFunc("DKOSGAudio::Mute", NULL, NULL);
	}
	DKLog("DKAudio::Mute(): No Mute funtion available \n", DKERROR);
	return false;
}

//////////////////////
bool DKAudio::UnMute()
{
	if(DKClass::HasFunc("DKSDLAudio::UnMute")){
		return DKClass::CallFunc("DKSDLAudio::UnMute", NULL, NULL);
	}
	if(DKClass::HasFunc("DKSDLWav::UnMute")){
		return DKClass::CallFunc("DKSDLWav::UnMute", NULL, NULL);
	}
	if (DKClass::HasFunc("DKOSGAudio::UnMute")){
		return DKClass::CallFunc("DKOSGAudio::UnMute", NULL, NULL);
	}
	DKLog("DKAudio::UnMute(): No UnMute funtion available \n", DKERROR);
	return false;
}

////////////////////////////////////
bool DKAudio::GetVolume(int& volume)
{
	if(DKClass::HasFunc("DKSDLAudio::GetVolume")){
		return DKClass::CallFunc("DKSDLAudio::GetVolume", NULL, &volume);
	}
	if(DKClass::HasFunc("DKSDLWav::GetVolume")){
		return DKClass::CallFunc("DKSDLWav::GetVolume", NULL, &volume);
	}
	if (DKClass::HasFunc("DKOSGAudio::GetVolume")) {
		return DKClass::CallFunc("DKOSGAudio::GetVolume", NULL, &volume);
	}
	DKLog("DKAudio::GetVolume(): No GetVolume funtion available \n", DKWARN);
	return false;
}

////////////////////////////////////
bool DKAudio::SetVolume(int& volume)
{
	if(DKClass::HasFunc("DKSDLAudio::SetVolume")){
		return DKClass::CallFunc("DKSDLAudio::SetVolume", &volume, NULL);
	}
	if(DKClass::HasFunc("DKSDLWav::SetVolume")){
		return DKClass::CallFunc("DKSDLWav::SetVolume", &volume, NULL);
	}
	if(DKClass::HasFunc("DKOSGAudio::SetVolume")){
		return DKClass::CallFunc("DKOSGAudio::SetVolume", &volume, NULL);
	}
	DKLog("DKAudio::SetVolume(): No SetVolume funtion available \n", DKERROR);
	return false;
}

///////////////////////////////////
bool DKAudio::SetTime(int& seconds)
{
	if(DKClass::HasFunc("DKSDLAudio::SetTime")){
		return DKClass::CallFunc("DKSDLAudio::SetTime", &seconds, NULL);
	}
	if(DKClass::HasFunc("DKSDLWav::SetTime")){
		return DKClass::CallFunc("DKSDLWav::SetTime", &seconds, NULL);
	}
	if(DKClass::HasFunc("DKOSGAudio::SetTime")) {
		return DKClass::CallFunc("DKOSGAudio::SetTime", &seconds, NULL);
	}
	DKLog("DKAudio::SetTime(): No SetTime funtion available \n", DKERROR);
	return false;
}

////////////////////////////////
bool DKAudio::GetTime(int& time)
{
	if(DKClass::HasFunc("DKSDLAudio::GetTime")){
		return DKClass::CallFunc("DKSDLAudio::GetTime", NULL, &time);
	}
	if(DKClass::HasFunc("DKSDLWav::GetTime")){
		return DKClass::CallFunc("DKSDLWav::GetTime", NULL, &time);
	}
	if (DKClass::HasFunc("DKOSGAudio::GetTime")) {
		return DKClass::CallFunc("DKOSGAudio::GetTime", NULL, &time);
	}
	DKLog("DKAudio::GetTime(): No GetTime funtion available \n", DKERROR);
	return false;
}

////////////////////////////////////////
bool DKAudio::GetDuration(int& duration)
{
	if(DKClass::HasFunc("DKSDLAudio::GetDuration")){
		return DKClass::CallFunc("DKSDLAudio::GetDuration", NULL, &duration);
	}
	if(DKClass::HasFunc("DKSDLWav::GetDuration")){
		return DKClass::CallFunc("DKSDLWav::GetDuration", NULL, &duration);
	}
	if (DKClass::HasFunc("DKOSGAudio::GetDuration")) {
		return DKClass::CallFunc("DKOSGAudio::GetDuration", NULL, &duration);
	}
	DKLog("DKAudio::GetDuration(): No GetDuration funtion available \n", DKERROR);
	return false;
}