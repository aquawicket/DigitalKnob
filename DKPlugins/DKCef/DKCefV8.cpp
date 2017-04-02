//#ifdef USE_DKCef
#include "DKCefV8.h"

////////////////////
void DKCefV8::Init()
{
	DKCreate("DKFileV8");
	DKCreate("DKAssetsV8");
	
	DKV8::AttachFunction("DK_ClickImage", DKCefV8::ClickImage);
	DKV8::AttachFunction("DKCreate_CPP", DKCefV8::_DKCreate);
	DKV8::AttachFunction("DK_SetLog", DKCefV8::_SetLog);
	DKV8::AttachFunction("DKValid", DKCefV8::_DKValid);
	DKV8::AttachFunction("DK_Execute", DKCefV8::Execute);
	DKV8::AttachFunction("DK_GetClipboard", DKCefV8::GetClipboard);
	DKV8::AttachFunction("DK_GetScreenHeight", DKCefV8::GetScreenHeight);
	DKV8::AttachFunction("DK_GetScreenWidth", DKCefV8::GetScreenWidth);
	DKV8::AttachFunction("DK_GetPixelUnderMouse", DKCefV8::GetPixelUnderMouse);
	DKV8::AttachFunction("DK_HideConsole", DKCefV8::HideConsole);
	DKV8::AttachFunction("DK_PressKey", DKCefV8::PressKey);
	DKV8::AttachFunction("DK_PrintFunctions", DKCefV8::PrintFunctions);
	DKV8::AttachFunction("DK_ReleaseKey", DKCefV8::ReleaseKey);
	DKV8::AttachFunction("DK_Run", DKCefV8::Run);
	DKV8::AttachFunction("DK_RunJavascript", DKCefV8::RunJavascript);
	DKV8::AttachFunction("DK_SetClipboard", DKCefV8::SetClipboard);
	DKV8::AttachFunction("DK_SetClipboardFiles", DKCefV8::SetClipboardFiles);
	DKV8::AttachFunction("DK_ShowConsole", DKCefV8::ShowConsole);
	DKV8::AttachFunction("DK_StrokeKey", DKCefV8::StrokeKey);
	DKV8::AttachFunction("DK_System", DKCefV8::System);
	DKV8::AttachFunction("DK_WaitForImage", DKCefV8::WaitForImage);
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
bool DKCefV8::_DKCreate(CefArgs args, CefReturn retval)
{
	DKString data = args[0]->GetStringValue();
	DKLog("DKCefV8::DKCreate_CPP("+data+")\n", DKDEBUG);
	DKCreate(data);
	return true;
}

/////////////////////////////////////////////////////
bool DKCefV8::_SetLog(CefArgs args, CefReturn retval)
{
	//TODO
	int lvl = args[0]->GetIntValue();
	DKString string = args[1]->GetStringValue();
	SetLog(lvl, string);
	return true;
}

/////////////////////////////////////////////////////////
bool DKCefV8::_DKValid(CefArgs args, CefReturn retval)
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
	DKString result;
	if(!DKUtil::Execute(command, result)){ return false; }
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

////////////////////////////////////////////////////////////////
bool DKCefV8::GetPixelUnderMouse(CefArgs args, CefReturn retval)
{
	int mouseX = 0;
	int mouseY = 0;
	if (!DKUtil::GetMousePos(mouseX, mouseY)) { return false; }
	int r;
	int g;
	int b;
	if (!DKUtil::GetPixelFromScreen(mouseX, mouseY, r, g, b)) { return false; }
	DKString rgb = toString(r) + "," + toString(g) + "," + toString(b);
	retval = CefV8Value::CreateString(rgb);
	return true;
}

/////////////////////////////////////////////////////////////
bool DKCefV8::GetScreenHeight(CefArgs args, CefReturn retval)
{
	int output;
	if(DKClass::HasFunc("DKSDLWindow::GetScreenHeight")){
		DKClass::CallFunc("DKSDLWindow::GetScreenHeight", NULL, &output);
	}
	else if(DKClass::HasFunc("DKOSGWindow::GetScreenHeight")){
		DKClass::CallFunc("DKOSGWindow::GetScreenHeight", NULL, &output);
	}
	else{
		DKLog("DKJS::GetScreenHeight(): no function available \n", DKERROR);
		return false;
	}
	retval = CefV8Value::CreateInt(output);
	return true;
}

////////////////////////////////////////////////////////////
bool DKCefV8::GetScreenWidth(CefArgs args, CefReturn retval)
{
	int output;
	if(DKClass::HasFunc("DKSDLWindow::GetScreenWidth")){
		DKClass::CallFunc("DKSDLWindow::GetScreenWidth", NULL, &output);
	}
	else if(DKClass::HasFunc("DKOSGWindow::GetScreenWidth")){
		DKClass::CallFunc("DKOSGWindow::GetScreenWidth", NULL, &output);
	}
	else{
		DKLog("DKJS::GetScreenWidth(): no function available \n", DKERROR);
		return false;
	}
	retval = CefV8Value::CreateInt(output);
	return true;
}

/////////////////////////////////////////////////////////
bool DKCefV8::HideConsole(CefArgs args, CefReturn retval)
{
#ifdef WIN32
	HWND consoleWindow = GetConsoleWindow();
	ShowWindow(consoleWindow, SW_HIDE);
#endif 
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
#ifndef MAC
	DKLog("\n**** V8 Functions ****\n", DKINFO);
	typedef std::map<DKString, boost::function<bool(CefArgs, CefReturn)>>::iterator it_type;
	for (it_type iterator = DKV8::functions.begin(); iterator != DKV8::functions.end(); iterator++) {
		DKLog(iterator->first+"\n", DKINFO);
	}
	return true;
#endif 
	return false;
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

///////////////////////////////////////////////////////////////
bool DKCefV8::SetClipboardFiles(CefArgs args, CefReturn retval)
{
	DKString filelist = args[0]->GetStringValue();
	if(!DKUtil::SetClipboardFiles(filelist)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////
bool DKCefV8::ShowConsole(CefArgs args, CefReturn retval)
{
#ifdef WIN32
	HWND consoleWindow = GetConsoleWindow();
	ShowWindow(consoleWindow, SW_RESTORE);
#endif 
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

///////////////////////////////////////////////////////
bool DKCefV8::System(CefArgs args, CefReturn retval)
{
	DKString command = args[0]->GetStringValue();
	if(!DKUtil::System(command)){
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
