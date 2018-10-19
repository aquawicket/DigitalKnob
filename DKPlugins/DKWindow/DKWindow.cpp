//TODO - add DKSFMLWindow to all functions

#include "DK/stdafx.h"
#include "DK/DKAndroid.h"
#include "DKWindow/DKWindow.h"

/////////////////////
bool DKWindow::Init()
{
	DKDebug();
	DKClass::DKCreate("DKWindowJS");
	DKClass::DKCreate("DKWindowV8");
	return true;
}

////////////////////
bool DKWindow::End()
{
	DKDebug();
	return true;
}



///
///  If "DKWindow::TestInt()" calls a registered function, it will alter the variable and send it back.
///  \a see: DKPlugins/DKSDLWindow.h
bool DKWindow::TestInt(int& input, int& output)
{
	DKDebug(input, output);
	if(DKClass::HasFunc("DKSDLWindow::TestInt")){
		return DKClass::CallFunc("DKSDLWindow::TestInt", &input, &output);
	}
	if(DKClass::HasFunc("DKSFMLWindow::TestInt")){
		return DKClass::CallFunc("DKSFMLWindow::TestInt", &input, &output);
	}
	DKLog("DKWindow::TestInt(): No function available \n", DKWARN);
	return false;
}

///
///  If "DKWindow::TestString()" calls a registered function, it will alter the variable and send it back.
///  \a see: DKPlugins/DKSDLWindow.h
bool DKWindow::TestString(DKString& input, DKString& output)
{
	DKDebug(input, output);
	if(DKClass::HasFunc("DKSDLWindow::TestString")){
		return DKClass::CallFunc("DKSDLWindow::TestString", &input, &output);
	}
	if(DKClass::HasFunc("DKSFMLWindow::TestString")){
		return DKClass::CallFunc("DKSFMLWindow::TestString", &input, &output);
	}
	DKLog("DKWindow::TestString(): No function available \n", DKWARN);
	return false;
}

///
///  If "DKWindow::TestReturnInt()" calls a registered function, it will return a variable.
///  \a see: DKPlugins/DKSDLWindow.h
bool DKWindow::TestReturnInt(int& output)
{
	DKDebug(output);
	if(DKClass::HasFunc("DKSDLWindow::TestReturnInt")){
		return DKClass::CallFunc("DKSDLWindow::TestReturnInt", NULL, &output);
	}
	if(DKClass::HasFunc("DKSFMLWindow::TestReturnInt")){
		return DKClass::CallFunc("DKSFMLWindow::TestReturnInt", NULL, &output);
	}
	DKLog("DKWindow::TestReturnInt(): No function available \n", DKWARN);
	return false;
}

///
///  If "DKWindow::TestReturnString()" calls a registered function, it will return a variable.
///  \a see: DKPlugins/DKSDLWindow.h
bool DKWindow::TestReturnString(DKString& output)
{
	DKDebug(output);
	if(DKClass::HasFunc("DKSDLWindow::TestReturnString")){
		return DKClass::CallFunc("DKSDLWindow::TestReturnString", NULL, &output);
	}
	if(DKClass::HasFunc("DKSFMLWindow::TestReturnString")){
		return DKClass::CallFunc("DKSFMLWindow::TestReturnString", NULL, &output);
	}
	DKLog("DKWindow::TestReturnString(): No function available \n", DKWARN);
	return false;
}


///////////////////////
bool DKWindow::Create()
{
	DKDebug();
	//Create DKSDLWindow or DKOSGWindow
	if(DKClass::DKAvailable("DKSDLWindow")){
		DKClass::DKCreate("DKSDLWindow");
		return true;
	}
	else if(DKClass::DKAvailable("DKSFMLWindow")){
		DKClass::DKCreate("DKSFMLWindow");
		return true;
	}
	else if(DKClass::DKAvailable("DKOSGWindow")){
		DKClass::DKCreate("DKOSGWindow");
		return true;
	}
	else{
		DKLog("DKWindow::Init(): No window system available \n", DKWARN);
	}
	return false;
}

///////////////////////////
bool DKWindow::Fullscreen()
{
	DKDebug();
	if(DKClass::HasFunc("DKCefWindow::Fullscreen")){
		return DKClass::CallFunc("DKCefWindow::Fullscreen", NULL, NULL);
	}
	if(DKClass::HasFunc("DKSDLWindow::Fullscreen")){
		return DKClass::CallFunc("DKSDLWindow::Fullscreen", NULL, NULL);
	}
	if(DKClass::HasFunc("DKOSGWindow::Fullscreen")){
		return DKClass::CallFunc("DKOSGWindow::Fullscreen", NULL, NULL);
	}
	DKLog("DKWindow::Fullscreen(): No function available \n", DKWARN);
	return false;
}

