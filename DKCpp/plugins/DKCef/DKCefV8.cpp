/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
<<<<<<< HEAD:DKPlugins/DKCef/DKCefV8.cpp
* Copyright(c) 2010 - 2024 Digitalknob Team, and contributors
=======
* Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
>>>>>>> Development:DKCpp/plugins/DKCef/DKCefV8.cpp
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

//https://stackoverflow.com/questions/63166/how-to-determine-cpu-and-memory-consumption-from-inside-a-process

//#if HAVE_DKCef
#include "DKDuktape/DKDuktape.h"
#include "DKCef/DKCefV8.h"

bool DKCefV8::Init()
{
	DKClass::DKCreate("DKFileV8");
	DKClass::DKCreate("DKAssetsV8");
	
	DKV8::AttachFunction("TestFunction", DKCefV8::TestFunction);
	DKV8::AttachFunction("CPP_DK_Create", DKCefV8::_DKCreate);
	DKV8::AttachFunction("CPP_DK_SetLog", DKCefV8::_SetLog);
	DKV8::AttachFunction("CPP_DK_Valid", DKCefV8::_DKValid);
	DKV8::AttachFunction("CPP_DK_Beep", DKCefV8::Beep);
	DKV8::AttachFunction("CPP_DK_ClickImage", DKCefV8::ClickImage);
	DKV8::AttachFunction("CPP_DK_CpuUsed", DKCefV8::CpuUsed);
	DKV8::AttachFunction("CPP_DK_CpuUsedByApp", DKCefV8::CpuUsedByApp);
	DKV8::AttachFunction("CPP_DK_DrawTextOnScreen", DKCefV8::DrawTextOnScreen);
	DKV8::AttachFunction("CPP_DK_Execute", DKCefV8::Execute);
	DKV8::AttachFunction("CPP_DK_Exit", DKCefV8::Exit);
	DKV8::AttachFunction("CPP_DK_GetClipboard", DKCefV8::GetClipboard);
	DKV8::AttachFunction("CPP_DK_GetFps", DKCefV8::GetFps);
	DKV8::AttachFunction("CPP_DK_GetFrames", DKCefV8::GetFrames);
	DKV8::AttachFunction("CPP_DK_GetFunctions", DKCefV8::GetFunctions);
	DKV8::AttachFunction("CPP_DK_GetLocalIP", DKCefV8::GetLocalIP);
	DKV8::AttachFunction("CPP_DK_GetMouseX", DKCefV8::GetMouseX);
	DKV8::AttachFunction("CPP_DK_GetMouseY", DKCefV8::GetMouseY);
	DKV8::AttachFunction("CPP_DK_GetPixelUnderMouse", DKCefV8::GetPixelUnderMouse);
	DKV8::AttachFunction("CPP_DK_GetScreenHeight", DKCefV8::GetScreenHeight);
	DKV8::AttachFunction("CPP_DK_GetScreenWidth", DKCefV8::GetScreenWidth);
	DKV8::AttachFunction("CPP_DK_GetTicks", DKCefV8::GetTicks);
	DKV8::AttachFunction("CPP_DK_GetVolume", DKCefV8::GetVolume);
	DKV8::AttachFunction("CPP_DK_HideConsole", DKCefV8::HideConsole);
	DKV8::AttachFunction("CPP_DK_LeftClick", DKCefV8::LeftClick);
	DKV8::AttachFunction("CPP_DK_LowPowerMonitor", DKCefV8::LowPowerMonitor);
	DKV8::AttachFunction("CPP_DK_PhysicalMemory", DKCefV8::PhysicalMemory);
	DKV8::AttachFunction("CPP_DK_PhysicalMemoryUsed", DKCefV8::PhysicalMemoryUsed);
	DKV8::AttachFunction("CPP_DK_PhysicalMemoryUsedByApp", DKCefV8::PhysicalMemoryUsedByApp);
	DKV8::AttachFunction("CPP_DK_PressKey", DKCefV8::PressKey);
	DKV8::AttachFunction("CPP_DK_QueueDuktape", DKCefV8::QueueDuktape);
	DKV8::AttachFunction("CPP_DK_ReleaseKey", DKCefV8::ReleaseKey);
	DKV8::AttachFunction("CPP_DK_Reload", DKCefV8::_Reload);
	DKV8::AttachFunction("CPP_DK_Run", DKCefV8::Run);
	DKV8::AttachFunction("CPP_DK_RunDuktape", DKCefV8::RunDuktape);
	DKV8::AttachFunction("CPP_DK_SetBrightness", DKCefV8::SetBrightness);
	DKV8::AttachFunction("CPP_DK_SetClipboard", DKCefV8::SetClipboard);
	DKV8::AttachFunction("CPP_DK_SetClipboardFiles", DKCefV8::SetClipboardFiles);
	DKV8::AttachFunction("CPP_DK_SetClipboardImage", DKCefV8::SetClipboardImage);
	DKV8::AttachFunction("CPP_DK_SetFramerate", DKCefV8::SetFramerate);
	DKV8::AttachFunction("CPP_DK_SetMousePos", DKCefV8::SetMousePos);
	DKV8::AttachFunction("CPP_DK_SetVolume", DKCefV8::SetVolume);
	DKV8::AttachFunction("CPP_DK_ShowConsole", DKCefV8::ShowConsole);
	DKV8::AttachFunction("CPP_DK_StrokeKey", DKCefV8::StrokeKey);
	DKV8::AttachFunction("CPP_DK_System", DKCefV8::System);
	DKV8::AttachFunction("CPP_DK_TurnOffMonitor", DKCefV8::TurnOffMonitor);
	DKV8::AttachFunction("CPP_DK_TurnOnMonitor", DKCefV8::TurnOnMonitor);
	DKV8::AttachFunction("CPP_DK_VirtualMemory", DKCefV8::VirtualMemory);
	DKV8::AttachFunction("CPP_DK_VirtualMemoryUsed", DKCefV8::VirtualMemoryUsed);
	DKV8::AttachFunction("CPP_DK_VirtualMemoryUsedByApp", DKCefV8::VirtualMemoryUsedByApp);
	DKV8::AttachFunction("CPP_DK_WaitForImage", DKCefV8::WaitForImage);

	//Cef js functions
	DKV8::AttachFunction("CPP_DKCef_CloseBrowser", DKCefV8::CloseBrowser);
	DKV8::AttachFunction("CPP_DKCef_CloseDevTools", DKCefV8::CloseDevTools);
	DKV8::AttachFunction("CPP_DKCef_Copy", DKCefV8::Copy);
	DKV8::AttachFunction("CPP_DKCef_CopyImage", DKCefV8::CopyImage);
	DKV8::AttachFunction("CPP_DKCef_Cut", DKCefV8::Cut);
	DKV8::AttachFunction("CPP_DKCef_DownloadUrl", DKCefV8::DownloadUrl);
	DKV8::AttachFunction("CPP_DKCef_FileDialog", DKCefV8::FileDialog);
	DKV8::AttachFunction("CPP_DKCef_Find", DKCefV8::Find);
	DKV8::AttachFunction("CPP_DKCef_GetBrowserId", DKCefV8::GetBrowserId);
	DKV8::AttachFunction("CPP_DKCef_GetBrowsers", DKCefV8::GetBrowsers);
	DKV8::AttachFunction("CPP_DKCef_GetCurrentBrowser", DKCefV8::GetCurrentBrowser);
	DKV8::AttachFunction("CPP_DKCef_GetPageSource", DKCefV8::GetPageSource);
	DKV8::AttachFunction("CPP_DKCef_GetUrl", DKCefV8::GetUrl);
	DKV8::AttachFunction("CPP_DKCef_GoBack", DKCefV8::GoBack);
	DKV8::AttachFunction("CPP_DKCef_GoForward", DKCefV8::GoForward);
	DKV8::AttachFunction("CPP_DKCef_NewBrowser", DKCefV8::NewBrowser);
	DKV8::AttachFunction("CPP_DKCef_Paste", DKCefV8::Paste);
	DKV8::AttachFunction("CPP_DKCef_Popup", DKCefV8::Popup);
	DKV8::AttachFunction("CPP_DKCef_Print", DKCefV8::Print);
	DKV8::AttachFunction("CPP_DKCef_Reload", DKCefV8::Reload);
	DKV8::AttachFunction("CPP_DKCef_RemoveFocus", DKCefV8::RemoveFocus);
	DKV8::AttachFunction("CPP_DKCef_RunJavascript", DKCefV8::RunJavascript);
	DKV8::AttachFunction("CPP_DKCef_SetFocus", DKCefV8::SetFocus);
	DKV8::AttachFunction("CPP_DKCef_SetKeyboardFocus", DKCefV8::SetKeyboardFocus);
	DKV8::AttachFunction("CPP_DKCef_SetUrl", DKCefV8::SetUrl);
	DKV8::AttachFunction("CPP_DKCef_ShowDevTools", DKCefV8::ShowDevTools);
	DKV8::AttachFunction("CPP_DKCef_Stop", DKCefV8::Stop);
	DKV8::AttachFunction("CPP_DKCef_ViewPageSource", DKCefV8::ViewPageSource);
	return true;
}

