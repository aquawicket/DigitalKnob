#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKRocket/DKRocket.h"
#include "DKRocket/DKRocketV8.h"

///////////////////////
bool DKRocketV8::Init()
{
	DKLog("DKRocketV8::Init()\n", DKDEBUG);
	DKV8::AttachFunction("DKRocket_Reload", DKRocketV8::Reload);
	DKV8::AttachFunction("DKRocket_ToggleDebugger", DKRocketV8::ToggleDebugger);
	return true;
}

//////////////////////
bool DKRocketV8::End()
{
	DKLog("DKRocketV8::End()\n", DKDEBUG);
	return true;
}

///////////////////////////////////////////////////////
bool DKRocketV8::Reload(CefArgs args, CefReturn retval)
{
	DKRocket::Get()->Reload();
	return true;
}

///////////////////////////////////////////////////////////////
bool DKRocketV8::ToggleDebugger(CefArgs args, CefReturn retval)
{
	DKRocket::Get()->ToggleDebugger();
	return true;
}

#endif //USE_DKCef