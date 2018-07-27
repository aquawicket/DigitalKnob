// This is a Switch plugin..  
// To links to DKSDLWindow, DKSFMLWindow, DKCefWindow and DKOSGWindow
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

	///Send a variable to DKClass::CallFunc("DKXXXWindow::TestInt") and recieve a return value.
	static bool TestInt(int& input, int& output);
	
	///Send a variable to DKClass::CallFunc("DKXXXWindow::TestString") and recieve a return value.
	static bool TestString(DKString& input, DKString& output);
	
	///Call DKClass::CallFunc("DKXXXWindow::TestReturnInt") and recieve a return value.
	static bool TestReturnInt(int& output);
	
	///Call DKClass::CallFunc("DKXXXWindow::TestReturnString") and recieve a return value.
	static bool TestReturnString(DKString& output);


	static bool Create();

	///Set the Window to Fullscreen
	static bool Fullscreen();

	///Get the handle of the window
	static bool GetHandle(void*& handle);

	///Get the Height of the window
	static bool GetHeight(int& height);

	///Get the Mouse x postion in the window
	static bool GetMouseX(int& x);

	///Get the Mouse x postion in the window
	static bool GetMouseY(int& y);

	///Get the Pixel Ratio of the window
	static bool GetPixelRatio(float& ratio);
	
	///Get the Title of the window
	static bool GetTitle(DKString& title);

	///Get the Width of the window
	static bool GetWidth(int& width);

	///Get the Left position of the window
	static bool GetX(int& x);

	///Get the Top position of the window
	static bool GetY(int& y);

	///Hide the window
	static bool Hide();

	///Get the Fullscreen status of the window 
	static bool IsFullscreen(bool& fullscreen);

	///Get the Visible status of the window 
	static bool IsVisible(bool& visible);

	///Maximize the window
	static bool Maximize();

	///Display a message box
	static bool MessageBox(DKString& msg);

	///Minimize the window
	static bool Minimize();

	///Restore the window
	static bool Restore();

	///Set the Height of the window
	static bool SetHeight(int& h);

	///Set the Window icon
	static bool SetIcon(DKString& file);

	///Set the Window title
	static bool SetTitle(DKString& string);
	
	///Set the Width of the window
	static bool SetWidth(int& w);

	///Set the Left position of the window
	static bool SetX(int& x);
	
	///Set the Top position of the window
	static bool SetY(int& y);
	
	///Show the window
	static bool Show();

	///Set the Window to Windowed mode
	static bool Windowed();
};

REGISTER_OBJECT(DKWindow, true)
#endif //DKWindow_H

