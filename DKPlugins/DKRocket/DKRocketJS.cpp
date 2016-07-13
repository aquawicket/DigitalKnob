#ifdef USE_DKDuktape
#include "DKRocket.h"
#include "DKRocketJS.h"


///////////////////////
void DKRocketJS::Init()
{
	DKDuktape::AttachFunction("DKRocket_ToggleDebugger", DKRocketJS::ToggleDebugger, 0);
	DKDuktape::AttachFunction("DKRocket_Reload", DKRocketJS::Reload, 0);
}

////////////////////////////////////////////////
int DKRocketJS::ToggleDebugger(duk_context* ctx)
{
	DKRocket::Get("DKRocket0")->ToggleDebugger();
	return 1;
}

/////////////////////////////////
int DKRocketJS::Reload(duk_context* ctx)
{
	DKRocket::Get("DKRocket0")->Reload();
	return 1;
}


#endif //USE_DKDuktape