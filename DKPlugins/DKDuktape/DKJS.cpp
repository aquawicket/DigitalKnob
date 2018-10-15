//https://stackoverflow.com/questions/63166/how-to-determine-cpu-and-memory-consumption-from-inside-a-process

#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DK/DKFile.h"
#include "DK/DKOsInfo.h"
#include "DK/DKPlugin.h"
#include "DK/DKUnix.h"
#include "DK/DKUtil.h"
#include "DKDuktape/DKJS.h"
#include <signal.h>

/////////////////
bool DKJS::Init()
{
	DKLog("DKJS::Init()\n", DKDEBUG);
	DKClass::DKCreate("DKFileJS");
	DKClass::DKCreate("DKAssetsJS");
	
	/*
	DKString errors;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_ERRORS]", errors);
	DKString warnings;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_WARNINGS]", warnings);
	DKString info;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_INFO]", info);
	DKString debug;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_DEBUG]", debug);
	DKString file;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[LOG_FILE]", file);
	if(same(errors,"OFF")){ log_errors = false; }
	if(same(warnings,"OFF")){ log_warnings = false; }
	if(same(info,"OFF")){ log_info = false; }
	if(same(debug,"OFF")){ log_debug = false; }
	if(same(file,"ON")){ log_file = true; }
	*/
	
	duk_eval_string(DKDuktape::ctx, "var DKERROR = 0;");
	duk_eval_string(DKDuktape::ctx, "var DKWARN = 1;");
	duk_eval_string(DKDuktape::ctx, "var DKINFO = 2;");
	duk_eval_string(DKDuktape::ctx, "var DKDEBUG = 3;");

	DKDuktape::AttachFunction("DKAddEvent", DKJS::_DKAddEvent);
	DKDuktape::AttachFunction("DKAvailable", DKJS::_DKAvailable);
	DKDuktape::AttachFunction("DKClose", DKJS::_DKClose);
	DKDuktape::AttachFunction("DKCreate", DKJS::_DKCreate);
	DKDuktape::AttachFunction("DKLoadPlugin", DKJS::_DKLoadPlugin);
	DKDuktape::AttachFunction("DKLog", DKJS::_DKLog);
	DKDuktape::AttachFunction("DKRemoveEvent", DKJS::_DKRemoveEvent);
	DKDuktape::AttachFunction("DKRemoveEvents", DKJS::_DKRemoveEvents);
	DKDuktape::AttachFunction("DKSendEvent", DKJS::_DKSendEvent);
	DKDuktape::AttachFunction("DKValid", DKJS::_DKValid);
	
	DKDuktape::AttachFunction("DK_Beep", DKJS::Beep);
	DKDuktape::AttachFunction("DK_CallFunc", DKJS::CallFunc);
	DKDuktape::AttachFunction("DK_ClearEvents", DKJS::ClearEvents);
	DKDuktape::AttachFunction("DK_ClickImage", DKJS::ClickImage);
	DKDuktape::AttachFunction("DK_CpuUsed", DKJS::CpuUsed);
	DKDuktape::AttachFunction("DK_CpuUsedByApp", DKJS::CpuUsedByApp);
	DKDuktape::AttachFunction("DK_Crash", DKJS::Crash);
	DKDuktape::AttachFunction("DK_DoFrame", DKJS::DoFrame);
	DKDuktape::AttachFunction("DK_DoubleClick", DKJS::DoubleClick);
	DKDuktape::AttachFunction("DK_Execute", DKJS::Execute);
	DKDuktape::AttachFunction("DK_Exit", DKJS::Exit);
	DKDuktape::AttachFunction("DK_GetArgs", DKJS::GetArgs);
	DKDuktape::AttachFunction("DK_GetBrowser", DKJS::GetBrowser);
	DKDuktape::AttachFunction("DK_GetClipboard", DKJS::GetClipboard);
	DKDuktape::AttachFunction("DK_GetData", DKJS::GetData);
	DKDuktape::AttachFunction("DK_GetDate", DKJS::GetDate);
	DKDuktape::AttachFunction("DK_GetEvents", DKJS::GetEvents);
	DKDuktape::AttachFunction("DK_GetFps", DKJS::GetFps);
	DKDuktape::AttachFunction("DK_GetFramerate", DKJS::GetFramerate);
	DKDuktape::AttachFunction("DK_GetFrames", DKJS::GetFrames);
	DKDuktape::AttachFunction("DK_GetFunctions", DKJS::GetFunctions);
	DKDuktape::AttachFunction("DK_GetId", DKJS::GetId);
	DKDuktape::AttachFunction("DK_GetJavascript", DKJS::GetJavascript);
	DKDuktape::AttachFunction("DK_GetKey", DKJS::GetKey);
	DKDuktape::AttachFunction("DK_GetLocalIP", DKJS::GetLocalIP);
	DKDuktape::AttachFunction("DK_GetMouseX", DKJS::GetMouseX); 
	DKDuktape::AttachFunction("DK_GetMouseY", DKJS::GetMouseY);
	DKDuktape::AttachFunction("DK_GetOS", DKJS::GetOS);
	DKDuktape::AttachFunction("DK_GetObjects", DKJS::GetObjects);
	DKDuktape::AttachFunction("DK_GetPixelUnderMouse", DKJS::GetPixelUnderMouse);
	DKDuktape::AttachFunction("DK_GetProcessList", DKJS::GetProcessList);
	DKDuktape::AttachFunction("DK_GetScreenHeight", DKJS::GetScreenHeight);
	DKDuktape::AttachFunction("DK_GetScreenWidth", DKJS::GetScreenWidth);
	DKDuktape::AttachFunction("DK_GetTicks", DKJS::GetTicks);
	DKDuktape::AttachFunction("DK_GetTime", DKJS::GetTime);
	DKDuktape::AttachFunction("DK_GetType", DKJS::GetType);
	DKDuktape::AttachFunction("DK_GetUsername", DKJS::GetUsername);
	DKDuktape::AttachFunction("DK_GetValue", DKJS::GetValue);
	DKDuktape::AttachFunction("DK_GetVolume", DKJS::GetVolume);
	DKDuktape::AttachFunction("DK_HideConsole", DKJS::HideConsole);
	DKDuktape::AttachFunction("DK_IE", DKJS::IE);
	DKDuktape::AttachFunction("DK_Id", DKJS::Id);
	DKDuktape::AttachFunction("DK_IdLike", DKJS::IdLike);
	DKDuktape::AttachFunction("DK_Include", DKJS::Include);
	DKDuktape::AttachFunction("DK_KeyIsDown", DKJS::KeyIsDown);
	DKDuktape::AttachFunction("DK_LeftClick", DKJS::LeftClick);
	DKDuktape::AttachFunction("DK_LogGuiConsole", DKJS::LogGuiConsole);
	DKDuktape::AttachFunction("DK_LowPowerMonitor", DKJS::LowPowerMonitor);
	DKDuktape::AttachFunction("DK_MessageBox", DKJS::MessageBox);
	DKDuktape::AttachFunction("DK_MouseToImage", DKJS::MouseToImage);
	DKDuktape::AttachFunction("DK_PhysicalMemory", DKJS::PhysicalMemory);
	DKDuktape::AttachFunction("DK_PhysicalMemoryUsed", DKJS::PhysicalMemoryUsed);
	DKDuktape::AttachFunction("DK_PhysicalMemoryUsedByApp", DKJS::PhysicalMemoryUsedByApp);
	DKDuktape::AttachFunction("DK_PressKey", DKJS::PressKey);
	DKDuktape::AttachFunction("DK_QueueDuktape", DKJS::QueueDuktape);
	DKDuktape::AttachFunction("DK_ReleaseKey", DKJS::ReleaseKey);
	DKDuktape::AttachFunction("DK_Reload", DKJS::Reload);
	DKDuktape::AttachFunction("DK_RightClick", DKJS::RightClick);
	DKDuktape::AttachFunction("DK_Run", DKJS::Run);
	DKDuktape::AttachFunction("DK_RunDuktape", DKJS::RunDuktape);
	DKDuktape::AttachFunction("DK_SetBrightness", DKJS::SetBrightness);
	DKDuktape::AttachFunction("DK_SetClipboard", DKJS::SetClipboard);
	DKDuktape::AttachFunction("DK_SetClipboardFiles", DKJS::SetClipboardFiles);
	DKDuktape::AttachFunction("DK_SetClipboardImage", DKJS::SetClipboardImage);
	DKDuktape::AttachFunction("DK_SetCursorPos", DKJS::SetCursorPos);
	DKDuktape::AttachFunction("DK_SetFramerate", DKJS::SetFramerate);
	DKDuktape::AttachFunction("DK_SetLog", DKJS::_SetLog);
	DKDuktape::AttachFunction("DK_SetVolume", DKJS::SetVolume);
	DKDuktape::AttachFunction("DK_ShowConsole", DKJS::ShowConsole);
	DKDuktape::AttachFunction("DK_Sleep", DKJS::Sleep);
	DKDuktape::AttachFunction("DK_StopPropagation", DKJS::StopPropagation);
	DKDuktape::AttachFunction("DK_StrokeKey", DKJS::StrokeKey);
	DKDuktape::AttachFunction("DK_System", DKJS::System);
	DKDuktape::AttachFunction("DK_TurnOffMonitor", DKJS::TurnOffMonitor);
	DKDuktape::AttachFunction("DK_TurnOnMonitor", DKJS::TurnOnMonitor);
	DKDuktape::AttachFunction("DK_Type", DKJS::Type);
	DKDuktape::AttachFunction("DK_Value", DKJS::Value);
	DKDuktape::AttachFunction("DK_VirtualMemory", DKJS::VirtualMemory);
	DKDuktape::AttachFunction("DK_VirtualMemoryUsed", DKJS::VirtualMemoryUsed);
	DKDuktape::AttachFunction("DK_VirtualMemoryUsedByApp", DKJS::VirtualMemoryUsedByApp);
	DKDuktape::AttachFunction("DK_WaitForImage", DKJS::WaitForImage);
	return true;
}



