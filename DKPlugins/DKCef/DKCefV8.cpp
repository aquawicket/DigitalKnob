#include "DKCefV8.h"

////////////////////
void DKCefV8::Init()
{
	DKCreate("DKFileV8");
	
	DKCefApp::AttachFunction("DKCreate_CPP", DKCefV8::DKCreate_CPP);
	DKCefApp::AttachFunction("DKValid", DKCefV8::DKValid_CPP);
	DKCefApp::AttachFunction("DK_Execute", DKCefV8::Execute);
	DKCefApp::AttachFunction("DK_RunJavascript", DKCefV8::RunJavascript);
}

///////////////////
void DKCefV8::End()
{

}

//////////////////////////////////////////////////////////
bool DKCefV8::DKCreate_CPP(CefArgs args, CefReturn retval)
{
	DKString data = args[0]->GetStringValue();
	DKLog("DKCefV8::DKCreate_CPP("+data+")\n", DKDEBUG);
	DKCreate(data);
	return true;
}

/////////////////////////////////////////////////////////
bool DKCefV8::DKValid_CPP(CefArgs args, CefReturn retval)
{
	DKString data = args[0]->GetStringValue();
	bool valid = DKValid(data);
	if(!valid){
		retval = CefV8Value::CreateBool(false);
		return true;
	}
	retval = CefV8Value::CreateBool(true);
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

///////////////////////////////////////////////////////////
bool DKCefV8::RunJavascript(CefArgs args, CefReturn retval)
{
	DKString code = args[0]->GetStringValue();
	DKLog("RunJavascript("+code+")\n", DKDEBUG);
	DKCef::RunJavascript(code);
	return true;
}

