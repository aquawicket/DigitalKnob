#ifdef USE_DKDuktape
#include "DKAudio.h"
#include "DKAudioJS.h"


//////////////////////
void DKAudioJS::Init()
{
	DKDuktape::AttachFunction("DKAudio_Play", DKAudioJS::Play, 1);
}

/////////////////////////////////////
int DKAudioJS::Play(duk_context* ctx)
{
	DKString data = duk_require_string(ctx, 0);
	DKAudio::Play(data);
	return 1;
}


#endif //USE_DKDuktape