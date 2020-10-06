#ifdef USE_DKDuktape
#include "DKAudio.h"
#include "DKAudioJS.h"


//////////////////////
bool DKAudioJS::Init()
{
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

////////////////////////////////////////////
int DKAudioJS::GetDuration(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int duration;
	if(!DKAudio::GetDuration(duration)){ return 0; }
	duk_push_int(ctx, duration);
	return 1;
}

////////////////////////////////////////
int DKAudioJS::GetTime(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int time;
	if(!DKAudio::GetTime(time)){ return 0; }
	duk_push_int(ctx, time);
	return 1;
}

//////////////////////////////////////////
int DKAudioJS::GetVolume(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int volume;
	if(!DKAudio::GetVolume(volume)){ return 0; }
	duk_push_int(ctx, volume);
	return 1;
}

/////////////////////////////////////
int DKAudioJS::Mute(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	if(!DKAudio::Mute()){ return 0; }
	return 1;
}

//////////////////////////////////////////
int DKAudioJS::OpenMusic(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString data = duk_require_string(ctx, 0);
	if(!DKAudio::OpenMusic(data)){ return 0; }
	return 1;
}

//////////////////////////////////////
int DKAudioJS::Pause(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString data = duk_require_string(ctx, 0);
	if(!DKAudio::Pause(data)){ return 0; }
	return 1;
}

//////////////////////////////////////////
int DKAudioJS::PlaySound(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString data = duk_require_string(ctx, 0);
	if(!DKAudio::PlaySound(data)){ return 0; }
	return 1;
}

///////////////////////////////////////
int DKAudioJS::Resume(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString data = duk_require_string(ctx, 0);
	if(!DKAudio::Resume(data)){ return 0; }
	return 1;
}

////////////////////////////////////////
int DKAudioJS::SetTime(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int time = duk_require_int(ctx, 0);
	if(!DKAudio::SetTime(time)){ return 0; }
	return 1;
}

//////////////////////////////////////////
int DKAudioJS::SetVolume(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int volume = duk_require_int(ctx, 0);
	if(!DKAudio::SetVolume(volume)){ return 0; }
	return 1;
}

///////////////////////////////////////
int DKAudioJS::UnMute(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	if(!DKAudio::UnMute()){ return 0; }
	return 1;
}

#endif //USE_DKDuktape