///////////////////////////////////////
int DKJS::_DKAddEvent(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKString type = duk_require_string(ctx, 1);

	DKString jsreturn;
	if(duk_to_string(ctx, 2)){
		jsreturn = duk_to_string(ctx, 2);
		replace(jsreturn, "function ", "");
	}

	DKEvent::AddEvent(id, type, jsreturn, &DKDuktape::OnEvent, DKDuktape::Get("DKDuktape0"));
	return 1;
}

////////////////////////////////////////
int DKJS::_DKAvailable(duk_context* ctx)
{
	DKString data = duk_require_string(ctx, 0);
	bool available = DKClass::DKAvailable(data);
	if(!available){
		return 0;
	}
	return 1;
}

////////////////////////////////////
int DKJS::_DKClose(duk_context* ctx)
{
	DKString value = duk_require_string(ctx, 0);
	DKClass::DKClose(value);
	return 1;
}

/////////////////////////////////////
int DKJS::_DKCreate(duk_context* ctx)
{	
	DKString data = duk_require_string(ctx, 0);
	
	bool callback_found = false;
	if (duk_is_function(ctx, -1)) {
		//DKLog("DKJS::_DKCreate("+data+"): Callback found in DKCreate :D \n", DKINFO);
		callback_found = true;
	}
	
	DKObject* obj = DKClass::DKCreate(data);
	if(!obj){
		duk_push_string(ctx, "");
		DKLog("DKJS::_DKCreate("+data+"): obj invalid \n", DKWARN);
		return 1;
	}

	//Look for a callback function, and call it if one exists. FIXME
	if(callback_found){
		//if(duk_is_function(ctx, 0)){ DKLog("index 0 is function \n", DKDEBUG); }
		//if(duk_is_function(ctx, 1)) { DKLog("index 1 is function \n", DKDEBUG); }
		if(duk_pcall(ctx, 0) != 0 && duk_pcall(ctx, 1) != 0){ // JsFunc call failed
			DKLog("DKJS::_DKCreate("+data+"): JsFunc call failed \n", DKERROR);
			DKLog("Error: "+toString(duk_safe_to_string(ctx, -1))+"\n", DKERROR);
			//printf("Error: %s\n", duk_safe_to_string(ctx, -1));
		}
		duk_pop(ctx);
    }

	duk_push_string(ctx, obj->data[1].c_str());
	return 1;
}

