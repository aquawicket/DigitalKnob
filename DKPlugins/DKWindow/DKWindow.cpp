/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2022 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

//TODO - add DKSFMLWindow to all functions

#include "DK/stdafx.h"
#include "DK/DKAndroid.h"
#include "DKWindow/DKWindow.h"


bool DKWindow::Init() {
	DKDEBUGFUNC();
	if (!DKClass::DKValid("DKSDLWindow,DKSDLWindow0") && !DKClass::DKValid("DKOSGWindow,DKOSGWindow0"))
		return DKERROR("DO NOT create DKWindow directly, use DKSDLWindow or DKOSGWindow\n");
	DKClass::DKCreate("DKWindowJS");
	DKClass::DKCreate("DKWindowV8");
	return true;
}

bool DKWindow::End() {
	DKDEBUGFUNC();
	return true;
}

///
///  If "DKWindow::TestInt()" calls a registered function, it will alter the variable and send it back.
///  \a see: DKPlugins/DKSDLWindow.h
bool DKWindow::TestInt(int& input, int& output) {
	//DKDEBUGFUNC(input, output);
	if(DKClass::HasFunc("DKSDLWindow::TestInt"))
		return DKClass::CallFunc("DKSDLWindow::TestInt", &input, &output);
	if(DKClass::HasFunc("DKSFMLWindow::TestInt"))
		return DKClass::CallFunc("DKSFMLWindow::TestInt", &input, &output);
	return DKERROR("DKWindow::TestInt(): No function available\n");
}

///
///  If "DKWindow::TestString()" calls a registered function, it will alter the variable and send it back.
///  \a see: DKPlugins/DKSDLWindow.h
bool DKWindow::TestString(DKString& input, DKString& output) {
	//DKDEBUGFUNC(input, output);
	if(DKClass::HasFunc("DKSDLWindow::TestString"))
		return DKClass::CallFunc("DKSDLWindow::TestString", &input, &output);
	if(DKClass::HasFunc("DKSFMLWindow::TestString"))
		return DKClass::CallFunc("DKSFMLWindow::TestString", &input, &output);
	return DKERROR("DKWindow::TestString(): No function available\n");
}

///
///  If "DKWindow::TestReturnInt()" calls a registered function, it will return a variable.
///  \a see: DKPlugins/DKSDLWindow.h
bool DKWindow::TestReturnInt(int& output) {
	//DKDEBUGFUNC(output);
	if(DKClass::HasFunc("DKSDLWindow::TestReturnInt"))
		return DKClass::CallFunc("DKSDLWindow::TestReturnInt", NULL, &output);
	if(DKClass::HasFunc("DKSFMLWindow::TestReturnInt"))
		return DKClass::CallFunc("DKSFMLWindow::TestReturnInt", NULL, &output);
	return DKERROR("DKWindow::TestReturnInt(): No function available\n");
}

///
///  If "DKWindow::TestReturnString()" calls a registered function, it will return a variable.
///  \a see: DKPlugins/DKSDLWindow.h
bool DKWindow::TestReturnString(DKString& output) {
	//DKDEBUGFUNC(output);
	if(DKClass::HasFunc("DKSDLWindow::TestReturnString"))
		return DKClass::CallFunc("DKSDLWindow::TestReturnString", NULL, &output);
	if(DKClass::HasFunc("DKSFMLWindow::TestReturnString"))
		return DKClass::CallFunc("DKSFMLWindow::TestReturnString", NULL, &output);
	return DKERROR("DKWindow::TestReturnString(): No function available\n");
}

bool DKWindow::Create() {
	DKDEBUGFUNC();
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
		DKWARN("DKWindow::Init(): No window system available\n");
	}
	return false;
}

bool DKWindow::Fullscreen() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCefWindow::Fullscreen"))
		return DKClass::CallFunc("DKCefWindow::Fullscreen", NULL, NULL);
	if(DKClass::HasFunc("DKSDLWindow::Fullscreen"))
		return DKClass::CallFunc("DKSDLWindow::Fullscreen", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Fullscreen"))
		return DKClass::CallFunc("DKOSGWindow::Fullscreen", NULL, NULL);
	return DKERROR("DKWindow::Fullscreen(): No function available\n");
}

bool DKWindow::GetHandle(void*& handle) {
	DKDEBUGFUNC(handle);
	//EXAMPLE
	//HWND hwnd = NULL;
	//DKWindow::GetHandle((void*&)hwnd);
	
	if(DKClass::HasFunc("DKCefWindow::GetHandle"))
		return DKClass::CallFunc("DKCefWindow::GetHandle", NULL, &handle);
	if(DKClass::HasFunc("DKSDLWindow::GetHandle"))
		return DKClass::CallFunc("DKSDLWindow::GetHandle", NULL, &handle);
	if(DKClass::HasFunc("DKOSGWindow::GetHandle"))
		return DKClass::CallFunc("DKOSGWindow::GetHandle", NULL, &handle);
	return DKERROR("DKWindow::GetHandle(): No function available\n");
}

