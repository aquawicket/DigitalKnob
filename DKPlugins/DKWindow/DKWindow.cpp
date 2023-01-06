/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
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
#include "DK/stdafx.h"
#include "DK/DKAndroid.h"
#include "DKWindow/DKWindow.h"


bool DKWindow::Init(){
	DKDEBUGFUNC();
	if(	!DKClass::DKValid("DKCEFWindow,DKCEFWindow0") &&
		!DKClass::DKValid("DKOSGWindow,DKOSGWindow0") &&
		!DKClass::DKValid("DKSDLWindow,DKSDLWindow0") && 
		!DKClass::DKValid("DKSFMLWindow,DKSFMLWindow0") )
		return DKERROR("DO NOT create DKWindow directly, use DKCEFWindow, DKOSGWindow, DKSDLWindow or DKSFMLWindow\n");
	DKClass::DKCreate("DKWindowJS");
	DKClass::DKCreate("DKWindowV8");
	return true;
}

bool DKWindow::End(){
	DKDEBUGFUNC();
	return true;
}

///
///  If "DKWindow::TestInt()" calls a registered function, it will alter the variable and send it back.
///  \a see: DKPlugins/DKSDLWindow.h
bool DKWindow::TestInt(int& input, int& output){
	DKDEBUGFUNC(input, output);
	if(DKClass::HasFunc("DKCEFWindow::TestInt"))
		return DKClass::CallFunc("DKCEFWindow::TestInt", &input, &output);
	if(DKClass::HasFunc("DKOSGWindow::TestInt"))
		return DKClass::CallFunc("DKOSGWindow::TestInt", &input, &output);
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
	DKDEBUGFUNC(input, output);
	if(DKClass::HasFunc("DKCEFWindow::TestString"))
		return DKClass::CallFunc("DKCEFWindow::TestString", &input, &output);
	if(DKClass::HasFunc("DKOSGWindow::TestString"))
		return DKClass::CallFunc("DKOSGWindow::TestString", &input, &output);
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
	DKDEBUGFUNC(output);
	if(DKClass::HasFunc("DKCEFWindow::TestReturnInt"))
		return DKClass::CallFunc("DKCEFWindow::TestReturnInt", NULL, &output);
	if(DKClass::HasFunc("DKOSGWindow::TestReturnInt"))
		return DKClass::CallFunc("DKOSGWindow::TestReturnInt", NULL, &output);
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
	DKDEBUGFUNC(output);
	if(DKClass::HasFunc("DKCEFWindow::TestReturnString"))
		return DKClass::CallFunc("DKCEFWindow::TestReturnString", NULL, &output);
	if(DKClass::HasFunc("DKOSGWindow::TestReturnString"))
		return DKClass::CallFunc("DKOSGWindow::TestReturnString", NULL, &output);
	if(DKClass::HasFunc("DKSDLWindow::TestReturnString"))
		return DKClass::CallFunc("DKSDLWindow::TestReturnString", NULL, &output);
	if(DKClass::HasFunc("DKSFMLWindow::TestReturnString"))
		return DKClass::CallFunc("DKSFMLWindow::TestReturnString", NULL, &output);
	return DKERROR("DKWindow::TestReturnString(): No function available\n");
}

bool DKWindow::Create() {
	DKDEBUGFUNC();
	if(DKClass::DKAvailable("DKCEFWindow")) {
		DKClass::DKCreate("DKCEFWindow");
		return true;
	}
	if(DKClass::DKAvailable("DKOSGWindow")) {
		DKClass::DKCreate("DKOSGWindow");
		return true;
	}
	if(DKClass::DKAvailable("DKSDLWindow")){
		DKClass::DKCreate("DKSDLWindow");
		return true;
	}
	if(DKClass::DKAvailable("DKSFMLWindow")){
		DKClass::DKCreate("DKSFMLWindow");
		return true;
	}
	return DKERROR("DKWindow::Init(): No window system available\n");
}