/////////////////////////////////////////
int DKJS::_DKLoadPlugin(duk_context* ctx)
{
	DKString file = duk_require_string(ctx, 0);
	DKPlugins::LoadPlugin(file);
	return 1;
}

//////////////////////////////////
int DKJS::_DKLog(duk_context* ctx)
{
	DKString string = duk_require_string(ctx, 0);
	if(duk_get_int(ctx, 1)){
		int lvl = duk_get_int(ctx, 1);
		DKLog(string, lvl);
		return 1;
	}
	DKLog(string, DKINFO);
	return 1;
}

//////////////////////////////////////////
int DKJS::_DKRemoveEvent(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKString type = duk_require_string(ctx, 1);
	DKString jsreturn;
	if(duk_to_string(ctx, 2)){
		jsreturn = duk_to_string(ctx, 2);
		replace(jsreturn, "function ", "");
	}

	if(!DKEvent::RemoveEvent(id, type, jsreturn)){ return 0; }
	return 1;
}

///////////////////////////////////////////
int DKJS::_DKRemoveEvents(duk_context* ctx)
{
	//variable can be id or jsreturn
	DKString variable = duk_to_string(ctx, 0);
	replace(variable, "function ", ""); //jsreturn type
	if(!DKEvent::RemoveEvents(variable)){ return 0; } //sending id or jsreturn
	return 1;
}

