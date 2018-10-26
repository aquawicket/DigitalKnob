#ifdef USE_DKDuktape 
#include "DKScreenRecorder.h"
#include "DKScreenRecorderJS.h"


///////////////////////////////
bool DKScreenRecorderJS::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKScreenRecorder_Record", DKScreenRecorderJS::Record);
	DKDuktape::AttachFunction("DKScreenRecorder_Stop", DKScreenRecorderJS::Stop);
	return true;
}

////////////////////////////////////////////////
int DKScreenRecorderJS::Record(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString file = duk_require_string(ctx, 0);
	if(!DKScreenRecorder::Record(file)){ return 0; }
	return 1;
}

//////////////////////////////////////////////
int DKScreenRecorderJS::Stop(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	if(!DKScreenRecorder::Stop()){ return 0; }
	return 1;
}

#endif //USE_DKDuktape