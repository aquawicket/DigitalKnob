#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKDebug/DKDebug.h"
#include "DKDebug/DKDebugV8.h"

//////////////////////
bool DKDebugV8::Init()
{
	DKLog("DKDebugV8::Init()\n", DKDEBUG);
	DKV8::AttachFunction("DKDebug_SendBugReport", DKDebugV8::SendBugReport);
	DKV8::AttachFunction("DKDebug_ShowStackTrace", DKDebugV8::ShowStackTrace);
	return true;
}

/////////////////////
bool DKDebugV8::End()
{
	DKLog("DKDebugV8::End()\n", DKDEBUG);
	return true;
}

/////////////////////////////////////////////////////////////
bool DKDebugV8::SendBugReport(CefArgs args, CefReturn retval)
{
	DKLog("DKDebugV8::SendBugReport(CefArgs,CefReturn)\n", DKDEBUG);

	DKString filename = args->GetString(0);
	if(!DKDebug::SendBugReport(filename)) { return false; }
	return true;
}

//////////////////////////////////////////////////////////////
bool DKDebugV8::ShowStackTrace(CefArgs args, CefReturn retval)
{
	DKLog("DKDebugV8::ShowStackTrace(CefArgs,CefReturn)\n", DKDEBUG);

	if(!DKDebug::ShowStackTrace()){ return false; }
	return true;
}

#endif //USE_DKCef