////////////////////////////////////////
int DKJS::_DKSendEvent(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKString type = duk_require_string(ctx, 1);
	DKString param;

	//if(duk_get_string(ctx, 1)){
	//	type = duk_get_string(ctx, 1);
	//}

	if(duk_get_string(ctx, 2)){
		param = duk_get_string(ctx, 2);
	}

	if(!param.empty()){
		DKEvent::SendEvent(id, type, param);
		return 1;
	}

	DKEvent::SendEvent(id, type, "");
	return 1;
}

////////////////////////////////////
int DKJS::_DKValid(duk_context* ctx)
{
	DKString data = duk_require_string(ctx, 0);
	bool valid = DKClass::DKValid(data);
	if(!valid){
		return 0;
	}
	return 1;
}

///////////////////////////////////
int DKJS::_SetLog(duk_context* ctx)
{
	//TODO
	int lvl = duk_require_int(ctx, 0);
	DKString string = duk_require_string(ctx, 1);
	SetLog(lvl, string);
	return 1;
}



////////////////////////////////
int DKJS::Beep(duk_context* ctx)
{
	DKUtil::Beep();
	return 1;
}

////////////////////////////////////
int DKJS::CallFunc(duk_context* ctx)
{
	DKString func = duk_require_string(ctx, 0);
	DKString args = duk_require_string(ctx, 1);
	DKString result;

	if(!DKClass::CallFunc(func, &args, &result)){ return 0;	}
	
	duk_push_string(ctx, result.c_str());
	return 1;
}

///////////////////////////////////////
int DKJS::ClearEvents(duk_context* ctx)
{
	DKEvent::events.clear();
	return 1;
}

//////////////////////////////////////
int DKJS::ClickImage(duk_context* ctx)
{
	DKString file = duk_require_string(ctx, 0);
	int x;
	int y;
	if(!DKUtil::FindImageOnScreen(file, x, y)){ return 0; }
	if(!DKUtil::SetMousePos(x, y)){ return 0; }
	if(!DKUtil::LeftClick()){ return 0; }
	duk_push_true(ctx);
	return 1;
}

///////////////////////////////////
int DKJS::CpuUsed(duk_context* ctx)
{
	int cpu;
	if(!DKUtil::CpuUsed(cpu)){ return 0; }
	duk_push_number(ctx, cpu);
	return 1;
}

////////////////////////////////////////
int DKJS::CpuUsedByApp(duk_context* ctx)
{
	int cpu;
	if(!DKUtil::CpuUsedByApp(cpu)){ return 0; }
	duk_push_number(ctx, cpu);
	return 1;
}

/////////////////////////////////
int DKJS::Crash(duk_context* ctx)
{
#if !defined(WIN32)
	raise(SIGSEGV);
#else
	abort();
#endif
	return 1;
}

///////////////////////////////////
int DKJS::DoFrame(duk_context* ctx)
{
	DKApp::DoFrame();
	return 1;
}

///////////////////////////////////////
int DKJS::DoubleClick(duk_context* ctx)
{
	if(!DKUtil::DoubleClick()){ return 0; }
	return 1;
}

///////////////////////////////////
int DKJS::Execute(duk_context* ctx)
{
	DKString command = duk_require_string(ctx, 0);
	DKString rtn;
	if(!DKUtil::Execute(command, rtn)){ return 0; }
	duk_push_string(ctx, rtn.c_str());
	return 1;
}

////////////////////////////////
int DKJS::Exit(duk_context* ctx)
{
	DKApp::Exit();
	return 1;
}

///////////////////////////////////
int DKJS::GetArgs(duk_context* ctx)
{
	DKString args;
	if(DKApp::argc > 1){
		for(int i = 1; i < DKApp::argc; ++i){
			//DKLog("argv["+toString(i)+"] = "+toString(DKApp::argv[i])+"\n", DKINFO);
			args += toString(DKApp::argv[i]) += ";";
		}
	}
	duk_push_string(ctx, args.c_str());
	return 1;
}

//////////////////////////////////////
int DKJS::GetBrowser(duk_context* ctx)
{
	DKString browser = "Rocket";
	duk_push_string(ctx, browser.c_str());
	return 1;
}

////////////////////////////////////////
int DKJS::GetClipboard(duk_context* ctx)
{
	DKString string;
	if(!DKUtil::GetClipboard(string)){ return 0; }
	duk_push_string(ctx, string.c_str());
	return 1;
}

