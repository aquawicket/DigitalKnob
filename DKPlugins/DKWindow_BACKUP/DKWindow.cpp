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
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
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
		!DKClass::DKValid("DKSdlWindow,DKSdlWindow0") && 
		!DKClass::DKValid("DKSfmlWindow,DKSfmlWindow0") )
		return DKERROR("DO NOT create DKWindow directly, use DKCEFWindow, DKOSGWindow, DKSdlWindow or DKSfmlWindow\n");
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
///  \a see: DKPlugins/DKSdlWindow.h
bool DKWindow::TestInt(int& input, int& output){
	DKDEBUGFUNC(input, output);
	if(DKClass::HasFunc("DKCEFWindow::TestInt"))
		return DKClass::CallFunc("DKCEFWindow::TestInt", &input, &output);
	if(DKClass::HasFunc("DKOSGWindow::TestInt"))
		return DKClass::CallFunc("DKOSGWindow::TestInt", &input, &output);
	if(DKClass::HasFunc("DKSdlWindow::TestInt"))
		return DKClass::CallFunc("DKSdlWindow::TestInt", &input, &output);
	if(DKClass::HasFunc("DKSfmlWindow::TestInt"))
		return DKClass::CallFunc("DKSfmlWindow::TestInt", &input, &output);
	return DKERROR("DKWindow::TestInt(): No function available\n");
}

///
///  If "DKWindow::TestString()" calls a registered function, it will alter the variable and send it back.
///  \a see: DKPlugins/DKSdlWindow.h
bool DKWindow::TestString(DKString& input, DKString& output) {
	DKDEBUGFUNC(input, output);
	if(DKClass::HasFunc("DKCEFWindow::TestString"))
		return DKClass::CallFunc("DKCEFWindow::TestString", &input, &output);
	if(DKClass::HasFunc("DKOSGWindow::TestString"))
		return DKClass::CallFunc("DKOSGWindow::TestString", &input, &output);
	if(DKClass::HasFunc("DKSdlWindow::TestString"))
		return DKClass::CallFunc("DKSdlWindow::TestString", &input, &output);
	if(DKClass::HasFunc("DKSfmlWindow::TestString"))
		return DKClass::CallFunc("DKSfmlWindow::TestString", &input, &output);
	return DKERROR("DKWindow::TestString(): No function available\n");
}

///
///  If "DKWindow::TestReturnInt()" calls a registered function, it will return a variable.
///  \a see: DKPlugins/DKSdlWindow.h
bool DKWindow::TestReturnInt(int& output) {
	DKDEBUGFUNC(output);
	if(DKClass::HasFunc("DKCEFWindow::TestReturnInt"))
		return DKClass::CallFunc("DKCEFWindow::TestReturnInt", NULL, &output);
	if(DKClass::HasFunc("DKOSGWindow::TestReturnInt"))
		return DKClass::CallFunc("DKOSGWindow::TestReturnInt", NULL, &output);
	if(DKClass::HasFunc("DKSdlWindow::TestReturnInt"))
		return DKClass::CallFunc("DKSdlWindow::TestReturnInt", NULL, &output);
	if(DKClass::HasFunc("DKSfmlWindow::TestReturnInt"))
		return DKClass::CallFunc("DKSfmlWindow::TestReturnInt", NULL, &output);
	return DKERROR("DKWindow::TestReturnInt(): No function available\n");
}

