/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#include "DK/stdafx.h"
#include "DKAudio/DKAudio.h"

bool DKAudio::Init(){
	DKDEBUGFUNC();
	DKClass::DKCreate("DKAudioJS");
	DKClass::DKCreate("DKAudioV8");
	if(DKClass::DKAvailable("DKSdlAudio")){
		DKClass::DKCreate("DKSdlAudio");
		return true;
	}
	if(DKClass::DKAvailable("DKSdlWav")){
		DKClass::DKCreate("DKSdlWav");
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
	DKClass::DKClose("DKSdlAudio");
	DKClass::DKClose("DKSdlWav");
	DKClass::DKClose("DKOSGAudio");
	return true;
}

bool DKAudio::GetDuration(int& duration){
	DKDEBUGFUNC(duration);
	if(DKClass::HasFunc("DKSdlAudio::GetDuration"))
		return DKClass::CallFunc("DKSdlAudio::GetDuration", NULL, &duration);
	if(DKClass::HasFunc("DKSdlWav::GetDuration"))
		return DKClass::CallFunc("DKSdlWav::GetDuration", NULL, &duration);
	if (DKClass::HasFunc("DKOSGAudio::GetDuration"))
		return DKClass::CallFunc("DKOSGAudio::GetDuration", NULL, &duration);
	return DKERROR("No GetDuration funtion available\n");
}

bool DKAudio::GetTime(int& time){
	DKDEBUGFUNC(time);
	if(DKClass::HasFunc("DKSdlAudio::GetTime"))
		return DKClass::CallFunc("DKSdlAudio::GetTime", NULL, &time);
	if(DKClass::HasFunc("DKSdlWav::GetTime"))
		return DKClass::CallFunc("DKSdlWav::GetTime", NULL, &time);
	if (DKClass::HasFunc("DKOSGAudio::GetTime"))
		return DKClass::CallFunc("DKOSGAudio::GetTime", NULL, &time);
	return DKERROR("No GetTime funtion available\n");
}

bool DKAudio::GetVolume(int& volume){
	DKDEBUGFUNC(volume);
	if(DKClass::HasFunc("DKSdlAudio::GetVolume"))
		return DKClass::CallFunc("DKSdlAudio::GetVolume", NULL, &volume);
	if(DKClass::HasFunc("DKSdlWav::GetVolume"))
		return DKClass::CallFunc("DKSdlWav::GetVolume", NULL, &volume);
	if (DKClass::HasFunc("DKOSGAudio::GetVolume"))
		return DKClass::CallFunc("DKOSGAudio::GetVolume", NULL, &volume);
	return DKERROR("No GetVolume funtion available\n");
}

bool DKAudio::Mute(){
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKSdlAudio::Mute"))
		return DKClass::CallFunc("DKSdlAudio::Mute");
	if(DKClass::HasFunc("DKSdlWav::Mute"))
		return DKClass::CallFunc("DKSdlWav::Mute");
	if (DKClass::HasFunc("DKOSGAudio::Mute"))
		return DKClass::CallFunc("DKOSGAudio::Mute");
	return DKERROR("No Mute funtion available\n");
}

bool DKAudio::OpenMusic(DKString& file){
	DKDEBUGFUNC(file);
	if(DKClass::HasFunc("DKSdlAudio::OpenMusic"))
		return DKClass::CallFunc("DKSdlAudio::OpenMusic", &file);
	if(DKClass::HasFunc("DKSdlWav::OpenMusic"))
		return DKClass::CallFunc("DKSdlWav::OpenMusic", &file);
	if (DKClass::HasFunc("DKOSGAudio::OpenMusic"))
		return DKClass::CallFunc("DKOSGAudio::OpenMusic", &file);
	return DKERROR("No OpenMusic funtion available\n");
}

bool DKAudio::Pause(DKString& file){
	DKDEBUGFUNC(file);
	if(DKClass::HasFunc("DKSdlAudio::Pause"))
		return DKClass::CallFunc("DKSdlAudio::Pause", &file);
	if(DKClass::HasFunc("DKSdlWav::Pause"))
		return DKClass::CallFunc("DKSdlWav::Pause", &file);
	if (DKClass::HasFunc("DKOSGAudio::Pause"))
		return DKClass::CallFunc("DKOSGAudio::Pause", &file);
	return DKERROR("No Pause funtion available\n");
}

bool DKAudio::PlaySound(const DKString& file){
	DKDEBUGFUNC(file);
	if(DKClass::HasFunc("DKSdlAudio::PlaySound"))
		return DKClass::CallFunc("DKSdlAudio::PlaySound", &file);
	if(DKClass::HasFunc("DKSdlWav::PlaySound"))
		return DKClass::CallFunc("DKSdlWav::PlaySound", &file);
	if (DKClass::HasFunc("DKOSGAudio::PlaySound"))
		return DKClass::CallFunc("DKOSGAudio::PlaySound", &file);
	return DKERROR("No PlaySound funtion available\n");
}

bool DKAudio::Resume(DKString& file){
	DKDEBUGFUNC(file);
	if(DKClass::HasFunc("DKSdlAudio::Resume"))
		return DKClass::CallFunc("DKSdlAudio::Resume", &file);
	if(DKClass::HasFunc("DKSdlWav::Resume"))
		return DKClass::CallFunc("DKSdlWav::Resume", &file);
	if (DKClass::HasFunc("DKOSGAudio::Resume"))
		return DKClass::CallFunc("DKOSGAudio::Resume", &file);
	return DKERROR("No Resume funtion available\n");
}

bool DKAudio::SetTime(int& seconds){
	DKDEBUGFUNC(seconds);
	if(DKClass::HasFunc("DKSdlAudio::SetTime"))
		return DKClass::CallFunc("DKSdlAudio::SetTime", &seconds);
	if(DKClass::HasFunc("DKSdlWav::SetTime"))
		return DKClass::CallFunc("DKSdlWav::SetTime", &seconds);
	if(DKClass::HasFunc("DKOSGAudio::SetTime"))
		return DKClass::CallFunc("DKOSGAudio::SetTime", &seconds);
	return DKERROR("No SetTime funtion available\n");
}

bool DKAudio::SetVolume(int& volume){
	DKDEBUGFUNC(volume);
	if(DKClass::HasFunc("DKSdlAudio::SetVolume"))
		return DKClass::CallFunc("DKSdlAudio::SetVolume", &volume);
	if(DKClass::HasFunc("DKSdlWav::SetVolume"))
		return DKClass::CallFunc("DKSdlWav::SetVolume", &volume);
	if(DKClass::HasFunc("DKOSGAudio::SetVolume"))
		return DKClass::CallFunc("DKOSGAudio::SetVolume", &volume);
	return DKERROR("No SetVolume funtion available\n");
}

bool DKAudio::UnMute(){
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKSdlAudio::UnMute"))
		return DKClass::CallFunc("DKSdlAudio::UnMute");
	if(DKClass::HasFunc("DKSdlWav::UnMute"))
		return DKClass::CallFunc("DKSdlWav::UnMute");
	if (DKClass::HasFunc("DKOSGAudio::UnMute"))
		return DKClass::CallFunc("DKOSGAudio::UnMute");
	return DKERROR("No UnMute funtion available\n");
}