///////////////////////////////////
int DKJS::GetData(duk_context* ctx)
{
	DKString data = duk_require_string(ctx, 0);
	if(!DKClass::DKValid(data)){ return 0; }
	DKString output = toString(DKClass::DKGet(data)->data, ",");
	duk_push_string(ctx, output.c_str());
	return 1;
}

///////////////////////////////////
int DKJS::GetDate(duk_context* ctx)
{
	DKString date;
	if(!DKUtil::GetDate(date)){ return 0; }
	duk_push_string(ctx, date.c_str());
	return 1;
}

/////////////////////////////////////
int DKJS::GetEvents(duk_context* ctx)
{
	DKString list;
	for(unsigned int i = 0; i < DKEvent::events.size(); ++i){
			
		list += DKEvent::events[i]->GetId();
		list += " : ";
		list += DKEvent::events[i]->GetType();
		list += " : ";
		list += DKEvent::events[i]->GetJSReturn();
		list += ",";
	}

	duk_push_string(ctx, list.c_str());
	return 1;
}

//////////////////////////////////
int DKJS::GetFps(duk_context* ctx)
{
	unsigned int fps;
	DKUtil::GetFps(fps);
	duk_push_int(ctx, fps);
	return 1;
}

////////////////////////////////////////
int DKJS::GetFramerate(duk_context* ctx)
{
	int framerate;
	if(!DKUtil::GetFramerate(framerate)){ return 0; }
	duk_push_int(ctx, framerate);
	return 1;
}

/////////////////////////////////////
int DKJS::GetFrames(duk_context* ctx)
{
	long frames;
	if(!DKUtil::GetFrames(frames)){ return 0; }
	duk_push_int(ctx, frames);
	return 1;
}

////////////////////////////////////////
int DKJS::GetFunctions(duk_context* ctx)
{
	DKStringArray list;
	for(unsigned int i=0; i < DKDuktape::functions.size(); ++i){
		list.push_back(DKDuktape::functions[i]);
	}
	DKString str = toString(list, ",");
	duk_push_string(ctx, str.c_str());
	return 1;
}

/////////////////////////////////
int DKJS::GetId(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKStringArray arry;
	toStringArray(arry, evt, ",");
	if(arry.size() < 1){ return 0; }
	duk_push_string(ctx, arry[0].c_str());
	return 1;
}

/////////////////////////////////////////
int DKJS::GetJavascript(duk_context* ctx)
{
	DKString browser = "Duktape";
	duk_push_string(ctx, browser.c_str());
	return 1;
}

//////////////////////////////////
int DKJS::GetKey(duk_context* ctx)
{
	int key;
	if(!DKUtil::GetKey(key)){ return 0; }
	duk_push_int(ctx, key);
	return 1;
}

//////////////////////////////////////
int DKJS::GetLocalIP(duk_context* ctx)
{
	DKString ip;
	if(!DKUtil::GetLocalIP(ip)){ return 0; }
	duk_push_string(ctx, ip.c_str());
	return 1;
}

/////////////////////////////////////
int DKJS::GetMouseX(duk_context* ctx)
{
	int mouseX = 0;
	int mouseY = 0;
	if(!DKUtil::GetMousePos(mouseX, mouseY)){ return 0; }
	duk_push_int(ctx, mouseX);
	return 1;
}

/////////////////////////////////////
int DKJS::GetMouseY(duk_context* ctx)
{
	int mouseX = 0;
	int mouseY = 0;
	if(!DKUtil::GetMousePos(mouseX, mouseY)){ return 0; }
	duk_push_int(ctx, mouseY);
	return 1;
}

/////////////////////////////////
int DKJS::GetOS(duk_context* ctx)
{
	DKString os;
	if(!GetSystemOS(os)){
		return 0; 
	}
	duk_push_string(ctx, os.c_str());
	return 1;
}

//////////////////////////////////////
int DKJS::GetObjects(duk_context* ctx)
{
	DKStringArray list;
	DKClass::GetObjects(list);
	for(unsigned int i=0; i<list.size(); ++i){
		replace(list[i], ",", " : ");
	}
	DKString str = toString(list, ",");
	duk_push_string(ctx, str.c_str());
	return 1;
}