///
///  If "DKWindow::TestReturnString()" calls a registered function, it will return a variable.
///  \a see: DKPlugins/DKSdlWindow.h
bool DKWindow::TestReturnString(DKString& output) {
	DKDEBUGFUNC(output);
	if(DKClass::HasFunc("DKCEFWindow::TestReturnString"))
		return DKClass::CallFunc("DKCEFWindow::TestReturnString", NULL, &output);
	if(DKClass::HasFunc("DKOSGWindow::TestReturnString"))
		return DKClass::CallFunc("DKOSGWindow::TestReturnString", NULL, &output);
	if(DKClass::HasFunc("DKSdlWindow::TestReturnString"))
		return DKClass::CallFunc("DKSdlWindow::TestReturnString", NULL, &output);
	if(DKClass::HasFunc("DKSfmlWindow::TestReturnString"))
		return DKClass::CallFunc("DKSfmlWindow::TestReturnString", NULL, &output);
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
	if(DKClass::DKAvailable("DKSdlWindow")){
		DKClass::DKCreate("DKSdlWindow");
		return true;
	}
	if(DKClass::DKAvailable("DKSfmlWindow")){
		DKClass::DKCreate("DKSfmlWindow");
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
	if(DKClass::HasFunc("DKSdlWindow::Fullscreen"))
		return DKClass::CallFunc("DKSdlWindow::Fullscreen", NULL, NULL);
	if(DKClass::HasFunc("DKSfmlWindow::Fullscreen"))
		return DKClass::CallFunc("DKSfmlWindow::Fullscreen", NULL, NULL);
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
	if(DKClass::HasFunc("DKSdlWindow::GetHandle"))
		return DKClass::CallFunc("DKSdlWindow::GetHandle", NULL, &handle);
	if(DKClass::HasFunc("DKSfmlWindow::GetHandle"))
		return DKClass::CallFunc("DKSfmlWindow::GetHandle", NULL, &handle);
	return DKERROR("DKWindow::GetHandle(): No function available\n");
}

bool DKWindow::GetHeight(int& height) {
	DKDEBUGFUNC(height);
	if(DKClass::HasFunc("DKCEFWindow::GetHeight"))
		return DKClass::CallFunc("DKCEFWindow::GetHeight", NULL, &height);
	if(DKClass::HasFunc("DKOSGWindow::GetHeight"))
		return DKClass::CallFunc("DKOSGWindow::GetHeight", NULL, &height);
	if(DKClass::HasFunc("DKSdlWindow::GetHeight"))
		return DKClass::CallFunc("DKSdlWindow::GetHeight", NULL, &height);
	if(DKClass::HasFunc("DKSfmlWindow::GetHeight"))
		return DKClass::CallFunc("DKSfmlWindow::GetHeight", NULL, &height);
	return DKERROR("DKWindow::GetHeight(): No function available\n");
}

bool DKWindow::GetMouseX(int& x) {
	DKDEBUGFUNC(x);
	if(DKClass::HasFunc("DKCEFWindow::GetMouseX"))
		return DKClass::CallFunc("DKCEFWindow::GetMouseX", NULL, &x);
	if(DKClass::HasFunc("DKOSGWindow::GetMouseX"))
		return DKClass::CallFunc("DKOSGWindow::GetMouseX", NULL, &x);
	if(DKClass::HasFunc("DKSdlWindow::GetMouseX"))
		return DKClass::CallFunc("DKSdlWindow::GetMouseX", NULL, &x);
	if(DKClass::HasFunc("DKSfmlWindow::GetMouseX"))
		return DKClass::CallFunc("DKSfmlWindow::GetMouseX", NULL, &x);
	return DKERROR("DKWindow::GetMouseX(): No function available\n");
}

bool DKWindow::GetMouseY(int& y) {
	DKDEBUGFUNC(y);
	if(DKClass::HasFunc("DKCEFWindow::GetMouseY"))
		return DKClass::CallFunc("DKCEFWindow::GetMouseY", NULL, &y);
	if(DKClass::HasFunc("DKOSGWindow::GetMouseY"))
		return DKClass::CallFunc("DKOSGWindow::GetMouseY", NULL, &y);
	if(DKClass::HasFunc("DKSdlWindow::GetMouseY"))
		return DKClass::CallFunc("DKSdlWindow::GetMouseY", NULL, &y);
	if(DKClass::HasFunc("DKSfmlWindow::GetMouseY"))
		return DKClass::CallFunc("DKSfmlWindow::GetMouseY", NULL, &y);
	return DKERROR("DKWindow::GetMouseY(): No function available\n");
}

bool DKWindow::GetPixelRatio(float& ratio) {
	DKDEBUGFUNC(ratio);
	if(DKClass::HasFunc("DKCEFWindow::GetPixelRatio"))
		return DKClass::CallFunc("DKCEFWindow::GetPixelRatio", NULL, &ratio);
	if(DKClass::HasFunc("DKOSGWindow::GetPixelRatio"))
		return DKClass::CallFunc("DKOSGWindow::GetPixelRatio", NULL, &ratio);
	if(DKClass::HasFunc("DKSdlWindow::GetPixelRatio"))
		return DKClass::CallFunc("DKSdlWindow::GetPixelRatio", NULL, &ratio);
	if(DKClass::HasFunc("DKSfmlWindow::GetPixelRatio"))
		return DKClass::CallFunc("DKSfmlWindow::GetPixelRatio", NULL, &ratio);
	ratio = 1.0;
	return DKERROR("DKWindow::GetPixelRatio(): No function available\n");
}

bool DKWindow::GetTitle(DKString& title) {
	DKDEBUGFUNC(title);
	if(DKClass::HasFunc("DKCEFWindow::GetTitle"))
		return DKClass::CallFunc("DKCEFWindow::GetTitle", NULL, &title);
	if(DKClass::HasFunc("DKOSGWindow::GetTitle"))
		return DKClass::CallFunc("DKOSGWindow::GetTitle", NULL, &title);
	if(DKClass::HasFunc("DKSdlWindow::GetTitle"))
		return DKClass::CallFunc("DKSdlWindow::GetTitle", NULL, &title);
	if(DKClass::HasFunc("DKSfmlWindow::GetTitle"))
		return DKClass::CallFunc("DKSfmlWindow::GetTitle", NULL, &title);
	return DKERROR("DKWindow::GetTitle(): No function available\n");
}

bool DKWindow::GetWidth(int& width) {
	DKDEBUGFUNC(width);
	if(DKClass::HasFunc("DKCEFWindow::GetWidth"))
		return DKClass::CallFunc("DKCEFWindow::GetWidth", NULL, &width);
	if(DKClass::HasFunc("DKOSGWindow::GetWidth"))
		return DKClass::CallFunc("DKOSGWindow::GetWidth", NULL, &width);
	if(DKClass::HasFunc("DKSdlWindow::GetWidth"))
		return DKClass::CallFunc("DKSdlWindow::GetWidth", NULL, &width);
	if(DKClass::HasFunc("DKSfmlWindow::GetWidth"))
		return DKClass::CallFunc("DKSfmlWindow::GetWidth", NULL, &width);
	return DKERROR("DKWindow::GetWidth(): No function available\n");
}

bool DKWindow::GetX(int& x) {
	DKDEBUGFUNC(x);
	if(DKClass::HasFunc("DKCEFWindow::GetX"))
		return DKClass::CallFunc("DKCEFWindow::GetX", NULL, &x);
	if(DKClass::HasFunc("DKOSGWindow::GetX"))
		return DKClass::CallFunc("DKOSGWindow::GetX", NULL, &x);
	if(DKClass::HasFunc("DKSdlWindow::GetX"))
		return DKClass::CallFunc("DKSdlWindow::GetX", NULL, &x);
	if(DKClass::HasFunc("DKSfmlWindow::GetX"))
		return DKClass::CallFunc("DKSfmlWindow::GetX", NULL, &x);
	return DKERROR("DKWindow::GetX(): No function available\n");
}

bool DKWindow::GetY(int& y) {
	DKDEBUGFUNC(y);
	if(DKClass::HasFunc("DKCEFWindow::GetY"))
		return DKClass::CallFunc("DKCEFWindow::GetY", NULL, &y);
	if(DKClass::HasFunc("DKOSGWindow::GetY"))
		return DKClass::CallFunc("DKOSGWindow::GetY", NULL, &y);
	if(DKClass::HasFunc("DKSdlWindow::GetY"))
		return DKClass::CallFunc("DKSdlWindow::GetY", NULL, &y);
	if(DKClass::HasFunc("DKSfmlWindow::GetY"))
		return DKClass::CallFunc("DKSfmlWindow::GetY", NULL, &y);
	return DKERROR("DKWindow::GetY(): No function available\n");
}

bool DKWindow::Hide() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCEFWindow::Hide"))
		return DKClass::CallFunc("DKCEFWindow::Hide", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Hide"))
		return DKClass::CallFunc("DKOSGWindow::Hide", NULL, NULL);
	if(DKClass::HasFunc("DKSdlWindow::Hide"))
		return DKClass::CallFunc("DKSdlWindow::Hide", NULL, NULL);
	if(DKClass::HasFunc("DKSfmlWindow::Hide"))
		return DKClass::CallFunc("DKSfmlWindow::Hide", NULL, NULL);
	return DKERROR("DKWindow::Hide(): No function available\n");
}

bool DKWindow::IsFullscreen(bool& fullscreen) {
	DKDEBUGFUNC(fullscreen);
	if(DKClass::HasFunc("DKCEFWindow::IsFullscreen"))
		return DKClass::CallFunc("DKCEFWindow::IsFullscreen", NULL, &fullscreen);
	if(DKClass::HasFunc("DKOSGWindow::IsFullscreen"))
		return DKClass::CallFunc("DKOSGWindow::IsFullscreen", NULL, &fullscreen);
	if(DKClass::HasFunc("DKSdlWindow::IsFullscreen"))
		return DKClass::CallFunc("DKSdlWindow::IsFullscreen", NULL, &fullscreen);
	if(DKClass::HasFunc("DKSfmlWindow::IsFullscreen"))
		return DKClass::CallFunc("DKSfmlWindow::IsFullscreen", NULL, &fullscreen);
	return DKERROR("DKWindow::IsFullscreen(): No function available\n");
}

bool DKWindow::IsVisible(bool& visible) {
	DKDEBUGFUNC(visible);
	if(DKClass::HasFunc("DKCEFWindow::IsVisible"))
		return DKClass::CallFunc("DKCEFWindow::IsVisible", NULL, &visible);
	if(DKClass::HasFunc("DKOSGWindow::IsVisible"))
		return DKClass::CallFunc("DKOSGWindow::IsVisible", NULL, &visible);
	if(DKClass::HasFunc("DKSdlWindow::IsVisible"))
		return DKClass::CallFunc("DKSdlWindow::IsVisible", NULL, &visible);
	if(DKClass::HasFunc("DKSfmlWindow::IsVisible"))
		return DKClass::CallFunc("DKSfmlWindow::IsVisible", NULL, &visible);
	return DKERROR("DKWindow::IsVisible(): No function available\n");
}

bool DKWindow::Maximize() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCEFWindow::Maximize"))
		return DKClass::CallFunc("DKCEFWindow::Maximize", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Maximize"))
		return DKClass::CallFunc("DKOSGWindow::Maximize", NULL, NULL);
	if(DKClass::HasFunc("DKSdlWindow::Maximize"))
		return DKClass::CallFunc("DKSdlWindow::Maximize", NULL, NULL);
	if(DKClass::HasFunc("DKSfmlWindow::Maximize"))
		return DKClass::CallFunc("DKSfmlWindow::Maximize", NULL, NULL);
	return DKERROR("DKWindow::Maximize(): No function available\n");
}

bool DKWindow::MessageBox(DKString& msg) {
	DKDEBUGFUNC(msg);
	if(DKClass::HasFunc("DKCEFWindow::MessageBox"))
		return DKClass::CallFunc("DKCEFWindow::MessageBox", &msg, NULL);
	if(DKClass::HasFunc("DKOSGWindow::MessageBox"))
		return DKClass::CallFunc("DKOSGWindow::MessageBox", &msg, NULL);
	if(DKClass::HasFunc("DKSdlWindow::MessageBox"))
		return DKClass::CallFunc("DKSdlWindow::MessageBox", &msg, NULL);
	if(DKClass::HasFunc("DKSfmlWindow::MessageBox"))
		return DKClass::CallFunc("DKSfmlWindow::MessageBox", &msg, NULL);
	return DKERROR("DKWindow::MessageBox(): No function available\n");
}

bool DKWindow::Minimize() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCEFWindow::Minimize"))
		return DKClass::CallFunc("DKCEFWindow::Minimize", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Minimize"))
		return DKClass::CallFunc("DKOSGWindow::Minimize", NULL, NULL);
	if(DKClass::HasFunc("DKSdlWindow::Minimize"))
		return DKClass::CallFunc("DKSdlWindow::Minimize", NULL, NULL);
	if(DKClass::HasFunc("DKSfmlWindow::Minimize"))
		return DKClass::CallFunc("DKSfmlWindow::Minimize", NULL, NULL);
	return DKERROR("DKWindow::Minimize(): No function available\n");
}

bool DKWindow::Restore() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCEFWindow::Restore"))
		return DKClass::CallFunc("DKCEFWindow::Restore", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Restore"))
		return DKClass::CallFunc("DKOSGWindow::Restore", NULL, NULL);
	if(DKClass::HasFunc("DKSdlWindow::Restore"))
		return DKClass::CallFunc("DKSdlWindow::Restore", NULL, NULL);
	if(DKClass::HasFunc("DKSfmlWindow::Restore"))
		return DKClass::CallFunc("DKSfmlWindow::Restore", NULL, NULL);
	return DKERROR("DKWindow::Restore(): No function available\n");
}

bool DKWindow::SetHeight(int& h) {
	DKDEBUGFUNC(h);
	if(DKClass::HasFunc("DKCEFWindow::SetHeight"))
		return DKClass::CallFunc("DKCEFWindow::SetHeight", &h, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetHeight"))
		return DKClass::CallFunc("DKOSGWindow::SetHeight", &h, NULL);
	if(DKClass::HasFunc("DKSdlWindow::SetHeight"))
		return DKClass::CallFunc("DKSdlWindow::SetHeight", &h, NULL);
	if(DKClass::HasFunc("DKSfmlWindow::SetHeight"))
		return DKClass::CallFunc("DKSfmlWindow::SetHeight", &h, NULL);
	return DKERROR("DKWindow::SetHeight(): No function available\n");
}

bool DKWindow::SetIcon(DKString& file) {
	DKDEBUGFUNC(file);
	if(DKClass::HasFunc("DKCEFWindow::SetIcon"))
		return DKClass::CallFunc("DKCEFWindow::SetIcon", &file, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetIcon"))
		return DKClass::CallFunc("DKOSGWindow::SetIcon", &file, NULL);
	if(DKClass::HasFunc("DKSdlWindow::SetIcon"))
		return DKClass::CallFunc("DKSdlWindow::SetIcon", &file, NULL);
	if(DKClass::HasFunc("DKSfmlWindow::SetIcon"))
		return DKClass::CallFunc("DKSfmlWindow::SetIcon", &file, NULL);
	return DKERROR("DKWindow::SetIcon(): No function available\n");
}

bool DKWindow::SetTitle(DKString& string) {
	DKDEBUGFUNC(string);
	if(DKClass::HasFunc("DKCEFWindow::SetTitle"))
		return DKClass::CallFunc("DKCEFWindow::SetTitle", &string, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetTitle"))
		return DKClass::CallFunc("DKOSGWindow::SetTitle", &string, NULL);
	if(DKClass::HasFunc("DKSdlWindow::SetTitle"))
		return DKClass::CallFunc("DKSdlWindow::SetTitle", &string, NULL);
	if(DKClass::HasFunc("DKSfmlWindow::SetTitle"))
		return DKClass::CallFunc("DKSfmlWindow::SetTitle", &string, NULL);
	return DKERROR("DKWindow::SetTitle(): No function available\n");
}

bool DKWindow::SetWidth(int& w) {
	DKDEBUGFUNC(w);
	if(DKClass::HasFunc("DKCEFWindow::SetWidth"))
		return DKClass::CallFunc("DKCEFWindow::SetWidth", &w, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetWidth"))
		return DKClass::CallFunc("DKOSGWindow::SetWidth", &w, NULL);
	if(DKClass::HasFunc("DKSdlWindow::SetWidth"))
		return DKClass::CallFunc("DKSdlWindow::SetWidth", &w, NULL);
	if(DKClass::HasFunc("DKSfmlWindow::SetWidth"))
		return DKClass::CallFunc("DKSfmlWindow::SetWidth", &w, NULL);
	return DKERROR("DKWindow::SetWidth(): No function available\n");
}

bool DKWindow::SetX(int& x) {
	DKDEBUGFUNC(x);
	if(DKClass::HasFunc("DKCEFWindow::SetX"))
		return DKClass::CallFunc("DKCEFWindow::SetX", &x, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetX"))
		return DKClass::CallFunc("DKOSGWindow::SetX", &x, NULL);
	if(DKClass::HasFunc("DKSdlWindow::SetX"))
		return DKClass::CallFunc("DKSdlWindow::SetX", &x, NULL);
	if(DKClass::HasFunc("DKSfmlWindow::SetX"))
		return DKClass::CallFunc("DKSfmlWindow::SetX", &x, NULL);
	return DKERROR("DKWindow::SetX(): No function available\n");
}

bool DKWindow::SetY(int& y) {
	DKDEBUGFUNC(y);
	if(DKClass::HasFunc("DKCEFWindow::SetY"))
		return DKClass::CallFunc("DKCEFWindow::SetY", &y, NULL);
	if(DKClass::HasFunc("DKOSGWindow::SetY"))
		return DKClass::CallFunc("DKOSGWindow::SetY", &y, NULL);
	if(DKClass::HasFunc("DKSdlWindow::SetY"))
		return DKClass::CallFunc("DKSdlWindow::SetY", &y, NULL);
	if(DKClass::HasFunc("DKSfmlWindow::SetY"))
		return DKClass::CallFunc("DKSfmlWindow::SetY", &y, NULL);
	return DKERROR("DKWindow::SetY(): No function available\n");
}

bool DKWindow::Show() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCEFWindow::Show"))
		return DKClass::CallFunc("DKCEFWindow::Show", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Show"))
		return DKClass::CallFunc("DKOSGWindow::Show", NULL, NULL);
	if(DKClass::HasFunc("DKSdlWindow::Show"))
		return DKClass::CallFunc("DKSdlWindow::Show", NULL, NULL);
	if(DKClass::HasFunc("DKSfmlWindow::Show"))
		return DKClass::CallFunc("DKSfmlWindow::Show", NULL, NULL);
	return DKERROR("DKWindow::Show(): No function available\n");
}

bool DKWindow::Windowed() {
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKCEFWindow::Windowed"))
		return DKClass::CallFunc("DKCEFWindow::Windowed", NULL, NULL);
	if(DKClass::HasFunc("DKOSGWindow::Windowed"))
		return DKClass::CallFunc("DKOSGWindow::Windowed", NULL, NULL);
	if(DKClass::HasFunc("DKSdlWindow::Windowed"))
		return DKClass::CallFunc("DKSdlWindow::Windowed", NULL, NULL);
	if(DKClass::HasFunc("DKSfmlWindow::Windowed"))
		return DKClass::CallFunc("DKSfmlWindow::Windowed", NULL, NULL);
	return DKERROR("DKWindow::Windowed(): No function available\n");
}
