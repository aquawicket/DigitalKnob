#ifdef USE_DKDuktape 
#include "DKJS.h"
#include "DKApp.h"
#include "DKPlugin.h"
#include "DKOsInfo.h"
#include "DKFile.h"
#include "DKUtil.h"
#include "DKUnix.h"
#include <signal.h>

/////////////////
void DKJS::Init()
{
	DKLog("DKJS::Init()\n", DKDEBUG);
	
	DKCreate("DKFileJS");
	DKCreate("DKAssetsJS");
	
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

	DKDuktape::AttachFunction("DKAddEvent", DKJS::_DKAddEvent, 3);
	DKDuktape::AttachFunction("DKAvailable", DKJS::_DKAvailable, 1);
	DKDuktape::AttachFunction("DKClose", DKJS::_DKClose, 1);
	DKDuktape::AttachFunction("DKCreate", DKJS::_DKCreate, 2);
	DKDuktape::AttachFunction("DKLoadPlugin", DKJS::_DKLoadPlugin, 1);
	DKDuktape::AttachFunction("DKLog", DKJS::_DKLog, 2);
	DKDuktape::AttachFunction("DKRemoveEvent", DKJS::_DKRemoveEvent, 3);
	DKDuktape::AttachFunction("DKSendEvent", DKJS::_DKSendEvent, 3);
	DKDuktape::AttachFunction("DKValid", DKJS::_DKValid, 1);
	
	DKDuktape::AttachFunction("DK_Beep", DKJS::Beep, 0);
	DKDuktape::AttachFunction("DK_CallFunc", DKJS::CallFunc, 2);
	DKDuktape::AttachFunction("DK_ChangeVolume", DKJS::ChangeVolume, 1);
	DKDuktape::AttachFunction("DK_ClearEvents", DKJS::ClearEvents, 0);
	DKDuktape::AttachFunction("DK_ClickImage", DKJS::ClickImage, 1);
	DKDuktape::AttachFunction("DK_DoFrame", DKJS::DoFrame, 0);
	DKDuktape::AttachFunction("DK_DoubleClick", DKJS::DoubleClick, 0);
	DKDuktape::AttachFunction("DK_Execute", DKJS::Execute, 1);
	DKDuktape::AttachFunction("DK_Exit", DKJS::Exit, 0);
	DKDuktape::AttachFunction("DK_GetBrowser", DKJS::GetBrowser, 0);
	DKDuktape::AttachFunction("DK_GetClipboard", DKJS::GetClipboard, 0);
	DKDuktape::AttachFunction("DK_GetData", DKJS::GetData, 1);
	DKDuktape::AttachFunction("DK_GetDate", DKJS::GetDate, 0);
	DKDuktape::AttachFunction("DK_GetEvents", DKJS::GetEvents, 0);
	DKDuktape::AttachFunction("DK_GetFramerate", DKJS::GetFramerate, 0);
	DKDuktape::AttachFunction("DK_GetId", DKJS::GetId, 1);
	DKDuktape::AttachFunction("DK_GetJavascript", DKJS::GetJavascript, 0);
	DKDuktape::AttachFunction("DK_GetKey", DKJS::GetKey, 0);
	DKDuktape::AttachFunction("DK_GetLocalIP", DKJS::GetLocalIP, 0);
	DKDuktape::AttachFunction("DK_GetMouseX", DKJS::GetMouseX, 0); 
	DKDuktape::AttachFunction("DK_GetMouseY", DKJS::GetMouseY, 0);
	DKDuktape::AttachFunction("DK_GetObjects", DKJS::GetObjects, 0);
	DKDuktape::AttachFunction("DK_GetOS", DKJS::GetOS, 0);
	DKDuktape::AttachFunction("DK_GetPixelUnderMouse", DKJS::GetPixelUnderMouse, 0);
	DKDuktape::AttachFunction("DK_GetScreenHeight", DKJS::GetScreenHeight, 0);
	DKDuktape::AttachFunction("DK_GetScreenWidth", DKJS::GetScreenWidth, 0);
	DKDuktape::AttachFunction("DK_GetTime", DKJS::GetTime, 0);
	DKDuktape::AttachFunction("DK_GetType", DKJS::GetType, 1);
	DKDuktape::AttachFunction("DK_GetUsername", DKJS::GetUsername, 0);
	DKDuktape::AttachFunction("DK_GetValue", DKJS::GetValue, 1);
	DKDuktape::AttachFunction("DK_GetVolume", DKJS::GetVolume, 0);
	DKDuktape::AttachFunction("DK_HideConsole", DKJS::HideConsole, 0);
	DKDuktape::AttachFunction("DK_Id", DKJS::Id, 2);
	DKDuktape::AttachFunction("DK_IdLike", DKJS::IdLike, 2);
	DKDuktape::AttachFunction("DK_IE", DKJS::IE, 0);
	DKDuktape::AttachFunction("DK_Include", DKJS::Include, 1);
	DKDuktape::AttachFunction("DK_LeftClick", DKJS::LeftClick, 0);
	DKDuktape::AttachFunction("DK_LogGuiConsole", DKJS::LogGuiConsole, 1);
	DKDuktape::AttachFunction("DK_MessageBox", DKJS::MessageBox, 3);
	DKDuktape::AttachFunction("DK_MouseToImage", DKJS::MouseToImage, 1);
	DKDuktape::AttachFunction("DK_PressKey", DKJS::PressKey, 1);
	DKDuktape::AttachFunction("DK_PrintFunctions", DKJS::PrintFunctions, 0);
	DKDuktape::AttachFunction("DK_ReleaseKey", DKJS::ReleaseKey, 1);
	DKDuktape::AttachFunction("DK_Reload", DKJS::Reload, 0);
	DKDuktape::AttachFunction("DK_RightClick", DKJS::RightClick, 0);
	DKDuktape::AttachFunction("DK_Run", DKJS::Run, 1);
	DKDuktape::AttachFunction("DK_RunJavascript", DKJS::RunJavascript, 1);
	DKDuktape::AttachFunction("DK_SetClipboard", DKJS::SetClipboard, 1);
	DKDuktape::AttachFunction("DK_SetCursorPos", DKJS::SetCursorPos, 2);
	DKDuktape::AttachFunction("DK_SetFramerate", DKJS::SetFramerate, 1);
	DKDuktape::AttachFunction("DK_SetLog", DKJS::_SetLog, 2);
	DKDuktape::AttachFunction("DK_ShowConsole", DKJS::ShowConsole, 0);
	DKDuktape::AttachFunction("DK_Sleep", DKJS::Sleep, 1);
	DKDuktape::AttachFunction("DK_StrokeKey", DKJS::StrokeKey, 1);
	DKDuktape::AttachFunction("DK_System", DKJS::System, 1);
	DKDuktape::AttachFunction("DK_Crash", DKJS::Crash, 0);
	DKDuktape::AttachFunction("DK_Type", DKJS::Type, 2);
	DKDuktape::AttachFunction("DK_Value", DKJS::Value, 2);
	DKDuktape::AttachFunction("DK_WaitForImage", DKJS::WaitForImage, 2);
	DKDuktape::AttachFunction("DK_GetProcessList", DKJS::WaitForImage, 0);
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
	
	DKObject* obj = DKCreate(data);
	if(!obj){
		duk_push_string(ctx, "");
		DKLog("DKJS::_DKCreate("+data+"): obj invalid \n", DKERROR);
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

////////////////////////////////////
int DKJS::_DKValid(duk_context* ctx)
{
	DKString data = duk_require_string(ctx, 0);
	bool valid = DKValid(data);
	if(!valid){
		return 0;
	}
	return 1;
}

////////////////////////////////////////
int DKJS::_DKAvailable(duk_context* ctx)
{
	DKString data = duk_require_string(ctx, 0);
	bool available = DKAvailable(data);
	if(!available){
		return 0;
	}
	return 1;
}

////////////////////////////////////
int DKJS::_DKClose(duk_context* ctx)
{
	DKString value = duk_require_string(ctx, 0);
	DKClose(value);
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

	DKEvent::RemoveEvent(id, type, jsreturn);
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
		SendEvent(id, type, param);
		return 1;
	}

	SendEvent(id, type, "");
	return 1;
}





/////////////////////////////////////////
int DKJS::_DKLoadPlugin(duk_context* ctx)
{
	DKString file = duk_require_string(ctx, 0);
	DKPlugins::LoadPlugin(file);
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
int DKJS::GetDate(duk_context* ctx)
{
	DKString date;
	if(!DKUtil::GetDate(date)){ return 0; }
	duk_push_string(ctx, date.c_str());
	return 1;
}

//////////////////////////////////////////
int DKJS::GetScreenWidth(duk_context* ctx)
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
		return 0;
	}
	duk_push_int(ctx, output);
	return 1;
}

