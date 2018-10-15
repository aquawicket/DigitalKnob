#ifdef USE_DKDuktape
#include "DKRocket.h"
#include "DKRocketJS.h"


///////////////////////
bool DKRocketJS::Init()
{
	DKDuktape::AttachFunction("DKRocket_Reload", DKRocketJS::Reload);
	DKDuktape::AttachFunction("DKRocket_ToggleDebugger", DKRocketJS::ToggleDebugger);

	//Note: moved to DKWidgetJS
	//DKString jsfile = DKFile::local_assets + "DKRocket/DKRocket.js";
	//DKDuktape::LoadFile(jsfile);
	return true;
}

////////////////////////////////////////
int DKRocketJS::Reload(duk_context* ctx)
{
	DKRocket::Get()->Reload();
	return 1;
}

////////////////////////////////////////////////
int DKRocketJS::ToggleDebugger(duk_context* ctx)
{
	DKRocket::Get()->ToggleDebugger();
	return 1;
}

#endif //USE_DKDuktape