bool DKWindow::Fullscreen() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCEFWindow::Fullscreen"))
		return DKClass::CallFunc("DKCEFWindow::Fullscreen", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Fullscreen"))
		return DKClass::CallFunc("DKOSGWindow::Fullscreen", NULL, NULL);
	if(DKClass::HasFunc("DKSDLWindow::Fullscreen"))
		return DKClass::CallFunc("DKSDLWindow::Fullscreen", NULL, NULL);
	if(DKClass::HasFunc("DKSFMLWindow::Fullscreen"))
		return DKClass::CallFunc("DKSFMLWindow::Fullscreen", NULL, NULL);
	return DKERROR("DKWindow::Fullscreen(): No function available\n");
}

bool DKWindow::GetHandle(void*& handle) {
	DKDEBUGFUNC(handle);
	//EXAMPLE
	//HWND hwnd = NULL;
	//DKWindow::GetHandle((void*&)hwnd);
	
	if(DKClass::HasFunc("DKCEFWindow::GetHandle"))
		return DKClass::CallFunc("DKCEFWindow::GetHandle", NULL, &handle);
	if(DKClass::HasFunc("DKOSGWindow::GetHandle"))
		return DKClass::CallFunc("DKOSGWindow::GetHandle", NULL, &handle);
	if(DKClass::HasFunc("DKSDLWindow::GetHandle"))
		return DKClass::CallFunc("DKSDLWindow::GetHandle", NULL, &handle);
	if(DKClass::HasFunc("DKSFMLWindow::GetHandle"))
		return DKClass::CallFunc("DKSFMLWindow::GetHandle", NULL, &handle);
	return DKERROR("DKWindow::GetHandle(): No function available\n");
}

bool DKWindow::GetHeight(int& height) {
	DKDEBUGFUNC(height);
	if(DKClass::HasFunc("DKCEFWindow::GetHeight"))
		return DKClass::CallFunc("DKCEFWindow::GetHeight", NULL, &height);
	if(DKClass::HasFunc("DKOSGWindow::GetHeight"))
		return DKClass::CallFunc("DKOSGWindow::GetHeight", NULL, &height);
	if(DKClass::HasFunc("DKSDLWindow::GetHeight"))
		return DKClass::CallFunc("DKSDLWindow::GetHeight", NULL, &height);
	if(DKClass::HasFunc("DKSFMLWindow::GetHeight"))
		return DKClass::CallFunc("DKSFMLWindow::GetHeight", NULL, &height);
	return DKERROR("DKWindow::GetHeight(): No function available\n");
}

bool DKWindow::GetMouseX(int& x) {
	DKDEBUGFUNC(x);
	if(DKClass::HasFunc("DKCEFWindow::GetMouseX"))
		return DKClass::CallFunc("DKCEFWindow::GetMouseX", NULL, &x);
	if(DKClass::HasFunc("DKOSGWindow::GetMouseX"))
		return DKClass::CallFunc("DKOSGWindow::GetMouseX", NULL, &x);
	if(DKClass::HasFunc("DKSDLWindow::GetMouseX"))
		return DKClass::CallFunc("DKSDLWindow::GetMouseX", NULL, &x);
	if(DKClass::HasFunc("DKSFMLWindow::GetMouseX"))
		return DKClass::CallFunc("DKSFMLWindow::GetMouseX", NULL, &x);
	return DKERROR("DKWindow::GetMouseX(): No function available\n");
}

bool DKWindow::GetMouseY(int& y) {
	DKDEBUGFUNC(y);
	if(DKClass::HasFunc("DKCEFWindow::GetMouseY"))
		return DKClass::CallFunc("DKCEFWindow::GetMouseY", NULL, &y);
	if(DKClass::HasFunc("DKOSGWindow::GetMouseY"))
		return DKClass::CallFunc("DKOSGWindow::GetMouseY", NULL, &y);
	if(DKClass::HasFunc("DKSDLWindow::GetMouseY"))
		return DKClass::CallFunc("DKSDLWindow::GetMouseY", NULL, &y);
	if(DKClass::HasFunc("DKSFMLWindow::GetMouseY"))
		return DKClass::CallFunc("DKSFMLWindow::GetMouseY", NULL, &y);
	return DKERROR("DKWindow::GetMouseY(): No function available\n");
}

