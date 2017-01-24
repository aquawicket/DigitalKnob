// This is a Switch plugin..  
// To links to DKOSGWindow and DKSDLWindow
// When we call DKWindow commands, this class will determine the proper window system to use. 

#pragma once
#ifndef DKWindow_H
#define DKWindow_H
#include "DK.h"

///////////////////////////////////////////
class DKWindow : public DKObjectT<DKWindow>
{
public:
	void Init();
	void End();

	static int TestInt(int input);
	static DKString TestString(DKString input);
	static int TestReturnInt();
	static DKString TestReturnString();

	static int GetX();
	static int GetY();
	static int GetWidth();
	static int GetHeight();
	static void SetX(int x);
	static void SetY(int y);
	static void SetWidth(int w);
	static void SetHeight(int h);
	static float GetPixelRatio();
	static bool IsFullscreen();
	static void Fullscreen();
	static void Windowed();
	static void Minimize();
	static void Restore();
	static bool IsVisible();
	static void Hide();
	static void Show();
	static int GetMouseX();
	static int GetMouseY();

#ifdef WIN32
	static HWND GetHwnd();
#endif

};

REGISTER_OBJECT(DKWindow, true)
#endif //DKWindow_H

