#ifdef USE_DKDuktape
#include "DKRml/DKRml.h"
#include "DKRml/DKRmlJS.h"


////////////////////
bool DKRmlJS::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKRml_LoadUrl", DKRmlJS::LoadUrl);
	DKDuktape::AttachFunction("DKRml_ToggleDebugger", DKRmlJS::ToggleDebugger);	
	return true;
}

//////////////////////////////////////
int DKRmlJS::LoadUrl(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString file = duk_require_string(ctx, 0);
	if(!DKRml::Get()->LoadUrl(file)){ return 0; }
	return 1;
}

/////////////////////////////////////////////
int DKRmlJS::ToggleDebugger(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKRml::Get()->ToggleDebugger();
	return 1;
}

#endif //USE_DKDuktape