bool DKWindow::GetPixelRatio(float& ratio) {
	DKDEBUGFUNC(ratio);
	if(DKClass::HasFunc("DKCEFWindow::GetPixelRatio"))
		return DKClass::CallFunc("DKCEFWindow::GetPixelRatio", NULL, &ratio);
	if(DKClass::HasFunc("DKOSGWindow::GetPixelRatio"))
		return DKClass::CallFunc("DKOSGWindow::GetPixelRatio", NULL, &ratio);
	if(DKClass::HasFunc("DKSDLWindow::GetPixelRatio"))
		return DKClass::CallFunc("DKSDLWindow::GetPixelRatio", NULL, &ratio);
	if(DKClass::HasFunc("DKSFMLWindow::GetPixelRatio"))
		return DKClass::CallFunc("DKSFMLWindow::GetPixelRatio", NULL, &ratio);
	ratio = 1.0;
	return DKERROR("DKWindow::GetPixelRatio(): No function available\n");
}

bool DKWindow::GetTitle(DKString& title) {
	DKDEBUGFUNC(title);
	if(DKClass::HasFunc("DKCEFWindow::GetTitle"))
		return DKClass::CallFunc("DKCEFWindow::GetTitle", NULL, &title);
	if(DKClass::HasFunc("DKOSGWindow::GetTitle"))
		return DKClass::CallFunc("DKOSGWindow::GetTitle", NULL, &title);
	if(DKClass::HasFunc("DKSDLWindow::GetTitle"))
		return DKClass::CallFunc("DKSDLWindow::GetTitle", NULL, &title);
	if(DKClass::HasFunc("DKSFMLWindow::GetTitle"))
		return DKClass::CallFunc("DKSFMLWindow::GetTitle", NULL, &title);
	return DKERROR("DKWindow::GetTitle(): No function available\n");
}

bool DKWindow::GetWidth(int& width) {
	DKDEBUGFUNC(width);
	if(DKClass::HasFunc("DKCEFWindow::GetWidth"))
		return DKClass::CallFunc("DKCEFWindow::GetWidth", NULL, &width);
	if(DKClass::HasFunc("DKOSGWindow::GetWidth"))
		return DKClass::CallFunc("DKOSGWindow::GetWidth", NULL, &width);
	if(DKClass::HasFunc("DKSDLWindow::GetWidth"))
		return DKClass::CallFunc("DKSDLWindow::GetWidth", NULL, &width);
	if(DKClass::HasFunc("DKSFMLWindow::GetWidth"))
		return DKClass::CallFunc("DKSFMLWindow::GetWidth", NULL, &width);
	return DKERROR("DKWindow::GetWidth(): No function available\n");
}

bool DKWindow::GetX(int& x) {
	DKDEBUGFUNC(x);
	if(DKClass::HasFunc("DKCEFWindow::GetX"))
		return DKClass::CallFunc("DKCEFWindow::GetX", NULL, &x);
	if(DKClass::HasFunc("DKOSGWindow::GetX"))
		return DKClass::CallFunc("DKOSGWindow::GetX", NULL, &x);
	if(DKClass::HasFunc("DKSDLWindow::GetX"))
		return DKClass::CallFunc("DKSDLWindow::GetX", NULL, &x);
	if(DKClass::HasFunc("DKSFMLWindow::GetX"))
		return DKClass::CallFunc("DKSFMLWindow::GetX", NULL, &x);
	return DKERROR("DKWindow::GetX(): No function available\n");
}

