#include "DKCefV8.h"

////////////////////
void DKCefV8::Init()
{
	DKCefApp::AttachFunction("myfunc", DKCefV8::MyFunc);
}

///////////////////
void DKCefV8::End()
{

}

////////////////////////////////////////////////////
bool DKCefV8::MyFunc(CefArgs args, CefReturn retval)
{
	DKString arg = args[0]->GetStringValue();
	DKLog("DKCefV8::MyFunc("+arg+")\n", DKFILTER);

	retval = CefV8Value::CreateString("output");
	return true;
}

