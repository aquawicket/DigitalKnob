#ifdef USE_DKDuktape
#include "DKAudio.h"
#include "DKAudioJS.h"

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

#endif //USE_DKDuktape