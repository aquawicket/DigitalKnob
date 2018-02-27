// This is a Switch plugin..  
// To links to DKCefWindow, DKOSGWindow and DKSDLWindow
// When we call DKWindow commands, this class will determine the proper window system to use. 

#pragma once
#ifndef DKWindow_H
#define DKWindow_H
#include "DK/DK.h"

///////////////////////////////////////////
class DKWindow : public DKObjectT<DKWindow>
{
public:
	bool Init();
	bool End();

	static bool Create();

	///Send a variable to DKClass::CallFunc("DKSDLWindow::TestInt") and recieve a return value.
	static bool TestInt(int& input, int& output);
	
	///Send a variable to DKClass::CallFunc("DKSDLWindow::TestString") and recieve a return value.
	static bool TestString(DKString& input, DKString& output);
	
	///Call DKClass::CallFunc("DKSDLWindow::TestReturnInt") and recieve a return value.
	static bool TestReturnInt(int& output);
	
	///Call DKClass::CallFunc("DKSDLWindow::TestReturnString") and recieve a return value.
	static bool TestReturnString(DKString& output);

	///Set the Window icon
	static bool SetIcon(DKString& file);

	///Set the Window title
	static bool SetTitle(DKString& string);

	///Get the Left position of the window
	static bool GetX(int& x);
	
	///Get the Top position of the window
	static bool GetY(int& y);
	
	///Get the Width of the window
	static bool GetWidth(int& width);
	
	///Get the Height of the window
	static bool GetHeight(int& height);
	
	///Set the Left position of the window
	static bool SetX(int& x);
	
	///Set the Top position of the window
	static bool SetY(int& y);
	
	///Set the Width of the window
	static bool SetWidth(int& w);
	
	///Set the Height of the window
	static bool SetHeight(int& h);
	
	///Get the Pixel Ratio of the window
	static bool GetPixelRatio(float& ratio);
	
	///Get the Fullscreen status of the window 
	static bool IsFullscreen(bool& fullscreen);
	
	///Set the Window to Fullscreen
	static bool Fullscreen();
	
	///Set the Window to Windowed mode
	static bool Windowed();
	
	///Minimize the window
	static bool Minimize();
	
	///Restore the window
	static bool Restore();
	
	///Get the Visible status of the window 
	static bool IsVisible(bool& visible);
	
	///Hide the window
	static bool Hide();
	
	///Show the window
	static bool Show();
	
	///Get the Mouse x postion in the window
	static bool GetMouseX(int& x);
	
	///Get the Mouse x postion in the window
	static bool GetMouseY(int& y);

	///Display a message box
	static bool MessageBox(DKString& msg);

#ifdef WIN32
	static bool GetHwnd(HWND* hwnd);
#endif

};

REGISTER_OBJECT(DKWindow, true)
#endif //DKWindow_H