//////////////////////////////////////////////
int DKJS::GetPixelUnderMouse(duk_context* ctx)
{
	int mouseX = 0;
	int mouseY = 0;
	if (!DKUtil::GetMousePos(mouseX, mouseY)) { return 0; }
	int r;
	int g;
	int b;
	if (!DKUtil::GetPixelFromScreen(mouseX, mouseY, r, g, b)) { return 0; }
	DKString rgb = toString(r) + "," + toString(g) + "," + toString(b);
	duk_push_string(ctx, rgb.c_str());
	return 1;
}

//////////////////////////////////////////
int DKJS::GetProcessList(duk_context* ctx)
{
	DKString list;
	DKUtil::GetProcessList(list);
	duk_push_string(ctx, list.c_str());
	return 1;
}

///////////////////////////////////////////
int DKJS::GetScreenHeight(duk_context* ctx)
{
	int h;
	if(!DKUtil::GetScreenHeight(h)){ return 0; }
	duk_push_int(ctx, h);
	return 1;
}

//////////////////////////////////////////
int DKJS::GetScreenWidth(duk_context* ctx)
{
	int w;
	if(!DKUtil::GetScreenWidth(w)){ return 0; }
	duk_push_int(ctx, w);
	return 1;
}

////////////////////////////////////
int DKJS::GetTicks(duk_context* ctx)
{
	long ticks;
	if(!DKUtil::GetTicks(ticks)){ return 0; }
	duk_push_int(ctx, ticks);
	return 1;
}

///////////////////////////////////
int DKJS::GetTime(duk_context* ctx)
{
	DKString time;
	if(!DKUtil::GetTime(time)){ return 0; }
	duk_push_string(ctx, time.c_str());
	return 1;
}

///////////////////////////////////
int DKJS::GetType(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKStringArray arry;
	toStringArray(arry, evt, ",");
	if(arry.size() < 2){ return 0; }
	duk_push_string(ctx, arry[1].c_str());
	return 1;
}

//////////////////////////////////////
int DKJS::GetUsername(duk_context* ctx)
{
#ifdef LINUX
	DKString username;
	DKUnix::GetUsername(username);
	duk_push_string(ctx, username.c_str());
#else
	DKLog("GetUsername: not implemented on this OS \n", DKERROR);
#endif
	return 1;
}

////////////////////////////////////
int DKJS::GetValue(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	//DKLog("DKJS::GetValue("+evt+")\n", DKINFO);
	DKStringArray arry;
	toStringArray(arry, evt, ",");
	if(arry.size() < 3){ 
		if(DKClass::DKValid("DKWidget,DKWidget0")){
			DKString rval;
			DKDuktape::RunDuktape("DKWidget_GetValue(\""+evt+"\");", rval);
			if(rval.empty()){
				return 0;
			}
			duk_push_string(ctx, rval.c_str());
			return 1;
		}
		//DKLog("DKJS::GetValue(" + evt + "): failed. \n", DKINFO);
		return 0;
	}
	duk_push_string(ctx, arry[2].c_str());
	return 1;
}

/////////////////////////////////////
int DKJS::GetVolume(duk_context* ctx)
{
	int percent;
	if(!DKUtil::GetVolume(percent)){ return 0; }
	duk_push_number(ctx, percent);
	return 1;
}

///////////////////////////////////////
int DKJS::HideConsole(duk_context* ctx)
{
#ifdef WIN32
	HWND consoleWindow = GetConsoleWindow();
	ShowWindow(consoleWindow, SW_HIDE);
#endif 
	return 1;
}

//////////////////////////////
int DKJS::IE(duk_context* ctx)
{
	return 0;
}

//////////////////////////////
int DKJS::Id(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString id = duk_require_string(ctx, 1);

	DKStringArray events;
	toStringArray(events, evt, ",");
	
	if(events.size() < 1){ return 0; }
	if(!same(events[0],id)){ return 0; }
	return 1;
}

//////////////////////////////////
int DKJS::IdLike(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString id = duk_require_string(ctx, 1);

	DKStringArray events;
	toStringArray(events, evt, ",");
	
	if(events.size() < 1){ return 0; }
	if(!has(events[0],id)){ return 0; }
	return 1;
}

///////////////////////////////////
int DKJS::Include(duk_context* ctx)
{
	//ignore this for now
	return 1;
}

/////////////////////////////////////
int DKJS::KeyIsDown(duk_context* ctx)
{
	int key = duk_require_int(ctx, 0);
	if(!DKUtil::KeyIsDown(key)){ return 0; }
	return 1;
}

/////////////////////////////////////
int DKJS::LeftClick(duk_context* ctx)
{
	if(!DKUtil::LeftClick()){ return 0; }
	return 1;
}

