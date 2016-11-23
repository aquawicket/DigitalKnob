#include "DKCefV8.h"

////////////////////
void DKCefV8::Init()
{
	DKCefApp::AttachFunction("myfunc", &DKCefV8::MyFunc, this);
}

///////////////////
void DKCefV8::End()
{

}

/////////////////////////////////////////////////////////////////////////////
bool DKCefV8::MyFunc(CefV8ValueList arguments, CefRefPtr<CefV8Value>& retval)
{
	DKLog("DKCefV8::MyFunc("+DKString(arguments[0]->GetStringValue())+") \n", DKDEBUG);
	retval = CefV8Value::CreateString("output");
	return true;
}