bool DKCefV8::End(){
	return true;
}

bool DKCefV8::TestFunction(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	int num = args->GetInt(0);
	bool yn = args->GetBool(1);
	DKString text = args->GetString(2);
	DKINFO("DKCefV8::TestFunction("+toString(num)+","+toString(yn)+","+text+")\n");
	DKString result = "test string";
	if(!retval->SetString(0, result)){ return false; }
	return true;
}

bool DKCefV8::_DKCreate(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString data = args->GetString(0);
	DKClass::DKCreate(data);
	return true;
}

bool DKCefV8::_Reload(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKDuktape::Reload();
	return 1;
}

bool DKCefV8::_SetLog(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	int lvl = args->GetInt(0);
	DKString string = args->GetString(1);
	DKLog::SetLog(lvl, string);
	return true;
}

bool DKCefV8::_DKValid(CefArgs args, CefReturn retval){
	DKString data = args->GetString(0);
	bool valid = DKClass::DKValid(data);
	if(!valid){
		retval->SetBool(0, false); 
		return true;
	}
	if(!retval->SetBool(0, true)){ return false; } 
	return true;
}


bool DKCefV8::Beep(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKUtil::Beep();
	return true;
}

bool DKCefV8::ClickImage(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString file = args->GetString(0);
	int x;
	int y;
	if(!DKUtil::FindImageOnScreen(file, x, y)){ return false; }
	if(!DKUtil::SetMousePos(x, y)){ return false; }
	if(!DKUtil::LeftClick()){ return false; }
	retval->SetBool(0, true);
	return true;
}

