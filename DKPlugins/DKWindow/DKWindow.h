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

	///Send a variable to DKClass::CallFunc("DKSDLWindow::TestInt") and recieve a return value.
	static int TestInt(int input);
	
	///Send a variable to DKClass::CallFunc("DKSDLWindow::TestString") and recieve a return value.
	static DKString TestString(DKString input);
	
	///Call DKClass::CallFunc("DKSDLWindow::TestReturnInt") and recieve a return value.
	static int TestReturnInt();
	
	///Call DKClass::CallFunc("DKSDLWindow::TestReturnString") and recieve a return value.
	static DKString TestReturnString();

	///Get the Left position of the window
	static int GetX();
	
	///Get the Top position of the window
	static int GetY();
	
	///Get the Width of the window
	static int GetWidth();
	
	///Get the Height of the window
	static int GetHeight();
	
	///Set the Left position of the window
	static void SetX(int x);
	
	///Set the Top position of the window
	static void SetY(int y);
	
	///Set the Width of the window
	static void SetWidth(int w);
	
	///Set the Height of the window
	static void SetHeight(int h);
	
	///Get the Pixel Ratio of the window
	static float GetPixelRatio();
	
	///Get the Fullscreen status of the window 
	static bool IsFullscreen();
	
	///Set the Window to Fullscreen
	static void Fullscreen();
	
	///Set the Window to Windowed mode
	static void Windowed();
	
	///Minimize the window
	static void Minimize();
	
	///Restore the window
	static void Restore();
	
	///Get the Visible status of the window 
	static bool IsVisible();
	
	///Hide the window
	static void Hide();
	
	///Show the window
	static void Show();
	
	///Get the Mouse x postion in the window
	static int GetMouseX();
	
	///Get the Mouse x postion in the window
	static int GetMouseY();

	///Display a message box
	bool MessageBox(void* input, void* output);

#ifdef WIN32
	static HWND GetHwnd();
#endif

};

REGISTER_OBJECT(DKWindow, true)
#endif //DKWindow_H

