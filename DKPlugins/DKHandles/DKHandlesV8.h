#ifdef USE_DKCef
#pragma once
#ifndef DKHandlesV8_H
#define DKHandlesV8_H

#include "DKCef/DKCef.h"

/////////////////////////////////////////////////
class DKHandlesV8 : public DKObjectT<DKHandlesV8>
{
public:
	bool Init();
	bool End();
	
	static bool Click(CefArgs args, CefReturn retval);
	static bool CurrentHandle(CefArgs args, CefReturn retval);
	static bool GetBottom(CefArgs args, CefReturn retval);
	static bool GetClass(CefArgs args, CefReturn retval);
	static bool GetIndex(CefArgs args, CefReturn retval);
	static bool GetLeft(CefArgs args, CefReturn retval);
	static bool GetParent(CefArgs args, CefReturn retval);
	static bool GetRight(CefArgs args, CefReturn retval);
	static bool GetTop(CefArgs args, CefReturn retval);
	static bool GetValue(CefArgs args, CefReturn retval);
	static bool GetWindow(CefArgs args, CefReturn retval);
	static bool GetWindowIndex(CefArgs args, CefReturn retval);
	static bool GetWindows(CefArgs args, CefReturn retval);
	static bool NextHandle(CefArgs args, CefReturn retval);
	static bool PrevHandle(CefArgs args, CefReturn retval);
	//static bool SendHook(CefArgs args, CefReturn retval);
	static bool SetHandle(CefArgs args, CefReturn retval);
	static bool SetValue(CefArgs args, CefReturn retval);
	static bool SetWindowHandle(CefArgs args, CefReturn retval);
	static bool ShowWindow(CefArgs args, CefReturn retval);
	static bool StartSearch(CefArgs args, CefReturn retval);
	static bool ToggleHighlight(CefArgs args, CefReturn retval);
	static bool WaitForHandle(CefArgs args, CefReturn retval);
	static bool WaitForWindow(CefArgs args, CefReturn retval);
	static bool WindowExists(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKHandlesV8, false);

#endif //DKHandlesV8_H
#endif //USE_DKCef