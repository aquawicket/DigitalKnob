#ifdef USE_DKCef
#include "DKTrayV8.h"
#include "DKTray.h"
#include "DKApp.h"

/////////////////////
void DKTrayV8::Init()
{
	DKLog("DKTrayV8::Init()\n", DKDEBUG);
	//DKCefV8Handler::AttachFunction("Test", DKTrayV8::Test);
	DKCefV8Handler::AttachFunction("AddItem", DKTrayV8::AddItem);
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

//////////////////////////////////////////////////////
bool DKTrayV8::AddItem(CefArgs args, CefReturn retval)
{
	DKLog("DKTrayV8::AddItem(CefArgs,CefReturn)\n", DKDEBUG);
	DKString name = args[0]->GetStringValue();
	int id = args[1]->GetIntValue();
	DKTray::Get("DKTray0")->AddItem(name, id);
	return true;
}

#endif //USE_DKCef