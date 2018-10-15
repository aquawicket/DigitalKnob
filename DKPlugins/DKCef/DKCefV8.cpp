//#ifdef USE_DKCef
#include "DKCef/DKCefV8.h"

////////////////////
bool DKCefV8::Init()
{
	DKClass::DKCreate("DKFileV8");
	DKClass::DKCreate("DKAssetsV8");
	
	DKV8::AttachFunction("TestFunction", DKCefV8::TestFunction);

	DKV8::AttachFunction("DKCreate_CPP", DKCefV8::_DKCreate);
	DKV8::AttachFunction("DKValid", DKCefV8::_DKValid);
	
	DKV8::AttachFunction("DK_Beep", DKCefV8::Beep);
	DKV8::AttachFunction("DK_ClickImage", DKCefV8::ClickImage);
	DKV8::AttachFunction("DK_CpuUsed", DKCefV8::CpuUsed);
	DKV8::AttachFunction("DK_CpuUsedByApp", DKCefV8::CpuUsedByApp);
	DKV8::AttachFunction("DK_DrawTextOnScreen", DKCefV8::DrawTextOnScreen);
	DKV8::AttachFunction("DK_Execute", DKCefV8::Execute);
	DKV8::AttachFunction("DK_Exit", DKCefV8::Exit);
	DKV8::AttachFunction("DK_GetClipboard", DKCefV8::GetClipboard);
	DKV8::AttachFunction("DK_GetFps", DKCefV8::GetFps);
	DKV8::AttachFunction("DK_GetFrames", DKCefV8::GetFrames);
	DKV8::AttachFunction("DK_GetLocalIP", DKCefV8::GetLocalIP);
	DKV8::AttachFunction("DK_GetMouseX", DKCefV8::GetMouseX);
	DKV8::AttachFunction("DK_GetMouseY", DKCefV8::GetMouseY);
	DKV8::AttachFunction("DK_GetPixelUnderMouse", DKCefV8::GetPixelUnderMouse);
	DKV8::AttachFunction("DK_GetScreenHeight", DKCefV8::GetScreenHeight);
	DKV8::AttachFunction("DK_GetScreenWidth", DKCefV8::GetScreenWidth);
	DKV8::AttachFunction("DK_GetTicks", DKCefV8::GetTicks);
	DKV8::AttachFunction("DK_GetVolume", DKCefV8::GetVolume);
	DKV8::AttachFunction("DK_HideConsole", DKCefV8::HideConsole);
	DKV8::AttachFunction("DK_LeftClick", DKCefV8::LeftClick);
	DKV8::AttachFunction("DK_LowPowerMonitor", DKCefV8::LowPowerMonitor);
	DKV8::AttachFunction("DK_PhysicalMemory", DKCefV8::PhysicalMemory);
	DKV8::AttachFunction("DK_PhysicalMemoryUsed", DKCefV8::PhysicalMemoryUsed);
	DKV8::AttachFunction("DK_PhysicalMemoryUsedByApp", DKCefV8::PhysicalMemoryUsedByApp);
	DKV8::AttachFunction("DK_PressKey", DKCefV8::PressKey);
	DKV8::AttachFunction("DK_PrintFunctions", DKCefV8::PrintFunctions);
	DKV8::AttachFunction("DK_QueueDuktape", DKCefV8::QueueDuktape);
	DKV8::AttachFunction("DK_ReleaseKey", DKCefV8::ReleaseKey);
	DKV8::AttachFunction("DK_Run", DKCefV8::Run);
	DKV8::AttachFunction("DK_RunDuktape", DKCefV8::RunDuktape);
	DKV8::AttachFunction("DK_SetBrightness", DKCefV8::SetBrightness);
	DKV8::AttachFunction("DK_SetClipboard", DKCefV8::SetClipboard);
	DKV8::AttachFunction("DK_SetClipboardFiles", DKCefV8::SetClipboardFiles);
	DKV8::AttachFunction("DK_SetClipboardImage", DKCefV8::SetClipboardImage);
	DKV8::AttachFunction("DK_SetFramerate", DKCefV8::SetFramerate);
	DKV8::AttachFunction("DK_SetLog", DKCefV8::_SetLog);
	DKV8::AttachFunction("DK_SetMousePos", DKCefV8::SetMousePos);
	DKV8::AttachFunction("DK_SetVolume", DKCefV8::SetVolume);
	DKV8::AttachFunction("DK_ShowConsole", DKCefV8::ShowConsole);
	DKV8::AttachFunction("DK_StrokeKey", DKCefV8::StrokeKey);
	DKV8::AttachFunction("DK_System", DKCefV8::System);
	DKV8::AttachFunction("DK_TurnOffMonitor", DKCefV8::TurnOffMonitor);
	DKV8::AttachFunction("DK_TurnOnMonitor", DKCefV8::TurnOnMonitor);
	DKV8::AttachFunction("DK_VirtualMemory", DKCefV8::VirtualMemory);
	DKV8::AttachFunction("DK_VirtualMemoryUsed", DKCefV8::VirtualMemoryUsed);
	DKV8::AttachFunction("DK_VirtualMemoryUsedByApp", DKCefV8::VirtualMemoryUsedByApp);
	DKV8::AttachFunction("DK_WaitForImage", DKCefV8::WaitForImage);

	//Cef js functions
	DKV8::AttachFunction("DKCef_CloseBrowser", DKCefV8::CloseBrowser);
	DKV8::AttachFunction("DKCef_CloseDevTools", DKCefV8::CloseDevTools);
	DKV8::AttachFunction("DKCef_Copy", DKCefV8::Copy);
	DKV8::AttachFunction("DKCef_CopyImage", DKCefV8::CopyImage);
	DKV8::AttachFunction("DKCef_Cut", DKCefV8::Cut);
	DKV8::AttachFunction("DKCef_DownloadUrl", DKCefV8::DownloadUrl);
	DKV8::AttachFunction("DKCef_FileDialog", DKCefV8::FileDialog);
	DKV8::AttachFunction("DKCef_Find", DKCefV8::Find);
	DKV8::AttachFunction("DKCef_Focused", DKCefV8::Focused);
	DKV8::AttachFunction("DKCef_GetBrowsers", DKCefV8::GetBrowsers);
	DKV8::AttachFunction("DKCef_GetCurrentBrowser", DKCefV8::GetCurrentBrowser);
	DKV8::AttachFunction("DKCef_GetPageSource", DKCefV8::GetPageSource);
	DKV8::AttachFunction("DKCef_GetUrl", DKCefV8::GetUrl);
	DKV8::AttachFunction("DKCef_GoBack", DKCefV8::GoBack);
	DKV8::AttachFunction("DKCef_GoForward", DKCefV8::GoForward);
	DKV8::AttachFunction("DKCef_NewBrowser", DKCefV8::NewBrowser);
	DKV8::AttachFunction("DKCef_Paste", DKCefV8::Paste);
	DKV8::AttachFunction("DKCef_Popup", DKCefV8::Popup);
	DKV8::AttachFunction("DKCef_Print", DKCefV8::Print);
	DKV8::AttachFunction("DKCef_Reload", DKCefV8::Reload);
	DKV8::AttachFunction("DKCef_RemoveFocus", DKCefV8::RemoveFocus);
	DKV8::AttachFunction("DKCef_RunJavascript", DKCefV8::RunJavascript);
	DKV8::AttachFunction("DKCef_SelectBrowser", DKCefV8::SelectBrowser);
	DKV8::AttachFunction("DKCef_SetFocus", DKCefV8::SetFocus);
	DKV8::AttachFunction("DKCef_SetUrl", DKCefV8::SetUrl);
	DKV8::AttachFunction("DKCef_ShowDevTools", DKCefV8::ShowDevTools);
	DKV8::AttachFunction("DKCef_Stop", DKCefV8::Stop);
	DKV8::AttachFunction("DKCef_ViewPageSource", DKCefV8::ViewPageSource);

	return true;
}

