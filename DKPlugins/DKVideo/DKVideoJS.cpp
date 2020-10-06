#ifdef USE_DKDuktape
#include "DKVideo.h"
#include "DKVideoJS.h"


//////////////////////
bool DKVideoJS::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKVideo_Play", DKVideoJS::Play);
	return true;
}

/////////////////////////////////////
int DKVideoJS::Play(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString data = duk_require_string(ctx, 0);
	DKVideo::Play(data);
	return 1;
}

#endif //USE_DKDuktape