#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKRml/DKRml.h"
#include "DKRml/DKRmlV8.h"

///////////////////////
bool DKRmlV8::Init()
{
	DKDEBUGFUNC();
	DKV8::AttachFunction("DKRml_Reload", DKRmlV8::Reload);
	DKV8::AttachFunction("DKRml_ToggleDebugger", DKRmlV8::ToggleDebugger);
	return true;
}

//////////////////////
bool DKRmlV8::End()
{
	DKDEBUGFUNC();
	return true;
}

///////////////////////////////////////////////////////
bool DKRmlV8::Reload(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKRml::Get()->Reload();
	return true;
}

///////////////////////////////////////////////////////////////
bool DKRmlV8::ToggleDebugger(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKRml::Get()->ToggleDebugger();
	return true;
}

#endif //USE_DKCef