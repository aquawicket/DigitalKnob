#include "DKCefV8.h"

////////////////////
void DKCefV8::Init()
{
	DKCefApp::AttachFunction("myfunc", DKCefV8::MyFunc);
	DKCefApp::AttachFunction("DKCreate_CPP", DKCefV8::DKCreate_CPP);
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

//////////////////////////////////////////////////////////
bool DKCefV8::DKCreate_CPP(CefArgs args, CefReturn retval)
{
	DKString data = args[0]->GetStringValue();
	DKLog("DKCefV8::DKCreate_CPP("+data+")\n", DKFILTER);
	DKCreate(data);
	return true;
}