bool DKWindow::GetY(int& y) {
	DKDEBUGFUNC(y);
	if(DKClass::HasFunc("DKCEFWindow::GetY"))
		return DKClass::CallFunc("DKCEFWindow::GetY", NULL, &y);
	if(DKClass::HasFunc("DKOSGWindow::GetY"))
		return DKClass::CallFunc("DKOSGWindow::GetY", NULL, &y);
	if(DKClass::HasFunc("DKSDLWindow::GetY"))
		return DKClass::CallFunc("DKSDLWindow::GetY", NULL, &y);
	if(DKClass::HasFunc("DKSFMLWindow::GetY"))
		return DKClass::CallFunc("DKSFMLWindow::GetY", NULL, &y);
	return DKERROR("DKWindow::GetY(): No function available\n");
}

bool DKWindow::Hide() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCEFWindow::Hide"))
		return DKClass::CallFunc("DKCEFWindow::Hide", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Hide"))
		return DKClass::CallFunc("DKOSGWindow::Hide", NULL, NULL);
	if(DKClass::HasFunc("DKSDLWindow::Hide"))
		return DKClass::CallFunc("DKSDLWindow::Hide", NULL, NULL);
	if(DKClass::HasFunc("DKSFMLWindow::Hide"))
		return DKClass::CallFunc("DKSFMLWindow::Hide", NULL, NULL);
	return DKERROR("DKWindow::Hide(): No function available\n");
}

bool DKWindow::IsFullscreen(bool& fullscreen) {
	DKDEBUGFUNC(fullscreen);
	if(DKClass::HasFunc("DKCEFWindow::IsFullscreen"))
		return DKClass::CallFunc("DKCEFWindow::IsFullscreen", NULL, &fullscreen);
	if(DKClass::HasFunc("DKOSGWindow::IsFullscreen"))
		return DKClass::CallFunc("DKOSGWindow::IsFullscreen", NULL, &fullscreen);
	if(DKClass::HasFunc("DKSDLWindow::IsFullscreen"))
		return DKClass::CallFunc("DKSDLWindow::IsFullscreen", NULL, &fullscreen);
	if(DKClass::HasFunc("DKSFMLWindow::IsFullscreen"))
		return DKClass::CallFunc("DKSFMLWindow::IsFullscreen", NULL, &fullscreen);
	return DKERROR("DKWindow::IsFullscreen(): No function available\n");
}

bool DKWindow::IsVisible(bool& visible) {
	DKDEBUGFUNC(visible);
	if(DKClass::HasFunc("DKCEFWindow::IsVisible"))
		return DKClass::CallFunc("DKCEFWindow::IsVisible", NULL, &visible);
	if(DKClass::HasFunc("DKOSGWindow::IsVisible"))
		return DKClass::CallFunc("DKOSGWindow::IsVisible", NULL, &visible);
	if(DKClass::HasFunc("DKSDLWindow::IsVisible"))
		return DKClass::CallFunc("DKSDLWindow::IsVisible", NULL, &visible);
	if(DKClass::HasFunc("DKSFMLWindow::IsVisible"))
		return DKClass::CallFunc("DKSFMLWindow::IsVisible", NULL, &visible);
	return DKERROR("DKWindow::IsVisible(): No function available\n");
}

bool DKWindow::Maximize() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCEFWindow::Maximize"))
		return DKClass::CallFunc("DKCEFWindow::Maximize", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Maximize"))
		return DKClass::CallFunc("DKOSGWindow::Maximize", NULL, NULL);
	if(DKClass::HasFunc("DKSDLWindow::Maximize"))
		return DKClass::CallFunc("DKSDLWindow::Maximize", NULL, NULL);
	if(DKClass::HasFunc("DKSFMLWindow::Maximize"))
		return DKClass::CallFunc("DKSFMLWindow::Maximize", NULL, NULL);
	return DKERROR("DKWindow::Maximize(): No function available\n");
}

