#ifdef USE_DKDuktape
#include "DKAudio.h"
#include "DKAudioJS.h"


//////////////////////
void DKAudioJS::Init()
{
	DKDuktape::AttachFunction("DKAudio_PlaySound", DKAudioJS::PlaySound, 1);
	DKDuktape::AttachFunction("DKAudio_PlayMusic", DKAudioJS::PlayMusic, 1);
}

//////////////////////////////////////////
int DKAudioJS::PlaySound(duk_context* ctx)
{
	DKString data = duk_require_string(ctx, 0);
	DKAudio::PlaySound(data);
	return 1;
}

//////////////////////////////////////////
int DKAudioJS::PlayMusic(duk_context* ctx)
{
	DKString data = duk_require_string(ctx, 0);
	DKAudio::PlayMusic(data);
	return 1;
}


#endif //USE_DKDuktape