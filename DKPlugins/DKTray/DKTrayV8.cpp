#ifdef USE_DKCef
#include "DKTrayV8.h"
#include "DKFile.h"
#include "DKApp.h"

/////////////////////
void DKTrayV8::Init()
{
	DKLog("DKTrayV8::Init()\n", DKDEBUG);
	//DKCefApp::AttachFunction("Test", DKTrayV8::Test);
}

///////////////////
void DKTrayV8::End()
{
	DKLog("DKTrayV8::End()\n", DKDEBUG);
}

/*
///////////////////////////////////////////////////
bool DKTrayV8::Test(CefArgs args, CefReturn retval)
{
	DKLog("DKTrayV8::Test(CefArgs,CefReturn)\n", DKDEBUG);
	DKString data = args[0]->GetStringValue();
	DKString result = data;
	retval = CefV8Value::CreateString(result);
	return true;
}
*/

#endif //USE_DKCef