///////////////////////////////////////
bool DKWindow::GetHandle(void*& handle)
{
	DKDebug(handle);
	//EXAMPLE
	//HWND hwnd = NULL;
	//DKWindow::GetHandle((void*&)hwnd);
	
	if(DKClass::HasFunc("DKCefWindow::GetHandle")){
		return DKClass::CallFunc("DKCefWindow::GetHandle", NULL, &handle);
	}
	if(DKClass::HasFunc("DKSDLWindow::GetHandle")){
		return DKClass::CallFunc("DKSDLWindow::GetHandle", NULL, &handle);
	}
	if(DKClass::HasFunc("DKOSGWindow::GetHandle")){
		return DKClass::CallFunc("DKOSGWindow::GetHandle", NULL, &handle);
	}
	DKLog("DKWindow::GetHandle(): No function available \n", DKWARN);
	return false;
}

/////////////////////////////////////
bool DKWindow::GetHeight(int& height)
{
	DKDebug(height);
	if(DKClass::HasFunc("DKCefWindow::GetHeight")){
		return DKClass::CallFunc("DKCefWindow::GetHeight", NULL, &height);
	}
	if(DKClass::HasFunc("DKSDLWindow::GetHeight")){
		return DKClass::CallFunc("DKSDLWindow::GetHeight", NULL, &height);
	}
	if(DKClass::HasFunc("DKOSGWindow::GetHeight")){
		return DKClass::CallFunc("DKOSGWindow::GetHeight", NULL, &height);
	}
	DKLog("DKWindow::GetHeight(): No function available \n", DKWARN);
	return false;
}

////////////////////////////////
bool DKWindow::GetMouseX(int& x)
{
	DKDebug(x);
	if(DKClass::HasFunc("DKCefWindow::GetMouseX")){
		return DKClass::CallFunc("DKCefWindow::GetMouseX", NULL, &x);
	}
	if(DKClass::HasFunc("DKSDLWindow::GetMouseX")){
		return DKClass::CallFunc("DKSDLWindow::GetMouseX", NULL, &x);
	}
	if(DKClass::HasFunc("DKOSGWindow::GetMouseX")){
		return DKClass::CallFunc("DKOSGWindow::GetMouseX", NULL, &x);
	}
	DKLog("DKWindow::GetMouseX(): No function available \n", DKWARN);
	return false;
}

////////////////////////////////
bool DKWindow::GetMouseY(int& y)
{
	DKDebug(y);
	if(DKClass::HasFunc("DKCefWindow::GetMouseY")){
		return DKClass::CallFunc("DKCefWindow::GetMouseY", NULL, &y);
	}
	if(DKClass::HasFunc("DKSDLWindow::GetMouseY")){
		return DKClass::CallFunc("DKSDLWindow::GetMouseY", NULL, &y);
	}
	if(DKClass::HasFunc("DKOSGWindow::GetMouseY")){
		return DKClass::CallFunc("DKOSGWindow::GetMouseY", NULL, &y);
	}
	DKLog("DKWindow::GetMouseY(): No function available \n", DKWARN);
	return false;
}

//////////////////////////////////////////
bool DKWindow::GetPixelRatio(float& ratio)
{
	DKDebug(ratio);
	if(DKClass::HasFunc("DKCefWindow::GetPixelRatio")){
		return DKClass::CallFunc("DKCefWindow::GetPixelRatio", NULL, &ratio);
	}
	if(DKClass::HasFunc("DKSDLWindow::GetPixelRatio")){
		return DKClass::CallFunc("DKSDLWindow::GetPixelRatio", NULL, &ratio);
	}
	if(DKClass::HasFunc("DKOSGWindow::GetPixelRatio")){
		return DKClass::CallFunc("DKOSGWindow::GetPixelRatio", NULL, &ratio);
	}
	DKLog("DKWindow::GetPixelRatio(): No function available \n", DKWARN);
	ratio = 1.0;
	return false;
}