/////////////////////////////////////////
int DKJS::LogGuiConsole(duk_context* ctx)
{
	int state = duk_require_boolean(ctx, 0);
	if(state){
		log_gui_console = true;
		return 1;
	}
	log_gui_console = false;
	return 1;
}

///////////////////////////////////////////
int DKJS::LowPowerMonitor(duk_context* ctx)
{
	if(!DKUtil::LowPowerMonitor()){ return 0; }
	return 1;
}

//////////////////////////////////////
int DKJS::MessageBox(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString cmd = duk_require_string(ctx, 1);
	DKString message = duk_require_string(ctx, 2);
	DKClass::DKCreate("DKMessage.js");
	DKStringArray arry;
	toStringArray(arry, evt, ",");
	DKString type = arry[0];
	DKString id = arry[1];
	DKString value;
	if(arry.size() > 2){
		value = arry[2];
	}

	if(value.empty()){ DKEvent::SendEvent("DKMessage.html", cmd, id+","+type+","+message); return 0; }
	if(same(value,"CANCEL")){ return 0; }
	duk_push_string(ctx, value.c_str());
	return 1;
}

////////////////////////////////////////
int DKJS::MouseToImage(duk_context* ctx)
{
	DKString file = duk_require_string(ctx, 0);
	int x;
	int y;
	if(!DKUtil::FindImageOnScreen(file, x, y)){ return 0; }
	if(!DKUtil::SetMousePos(x, y)){ return 0; }
	return 1;
}

//////////////////////////////////////////
int DKJS::PhysicalMemory(duk_context* ctx)
{
	unsigned long long physicalMemory;
	if(!DKUtil::PhysicalMemory(physicalMemory)){ return 0; }
	duk_push_number(ctx, (double)physicalMemory);
	return 1;
}

//////////////////////////////////////////////
int DKJS::PhysicalMemoryUsed(duk_context* ctx)
{
	unsigned long long physicalMemory;
	if(!DKUtil::PhysicalMemoryUsed(physicalMemory)){ return 0; }
	duk_push_number(ctx, (double)physicalMemory);
	return 1;
}

///////////////////////////////////////////////////
int DKJS::PhysicalMemoryUsedByApp(duk_context* ctx)
{
	unsigned int physicalMemory;
	if(!DKUtil::PhysicalMemoryUsedByApp(physicalMemory)){ return 0; }
	duk_push_number(ctx, physicalMemory);
	return 1;
}

////////////////////////////////////
int DKJS::PressKey(duk_context* ctx)
{
	int key = duk_require_int(ctx, 0);
	if(!DKUtil::PressKey(key)){
		return 0;
	}
	return 1;
}

////////////////////////////////////////
int DKJS::QueueDuktape(duk_context* ctx)
{
	DKString code = duk_require_string(ctx, 0);
	DKDuktape::QueueDuktape(code);
	return 1;
}

//////////////////////////////////////
int DKJS::ReleaseKey(duk_context* ctx)
{
	int key = duk_require_int(ctx, 0);
	if(!DKUtil::ReleaseKey(key)){
		return 0;
	}
	return 1;
}

//////////////////////////////////
int DKJS::Reload(duk_context* ctx)
{
	DKDuktape::Reload();
	return 1;
}

//////////////////////////////////////
int DKJS::RightClick(duk_context* ctx)
{
	if(!DKUtil::RightClick()){ return 0; }
	return 1;
}

///////////////////////////////
int DKJS::Run(duk_context* ctx)
{
	DKString command = duk_require_string(ctx, 0);
	DKString params = duk_require_string(ctx, 1);
	if(!DKUtil::Run(command, params)){ return 0; }
	return 1;
}

/////////////////////////////////////////
int DKJS::RunDuktape(duk_context* ctx)
{
	DKString code = duk_require_string(ctx, 0);
	DKString rval;
	DKDuktape::RunDuktape(code, rval);
	if(rval.empty()){
		return 0;
	}
	duk_push_string(ctx, rval.c_str());
	return 1;
}

/////////////////////////////////////////
int DKJS::SetBrightness(duk_context* ctx)
{
	int percent = duk_require_int(ctx, 0);
	if(!DKUtil::SetBrightness(percent)){ return 0; }
	return 1;
}

////////////////////////////////////////
int DKJS::SetClipboard(duk_context* ctx)
{
	DKString string = duk_require_string(ctx, 0);
	if(!DKUtil::SetClipboard(string)){ return 0; }
	return 1;
}

/////////////////////////////////////////////
int DKJS::SetClipboardFiles(duk_context* ctx)
{
	DKString filelist = duk_require_string(ctx, 0);
	if(!DKUtil::SetClipboardFiles(filelist)){ return 0; }
	return 1;
}

