#include "DKCefV8.h"

////////////////////
void DKCefV8::Init()
{
	DKCefApp::AttachFunction("DKCreate_CPP", DKCefV8::DKCreate_CPP);
	DKCefApp::AttachFunction("DK_Execute", DKCefV8::Execute);
}

///////////////////
void DKCefV8::End()
{

}

//////////////////////////////////////////////////////////
bool DKCefV8::DKCreate_CPP(CefArgs args, CefReturn retval)
{
	DKString data = args[0]->GetStringValue();
	DKLog("DKCefV8::DKCreate_CPP("+data+")\n", DKFILTER);
	DKCreate(data);
	return true;
}

/////////////////////////////////////////////////////
bool DKCefV8::Execute(CefArgs args, CefReturn retval)
{
	DKString command = args[0]->GetStringValue();
	DKString result = DKUtil::Execute(command);
	retval = CefV8Value::CreateString(result);
	return true;
}

