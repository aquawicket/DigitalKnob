#ifdef USE_DKCef
#pragma once
#ifndef DKWindowV8_H
#define DKWindowV8_H

#include "DKCef/DKCef.h"

///////////////////////////////////////////////
class DKWindowV8 : public DKObjectT<DKWindowV8>
{
public:
	bool DKWindowV8::Init();
	bool DKWindowV8::End();

	static bool TestInt(CefArgs args, CefReturn retval);
	static bool TestString(CefArgs args, CefReturn retval);
	static bool TestReturnInt(CefArgs args, CefReturn retval);
	static bool TestReturnString(CefArgs args, CefReturn retval);

	static bool Create(CefArgs args, CefReturn retval);
	static bool Fullscreen(CefArgs args, CefReturn retval);
	static bool GetHeight(CefArgs args, CefReturn retval);
	static bool GetMouseX(CefArgs args, CefReturn retval);
	static bool GetMouseY(CefArgs args, CefReturn retval);
	static bool GetPixelRatio(CefArgs args, CefReturn retval);
	static bool GetWidth(CefArgs args, CefReturn retval);
	static bool GetX(CefArgs args, CefReturn retval);
	static bool GetY(CefArgs args, CefReturn retval);
	static bool Hide(CefArgs args, CefReturn retval);
	static bool IsFullscreen(CefArgs args, CefReturn retval);
	static bool IsVisible(CefArgs args, CefReturn retval);
	static bool Maximize(CefArgs args, CefReturn retval);
	static bool MessageBox(CefArgs args, CefReturn retval);
	static bool Minimize(CefArgs args, CefReturn retval);
	static bool Restore(CefArgs args, CefReturn retval);
	static bool SetHeight(CefArgs args, CefReturn retval);
	static bool SetIcon(CefArgs args, CefReturn retval);
	static bool SetTitle(CefArgs args, CefReturn retval);
	static bool SetWidth(CefArgs args, CefReturn retval);
	static bool SetX(CefArgs args, CefReturn retval);
	static bool SetY(CefArgs args, CefReturn retval);
	static bool Show(CefArgs args, CefReturn retval);
	static bool Windowed(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKWindowV8, false);

#endif //DKWindowV8_H
#endif //USE_DKCef