////////////////////////////////////////
bool DKWindow::GetTitle(DKString& title)
{
	DKDebug(title);
	if(DKClass::HasFunc("DKCefWindow::GetTitle")){
		return DKClass::CallFunc("DKCefWindow::GetTitle", NULL, &title);
	}
	if(DKClass::HasFunc("DKSDLWindow::GetTitle")){
		return DKClass::CallFunc("DKSDLWindow::GetTitle", NULL, &title);
	}
	if(DKClass::HasFunc("DKOSGWindow::GetTitle")){
		return DKClass::CallFunc("DKOSGWindow::GetTitle", NULL, &title);
	}
	DKLog("DKWindow::GetTitle(): No function available \n", DKWARN);
	return false;
}

///////////////////////////////////
bool DKWindow::GetWidth(int& width)
{
	DKDebug(width);
	if(DKClass::HasFunc("DKCefWindow::GetWidth")){
		return DKClass::CallFunc("DKCefWindow::GetWidth", NULL, &width);
	}
	if(DKClass::HasFunc("DKSDLWindow::GetWidth")){
		return DKClass::CallFunc("DKSDLWindow::GetWidth", NULL, &width);
	}
	if(DKClass::HasFunc("DKOSGWindow::GetWidth")){
		return DKClass::CallFunc("DKOSGWindow::GetWidth", NULL, &width);
	}
	DKLog("DKWindow::GetWidth(): No function available \n", DKWARN);
	return false;
}

///////////////////////////
bool DKWindow::GetX(int& x)
{
	DKDebug(x);
	if(DKClass::HasFunc("DKCefWindow::GetX")){
		return DKClass::CallFunc("DKCefWindow::GetX", NULL, &x);
	}
	if(DKClass::HasFunc("DKSDLWindow::GetX")){
		return DKClass::CallFunc("DKSDLWindow::GetX", NULL, &x);
	}
	if(DKClass::HasFunc("DKOSGWindow::GetX")){
		return DKClass::CallFunc("DKOSGWindow::GetX", NULL, &x);
	}
	DKLog("DKWindow::GetX(): No function available \n", DKWARN);
	return false;
}

///////////////////////////
bool DKWindow::GetY(int& y)
{
	DKDebug(y);
	if(DKClass::HasFunc("DKCefWindow::GetY")){
		return DKClass::CallFunc("DKCefWindow::GetY", NULL, &y);
	}
	if(DKClass::HasFunc("DKSDLWindow::GetY")){
		return DKClass::CallFunc("DKSDLWindow::GetY", NULL, &y);
	}
	if(DKClass::HasFunc("DKOSGWindow::GetY")){
		return DKClass::CallFunc("DKOSGWindow::GetY", NULL, &y);
	}
	DKLog("DKWindow::GetY(): No function available \n", DKWARN);
	return false;
}

/////////////////////
bool DKWindow::Hide()
{
	DKDebug();
	if(DKClass::HasFunc("DKCefWindow::Hide")){
		return DKClass::CallFunc("DKCefWindow::Hide", NULL, NULL);
	}
	if(DKClass::HasFunc("DKSDLWindow::Hide")){
		return DKClass::CallFunc("DKSDLWindow::Hide", NULL, NULL);
	}
	if(DKClass::HasFunc("DKOSGWindow::Hide")){
		return DKClass::CallFunc("DKOSGWindow::Hide", NULL, NULL);
	}
	DKLog("DKWindow::Hide(): No function available \n", DKWARN);
	return false;
}

/////////////////////////////////////////////
bool DKWindow::IsFullscreen(bool& fullscreen)
{
	DKDebug(fullscreen);
	if(DKClass::HasFunc("DKCefWindow::IsFullscreen")){
		return DKClass::CallFunc("DKCefWindow::IsFullscreen", NULL, &fullscreen);
	}
	if(DKClass::HasFunc("DKSDLWindow::IsFullscreen")){
		return DKClass::CallFunc("DKSDLWindow::IsFullscreen", NULL, &fullscreen);
	}
	if(DKClass::HasFunc("DKOSGWindow::IsFullscreen")){
		return DKClass::CallFunc("DKOSGWindow::IsFullscreen", NULL, &fullscreen);
	}
	DKLog("DKWindow::IsFullscreen(): No function available \n", DKWARN);
	return false;
}