///////////////////
bool DKCefV8::End()
{
	return true;
}


//////////////////////////////////////////////////////////
bool DKCefV8::TestFunction(CefArgs args, CefReturn retval)
{
	int num = args->GetInt(0);
	bool yn = args->GetBool(1);
	DKString text = args->GetString(2);
	DKLog("DKCefV8::TestFunction("+toString(num)+","+toString(yn)+","+text+")\n", DKINFO);
	DKString result = "test string";
	if(!retval->SetString(0, result)){ return false; }
	return true;
}

//////////////////////////////////////////////////////////
bool DKCefV8::_DKCreate(CefArgs args, CefReturn retval)
{
	DKString data = args->GetString(0);
	DKLog("DKCefV8::DKCreate_CPP("+data+")\n", DKDEBUG);
	DKClass::DKCreate(data);
	return true;
}

//////////////////////////////////////////////////////
bool DKCefV8::_DKValid(CefArgs args, CefReturn retval)
{
	DKString data = args->GetString(0);
	bool valid = DKClass::DKValid(data);
	if(!valid){
		retval->SetBool(0, false); 
		return true;
	}
	if(!retval->SetBool(0, true)){ return false; } 
	return true;
}



//////////////////////////////////////////////////
bool DKCefV8::Beep(CefArgs args, CefReturn retval)
{
	DKUtil::Beep();
	return true;
}

