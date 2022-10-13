#ifdef USE_DKDuktape 
#include "DKOSGVideo/DKOSGVideo.h"
#include "DKOSGVideo/DKOSGVideoJS.h"


bool DKOSGVideoJS::Init(){
	DKDuktape::AttachFunction("DKOSGVideo_Play", DKOSGVideoJS::Play, 1);
	return true;
}

int DKOSGVideoJS::Play(duk_context* ctx){
	DKString file = duk_require_string(ctx, 0);
	DKOSGVideo::Instance("DKOSGVideo")->Play(file);
	return 1;
}


#endif //USE_DKDuktape