bool DKWindow::GetHeight(int& height) {
	DKDEBUGFUNC(height);
	if(DKClass::HasFunc("DKCefWindow::GetHeight"))
		return DKClass::CallFunc("DKCefWindow::GetHeight", NULL, &height);
	if(DKClass::HasFunc("DKSDLWindow::GetHeight"))
		return DKClass::CallFunc("DKSDLWindow::GetHeight", NULL, &height);
	if(DKClass::HasFunc("DKOSGWindow::GetHeight"))
		return DKClass::CallFunc("DKOSGWindow::GetHeight", NULL, &height);
	return DKERROR("DKWindow::GetHeight(): No function available\n");
}

bool DKWindow::GetMouseX(int& x) {
	DKDEBUGFUNC(x);
	if(DKClass::HasFunc("DKCefWindow::GetMouseX"))
		return DKClass::CallFunc("DKCefWindow::GetMouseX", NULL, &x);
	if(DKClass::HasFunc("DKSDLWindow::GetMouseX"))
		return DKClass::CallFunc("DKSDLWindow::GetMouseX", NULL, &x);
	if(DKClass::HasFunc("DKOSGWindow::GetMouseX"))
		return DKClass::CallFunc("DKOSGWindow::GetMouseX", NULL, &x);
	return DKERROR("DKWindow::GetMouseX(): No function available\n");

}

bool DKWindow::GetMouseY(int& y) {
	DKDEBUGFUNC(y);
	if(DKClass::HasFunc("DKCefWindow::GetMouseY"))
		return DKClass::CallFunc("DKCefWindow::GetMouseY", NULL, &y);
	if(DKClass::HasFunc("DKSDLWindow::GetMouseY"))
		return DKClass::CallFunc("DKSDLWindow::GetMouseY", NULL, &y);
	if(DKClass::HasFunc("DKOSGWindow::GetMouseY"))
		return DKClass::CallFunc("DKOSGWindow::GetMouseY", NULL, &y);
	return DKERROR("DKWindow::GetMouseY(): No function available\n");
}

bool DKWindow::GetPixelRatio(float& ratio) {
	DKDEBUGFUNC(ratio);
	if(DKClass::HasFunc("DKCefWindow::GetPixelRatio"))
		return DKClass::CallFunc("DKCefWindow::GetPixelRatio", NULL, &ratio);
	if(DKClass::HasFunc("DKSDLWindow::GetPixelRatio"))
		return DKClass::CallFunc("DKSDLWindow::GetPixelRatio", NULL, &ratio);
	if(DKClass::HasFunc("DKOSGWindow::GetPixelRatio"))
		return DKClass::CallFunc("DKOSGWindow::GetPixelRatio", NULL, &ratio);
	ratio = 1.0;
	return DKERROR("DKWindow::GetPixelRatio(): No function available\n");
}

bool DKWindow::GetTitle(DKString& title) {
	DKDEBUGFUNC(title);
	if(DKClass::HasFunc("DKCefWindow::GetTitle"))
		return DKClass::CallFunc("DKCefWindow::GetTitle", NULL, &title);
	if(DKClass::HasFunc("DKSDLWindow::GetTitle"))
		return DKClass::CallFunc("DKSDLWindow::GetTitle", NULL, &title);
	if(DKClass::HasFunc("DKOSGWindow::GetTitle"))
		return DKClass::CallFunc("DKOSGWindow::GetTitle", NULL, &title);
	return DKERROR("DKWindow::GetTitle(): No function available\n");
}

bool DKWindow::GetWidth(int& width) {
	DKDEBUGFUNC(width);
	if(DKClass::HasFunc("DKCefWindow::GetWidth"))
		return DKClass::CallFunc("DKCefWindow::GetWidth", NULL, &width);
	if(DKClass::HasFunc("DKSDLWindow::GetWidth"))
		return DKClass::CallFunc("DKSDLWindow::GetWidth", NULL, &width);
	if(DKClass::HasFunc("DKOSGWindow::GetWidth"))
		return DKClass::CallFunc("DKOSGWindow::GetWidth", NULL, &width);
	return DKERROR("DKWindow::GetWidth(): No function available\n");
}