////////////////////////////////////////////////////////
bool DKCefV8::ClickImage(CefArgs args, CefReturn retval)
{
	DKString file = args->GetString(0);
	int x;
	int y;
	if(!DKUtil::FindImageOnScreen(file, x, y)){ return false; }
	if(!DKUtil::SetMousePos(x, y)){ return false; }
	if(!DKUtil::LeftClick()){ return false; }
	retval->SetBool(0, true);
	return true;
}

//////////////////////////////////////////////////////////////
bool DKCefV8::DrawTextOnScreen(CefArgs args, CefReturn retval)
{
	DKString text = args->GetString(0);
	if(!DKUtil::DrawTextOnScreen(text)){ 
		retval->SetBool(0, false);
		return false; 
	}
	retval->SetBool(0, true);
	return true;
}

/////////////////////////////////////////////////////
bool DKCefV8::_SetLog(CefArgs args, CefReturn retval)
{
	//TODO
	int lvl = args->GetInt(0);
	DKString string = args->GetString(1);
	SetLog(lvl, string);
	return true;
}

/////////////////////////////////////////////////////
bool DKCefV8::Execute(CefArgs args, CefReturn retval)
{
	DKString command = args->GetString(0);
	DKString result;
	if(!DKUtil::Execute(command, result)){ return false; }
	if(!retval->SetString(0, result)){ return false; }
	return true;
}

//////////////////////////////////////////////////
bool DKCefV8::Exit(CefArgs args, CefReturn retval)
{
	DKApp::Exit();
	return true;
}

//////////////////////////////////////////////////////////
bool DKCefV8::GetClipboard(CefArgs args, CefReturn retval)
{
	DKString string;
	if(!DKUtil::GetClipboard(string)){ return false; }
	if(!retval->SetString(0, string)){ return false; } 
	return true;
}

////////////////////////////////////////////////////////
bool DKCefV8::GetLocalIP(CefArgs args, CefReturn retval)
{
	DKString ip;
	if(!DKUtil::GetLocalIP(ip)){ return false; }
	if(!retval->SetString(0, ip)){ return false; } 
	return true;
}

///////////////////////////////////////////////////////
bool DKCefV8::GetMouseX(CefArgs args, CefReturn retval)
{
	int mouseX = 0;
	int mouseY = 0;
	if(!DKUtil::GetMousePos(mouseX, mouseY)){ return false; }
	if(!retval->SetInt(0, mouseX)){ return false; } 
	return true;
}

