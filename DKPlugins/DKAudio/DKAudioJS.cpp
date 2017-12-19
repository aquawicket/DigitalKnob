#ifdef USE_DKDuktape
#include "DKAudio.h"
#include "DKAudioJS.h"


//////////////////////
void DKAudioJS::Init()
{
	DKDuktape::AttachFunction("DKAudio_PlaySound", DKAudioJS::PlaySound);
	DKDuktape::AttachFunction("DKAudio_OpenMusic", DKAudioJS::OpenMusic);
	DKDuktape::AttachFunction("DKAudio_Pause", DKAudioJS::Pause);
	DKDuktape::AttachFunction("DKAudio_Resume", DKAudioJS::Resume);
	DKDuktape::AttachFunction("DKAudio_Mute", DKAudioJS::Mute);
	DKDuktape::AttachFunction("DKAudio_UnMute", DKAudioJS::UnMute);
	DKDuktape::AttachFunction("DKAudio_GetVolume", DKAudioJS::GetVolume);
	DKDuktape::AttachFunction("DKAudio_SetVolume", DKAudioJS::SetVolume);
	DKDuktape::AttachFunction("DKAudio_SetTime", DKAudioJS::SetTime);
	DKDuktape::AttachFunction("DKAudio_GetTime", DKAudioJS::GetTime);
	DKDuktape::AttachFunction("DKAudio_GetDuration", DKAudioJS::GetDuration);
}

//////////////////////////////////////////
int DKAudioJS::PlaySound(duk_context* ctx)
{
	DKString data = duk_require_string(ctx, 0);
	DKAudio::PlaySound(data);
	return 1;
}

//////////////////////////////////////////
int DKAudioJS::OpenMusic(duk_context* ctx)
{
	DKString data = duk_require_string(ctx, 0);
	DKAudio::OpenMusic(data);
	return 1;
}

//////////////////////////////////////
int DKAudioJS::Pause(duk_context* ctx)
{
	DKString data = duk_require_string(ctx, 0);
	DKAudio::Pause(data);
	return 1;
}

///////////////////////////////////////
int DKAudioJS::Resume(duk_context* ctx)
{
	DKString data = duk_require_string(ctx, 0);
	DKAudio::Resume(data);
	return 1;
}

/////////////////////////////////////
int DKAudioJS::Mute(duk_context* ctx)
{
	DKAudio::Mute();
	return 1;
}

///////////////////////////////////////
int DKAudioJS::UnMute(duk_context* ctx)
{
	DKAudio::UnMute();
	return 1;
}

//////////////////////////////////////////
int DKAudioJS::GetVolume(duk_context* ctx)
{
	int volume = DKAudio::GetVolume();
	duk_push_int(ctx, volume);
	return 1;
}

//////////////////////////////////////////
int DKAudioJS::SetVolume(duk_context* ctx)
{
	int volume = duk_require_int(ctx, 0);
	DKAudio::SetVolume(volume);
	return 1;
}

////////////////////////////////////////
int DKAudioJS::SetTime(duk_context* ctx)
{
	int time = duk_require_int(ctx, 0);
	DKAudio::SetTime(time);
	return 1;
}

////////////////////////////////////////
int DKAudioJS::GetTime(duk_context* ctx)
{
	int time = DKAudio::GetTime();
	duk_push_int(ctx, time);
	return 1;
}

////////////////////////////////////////////
int DKAudioJS::GetDuration(duk_context* ctx)
{
	int duration = DKAudio::GetDuration();
	duk_push_int(ctx, duration);
	return 1;
}

#endif //USE_DKDuktape