bool DKWindow::GetX(int& x) {
	DKDEBUGFUNC(x);
	if(DKClass::HasFunc("DKCefWindow::GetX"))
		return DKClass::CallFunc("DKCefWindow::GetX", NULL, &x);
	if(DKClass::HasFunc("DKSDLWindow::GetX"))
		return DKClass::CallFunc("DKSDLWindow::GetX", NULL, &x);
	if(DKClass::HasFunc("DKOSGWindow::GetX"))
		return DKClass::CallFunc("DKOSGWindow::GetX", NULL, &x);
	return DKERROR("DKWindow::GetX(): No function available\n");
}

bool DKWindow::GetY(int& y) {
	DKDEBUGFUNC(y);
	if(DKClass::HasFunc("DKCefWindow::GetY"))
		return DKClass::CallFunc("DKCefWindow::GetY", NULL, &y);
	if(DKClass::HasFunc("DKSDLWindow::GetY"))
		return DKClass::CallFunc("DKSDLWindow::GetY", NULL, &y);
	if(DKClass::HasFunc("DKOSGWindow::GetY"))
		return DKClass::CallFunc("DKOSGWindow::GetY", NULL, &y);
	return DKERROR("DKWindow::GetY(): No function available\n");
}

bool DKWindow::Hide() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCefWindow::Hide"))
		return DKClass::CallFunc("DKCefWindow::Hide", NULL, NULL);
	if(DKClass::HasFunc("DKSDLWindow::Hide"))
		return DKClass::CallFunc("DKSDLWindow::Hide", NULL, NULL);
	if (DKClass::HasFunc("DKOSGWindow::Hide"))
		return DKClass::CallFunc("DKOSGWindow::Hide", NULL, NULL);
	return DKERROR("DKWindow::Hide(): No function available\n");
}

bool DKWindow::IsFullscreen(bool& fullscreen) {
	DKDEBUGFUNC(fullscreen);
	if(DKClass::HasFunc("DKCefWindow::IsFullscreen"))
		return DKClass::CallFunc("DKCefWindow::IsFullscreen", NULL, &fullscreen);
	if(DKClass::HasFunc("DKSDLWindow::IsFullscreen"))
		return DKClass::CallFunc("DKSDLWindow::IsFullscreen", NULL, &fullscreen);
	if(DKClass::HasFunc("DKOSGWindow::IsFullscreen"))
		return DKClass::CallFunc("DKOSGWindow::IsFullscreen", NULL, &fullscreen);
	return DKERROR("DKWindow::IsFullscreen(): No function available\n");
}

bool DKWindow::IsVisible(bool& visible) {
	DKDEBUGFUNC(visible);
	if(DKClass::HasFunc("DKCefWindow::IsVisible"))
		return DKClass::CallFunc("DKCefWindow::IsVisible", NULL, &visible);
	if(DKClass::HasFunc("DKSDLWindow::IsVisible"))
		return DKClass::CallFunc("DKSDLWindow::IsVisible", NULL, &visible);
	if(DKClass::HasFunc("DKOSGWindow::IsVisible"))
		return DKClass::CallFunc("DKOSGWindow::IsVisible", NULL, &visible);
	return DKERROR("DKWindow::IsVisible(): No function available\n");
}

bool DKWindow::Maximize() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCefWindow::Maximize"))
		return DKClass::CallFunc("DKCefWindow::Maximize", NULL, NULL);
	if(DKClass::HasFunc("DKSDLWindow::Maximize"))
		return DKClass::CallFunc("DKSDLWindow::Maximize", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Maximize"))
		return DKClass::CallFunc("DKOSGWindow::Maximize", NULL, NULL);
	return DKERROR("DKWindow::Maximize(): No function available\n");
}

bool DKWindow::MessageBox(DKString& msg) {
	DKDEBUGFUNC(msg);
	if(DKClass::HasFunc("DKCefWindow::MessageBox"))
		return DKClass::CallFunc("DKCefWindow::MessageBox", &msg, NULL);
	if(DKClass::HasFunc("DKSDLWindow::MessageBox"))
		return DKClass::CallFunc("DKSDLWindow::MessageBox", &msg, NULL);
	if(DKClass::HasFunc("DKOSGWindow::MessageBox"))
		return DKClass::CallFunc("DKOSGWindow::MessageBox", &msg, NULL);
	return DKERROR("DKWindow::MessageBox(): No function available\n");
}

bool DKWindow::Minimize() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCefWindow::Minimize"))
		return DKClass::CallFunc("DKCefWindow::Minimize", NULL, NULL);
	if(DKClass::HasFunc("DKSDLWindow::Minimize"))
		return DKClass::CallFunc("DKSDLWindow::Minimize", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Minimize"))
		return DKClass::CallFunc("DKOSGWindow::Minimize", NULL, NULL);
	return DKERROR("DKWindow::Minimize(): No function available\n");
}

