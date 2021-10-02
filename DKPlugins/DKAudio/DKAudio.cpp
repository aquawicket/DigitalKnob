#include "DK/stdafx.h"
#include "DKAudio.h"

bool DKAudio::Init(){
	DKDEBUGFUNC();
	DKClass::DKCreate("DKAudioJS");
	DKClass::DKCreate("DKAudioV8");
	if(DKClass::DKAvailable("DKSDLAudio")){
		DKClass::DKCreate("DKSDLAudio");
		return true;
	}
	if(DKClass::DKAvailable("DKSDLWav")){
		DKClass::DKCreate("DKSDLWav");
		return true;
	}
	if(DKClass::DKAvailable("DKOSGAudio")){
		DKClass::DKCreate("DKOSGAudio");
		return true;
	}
	return DKERROR("No audio interface available\n");
}

bool DKAudio::End(){
	DKDEBUGFUNC();
	DKClass::DKClose("DKAudioJS");
	DKClass::DKClose("DKAudioV8");
	DKClass::DKClose("DKSDLAudio");
	DKClass::DKClose("DKSDLWav");
	DKClass::DKClose("DKOSGAudio");
	return true;
}

bool DKAudio::GetDuration(int& duration){
	DKDEBUGFUNC(duration);
	if(DKClass::HasFunc("DKSDLAudio::GetDuration"))
		return DKClass::CallFunc("DKSDLAudio::GetDuration", NULL, &duration);
	if(DKClass::HasFunc("DKSDLWav::GetDuration"))
		return DKClass::CallFunc("DKSDLWav::GetDuration", NULL, &duration);
	if (DKClass::HasFunc("DKOSGAudio::GetDuration"))
		return DKClass::CallFunc("DKOSGAudio::GetDuration", NULL, &duration);
	return DKERROR("No GetDuration funtion available\n");
}

bool DKAudio::GetTime(int& time){
	DKDEBUGFUNC(time);
	if(DKClass::HasFunc("DKSDLAudio::GetTime"))
		return DKClass::CallFunc("DKSDLAudio::GetTime", NULL, &time);
	if(DKClass::HasFunc("DKSDLWav::GetTime"))
		return DKClass::CallFunc("DKSDLWav::GetTime", NULL, &time);
	if (DKClass::HasFunc("DKOSGAudio::GetTime"))
		return DKClass::CallFunc("DKOSGAudio::GetTime", NULL, &time);
	return DKERROR("No GetTime funtion available\n");
}

bool DKAudio::GetVolume(int& volume){
	DKDEBUGFUNC(volume);
	if(DKClass::HasFunc("DKSDLAudio::GetVolume"))
		return DKClass::CallFunc("DKSDLAudio::GetVolume", NULL, &volume);
	if(DKClass::HasFunc("DKSDLWav::GetVolume"))
		return DKClass::CallFunc("DKSDLWav::GetVolume", NULL, &volume);
	if (DKClass::HasFunc("DKOSGAudio::GetVolume"))
		return DKClass::CallFunc("DKOSGAudio::GetVolume", NULL, &volume);
	return DKERROR("No GetVolume funtion available\n");
}

bool DKAudio::Mute(){
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKSDLAudio::Mute"))
		return DKClass::CallFunc("DKSDLAudio::Mute");
	if(DKClass::HasFunc("DKSDLWav::Mute"))
		return DKClass::CallFunc("DKSDLWav::Mute");
	if (DKClass::HasFunc("DKOSGAudio::Mute"))
		return DKClass::CallFunc("DKOSGAudio::Mute");
	return DKERROR("No Mute funtion available\n");
}

