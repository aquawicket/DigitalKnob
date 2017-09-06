#ifdef USE_DKCef
#pragma once
#ifndef DKHookV8_H
#define DKHookV8_H

#include "DKCef.h"

///////////////////////////////////////////
class DKHookV8 : public DKObjectT<DKHookV8>
{
public:
	void Init();
	void End();

	//static bool Test(CefArgs args, CefReturn retval);
	static bool SendHook(CefArgs args, CefReturn retval);
	static bool GetValue(CefArgs args, CefReturn retval);
	static bool SetValue(CefArgs args, CefReturn retval);
	static bool GetClass(CefArgs args, CefReturn retval);
	static bool GetTop(CefArgs args, CefReturn retval);
	static bool GetLeft(CefArgs args, CefReturn retval);
	static bool GetParent(CefArgs args, CefReturn retval);
	static bool Click(CefArgs args, CefReturn retval);
	static bool SetHandle(CefArgs args, CefReturn retval);
	static bool PrevHandle(CefArgs args, CefReturn retval);
	static bool NextHandle(CefArgs args, CefReturn retval);
	static bool ToggleHighlight(CefArgs args, CefReturn retval);
	static bool SetWindowHandle(CefArgs args, CefReturn retval);
	static bool GetWindows(CefArgs args, CefReturn retval);
	static bool CurrentHandle(CefArgs args, CefReturn retval);
	static bool WindowExists(CefArgs args, CefReturn retval);
	static bool WaitForWindow(CefArgs args, CefReturn retval);
	static bool WaitForHandle(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKHookV8, false);

#endif //DKHookV8_H
#endif //USE_DKCef