///////////////////////////////////////////
int DKJS::GetScreenHeight(duk_context* ctx)
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
		return 0;
	}
	duk_push_int(ctx, output);
	return 1;
}

////////////////////////////////////////
int DKJS::GetFramerate(duk_context* ctx)
{
	duk_push_int(ctx, DKApp::GetFramerate());
	return 1;
}

/////////////////////////////////
int DKJS::SetFramerate(duk_context* ctx)
{
	int fps = duk_require_int(ctx, 0);
	DKApp::SetFramerate(fps);
	return 1;
}

//////////////////////////////
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

////////////////////////////////
int DKJS::ClearEvents(duk_context* ctx)
{
	DKEvent::events.clear();
	return 1;
}

///////////////////////////////
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

//////////////////////////////////
int DKJS::Reload(duk_context* ctx)
{
	DKDuktape::Reload();
	return 1;
}

////////////////////////////
int DKJS::Include(duk_context* ctx)
{
	//ignore this for now
	return 1;
}

//////////////////////////
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
int DKJS::GetBrowser(duk_context* ctx)
{
	DKString browser = "Rocket";
	duk_push_string(ctx, browser.c_str());
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

/////////////////////////////////////////
int DKJS::GetJavascript(duk_context* ctx)
{
	DKString browser = "Duktape";
	duk_push_string(ctx, browser.c_str());
	return 1;
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

////////////////////////////////////
int DKJS::CallFunc(duk_context* ctx)
{
	DKString func = duk_require_string(ctx, 0);
	DKString args = duk_require_string(ctx, 1);
	DKString result;

	if(!DKClass::CallFunc(func, &args, &result)){
		return 0;
	}
	
	duk_push_string(ctx, result.c_str());
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

////////////////////////////////////
int DKJS::GetValue(duk_context* ctx)
{
	//TODO
	return 0;
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

//////////////////////////////
int DKJS::IE(duk_context* ctx)
{
	return 0;
}

////////////////////////////////////////
int DKJS::SetClipboard(duk_context* ctx)
{
	DKString string = duk_require_string(ctx, 0);
	if(!DKUtil::SetClipboard(string)){ return 0; }
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

//////////////////////////////////////
int DKJS::GetLocalIP(duk_context* ctx)
{
	DKString ip;
	if(!DKUtil::GetLocalIP(ip)){ return 0; }
	duk_push_string(ctx, ip.c_str());
	return 1;
}

/////////////////////////////////////
int DKJS::GetVolume(duk_context* ctx)
{
	float volume;
	if(!DKUtil::GetVolume(volume)){ return 0; }
	duk_push_number(ctx, volume);
	return 1;
}

////////////////////////////////////////
int DKJS::ChangeVolume(duk_context* ctx)
{
	double volume = (double)duk_require_number(ctx, 0);
	if(!DKUtil::ChangeVolume(volume)){ return 0; }
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

/////////////////////////////////////
int DKJS::LeftClick(duk_context* ctx)
{
	if(!DKUtil::LeftClick()){ return 0; }
	return 1;
}

//////////////////////////////////////
int DKJS::RightClick(duk_context* ctx)
{
	if(!DKUtil::RightClick()){ return 0; }
	return 1;
}

///////////////////////////////////////
int DKJS::DoubleClick(duk_context* ctx)
{
	if(!DKUtil::DoubleClick()){ return 0; }
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

//////////////////////////////////////
int DKJS::ClickImage(duk_context* ctx)
{
	DKString file = duk_require_string(ctx, 0);
	int x;
	int y;
	if(!DKUtil::FindImageOnScreen(file, x, y)){ return 0; }
	if(!DKUtil::SetMousePos(x, y)){ return 0; }
	if(!DKUtil::LeftClick()){ return 0; }
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

//////////////////////////////////////
int DKJS::MessageBox(duk_context* ctx)
{
	DKString evt = duk_require_string(ctx, 0);
	DKString cmd = duk_require_string(ctx, 1);
	DKString message = duk_require_string(ctx, 2);
	DKCreate("DKMessage.js");
	DKStringArray arry;
	toStringArray(arry, evt, ",");
	DKString type = arry[0];
	DKString id = arry[1];
	DKString value;
	if(arry.size() > 2){
		value = arry[2];
	}

	if(value.empty()){ SendEvent("DKMessage.html", cmd, id+","+type+","+message); return 0; }
	if(same(value,"CANCEL")){ return 0; }
	duk_push_string(ctx, value.c_str());
	return 1;
}

/////////////////////////////////
int DKJS::Sleep(duk_context* ctx)
{
	int milliseconds = duk_require_int(ctx, 0);
	if(!DKUtil::Sleep(milliseconds)){ return 0; }
	return 1;
}

///////////////////////////////////
int DKJS::GetData(duk_context* ctx)
{
	DKString data = duk_require_string(ctx, 0);
	if(!DKValid(data)){ return 0; }
	DKString output = toString(DKGet(data)->data, ",");
	duk_push_string(ctx, output.c_str());
	return 1;
}

/////////////////////////////////////
int DKJS::Crash(duk_context* ctx)
{
#if !defined(WIN32)
	raise(SIGSEGV);
#else
	abort();
#endif
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

/////////////////////////////////////////
int DKJS::RunJavascript(duk_context* ctx)
{
	DKString code = duk_require_string(ctx, 0);
	DKLog("RunJavascript("+code+")\n", DKDEBUG);
	duk_eval_string(DKDuktape::ctx, code.c_str());
	return 1;
}

///////////////////////////////
int DKJS::Run(duk_context* ctx)
{
	DKString command = duk_require_string(ctx, 0);
	if(!DKUtil::Run(command)){ return 0; }
	return 1;
}

//////////////////////////////////
int DKJS::System(duk_context* ctx)
{
	DKString command = duk_require_string(ctx, 0);
	if(!DKUtil::System(command)){ return 0; }
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

//////////////////////////////////////////
int DKJS::PrintFunctions(duk_context* ctx)
{
	DKLog("\n**** Duktape Functions ****\n", DKINFO);
	for(unsigned int i=0; i < DKDuktape::functions.size(); ++i){
		DKLog(DKDuktape::functions[i]+"\n", DKINFO);
	}
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

////////////////////////////////////
int DKJS::PressKey(duk_context* ctx)
{
	int key = duk_require_int(ctx, 0);
	if(!DKUtil::PressKey(key)){
		return 0;
	}
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

/////////////////////////////////////
int DKJS::StrokeKey(duk_context* ctx)
{
	int key = duk_require_int(ctx, 0);
	if(!DKUtil::StrokeKey(key)){
		return 0;
	}
	return 1;
}

////////////////////////////////
int DKJS::Exit(duk_context* ctx)
{
	DKApp::Exit();
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

///////////////////////////////////
int DKJS::DoFrame(duk_context* ctx)
{
	DKApp::DoFrame();
	return 1;
}

////////////////////////////////
int DKJS::Beep(duk_context* ctx)
{
	DKUtil::Beep();
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

///////////////////////////////////////
int DKJS::HideConsole(duk_context* ctx)
{
#ifdef WIN32
	HWND consoleWindow = GetConsoleWindow();
	ShowWindow(consoleWindow, SW_HIDE);
#endif 
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

//////////////////////////////////////////
int DKJS::GetProcessList(duk_context* ctx)
{
	DKString list;
	DKUtil::GetProcessList(list);
	duk_push_string(ctx, list.c_str());
	return 1;
}

#endif //USE_DKDuktape