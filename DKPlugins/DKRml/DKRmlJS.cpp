#ifdef USE_DKDuktape
#include "DKRml/DKRml.h"
#include "DKRml/DKRmlJS.h"


////////////////////
bool DKRmlJS::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKRml_DebuggerOff", DKRmlJS::DebuggerOff);
	DKDuktape::AttachFunction("DKRml_DebuggerOn", DKRmlJS::DebuggerOn);
	DKDuktape::AttachFunction("DKRml_DebuggerToggle", DKRmlJS::DebuggerToggle);
	DKDuktape::AttachFunction("DKRml_LoadUrl", DKRmlJS::LoadUrl);
	return true;
}


//////////////////////////////////////////
int DKRmlJS::DebuggerOff(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKRml::Get()->DebuggerOff();
	return false;
}

/////////////////////////////////////////
int DKRmlJS::DebuggerOn(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKRml::Get()->DebuggerOn();
	return false;
}

/////////////////////////////////////////////
int DKRmlJS::DebuggerToggle(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKRml::Get()->DebuggerToggle();
	return true;
}

//////////////////////////////////////
int DKRmlJS::LoadUrl(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString file = duk_require_string(ctx, 0);
	if (!DKRml::Get()->LoadUrl(file)) { return 0; }
	return true;
}

#endif //USE_DKDuktape