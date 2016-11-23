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

/////////////////////////////////////////////////////////////////////////////
bool DKCefV8::MyFunc(CefV8ValueList arguments, CefRefPtr<CefV8Value>& retval)
{
	DKString arg = arguments[0]->GetStringValue();
	DKLog("DKCefV8::MyFunc("+arg+") \n", DKDEBUG);

	retval = CefV8Value::CreateString("output");
	return true;
}