///////////////////////////////////////
bool DKWindow::IsVisible(bool& visible)
{
	DKDebug(visible);
	if(DKClass::HasFunc("DKCefWindow::IsVisible")){
		return DKClass::CallFunc("DKCefWindow::IsVisible", NULL, &visible);
	}
	if(DKClass::HasFunc("DKSDLWindow::IsVisible")){
		return DKClass::CallFunc("DKSDLWindow::IsVisible", NULL, &visible);
	}
	if(DKClass::HasFunc("DKOSGWindow::IsVisible")){
		return DKClass::CallFunc("DKOSGWindow::IsVisible", NULL, &visible);
	}
	DKLog("DKWindow::IsVisible(): No function available \n", DKWARN);
	return false;
}

/////////////////////////
bool DKWindow::Maximize()
{
	DKDebug();
	if(DKClass::HasFunc("DKCefWindow::Maximize")) {
		return DKClass::CallFunc("DKCefWindow::Maximize", NULL, NULL);
	}
	if(DKClass::HasFunc("DKSDLWindow::Maximize")){
		return DKClass::CallFunc("DKSDLWindow::Maximize", NULL, NULL);
	}
	if(DKClass::HasFunc("DKOSGWindow::Maximize")){
		return DKClass::CallFunc("DKOSGWindow::Maximize", NULL, NULL);
	}
	DKLog("DKWindow::Maximize(): No function available \n", DKWARN);
	return false;
}

////////////////////////////////////////
bool DKWindow::MessageBox(DKString& msg)
{
	DKDebug(msg);
	if(DKClass::HasFunc("DKCefWindow::MessageBox")){
		return DKClass::CallFunc("DKCefWindow::MessageBox", &msg, NULL);
	}
	if(DKClass::HasFunc("DKSDLWindow::MessageBox")){
		return DKClass::CallFunc("DKSDLWindow::MessageBox", &msg, NULL);
	}
	if(DKClass::HasFunc("DKOSGWindow::MessageBox")){
		return DKClass::CallFunc("DKOSGWindow::MessageBox", &msg, NULL);
	}
	DKLog("DKWindow::MessageBox(): No function available \n", DKWARN);
	return false;
}

/////////////////////////
bool DKWindow::Minimize()
{
	DKDebug();
	if(DKClass::HasFunc("DKCefWindow::Minimize")) {
		return DKClass::CallFunc("DKCefWindow::Minimize", NULL, NULL);
	}
	if(DKClass::HasFunc("DKSDLWindow::Minimize")){
		return DKClass::CallFunc("DKSDLWindow::Minimize", NULL, NULL);
	}
	if(DKClass::HasFunc("DKOSGWindow::Minimize")){
		return DKClass::CallFunc("DKOSGWindow::Minimize", NULL, NULL);
	}
	DKLog("DKWindow::Minimize(): No function available \n", DKWARN);
	return false;
}

////////////////////////
bool DKWindow::Restore()
{
	DKDebug();
	if(DKClass::HasFunc("DKCefWindow::Restore")) {
		return DKClass::CallFunc("DKCefWindow::Restore", NULL, NULL);
	}
	if(DKClass::HasFunc("DKSDLWindow::Restore")){
		return DKClass::CallFunc("DKSDLWindow::Restore", NULL, NULL);
	}
	if(DKClass::HasFunc("DKOSGWindow::Restore")){
		return DKClass::CallFunc("DKOSGWindow::Restore", NULL, NULL);
	}
	DKLog("DKWindow::Restore(): No function available \n", DKWARN);
	return false;
}

////////////////////////////////
bool DKWindow::SetHeight(int& h)
{
	DKDebug(h);
	if(DKClass::HasFunc("DKCefWindow::SetHeight")){
		return DKClass::CallFunc("DKCefWindow::SetHeight", &h, NULL);
	}
	if(DKClass::HasFunc("DKSDLWindow::SetHeight")){
		return DKClass::CallFunc("DKSDLWindow::SetHeight", &h, NULL);
	}
	if(DKClass::HasFunc("DKOSGWindow::SetHeight")){
		return DKClass::CallFunc("DKOSGWindow::SetHeight", &h, NULL);
	}
	DKLog("DKWindow::SetHeight(): No function available \n", DKWARN);
	return false;
}

//////////////////////////////////////
bool DKWindow::SetIcon(DKString& file)
{
	DKDebug(file);
	if(DKClass::HasFunc("DKCefWindow::SetIcon")){
		return DKClass::CallFunc("DKCefWindow::SetIcon", &file, NULL);
	}
	if(DKClass::HasFunc("DKSDLWindow::SetIcon")){
		return DKClass::CallFunc("DKSDLWindow::SetIcon", &file, NULL);
	}
	if(DKClass::HasFunc("DKOSGWindow::SetIcon")){
		return DKClass::CallFunc("DKOSGWindow::SetIcon", &file, NULL);
	}
	DKLog("DKWindow::SetIcon(): No function available \n", DKWARN);
	return false;
}

