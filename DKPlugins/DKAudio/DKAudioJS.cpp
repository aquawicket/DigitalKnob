#ifdef USE_DKDuktape
#include "DKAudio.h"
#include "DKAudioJS.h"


//////////////////////
void DKAudioJS::Init()
{
	DKDuktape::AttachFunction("DKAudio_PlaySound", DKAudioJS::PlaySound, 1);
	DKDuktape::AttachFunction("DKAudio_OpenMusic", DKAudioJS::OpenMusic, 1);
	DKDuktape::AttachFunction("DKAudio_Pause", DKAudioJS::Pause, 1);
	DKDuktape::AttachFunction("DKAudio_Resume", DKAudioJS::Resume, 1);
	DKDuktape::AttachFunction("DKAudio_Mute", DKAudioJS::Mute, 0);
	DKDuktape::AttachFunction("DKAudio_UnMute", DKAudioJS::UnMute, 0);
	DKDuktape::AttachFunction("DKAudio_GetVolume", DKAudioJS::GetVolume, 0);
	DKDuktape::AttachFunction("DKAudio_SetVolume", DKAudioJS::SetVolume, 1);
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

#endif //USE_DKDuktape