bool DKAudio::OpenMusic(DKString& file){
	DKDEBUGFUNC(file);
	if(DKClass::HasFunc("DKSDLAudio::OpenMusic"))
		return DKClass::CallFunc("DKSDLAudio::OpenMusic", &file);
	if(DKClass::HasFunc("DKSDLWav::OpenMusic"))
		return DKClass::CallFunc("DKSDLWav::OpenMusic", &file);
	if (DKClass::HasFunc("DKOSGAudio::OpenMusic"))
		return DKClass::CallFunc("DKOSGAudio::OpenMusic", &file);
	return DKERROR("No OpenMusic funtion available\n");
}

bool DKAudio::Pause(DKString& file){
	DKDEBUGFUNC(file);
	if(DKClass::HasFunc("DKSDLAudio::Pause"))
		return DKClass::CallFunc("DKSDLAudio::Pause", &file);
	if(DKClass::HasFunc("DKSDLWav::Pause"))
		return DKClass::CallFunc("DKSDLWav::Pause", &file);
	if (DKClass::HasFunc("DKOSGAudio::Pause"))
		return DKClass::CallFunc("DKOSGAudio::Pause", &file);
	return DKERROR("No Pause funtion available\n");
}

bool DKAudio::PlaySound(const DKString& file){
	DKDEBUGFUNC(file);
	if(DKClass::HasFunc("DKSDLAudio::PlaySound"))
		return DKClass::CallFunc("DKSDLAudio::PlaySound", &file);
	if(DKClass::HasFunc("DKSDLWav::PlaySound"))
		return DKClass::CallFunc("DKSDLWav::PlaySound", &file);
	if (DKClass::HasFunc("DKOSGAudio::PlaySound"))
		return DKClass::CallFunc("DKOSGAudio::PlaySound", &file);
	return DKERROR("No PlaySound funtion available\n");
}

bool DKAudio::Resume(DKString& file){
	DKDEBUGFUNC(file);
	if(DKClass::HasFunc("DKSDLAudio::Resume"))
		return DKClass::CallFunc("DKSDLAudio::Resume", &file);
	if(DKClass::HasFunc("DKSDLWav::Resume"))
		return DKClass::CallFunc("DKSDLWav::Resume", &file);
	if (DKClass::HasFunc("DKOSGAudio::Resume"))
		return DKClass::CallFunc("DKOSGAudio::Resume", &file);
	return DKERROR("No Resume funtion available\n");
}

bool DKAudio::SetTime(int& seconds){
	DKDEBUGFUNC(seconds);
	if(DKClass::HasFunc("DKSDLAudio::SetTime"))
		return DKClass::CallFunc("DKSDLAudio::SetTime", &seconds);
	if(DKClass::HasFunc("DKSDLWav::SetTime"))
		return DKClass::CallFunc("DKSDLWav::SetTime", &seconds);
	if(DKClass::HasFunc("DKOSGAudio::SetTime"))
		return DKClass::CallFunc("DKOSGAudio::SetTime", &seconds);
	return DKERROR("No SetTime funtion available\n");
}

bool DKAudio::SetVolume(int& volume){
	DKDEBUGFUNC(volume);
	if(DKClass::HasFunc("DKSDLAudio::SetVolume"))
		return DKClass::CallFunc("DKSDLAudio::SetVolume", &volume);
	if(DKClass::HasFunc("DKSDLWav::SetVolume"))
		return DKClass::CallFunc("DKSDLWav::SetVolume", &volume);
	if(DKClass::HasFunc("DKOSGAudio::SetVolume"))
		return DKClass::CallFunc("DKOSGAudio::SetVolume", &volume);
	return DKERROR("No SetVolume funtion available\n");
}

bool DKAudio::UnMute(){
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKSDLAudio::UnMute"))
		return DKClass::CallFunc("DKSDLAudio::UnMute");
	if(DKClass::HasFunc("DKSDLWav::UnMute"))
		return DKClass::CallFunc("DKSDLWav::UnMute");
	if (DKClass::HasFunc("DKOSGAudio::UnMute"))
		return DKClass::CallFunc("DKOSGAudio::UnMute");
	return DKERROR("No UnMute funtion available\n");
}
