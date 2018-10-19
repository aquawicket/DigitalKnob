#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKDebug/DKDebug.h"
#include "DKDebug/DKDebugV8.h"

//////////////////////
bool DKDebugV8::Init()
{
	DKDebug();
	DKV8::AttachFunction("DKDebug_SendBugReport", DKDebugV8::SendBugReport);
	DKV8::AttachFunction("DKDebug_ShowStackTrace", DKDebugV8::ShowStackTrace);
	return true;
}

/////////////////////
bool DKDebugV8::End()
{
	DKDebug();
	return true;
}

/////////////////////////////////////////////////////////////
bool DKDebugV8::SendBugReport(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	DKString filename = args->GetString(0);
	if(!DKDebug::SendBugReport(filename)) { return false; }
	return true;
}

//////////////////////////////////////////////////////////////
bool DKDebugV8::ShowStackTrace(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	if(!DKDebug::ShowStackTrace()){ return false; }
	return true;
}

#endif //USE_DKCef