#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKRml/DKRml.h"
#include "DKRml/DKRmlV8.h"

bool DKRmlV8::Init()
{
	DKDEBUGFUNC();
	DKV8::AttachFunction("DKRml_DebuggerToggle", DKRmlV8::DebuggerToggle);
	return true;
}

bool DKRmlV8::End()
{
	DKDEBUGFUNC();
	return true;
}

bool DKRmlV8::DebuggerToggle(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKRml::Get()->DebuggerToggle();
	return true;
}

#endif //USE_DKCef