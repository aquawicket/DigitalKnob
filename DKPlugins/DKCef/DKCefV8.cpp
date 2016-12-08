//#ifdef USE_DKCef
#include "DKCefV8.h"

////////////////////
void DKCefV8::Init()
{
	DKCreate("DKFileV8");
	DKCreate("DKAssetsV8");
	
	DKCefApp::AttachFunction("DK_ClickImage", DKCefV8::ClickImage);
	DKCefApp::AttachFunction("DKCreate_CPP", DKCefV8::DKCreate_CPP);
	DKCefApp::AttachFunction("DKValid", DKCefV8::DKValid_CPP);
	DKCefApp::AttachFunction("DK_Execute", DKCefV8::Execute);
	DKCefApp::AttachFunction("DK_GetClipboard", DKCefV8::GetClipboard);
	DKCefApp::AttachFunction("DK_PressKey", DKCefV8::PressKey);
	DKCefApp::AttachFunction("DK_PrintFunctions", DKCefV8::PrintFunctions);
	DKCefApp::AttachFunction("DK_ReleaseKey", DKCefV8::ReleaseKey);
	DKCefApp::AttachFunction("DK_Run", DKCefV8::Run);
	DKCefApp::AttachFunction("DK_RunJavascript", DKCefV8::RunJavascript);
	DKCefApp::AttachFunction("DK_SetClipboard", DKCefV8::SetClipboard);
	DKCefApp::AttachFunction("DK_StrokeKey", DKCefV8::StrokeKey);
	DKCefApp::AttachFunction("DK_WaitForImage", DKCefV8::WaitForImage);
}

///////////////////
void DKCefV8::End()
{

}

////////////////////////////////////////////////////////
bool DKCefV8::ClickImage(CefArgs args, CefReturn retval)
{
	DKString file = args[0]->GetStringValue();
	int x;
	int y;
	if(!DKUtil::FindImageOnScreen(file, x, y)){ return false; }
	if(!DKUtil::SetMousePos(x, y)){ return false; }
	if(!DKUtil::LeftClick()){ return false; }
	return true;
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

//////////////////////////////////////////////////////////
bool DKCefV8::GetClipboard(CefArgs args, CefReturn retval)
{
	DKString string;
	if(!DKUtil::GetClipboard(string)){ return false; }
	retval = CefV8Value::CreateString(string);
	return true;
}

//////////////////////////////////////////////////////
bool DKCefV8::PressKey(CefArgs args, CefReturn retval)
{
	int key = args[0]->GetIntValue();
	if(!DKUtil::PressKey(key)){
		return false;
	}
	return true;
}

////////////////////////////////////////////////////////////
bool DKCefV8::PrintFunctions(CefArgs args, CefReturn retval)
{
	DKLog("\n**** V8 Functions ****\n", DKINFO);
	typedef std::map<DKString, boost::function<bool(CefArgs, CefReturn)>>::iterator it_type;
	for (it_type iterator = DKCefApp::handler->functions.begin(); iterator != DKCefApp::handler->functions.end(); iterator++) {
		DKLog(iterator->first+"\n", DKINFO);
	}
	return true;
}

////////////////////////////////////////////////////////
bool DKCefV8::ReleaseKey(CefArgs args, CefReturn retval)
{
	int key = args[0]->GetIntValue();
	if(!DKUtil::ReleaseKey(key)){
		return false;
	}
	return true;
}

/////////////////////////////////////////////////
bool DKCefV8::Run(CefArgs args, CefReturn retval)
{
	DKString command = args[0]->GetStringValue();
	if(!DKUtil::Run(command)){ 
		return false; 
	}
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

//////////////////////////////////////////////////////////
bool DKCefV8::SetClipboard(CefArgs args, CefReturn retval)
{
	DKString string = args[0]->GetStringValue();
	if(!DKUtil::SetClipboard(string)){ return false; }
	return true;
}

///////////////////////////////////////////////////////
bool DKCefV8::StrokeKey(CefArgs args, CefReturn retval)
{
	int key = args[0]->GetIntValue();
	if(!DKUtil::StrokeKey(key)){
		return false;
	}
	return true;
}

//////////////////////////////////////////////////////////
bool DKCefV8::WaitForImage(CefArgs args, CefReturn retval)
{
	DKString file = args[0]->GetStringValue();
	int timeout = args[1]->GetIntValue();
	if(!!DKUtil::WaitForImage(file, timeout)){
		return false;
	}
	retval = CefV8Value::CreateBool(true);
	return 1;
}

//#endif //USE_DKCef
