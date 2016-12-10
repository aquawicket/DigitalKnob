#ifdef USE_DKDuktape 
#pragma once
#ifndef DKJS_H
#define DKJS_H

#include "DKDuktape.h"

////////////////////////////////////
class DKJS : public DKObjectT<DKJS>
{
public:
	void Init();
	static int _DKAddEvent(duk_context* ctx);
	static int _DKAvailable(duk_context* ctx);
	static int _DKClose(duk_context* ctx);
	static int _DKCreate(duk_context* ctx);
	static int _DKLoadPlugin(duk_context* ctx);
	static int _DKLog(duk_context* ctx);
	static int _DKRemoveEvent(duk_context* ctx);
	static int _DKSendEvent(duk_context* ctx);
	static int _DKValid(duk_context* ctx);
	static int _SetLog(duk_context* ctx);
	
	static int Beep(duk_context* ctx);
	static int CallFunc(duk_context* ctx);
	static int ChangeVolume(duk_context* ctx);
	static int ClearEvents(duk_context* ctx);
	static int ClickImage(duk_context* ctx);
	static int DoFrame(duk_context* ctx);
	static int DoubleClick(duk_context* ctx);
	static int Execute(duk_context* ctx);
	static int Exit(duk_context* ctx);
	static int GetBrowser(duk_context* ctx);
	static int GetClipboard(duk_context* ctx);
	static int GetData(duk_context* ctx);
	static int GetDate(duk_context* ctx);
	static int GetEvents(duk_context* ctx);
	static int GetFramerate(duk_context* ctx);
	static int GetId(duk_context* ctx);
	static int GetJavascript(duk_context* ctx);
	static int GetKey(duk_context* ctx);
	static int GetLocalIP(duk_context* ctx);
	static int GetMouseX(duk_context* ctx);
	static int GetMouseY(duk_context* ctx);
	static int GetObjects(duk_context* ctx);
	static int GetOS(duk_context* ctx);
	static int GetScreenHeight(duk_context* ctx);
	static int GetScreenWidth(duk_context* ctx);
	static int GetTime(duk_context* ctx);
	static int GetType(duk_context* ctx);
	static int GetUsername(duk_context* ctx);
	static int GetVolume(duk_context* ctx);
	static int HideConsole(duk_context* ctx);
	static int Id(duk_context* ctx);
	static int IdLike(duk_context* ctx);
	static int IE(duk_context* ctx);
	static int Include(duk_context* ctx);
	static int LeftClick(duk_context* ctx);
	static int LogGuiConsole(duk_context* ctx);
	static int MessageBox(duk_context* ctx);
	static int MouseToImage(duk_context* ctx);
	static int PressKey(duk_context* ctx);
	static int PrintFunctions(duk_context* ctx);
	static int ReleaseKey(duk_context* ctx);
	static int Reload(duk_context* ctx);
	static int RightClick(duk_context* ctx);
	static int Run(duk_context* ctx);
	static int RunJavascript(duk_context* ctx);
	static int SetClipboard(duk_context* ctx);
	static int SetCursorPos(duk_context* ctx);
	static int SetFramerate(duk_context* ctx);
	static int ShowConsole(duk_context* ctx);
	static int Sleep(duk_context* ctx);
	static int StrokeKey(duk_context* ctx);
	static int System(duk_context* ctx);
	static int TestCrash(duk_context* ctx);
	static int Type(duk_context* ctx);
	static int Value(duk_context* ctx);
	static int WaitForImage(duk_context* ctx);	
};


REGISTER_OBJECT(DKJS, true)

#endif //DKJS_H
#endif //USE_DKDuktape