bool DKWindow::Restore() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCefWindow::Restore"))
		return DKClass::CallFunc("DKCefWindow::Restore", NULL, NULL);
	if(DKClass::HasFunc("DKSDLWindow::Restore"))
		return DKClass::CallFunc("DKSDLWindow::Restore", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Restore"))
		return DKClass::CallFunc("DKOSGWindow::Restore", NULL, NULL);
	return DKERROR("DKWindow::Restore(): No function available\n");
}

bool DKWindow::SetHeight(int& h) {
	DKDEBUGFUNC(h);
	//if(DKClass::HasFunc("DKCefWindow::SetHeight"))
	//	return DKClass::CallFunc("DKCefWindow::SetHeight", &h, NULL);
	if(DKClass::HasFunc("DKSDLWindow::SetHeight"))
		return DKClass::CallFunc("DKSDLWindow::SetHeight", &h, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetHeight"))
		return DKClass::CallFunc("DKOSGWindow::SetHeight", &h, NULL);
	return DKERROR("DKWindow::SetHeight(): No function available\n");
}

bool DKWindow::SetIcon(DKString& file) {
	DKDEBUGFUNC(file);
	if(DKClass::HasFunc("DKCefWindow::SetIcon"))
		return DKClass::CallFunc("DKCefWindow::SetIcon", &file, NULL);
	if(DKClass::HasFunc("DKSDLWindow::SetIcon"))
		return DKClass::CallFunc("DKSDLWindow::SetIcon", &file, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetIcon"))
		return DKClass::CallFunc("DKOSGWindow::SetIcon", &file, NULL);
	return DKERROR("DKWindow::SetIcon(): No function available\n");
}

bool DKWindow::SetTitle(DKString& string) {
	DKDEBUGFUNC(string);
	if(DKClass::HasFunc("DKCefWindow::SetTitle"))
		return DKClass::CallFunc("DKCefWindow::SetTitle", &string, NULL);
	if(DKClass::HasFunc("DKSDLWindow::SetTitle"))
		return DKClass::CallFunc("DKSDLWindow::SetTitle", &string, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetTitle"))
		return DKClass::CallFunc("DKOSGWindow::SetTitle", &string, NULL);
	return DKERROR("DKWindow::SetTitle(): No function available\n");
}

bool DKWindow::SetWidth(int& w) {
	DKDEBUGFUNC(w);
	//if(DKClass::HasFunc("DKCefWindow::SetWidth"))
	//	return DKClass::CallFunc("DKCefWindow::SetWidth", &w, NULL);
	if(DKClass::HasFunc("DKSDLWindow::SetWidth"))
		return DKClass::CallFunc("DKSDLWindow::SetWidth", &w, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetWidth"))
		return DKClass::CallFunc("DKOSGWindow::SetWidth", &w, NULL);
	return DKERROR("DKWindow::SetWidth(): No function available\n");
}

bool DKWindow::SetX(int& x) {
	DKDEBUGFUNC(x);
	//if(DKClass::HasFunc("DKCefWindow::SetX"))
	//	return DKClass::CallFunc("DKCefWindow::SetX", &x, NULL);
	if(DKClass::HasFunc("DKSDLWindow::SetX"))
		return DKClass::CallFunc("DKSDLWindow::SetX", &x, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetX"))
		return DKClass::CallFunc("DKOSGWindow::SetX", &x, NULL);
	return DKERROR("DKWindow::SetX(): No function available\n");
}

bool DKWindow::SetY(int& y) {
	DKDEBUGFUNC(y);
	//if(DKClass::HasFunc("DKCefWindow::SetY"))
	//	return DKClass::CallFunc("DKCefWindow::SetY", &y, NULL);
	if(DKClass::HasFunc("DKSDLWindow::SetY"))
		return DKClass::CallFunc("DKSDLWindow::SetY", &y, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetY"))
		return DKClass::CallFunc("DKOSGWindow::SetY", &y, NULL);
	return DKERROR("DKWindow::SetY(): No function available\n");
}

bool DKWindow::Show() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCefWindow::Show"))
		return DKClass::CallFunc("DKCefWindow::Show", NULL, NULL);
	if(DKClass::HasFunc("DKSDLWindow::Show"))
		return DKClass::CallFunc("DKSDLWindow::Show", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Show"))
		return DKClass::CallFunc("DKOSGWindow::Show", NULL, NULL);
	return DKERROR("DKWindow::Show(): No function available\n");
}

bool DKWindow::Windowed() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCefWindow::Windowed"))
		return DKClass::CallFunc("DKCefWindow::Windowed", NULL, NULL);
	if(DKClass::HasFunc("DKSDLWindow::Windowed"))
		return DKClass::CallFunc("DKSDLWindow::Windowed", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Windowed"))
		return DKClass::CallFunc("DKOSGWindow::Windowed", NULL, NULL);
	return DKERROR("DKWindow::Windowed(): No function available\n");
}