bool DKCefV8::CpuUsed(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	int cpu;
	if(!DKUtil::CpuUsed(cpu)){ return false; }
	if(!retval->SetInt(0, cpu)){ return false; }
	return true;
}

bool DKCefV8::CpuUsedByApp(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	int cpu;
	if(!DKUtil::CpuUsedByApp(cpu)){ return false; }
	if(!retval->SetInt(0, cpu)){ return false; }
	return true;
}

bool DKCefV8::DrawTextOnScreen(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString text = args->GetString(0);
	if(!DKUtil::DrawTextOnScreen(text)){ 
		retval->SetBool(0, false);
		return false; 
	}
	retval->SetBool(0, true);
	return true;
}

bool DKCefV8::Execute(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString command = args->GetString(0);
	DKString mode = "r"; //default
	if (args->GetType(1))
		mode = args->GetString(1);
	DKString stdouterr;
	int rtncode;
	if (!DKUtil::Execute(command, mode, stdouterr, rtncode))
		return DKERROR("DKUtil::Execute() failed");
<<<<<<< HEAD:DKPlugins/DKCef/DKCefV8.cpp
	if (rtncode == 0) {
=======
	if (rtncode == 0){
>>>>>>> Development:DKCpp/plugins/DKCef/DKCefV8.cpp
		if (!retval->SetString(0, stdouterr))
			return DKERROR("SetString failed");
	}
	else {
		// jsonRetrun = "{'rtncode':0, 'stdouterr':'the stdouterr string'}"
		DKString jsonReturn = "{'rtncode':" + toString(rtncode) + ",'stdouterr':" + stdouterr + "}";
		if (!retval->SetString(0, jsonReturn))
			return DKERROR("SetString failed");
		//DKERROR(jsonReturn + "\n");
		//DKERROR("CPP_DK_EXECUTE() now returns json on rtncode error. Adjust your return variable accordingly\n");
	}
	return true;
}

bool DKCefV8::Exit(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKApp::Exit();
	return true;
}

bool DKCefV8::GetClipboard(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString string;
	if(!DKUtil::GetClipboard(string)){ return false; }
	if(!retval->SetString(0, string)){ return false; } 
	return true;
}

bool DKCefV8::GetFps(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	unsigned int fps;
	DKUtil::GetFps(fps);
	if(!retval->SetInt(0, fps)){ return false; }
	return true;
}

bool DKCefV8::GetFrames(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	unsigned long frames;
	if(!DKUtil::GetFrames(frames)){ return false; }
	if(!retval->SetInt(0, (int)frames)){ return false; }
	return true;
}

bool DKCefV8::GetFunctions(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
#ifndef MAC
	DKStringArray list;
	//typedef std::map<DKString, boost::function<bool(CefArgs, CefReturn)>>::iterator it_type;
	typedef std::map<DKString, std::function<bool(CefArgs, CefReturn)>>::iterator it_type;
	for(it_type iterator = DKV8::functions.begin(); iterator != DKV8::functions.end(); iterator++){
		list.push_back(iterator->first);
	}
	DKString str = toString(list, ",");
	if(!retval->SetString(0, str)){ return false; }
	return true;
#endif 
	return false;
}

bool DKCefV8::GetLocalIP(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString ip;
	if(!DKUtil::GetLocalIP(ip)){ return false; }
	if(!retval->SetString(0, ip)){ return false; } 
	return true;
}

bool DKCefV8::GetMouseX(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	int mouseX = 0;
	int mouseY = 0;
	if(!DKUtil::GetMousePos(mouseX, mouseY)){ return false; }
	if(!retval->SetInt(0, mouseX)){ return false; } 
	return true;
}

bool DKCefV8::GetMouseY(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	int mouseX = 0;
	int mouseY = 0;
	if(!DKUtil::GetMousePos(mouseX, mouseY)){ return false; }
	if(!retval->SetInt(0, mouseY)){ return false; } 
	return true;
}

bool DKCefV8::GetPixelUnderMouse(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	int mouseX = 0;
	int mouseY = 0;
	if (!DKUtil::GetMousePos(mouseX, mouseY)){ return false; }
	int r;
	int g;
	int b;
	if (!DKUtil::GetPixelFromScreen(mouseX, mouseY, r, g, b)){ return false; }
	DKString rgb = toString(r) + "," + toString(g) + "," + toString(b);
	if(!retval->SetString(0, rgb)){ return false; }
	return true;
}

bool DKCefV8::GetScreenHeight(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	int h;
	if(!DKUtil::GetScreenHeight(h)){ return false; }
	if(!retval->SetInt(0, h)){ return false; }
	return true;
}

bool DKCefV8::GetScreenWidth(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	int w;
	if(!DKUtil::GetScreenWidth(w)){ return false; }
	if(!retval->SetInt(0, w)){ return false; }
	return true;
}

bool DKCefV8::GetTicks(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	long ticks;
	if(!DKUtil::GetTicks(ticks)){ return false; }
	if(!retval->SetInt(0, (int)ticks)){ return false; }
	return true;
}

bool DKCefV8::GetVolume(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	int percent;
	if(!DKUtil::GetVolume(percent)){ return false; }
	DKINFO("DKCefV8::GetVolume(): volume ="+toString(percent)+"\n");
	if(!retval->SetInt(0, percent)){ return false; }
	return 1;
}

bool DKCefV8::HideConsole(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
#if WIN
	HWND consoleWindow = GetConsoleWindow();
	ShowWindow(consoleWindow, SW_HIDE);
#endif 
	return true;
}

bool DKCefV8::LeftClick(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	return DKUtil::LeftClick();
}

bool DKCefV8::LowPowerMonitor(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	if(!DKUtil::LowPowerMonitor()){ return false; }
	return true;
}

bool DKCefV8::PhysicalMemory(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	unsigned long long physicalMemory;
	if(!DKUtil::PhysicalMemory(physicalMemory)){ return false; }
	if(!retval->SetInt(0, (int)physicalMemory)){ return false; }
	return true;
}

bool DKCefV8::PhysicalMemoryUsed(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	unsigned long long physicalMemory;
	if(!DKUtil::PhysicalMemoryUsed(physicalMemory)){ return false; }
	if(!retval->SetInt(0, (int)physicalMemory)){ return false; }
	return true;
}

bool DKCefV8::PhysicalMemoryUsedByApp(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	unsigned long long physicalMemory;
	if(!DKUtil::PhysicalMemoryUsedByApp(physicalMemory)){ return false; }
	if(!retval->SetInt(0, (int)physicalMemory)){ return false; }
	return true;
}

bool DKCefV8::PressKey(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	unsigned short key = (unsigned short)args->GetInt(0);
	return DKUtil::PressKey(key);
}

bool DKCefV8::QueueDuktape(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString code = args->GetString(0);
	if(!DKCef::Get()->QueueDuktape(code)){ return false; }
	return true;
}

bool DKCefV8::ReleaseKey(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	unsigned short key = (unsigned short)args->GetInt(0);
	return DKUtil::ReleaseKey(key);
}

bool DKCefV8::Run(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString command = args->GetString(0);
	DKString params = args->GetString(1);
	return DKUtil::Run(command, params);
}

bool DKCefV8::RunDuktape(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString rval;
	DKString code = args->GetString(0);
	if(!DKCef::Get()->RunDuktape(code, rval)){ 
		DKERROR("DKCefV8::RunDuktape(): DKCef::Get()->RunDuktape() failed");
		return false; 
	}
	if(!rval.empty()){
		if(!retval->SetString(0, rval)){ 
			DKERROR("DKCefV8::RunDuktape() retval->SetString(0, rval) failed\n");
			return false; 
		}
	}
	return true;
}

bool DKCefV8::SetBrightness(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	int percent = args->GetInt(0);
	return DKUtil::SetBrightness(percent);
}

bool DKCefV8::SetClipboard(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString string = args->GetString(0);
	return DKUtil::SetClipboard(string);
}

bool DKCefV8::SetClipboardFiles(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString filelist = args->GetString(0);
	return DKUtil::SetClipboardFiles(filelist);
}

bool DKCefV8::SetClipboardImage(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString file = args->GetString(0);
	return DKUtil::SetClipboardImage(file);
}

bool DKCefV8::SetFramerate(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	int fps = args->GetInt(0);
	DKUtil::SetFramerate(fps);
	return true;
}

bool DKCefV8::SetMousePos(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	int x = args->GetInt(0);
	int y = args->GetInt(1);
	return DKUtil::SetMousePos(x,y);
}

bool DKCefV8::SetVolume(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	int percent = args->GetInt(0);
	DKINFO("DKCefV8::SetVolume(): volume ="+toString(percent)+"\n");
	if(!DKUtil::SetVolume(percent)){ return false; }
	return 1;
}

bool DKCefV8::ShowConsole(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
#if WIN
	HWND consoleWindow = GetConsoleWindow();
	ShowWindow(consoleWindow, SW_RESTORE);
#endif 
	return true;
}

bool DKCefV8::StrokeKey(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	unsigned short key = (unsigned short)args->GetInt(0);
	return DKUtil::StrokeKey(key);
}

bool DKCefV8::System(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString command = args->GetString(0);
	int ret;
	return DKUtil::System(command, ret);
}

bool DKCefV8::TurnOffMonitor(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	if(!DKUtil::TurnOffMonitor()){ return false; }
	return true;
}

bool DKCefV8::TurnOnMonitor(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	if(!DKUtil::TurnOnMonitor()){ return false; }
	return true;
}

bool DKCefV8::VirtualMemory(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	unsigned long long virtualMemory;
	if(!DKUtil::VirtualMemory(virtualMemory)){ return false; }
	if(!retval->SetInt(0, (int)virtualMemory)){ return false; }
	return true;
}

bool DKCefV8::VirtualMemoryUsed(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	unsigned long long virtualMemory;
	if(!DKUtil::VirtualMemoryUsed(virtualMemory)){ return false; }
	if(!retval->SetInt(0, (int)virtualMemory)){ return false; }
	return true;
}

bool DKCefV8::VirtualMemoryUsedByApp(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	unsigned long long virtualMemory;
	if(!DKUtil::VirtualMemoryUsedByApp(virtualMemory)){ return false; }
	if(!retval->SetInt(0, (int)virtualMemory)){ return false; }
	return true;
}

bool DKCefV8::WaitForImage(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString file = args->GetString(0);
	int timeout = args->GetInt(1);
	if(!DKUtil::WaitForImage(file, timeout)){
		retval->SetBool(0, false); 
		return false;
	}
	if(!retval->SetBool(0, true)){ return false; }
	return true;
}




//CEF js functions
bool DKCefV8::CloseBrowser(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	if(!DKCef::Get()->CloseBrowser(browser)){ return false; }
	return true;
}

bool DKCefV8::CloseDevTools(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	if(!DKCef::Get()->CloseDevTools(browser)){ return false; }
	return true;
}

bool DKCefV8::Copy(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	if(!DKCef::Get()->Copy()){ return false; }
	return true;
}

bool DKCefV8::CopyImage(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString url = args->GetString(0);
	if(!DKCef::Get()->CopyImage(url)){ return false; }
	return true;
}

bool DKCefV8::Cut(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	if(!DKCef::Get()->Cut()){ return false; }
	return true;
}

bool DKCefV8::DownloadUrl(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString url = args->GetString(0);
	if(!DKCef::Get()->DownloadUrl(url)){ return false; }
	return true;
}

bool DKCefV8::FileDialog(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString type = args->GetString(0);
	DKString title = args->GetString(1);
	if(!DKCef::Get()->FileDialog(type,title)){ return false; }
	return true;
}

bool DKCefV8::Find(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	DKString text = args->GetString(1);
	if(!DKCef::Get()->Find(browser, text)){ return false; }
	return true;
}

bool DKCefV8::GetBrowserId(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	DKString id;
	if(!DKCef::Get()->GetBrowserId(browser, id)){ return false; }
	if(!retval->SetString(0, id)){ return false; }
	return true;
}

bool DKCefV8::GetBrowsers(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int num;
	if(!DKCef::Get()->GetBrowsers(num)){ return false; }
	if(!retval->SetInt(0, num)){ return false; }
	return true;
}

bool DKCefV8::GetCurrentBrowser(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser;
	if(!DKCef::Get()->GetCurrentBrowser(browser)){ return false; }
	if(!retval->SetInt(0, browser)){ return false; }
	return true;
}

bool DKCefV8::GetPageSource(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	DKString source;
	if(!DKCef::Get()->GetPageSource(browser, source)){ return false; }
	if(!source.empty()){ 
		if(!retval->SetString(0, source)){ return false; }
	}
	return true;
}

bool DKCefV8::GetUrl(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	DKString url;
	if(!DKCef::Get()->GetUrl(browser, url)){ return false; }
	if(!url.empty()){ 
		if(!retval->SetString(0, url)){ return false; }
	}
	return true;
}

bool DKCefV8::GoBack(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	if(!DKCef::Get()->GoBack(browser)){ return false; }
	return true;
}

bool DKCefV8::GoForward(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	if(!DKCef::Get()->GoForward(browser)){ return false; }
	return true;
}

bool DKCefV8::NewBrowser(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString id = args->GetString(0);
	int top = args->GetInt(1);
	int left = args->GetInt(2);
	int width = args->GetInt(3);
	int height = args->GetInt(4);
	DKString url = args->GetString(5);
	if(!DKCef::Get()->NewBrowser(id, top, left, width, height, url)){ return false; }
	return true;
}

bool DKCefV8::Paste(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	if(!DKCef::Get()->Paste()){ return false; }
	return true;
}

bool DKCefV8::Popup(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString url = args->GetString(0);
	if(!DKCef::Get()->Popup(url)){ return false; }
	return true;
}

bool DKCefV8::Print(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	if(!DKCef::Get()->Print(browser)){ return false; }
	return true;
}

bool DKCefV8::Reload(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	if(!DKCef::Get()->Reload(browser)){ return false; }
	return true;
}

bool DKCefV8::RemoveFocus(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	if(!DKCef::Get()->RemoveFocus(browser)){ return false; }
	return true;
}

bool DKCefV8::RunJavascript(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	DKString code = args->GetString(1);
	if(!DKCef::Get()->RunJavascript(browser, code)){ return false; }
	return true;
}

bool DKCefV8::SetFocus(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	if(!DKCef::Get()->SetFocus(browser)){ return false; }
	return true;
}

bool DKCefV8::SetKeyboardFocus(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	if(!DKCef::Get()->SetKeyboardFocus(browser)){ return false; }
	return true;
}

bool DKCefV8::SetUrl(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	DKString url = args->GetString(1);
	if(!DKCef::Get()->SetUrl(browser, url)){ return false; }
	return true;
}

bool DKCefV8::ShowDevTools(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	if(!DKCef::Get()->ShowDevTools(browser)){ return false; }
	return true;
}

bool DKCefV8::Stop(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	if(!DKCef::Get()->Stop(browser)){ return false; }
	return true;
}

bool DKCefV8::ViewPageSource(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	int browser = args->GetInt(0);
	if(!DKCef::Get()->ViewPageSource(browser)){ return false; }
	return true;
}

//#endif //HAVE_DKCef