bool DKWindow::MessageBox(DKString& msg) {
	DKDEBUGFUNC(msg);
	if(DKClass::HasFunc("DKCEFWindow::MessageBox"))
		return DKClass::CallFunc("DKCEFWindow::MessageBox", &msg, NULL);
	if(DKClass::HasFunc("DKOSGWindow::MessageBox"))
		return DKClass::CallFunc("DKOSGWindow::MessageBox", &msg, NULL);
	if(DKClass::HasFunc("DKSDLWindow::MessageBox"))
		return DKClass::CallFunc("DKSDLWindow::MessageBox", &msg, NULL);
	if(DKClass::HasFunc("DKSFMLWindow::MessageBox"))
		return DKClass::CallFunc("DKSFMLWindow::MessageBox", &msg, NULL);
	return DKERROR("DKWindow::MessageBox(): No function available\n");
}

bool DKWindow::Minimize() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCEFWindow::Minimize"))
		return DKClass::CallFunc("DKCEFWindow::Minimize", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Minimize"))
		return DKClass::CallFunc("DKOSGWindow::Minimize", NULL, NULL);
	if(DKClass::HasFunc("DKSDLWindow::Minimize"))
		return DKClass::CallFunc("DKSDLWindow::Minimize", NULL, NULL);
	if(DKClass::HasFunc("DKSFMLWindow::Minimize"))
		return DKClass::CallFunc("DKSFMLWindow::Minimize", NULL, NULL);
	return DKERROR("DKWindow::Minimize(): No function available\n");
}

bool DKWindow::Restore() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCEFWindow::Restore"))
		return DKClass::CallFunc("DKCEFWindow::Restore", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Restore"))
		return DKClass::CallFunc("DKOSGWindow::Restore", NULL, NULL);
	if(DKClass::HasFunc("DKSDLWindow::Restore"))
		return DKClass::CallFunc("DKSDLWindow::Restore", NULL, NULL);
	if(DKClass::HasFunc("DKSFMLWindow::Restore"))
		return DKClass::CallFunc("DKSFMLWindow::Restore", NULL, NULL);
	return DKERROR("DKWindow::Restore(): No function available\n");
}

