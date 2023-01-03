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
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#ifdef HAVE_DKDuktape
#include "DKAudio/DKAudio.h"
#include "DKAudio/DKAudioJS.h"

bool DKAudioJS::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKAudio_GetDuration", DKAudioJS::GetDuration);
	DKDuktape::AttachFunction("CPP_DKAudio_GetTime", DKAudioJS::GetTime);
	DKDuktape::AttachFunction("CPP_DKAudio_GetVolume", DKAudioJS::GetVolume);
	DKDuktape::AttachFunction("CPP_DKAudio_Mute", DKAudioJS::Mute);
	DKDuktape::AttachFunction("CPP_DKAudio_OpenMusic", DKAudioJS::OpenMusic);
	DKDuktape::AttachFunction("CPP_DKAudio_Pause", DKAudioJS::Pause);
	DKDuktape::AttachFunction("CPP_DKAudio_PlaySound", DKAudioJS::PlaySound);
	DKDuktape::AttachFunction("CPP_DKAudio_Resume", DKAudioJS::Resume);
	DKDuktape::AttachFunction("CPP_DKAudio_SetTime", DKAudioJS::SetTime);
	DKDuktape::AttachFunction("CPP_DKAudio_SetVolume", DKAudioJS::SetVolume);
	DKDuktape::AttachFunction("CPP_DKAudio_UnMute", DKAudioJS::UnMute);
	return true;
}

int DKAudioJS::GetDuration(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int duration;
	if(!DKAudio::GetDuration(duration))
		return false;
	duk_push_int(ctx, duration);
	return true;
}

int DKAudioJS::GetTime(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int time;
	if(!DKAudio::GetTime(time))
		return false;
	duk_push_int(ctx, time);
	return true;
}

int DKAudioJS::GetVolume(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int volume;
	if(!DKAudio::GetVolume(volume))
		return false;
	duk_push_int(ctx, volume);
	return true;
}

int DKAudioJS::Mute(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	if(!DKAudio::Mute())
		return false;
	return true;
}

int DKAudioJS::OpenMusic(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString data = duk_require_string(ctx, 0);
	if(!DKAudio::OpenMusic(data))
		return false;
	return true;
}

int DKAudioJS::Pause(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString data = duk_require_string(ctx, 0);
	if(!DKAudio::Pause(data))
		return false;
	return true;
}

int DKAudioJS::PlaySound(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString data = duk_require_string(ctx, 0);
	if(!DKAudio::PlaySound(data))
		return false;
	return true;
}

int DKAudioJS::Resume(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString data = duk_require_string(ctx, 0);
	if(!DKAudio::Resume(data))
		return false;
	return true;
}

int DKAudioJS::SetTime(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int time = duk_require_int(ctx, 0);
	if(!DKAudio::SetTime(time))
		return false;
	return true;
}

int DKAudioJS::SetVolume(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int volume = duk_require_int(ctx, 0);
	if(!DKAudio::SetVolume(volume))
		return false;
	return true;
}

int DKAudioJS::UnMute(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	if(!DKAudio::UnMute())
		return false;
	return true;
}

#endif //HAVE_DKDuktape