#ifdef USE_DKCef
#include "DKDebugV8.h"
#include "DKDebug.h"
#include "DKApp.h"

/////////////////////
void DKDebugV8::Init()
{
	DKLog("DKDebugV8::Init()\n", DKDEBUG);
	//DKV8::AttachFunction("Test", DKDebugV8::Test);
	DKV8::AttachFunction("DKDebug_ShowStackTrace", DKDebugV8::ShowStackTrace);
	DKV8::AttachFunction("DKDebug_SendBugReport", DKDebugV8::SendBugReport);
}

///////////////////
void DKDebugV8::End()
{
	DKLog("DKDebugV8::End()\n", DKDEBUG);
}

/*
////////////////////////////////////////////////////
bool DKDebugV8::Test(CefArgs args, CefReturn retval)
{
	DKLog("DKDebugV8::Test(CefArgs,CefReturn)\n", DKDEBUG);
	DKString data = args->GetString(0);
	DKString result = data;
	retval = CefV8Value::CreateString(result);
	return true;
}
*/

//////////////////////////////////////////////////////////////
bool DKDebugV8::ShowStackTrace(CefArgs args, CefReturn retval)
{
	DKLog("DKDebugV8::ShowStackTrace(CefArgs,CefReturn)\n", DKDEBUG);

	if(!DKDebug::ShowStackTrace()){ return false; }
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

#endif //USE_DKCef