//#ifdef USE_DKCef
#pragma once
#ifndef DKCefV8_H
#define DKCefV8_H

#include "DKCef.h"

/////////////////////////////////////////
class DKCefV8 : public DKObjectT<DKCefV8>
{
public:
	void Init();
	void End();

	static bool _DKCreate(CefArgs args, CefReturn retval);
	static bool _DKValid(CefArgs args, CefReturn retval);
	static bool _SetLog(CefArgs args, CefReturn retval);

	static bool ClickImage(CefArgs args, CefReturn retval);
	static bool Execute(CefArgs args, CefReturn retval);
	static bool GetClipboard(CefArgs args, CefReturn retval);
	static bool GetPixelUnderMouse(CefArgs args, CefReturn retval);
	static bool GetScreenHeight(CefArgs args, CefReturn retval);
	static bool GetScreenWidth(CefArgs args, CefReturn retval);
	static bool HideConsole(CefArgs args, CefReturn retval);
	static bool LeftClick(CefArgs args, CefReturn retval);
	static bool PressKey(CefArgs args, CefReturn retval);
	static bool PrintFunctions(CefArgs args, CefReturn retval);
	static bool ReleaseKey(CefArgs args, CefReturn retval);
	static bool Run(CefArgs args, CefReturn retval);
	static bool RunJavascript(CefArgs args, CefReturn retval);
	static bool SetClipboard(CefArgs args, CefReturn retval);
	static bool SetClipboardFiles(CefArgs args, CefReturn retval);
	static bool SetMousePos(CefArgs args, CefReturn retval);
	static bool ShowConsole(CefArgs args, CefReturn retval);
	static bool StrokeKey(CefArgs args, CefReturn retval);
	static bool System(CefArgs args, CefReturn retval);
	static bool WaitForImage(CefArgs args, CefReturn retval);
	
	//Cef JS functions
	static bool Print(CefArgs args, CefReturn retval);
	static bool ShowDevTools(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKCefV8, false);

#endif //DKCefV8_H
//#endif //USE_DKCef