/////////////////////////////////////////////
int DKJS::SetClipboardImage(duk_context* ctx)
{
	DKString file = duk_require_string(ctx, 0);
	if(!DKUtil::SetClipboardImage(file)){ return 0; }
	return 1;
}

////////////////////////////////////////
int DKJS::SetCursorPos(duk_context* ctx)
{
	int x = duk_require_int(ctx, 0);
	int y = duk_require_int(ctx, 1);
	if(!DKUtil::SetMousePos(x, y)){ return 0; }
	return 1;
}

////////////////////////////////////////
int DKJS::SetFramerate(duk_context* ctx)
{
	int fps = duk_require_int(ctx, 0);
	DKUtil::SetFramerate(fps);
	return 1;
}

/////////////////////////////////////
int DKJS::SetVolume(duk_context* ctx)
{
	int percent = duk_require_int(ctx, 0);
	if(!DKUtil::SetVolume(percent)){ return 0; }
	return 1;
}

///////////////////////////////////////
int DKJS::ShowConsole(duk_context* ctx)
{
#ifdef WIN32
	HWND consoleWindow = GetConsoleWindow();
	ShowWindow(consoleWindow, SW_RESTORE);
#endif 
	return 1;
}

/////////////////////////////////
int DKJS::Sleep(duk_context* ctx)
{
	int milliseconds = duk_require_int(ctx, 0);
	if(!DKUtil::Sleep(milliseconds)){ return 0; }
	return 1;
}

///////////////////////////////////////////
int DKJS::StopPropagation(duk_context* ctx)
{
	return 0;
}

/////////////////////////////////////
int DKJS::StrokeKey(duk_context* ctx)
{
	int key = duk_require_int(ctx, 0);
	if(!DKUtil::StrokeKey(key)){
		return 0;
	}
	return 1;
}

//////////////////////////////////
int DKJS::System(duk_context* ctx)
{
	DKString command = duk_require_string(ctx, 0);
	if(!DKUtil::System(command)){ return 0; }
	return 1;
}

//////////////////////////////////////////
int DKJS::TurnOffMonitor(duk_context* ctx)
{
	if(!DKUtil::TurnOffMonitor()){ return 0; }
	return 1;
}

/////////////////////////////////////////
int DKJS::TurnOnMonitor(duk_context* ctx)
{
	if(!DKUtil::TurnOnMonitor()){ return 0; }
	return 1;
}

////////////////////////////////
int DKJS::Type(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString id = duk_require_string(ctx, 1);

	DKStringArray events;
	toStringArray(events, evt, ",");
	
	if(events.size() < 2){ return 0; }
	if(!same(events[1],id)){ return 0; }
	return 1;
}

/////////////////////////////////
int DKJS::Value(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString value = duk_require_string(ctx, 1);

	DKStringArray events;
	toStringArray(events, evt, ",");
	
	if(events.size() > 2){
		//DKLog("Value:"+events[2]+"\n");
		if(!same(events[2],value)){ return 0; }
		return 1;
	}
	
	//DKLog("Value:"+events[1]+"\n");
	DKLog("DKJS::Value(): We should not get here \n",DKERROR);
	if(!same(events[1],value)){ return 0; }
	return 1;

}

/////////////////////////////////////////
int DKJS::VirtualMemory(duk_context* ctx)
{
	unsigned long long virtualMemory;
	if(!DKUtil::VirtualMemory(virtualMemory)){ return 0; }
	duk_push_number(ctx, (double)virtualMemory);
	return 1;
}

/////////////////////////////////////////////
int DKJS::VirtualMemoryUsed(duk_context* ctx)
{
	unsigned long long virtualMemory;
	if(!DKUtil::VirtualMemoryUsed(virtualMemory)){ return 0; }
	duk_push_number(ctx, (double)virtualMemory);
	return 1;
}

//////////////////////////////////////////////////
int DKJS::VirtualMemoryUsedByApp(duk_context* ctx)
{
	unsigned int virtualMemory;
	if(!DKUtil::VirtualMemoryUsedByApp(virtualMemory)){ return 0; }
	duk_push_number(ctx, virtualMemory);
	return 1;
}

////////////////////////////////////////
int DKJS::WaitForImage(duk_context* ctx)
{
	DKString file = duk_require_string(ctx, 0);
	int timeout = duk_require_int(ctx, 1);
	if(!!DKUtil::WaitForImage(file, timeout)){
		return 0;
	}
	duk_push_true(ctx);
	return 1;
}

#endif //USE_DKDuktape