bool DKWindow::SetHeight(int& h) {
	DKDEBUGFUNC(h);
	if(DKClass::HasFunc("DKCEFWindow::SetHeight"))
		return DKClass::CallFunc("DKCEFWindow::SetHeight", &h, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetHeight"))
		return DKClass::CallFunc("DKOSGWindow::SetHeight", &h, NULL);
	if(DKClass::HasFunc("DKSDLWindow::SetHeight"))
		return DKClass::CallFunc("DKSDLWindow::SetHeight", &h, NULL);
	if(DKClass::HasFunc("DKSFMLWindow::SetHeight"))
		return DKClass::CallFunc("DKSFMLWindow::SetHeight", &h, NULL);
	return DKERROR("DKWindow::SetHeight(): No function available\n");
}

bool DKWindow::SetIcon(DKString& file) {
	DKDEBUGFUNC(file);
	if(DKClass::HasFunc("DKCEFWindow::SetIcon"))
		return DKClass::CallFunc("DKCEFWindow::SetIcon", &file, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetIcon"))
		return DKClass::CallFunc("DKOSGWindow::SetIcon", &file, NULL);
	if(DKClass::HasFunc("DKSDLWindow::SetIcon"))
		return DKClass::CallFunc("DKSDLWindow::SetIcon", &file, NULL);
	if(DKClass::HasFunc("DKSFMLWindow::SetIcon"))
		return DKClass::CallFunc("DKSFMLWindow::SetIcon", &file, NULL);
	return DKERROR("DKWindow::SetIcon(): No function available\n");
}

bool DKWindow::SetTitle(DKString& string) {
	DKDEBUGFUNC(string);
	if(DKClass::HasFunc("DKCEFWindow::SetTitle"))
		return DKClass::CallFunc("DKCEFWindow::SetTitle", &string, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetTitle"))
		return DKClass::CallFunc("DKOSGWindow::SetTitle", &string, NULL);
	if(DKClass::HasFunc("DKSDLWindow::SetTitle"))
		return DKClass::CallFunc("DKSDLWindow::SetTitle", &string, NULL);
	if(DKClass::HasFunc("DKSFMLWindow::SetTitle"))
		return DKClass::CallFunc("DKSFMLWindow::SetTitle", &string, NULL);
	return DKERROR("DKWindow::SetTitle(): No function available\n");
}

bool DKWindow::SetWidth(int& w) {
	DKDEBUGFUNC(w);
	if(DKClass::HasFunc("DKCEFWindow::SetWidth"))
		return DKClass::CallFunc("DKCEFWindow::SetWidth", &w, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetWidth"))
		return DKClass::CallFunc("DKOSGWindow::SetWidth", &w, NULL);
	if(DKClass::HasFunc("DKSDLWindow::SetWidth"))
		return DKClass::CallFunc("DKSDLWindow::SetWidth", &w, NULL);
	if(DKClass::HasFunc("DKSFMLWindow::SetWidth"))
		return DKClass::CallFunc("DKSFMLWindow::SetWidth", &w, NULL);
	return DKERROR("DKWindow::SetWidth(): No function available\n");
}

bool DKWindow::SetX(int& x) {
	DKDEBUGFUNC(x);
	if(DKClass::HasFunc("DKCEFWindow::SetX"))
		return DKClass::CallFunc("DKCEFWindow::SetX", &x, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetX"))
		return DKClass::CallFunc("DKOSGWindow::SetX", &x, NULL);
	if(DKClass::HasFunc("DKSDLWindow::SetX"))
		return DKClass::CallFunc("DKSDLWindow::SetX", &x, NULL);
	if(DKClass::HasFunc("DKSFMLWindow::SetX"))
		return DKClass::CallFunc("DKSFMLWindow::SetX", &x, NULL);
	return DKERROR("DKWindow::SetX(): No function available\n");
}

bool DKWindow::SetY(int& y) {
	DKDEBUGFUNC(y);
	if(DKClass::HasFunc("DKCEFWindow::SetY"))
		return DKClass::CallFunc("DKCEFWindow::SetY", &y, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetY"))
		return DKClass::CallFunc("DKOSGWindow::SetY", &y, NULL);
	if(DKClass::HasFunc("DKSDLWindow::SetY"))
		return DKClass::CallFunc("DKSDLWindow::SetY", &y, NULL);
	if(DKClass::HasFunc("DKSFMLWindow::SetY"))
		return DKClass::CallFunc("DKSFMLWindow::SetY", &y, NULL);
	return DKERROR("DKWindow::SetY(): No function available\n");
}

bool DKWindow::Show() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCEFWindow::Show"))
		return DKClass::CallFunc("DKCEFWindow::Show", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Show"))
		return DKClass::CallFunc("DKOSGWindow::Show", NULL, NULL);
	if(DKClass::HasFunc("DKSDLWindow::Show"))
		return DKClass::CallFunc("DKSDLWindow::Show", NULL, NULL);
	if(DKClass::HasFunc("DKSFMLWindow::Show"))
		return DKClass::CallFunc("DKSFMLWindow::Show", NULL, NULL);
	return DKERROR("DKWindow::Show(): No function available\n");
}

bool DKWindow::Windowed() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCEFWindow::Windowed"))
		return DKClass::CallFunc("DKCEFWindow::Windowed", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Windowed"))
		return DKClass::CallFunc("DKOSGWindow::Windowed", NULL, NULL);
	if(DKClass::HasFunc("DKSDLWindow::Windowed"))
		return DKClass::CallFunc("DKSDLWindow::Windowed", NULL, NULL);
	if(DKClass::HasFunc("DKSFMLWindow::Windowed"))
		return DKClass::CallFunc("DKSFMLWindow::Windowed", NULL, NULL);
	return DKERROR("DKWindow::Windowed(): No function available\n");
}
