#ifdef USE_DKDuktape 
#include "DKScreenRecorder.h"
#include "DKScreenRecorderJS.h"


///////////////////////////////
bool DKScreenRecorderJS::Init()
{
	DKDuktape::AttachFunction("DKScreenRecorder_Test", DKScreenRecorderJS::Test);
	return true;
}

//////////////////////////////////////////////
int DKScreenRecorderJS::Test(duk_context* ctx)
{
	//TODO
	return 0;
}


#endif //USE_DKDuktape