/////////////////////////////////////////
bool DKWindow::SetTitle(DKString& string)
{
	DKDebug(string);
	if(DKClass::HasFunc("DKCefWindow::SetTitle")){
		return DKClass::CallFunc("DKCefWindow::SetTitle", &string, NULL);
	}
	if(DKClass::HasFunc("DKSDLWindow::SetTitle")){
		return DKClass::CallFunc("DKSDLWindow::SetTitle", &string, NULL);
	}
	if(DKClass::HasFunc("DKOSGWindow::SetTitle")){
		return DKClass::CallFunc("DKOSGWindow::SetTitle", &string, NULL);
	}
	DKLog("DKWindow::SetTitle(): No function available \n", DKWARN);
	return false;
}

///////////////////////////////
bool DKWindow::SetWidth(int& w)
{
	DKDebug(w);
	if(DKClass::HasFunc("DKCefWindow::SetWidth")){
		return DKClass::CallFunc("DKCefWindow::SetWidth", &w, NULL);
	}
	if(DKClass::HasFunc("DKSDLWindow::SetWidth")){
		return DKClass::CallFunc("DKSDLWindow::SetWidth", &w, NULL);
	}
	if(DKClass::HasFunc("DKOSGWindow::SetWidth")){
		return DKClass::CallFunc("DKOSGWindow::SetWidth", &w, NULL);
	}
	DKLog("DKWindow::SetWidth(): No function available \n", DKWARN);
	return false;
}

///////////////////////////
bool DKWindow::SetX(int& x)
{
	DKDebug(x);
	if(DKClass::HasFunc("DKCefWindow::SetX")){
		return DKClass::CallFunc("DKCefWindow::SetX", &x, NULL);
	}
	if(DKClass::HasFunc("DKSDLWindow::SetX")){
		return DKClass::CallFunc("DKSDLWindow::SetX", &x, NULL);
	}
	if(DKClass::HasFunc("DKOSGWindow::SetX")){
		return DKClass::CallFunc("DKOSGWindow::SetX", &x, NULL);
	}
	DKLog("DKWindow::SetX(): No function available \n", DKWARN);
	return false;
}

///////////////////////////
bool DKWindow::SetY(int& y)
{
	DKDebug(y);
	if(DKClass::HasFunc("DKCefWindow::SetY")){
		return DKClass::CallFunc("DKCefWindow::SetY", &y, NULL);
	}
	if(DKClass::HasFunc("DKSDLWindow::SetY")){
		return DKClass::CallFunc("DKSDLWindow::SetY", &y, NULL);
	}
	if(DKClass::HasFunc("DKOSGWindow::SetY")){
		return DKClass::CallFunc("DKOSGWindow::SetY", &y, NULL);
	}
	DKLog("DKWindow::SetY(): No function available \n", DKWARN);
	return false;
}

/////////////////////
bool DKWindow::Show()
{
	DKDebug();
	if(DKClass::HasFunc("DKCefWindow::Show")){
		return DKClass::CallFunc("DKCefWindow::Show", NULL, NULL);
	}
	if(DKClass::HasFunc("DKSDLWindow::Show")){
		return DKClass::CallFunc("DKSDLWindow::Show", NULL, NULL);
	}
	if(DKClass::HasFunc("DKOSGWindow::Show")){
		return DKClass::CallFunc("DKOSGWindow::Show", NULL, NULL);
	}
	DKLog("DKWindow::Show(): No function available \n", DKWARN);
	return false;
}

/////////////////////////
bool DKWindow::Windowed()
{
	DKDebug();
	if(DKClass::HasFunc("DKCefWindow::Windowed")){
		return DKClass::CallFunc("DKCefWindow::Windowed", NULL, NULL);
	}
	if(DKClass::HasFunc("DKSDLWindow::Windowed")){
		return DKClass::CallFunc("DKSDLWindow::Windowed", NULL, NULL);
	}
	if(DKClass::HasFunc("DKOSGWindow::Windowed")){
		return DKClass::CallFunc("DKOSGWindow::Windowed", NULL, NULL);
	}
	DKLog("DKWindow::Windowed(): No function available \n", DKWARN);
	return false;
}