///////////////////////////////////////////////////////
bool DKCefV8::GetMouseY(CefArgs args, CefReturn retval)
{
	int mouseX = 0;
	int mouseY = 0;
	if(!DKUtil::GetMousePos(mouseX, mouseY)){ return false; }
	if(!retval->SetInt(0, mouseY)){ return false; } 
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
	if(!retval->SetString(0, rgb)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////
bool DKCefV8::GetScreenHeight(CefArgs args, CefReturn retval)
{
	int h;
	if(!DKUtil::GetScreenHeight(h)){ return false; }
	if(!retval->SetInt(0, h)){ return false; }
	return true;
}

////////////////////////////////////////////////////////////
bool DKCefV8::GetScreenWidth(CefArgs args, CefReturn retval)
{
	int w;
	if(!DKUtil::GetScreenWidth(w)){ return false; }
	if(!retval->SetInt(0, w)){ return false; }
	return true;
}

///////////////////////////////////////////////////////
bool DKCefV8::GetVolume(CefArgs args, CefReturn retval)
{
	int percent;
	if(!DKUtil::GetVolume(percent)){ return false; }
	DKLog("DKCefV8::GetVolume(): volume ="+toString(percent)+"\n", DKINFO);
	if(!retval->SetInt(0, percent)){ return false; }
	return 1;
}

///////////////////////////////////////////////////////
bool DKCefV8::SetVolume(CefArgs args, CefReturn retval)
{
	int percent = args->GetInt(0);
	DKLog("DKCefV8::SetVolume(): volume ="+toString(percent)+"\n", DKINFO);
	if(!DKUtil::SetVolume(percent)){ return false; }
	return 1;
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

///////////////////////////////////////////////////////
bool DKCefV8::LeftClick(CefArgs args, CefReturn retval)
{
	return DKUtil::LeftClick();
}

//////////////////////////////////////////////////////
bool DKCefV8::PressKey(CefArgs args, CefReturn retval)
{
	int key = args->GetInt(0);
	return DKUtil::PressKey(key);
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

//////////////////////////////////////////////////////////
bool DKCefV8::QueueDuktape(CefArgs args, CefReturn retval)
{
	DKString code = args->GetString(0);
	if(!DKCef::QueueDuktape(code)){ return false; }
	return true;
}

////////////////////////////////////////////////////////
bool DKCefV8::ReleaseKey(CefArgs args, CefReturn retval)
{
	int key = args->GetInt(0);
	return DKUtil::ReleaseKey(key);
}

/////////////////////////////////////////////////
bool DKCefV8::Run(CefArgs args, CefReturn retval)
{
	DKString command = args->GetString(0);
	DKString params = args->GetString(1);
	return DKUtil::Run(command, params);
}

////////////////////////////////////////////////////////
bool DKCefV8::RunDuktape(CefArgs args, CefReturn retval)
{
	DKString code = args->GetString(0);
	if(!DKCef::RunDuktape(code)){ 
		DKLog("DKCefV8::RunDuktape(): DKCef::RunDuktape(code) failed", DKWARN);
		return false; 
	}
	/*
	DKString rval;
	if(!DKCef::RunDuktape(code, rval)){
		DKLog("DKCefV8::RunDuktape():  DKCef::RunDuktape(code, rval) failed", DKWARN);
		return false; 
	}
	if(!rval.empty()){
		if(!retval->SetString(0, rval)){ 
			DKLog("DKCefV8::RunDuktape() retval->SetString(0, rval) failed", DKWARN);
			return false; 
		}
	}
	*/
	return true;
}

//////////////////////////////////////////////////////////
bool DKCefV8::SetBrightness(CefArgs args, CefReturn retval)
{
	int percent = args->GetInt(0);
	return DKUtil::SetBrightness(percent);
}

//////////////////////////////////////////////////////////
bool DKCefV8::SetClipboard(CefArgs args, CefReturn retval)
{
	DKString string = args->GetString(0);
	return DKUtil::SetClipboard(string);
}

///////////////////////////////////////////////////////////////
bool DKCefV8::SetClipboardFiles(CefArgs args, CefReturn retval)
{
	DKString filelist = args->GetString(0);
	return DKUtil::SetClipboardFiles(filelist);
}

///////////////////////////////////////////////////////////////
bool DKCefV8::SetClipboardImage(CefArgs args, CefReturn retval)
{
	DKString file = args->GetString(0);
	return DKUtil::SetClipboardImage(file);
}

/////////////////////////////////////////////////////////
bool DKCefV8::SetMousePos(CefArgs args, CefReturn retval)
{
	int x = args->GetInt(0);
	int y = args->GetInt(1);
	return DKUtil::SetMousePos(x,y);
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
	int key = args->GetInt(0);
	return DKUtil::StrokeKey(key);
}

///////////////////////////////////////////////////////
bool DKCefV8::System(CefArgs args, CefReturn retval)
{
	DKString command = args->GetString(0);
	return DKUtil::System(command);
}

//////////////////////////////////////////////////////////
bool DKCefV8::WaitForImage(CefArgs args, CefReturn retval)
{
	DKString file = args->GetString(0);
	int timeout = args->GetInt(1);
	if(!DKUtil::WaitForImage(file, timeout)){
		retval->SetBool(0, false); 
		return false;
	}
	if(!retval->SetBool(0, true)){ return false; }
	return true;
}

//////////////////////////////////////////////////////////
bool DKCefV8::SetFramerate(CefArgs args, CefReturn retval)
{
	int fps = args->GetInt(0);
	DKUtil::SetFramerate(fps);
	return true;
}

////////////////////////////////////////////////////
bool DKCefV8::GetFps(CefArgs args, CefReturn retval)
{
	unsigned int fps;
	DKUtil::GetFps(fps);
	if(!retval->SetInt(0, fps)){ return false; }
	return true;
}

//https://stackoverflow.com/questions/63166/how-to-determine-cpu-and-memory-consumption-from-inside-a-process
///////////////////////////////////////////////////////////
bool DKCefV8::VirtualMemory(CefArgs args, CefReturn retval)
{
	unsigned long long virtualMemory;
	if(!DKUtil::VirtualMemory(virtualMemory)){ return false; }
	if(!retval->SetInt(0, (int)virtualMemory)){ return false; }
	return true;
}

///////////////////////////////////////////////////////////////
bool DKCefV8::VirtualMemoryUsed(CefArgs args, CefReturn retval)
{
	unsigned long long virtualMemory;
	if(!DKUtil::VirtualMemoryUsed(virtualMemory)){ return false; }
	if(!retval->SetInt(0, (int)virtualMemory)){ return false; }
	return true;
}

////////////////////////////////////////////////////////////////////
bool DKCefV8::VirtualMemoryUsedByApp(CefArgs args, CefReturn retval)
{
	unsigned int virtualMemory;
	if(!DKUtil::VirtualMemoryUsedByApp(virtualMemory)){ return false; }
	if(!retval->SetInt(0, (int)virtualMemory)){ return false; }
	return true;
}

////////////////////////////////////////////////////////////
bool DKCefV8::PhysicalMemory(CefArgs args, CefReturn retval)
{
	unsigned long long physicalMemory;
	if(!DKUtil::PhysicalMemory(physicalMemory)){ return false; }
	if(!retval->SetInt(0, (int)physicalMemory)){ return false; }
	return true;
}

////////////////////////////////////////////////////////////////
bool DKCefV8::PhysicalMemoryUsed(CefArgs args, CefReturn retval)
{
	unsigned long long physicalMemory;
	if(!DKUtil::PhysicalMemoryUsed(physicalMemory)){ return false; }
	if(!retval->SetInt(0, (int)physicalMemory)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////////////
bool DKCefV8::PhysicalMemoryUsedByApp(CefArgs args, CefReturn retval)
{
	unsigned int physicalMemory;
	if(!DKUtil::PhysicalMemoryUsedByApp(physicalMemory)){ return false; }
	if(!retval->SetInt(0, (int)physicalMemory)){ return false; }
	return true;
}

/////////////////////////////////////////////////////
bool DKCefV8::CpuUsed(CefArgs args, CefReturn retval)
{
	int cpu;
	if(!DKUtil::CpuUsed(cpu)){ return false; }
	if(!retval->SetInt(0, cpu)){ return false; }
	return true;
}

//////////////////////////////////////////////////////////
bool DKCefV8::CpuUsedByApp(CefArgs args, CefReturn retval)
{
	int cpu;
	if(!DKUtil::CpuUsedByApp(cpu)){ return false; }
	if(!retval->SetInt(0, cpu)){ return false; }
	return true;
}

////////////////////////////////////////////////////////////
bool DKCefV8::TurnOffMonitor(CefArgs args, CefReturn retval)
{
	if(!DKUtil::TurnOffMonitor()){ return false; }
	return true;
}

///////////////////////////////////////////////////////////
bool DKCefV8::TurnOnMonitor(CefArgs args, CefReturn retval)
{
	if(!DKUtil::TurnOnMonitor()){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////
bool DKCefV8::LowPowerMonitor(CefArgs args, CefReturn retval)
{
	if(!DKUtil::LowPowerMonitor()){ return false; }
	return true;
}

//////////////////////////////////////////////////////
bool DKCefV8::GetTicks(CefArgs args, CefReturn retval)
{
	long ticks;
	if(!DKUtil::GetTicks(ticks)){ return false; }
	if(!retval->SetInt(0, (int)ticks)){ return false; }
	return true;
}

///////////////////////////////////////////////////////
bool DKCefV8::GetFrames(CefArgs args, CefReturn retval)
{
	long frames;
	if(!DKUtil::GetFrames(frames)){ return false; }
	if(!retval->SetInt(0, (int)frames)){ return false; }
	return true;
}






//CEF js functions
//////////////////////////////////////////////////////////
bool DKCefV8::CloseBrowser(CefArgs args, CefReturn retval)
{
	int browser = args->GetInt(0);
	if(!DKCef::CloseBrowser(browser)){ return false; }
	return true;
}

///////////////////////////////////////////////////////////
bool DKCefV8::CloseDevTools(CefArgs args, CefReturn retval)
{
	int browser = args->GetInt(0);
	if(!DKCef::CloseDevTools(browser)){ return false; }
	return true;
}

//////////////////////////////////////////////////
bool DKCefV8::Copy(CefArgs args, CefReturn retval)
{
	if(!DKCef::Copy()){ return false; }
	return true;
}

///////////////////////////////////////////////////////
bool DKCefV8::CopyImage(CefArgs args, CefReturn retval)
{
	DKString url = args->GetString(0);
	if(!DKCef::CopyImage(url)){ return false; }
	return true;
}

/////////////////////////////////////////////////
bool DKCefV8::Cut(CefArgs args, CefReturn retval)
{
	if(!DKCef::Cut()){ return false; }
	return true;
}

/////////////////////////////////////////////////////////
bool DKCefV8::DownloadUrl(CefArgs args, CefReturn retval)
{
	DKString url = args->GetString(0);
	if(!DKCef::DownloadUrl(url)){ return false; }
	return true;
}

////////////////////////////////////////////////////////
bool DKCefV8::FileDialog(CefArgs args, CefReturn retval)
{
	DKString type = args->GetString(0);
	DKString title = args->GetString(1);
	if(!DKCef::FileDialog(type,title)){ return false; }
	return true;
}

//////////////////////////////////////////////////
bool DKCefV8::Find(CefArgs args, CefReturn retval)
{
	int browser = args->GetInt(0);
	DKString text = args->GetString(1);
	if(!DKCef::Find(browser, text)){ return false; }
	return true;
}

/////////////////////////////////////////////////////
bool DKCefV8::Focused(CefArgs args, CefReturn retval)
{
	bool focused = DKCef::inFocus;
	if(!focused){ return false; }
	if(!retval->SetBool(0, true)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////
bool DKCefV8::GetBrowsers(CefArgs args, CefReturn retval)
{
	int num;
	if(!DKCef::GetBrowsers(num)){ return false; }
	if(!retval->SetInt(0, num)){ return false; }
	return true;
}

///////////////////////////////////////////////////////////////
bool DKCefV8::GetCurrentBrowser(CefArgs args, CefReturn retval)
{
	int browser;
	if(!DKCef::GetCurrentBrowser(browser)){ return false; }
	if(!retval->SetInt(0, browser)){ return false; }
	return true;
}

///////////////////////////////////////////////////////////
bool DKCefV8::GetPageSource(CefArgs args, CefReturn retval)
{
	//DKLog("DKCefV8::GetPageSource()\n", DKDEBUG);
	int browser = args->GetInt(0);
	DKString source;
	if(!DKCef::GetPageSource(browser, source)){ return false; }
	if(!source.empty()){ 
		if(!retval->SetString(0, source)){ return false; }
	}
	return true;
}

////////////////////////////////////////////////////
bool DKCefV8::GetUrl(CefArgs args, CefReturn retval)
{
	//DKLog("DKCefV8::GetUrl()\n", DKINFO);
	int browser = args->GetInt(0);
	DKString url;
	if(!DKCef::GetUrl(browser, url)){ return false; }
	if(!url.empty()){ 
		if(!retval->SetString(0, url)){ return false; }
	}
	return true;
}

////////////////////////////////////////////////////
bool DKCefV8::GoBack(CefArgs args, CefReturn retval)
{
	int browser = args->GetInt(0);
	if(!DKCef::GoBack(browser)){ return false; }
	return true;
}

///////////////////////////////////////////////////////
bool DKCefV8::GoForward(CefArgs args, CefReturn retval)
{
	int browser = args->GetInt(0);
	if(!DKCef::GoForward(browser)){ return false; }
	return true;
}

////////////////////////////////////////////////////////
bool DKCefV8::NewBrowser(CefArgs args, CefReturn retval)
{
	if(!DKCef::NewBrowser()){ return false; }
	return true;
}

///////////////////////////////////////////////////
bool DKCefV8::Paste(CefArgs args, CefReturn retval)
{
	if(!DKCef::Paste()){ return false; }
	return true;
}

///////////////////////////////////////////////////
bool DKCefV8::Popup(CefArgs args, CefReturn retval)
{
	DKString url = args->GetString(0);
	if(!DKCef::Popup(url)){ return false; }
	return true;
}

///////////////////////////////////////////////////
bool DKCefV8::Print(CefArgs args, CefReturn retval)
{
	int browser = args->GetInt(0);
	if(!DKCef::Print(browser)){ return false; }
	return true;
}

////////////////////////////////////////////////////
bool DKCefV8::Reload(CefArgs args, CefReturn retval)
{
	int browser = args->GetInt(0);
	if(!DKCef::Reload(browser)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////
bool DKCefV8::RemoveFocus(CefArgs args, CefReturn retval)
{
	DKCef::current_browser->GetHost()->SendFocusEvent(false);
	DKCef::inFocus = false;
	return true;
}

///////////////////////////////////////////////////////////
bool DKCefV8::RunJavascript(CefArgs args, CefReturn retval)
{
	int browser = args->GetInt(0);
	DKString code = args->GetString(1);
	if(!DKCef::RunJavascript(browser, code)){ return false; }
	return true;
}

///////////////////////////////////////////////////////////
bool DKCefV8::SelectBrowser(CefArgs args, CefReturn retval)
{
	int browser = args->GetInt(0);
	if(!DKCef::SelectBrowser(browser)){ return false; }
	return true;
}

//////////////////////////////////////////////////////
bool DKCefV8::SetFocus(CefArgs args, CefReturn retval)
{
	//if(!DKCef::Valid("")){ return false; }
	if(!DKCef::current_browser){ return false; }
	if(!DKCef::current_browser->GetHost()){ return false; }
	DKCef::current_browser->GetHost()->SendFocusEvent(true);
	DKCef::inFocus = true;
	return true;
}

////////////////////////////////////////////////////
bool DKCefV8::SetUrl(CefArgs args, CefReturn retval)
{
	int browser = args->GetInt(0);
	DKString url = args->GetString(1);
	if(!DKCef::SetUrl(browser, url)){ return false; }
	return true;
}

//////////////////////////////////////////////////////////
bool DKCefV8::ShowDevTools(CefArgs args, CefReturn retval)
{
	int browser = args->GetInt(0);
	if(!DKCef::ShowDevTools(browser)){ return false; }
	return true;
}

//////////////////////////////////////////////////
bool DKCefV8::Stop(CefArgs args, CefReturn retval)
{
	int browser = args->GetInt(0);
	if(!DKCef::Stop(browser)){ return false; }
	return true;
}

////////////////////////////////////////////////////////////
bool DKCefV8::ViewPageSource(CefArgs args, CefReturn retval)
{
	//DKLog("DKCefV8::ViewPageSource()\n", DKDEBUG);
	int browser = args->GetInt(0);
	if(!DKCef::ViewPageSource(browser)){ return false; }
	return true;
}

//#endif //USE_DKCef