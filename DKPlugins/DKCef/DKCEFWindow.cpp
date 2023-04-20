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
#include "DKCef/DKCEFWindow.h"

WARNING_DISABLE
	#if MAC
		#import <AppKit/AppKit.h>
	#endif
WARNING_ENABLE


DKCEFWindow::DKCEFWindow(){
	DKDEBUGFUNC();
	DKClass::RegisterFunc("DKCEFWindow::TestInt", &DKCEFWindow::TestInt, this);
	DKClass::RegisterFunc("DKCEFWindow::TestString", &DKCEFWindow::TestString, this);
	DKClass::RegisterFunc("DKCEFWindow::TestReturnInt", &DKCEFWindow::TestReturnInt, this);
	DKClass::RegisterFunc("DKCEFWindow::TestReturnString", &DKCEFWindow::TestReturnString, this);

	DKClass::RegisterFunc("DKCEFWindow::Fullscreen", &DKCEFWindow::Fullscreen, this);
	DKClass::RegisterFunc("DKCEFWindow::GetHandle", &DKCEFWindow::GetHandle, this);
	DKClass::RegisterFunc("DKCEFWindow::GetHeight", &DKCEFWindow::GetHeight, this);
	DKClass::RegisterFunc("DKCEFWindow::GetMouseX", &DKCEFWindow::GetMouseX, this);
	DKClass::RegisterFunc("DKCEFWindow::GetMouseY", &DKCEFWindow::GetMouseY, this);
	DKClass::RegisterFunc("DKCEFWindow::GetWidth", &DKCEFWindow::GetWidth, this);
	DKClass::RegisterFunc("DKCEFWindow::GetX", &DKCEFWindow::GetX, this);
	DKClass::RegisterFunc("DKCEFWindow::GetY", &DKCEFWindow::GetY, this);
	DKClass::RegisterFunc("DKCEFWindow::Hide", &DKCEFWindow::Hide, this);
	DKClass::RegisterFunc("DKCEFWindow::IsFullscreen", &DKCEFWindow::IsFullscreen, this);
	DKClass::RegisterFunc("DKCEFWindow::IsVisible", &DKCEFWindow::IsVisible, this);
	DKClass::RegisterFunc("DKCEFWindow::Maximize", &DKCEFWindow::Maximize, this);
	DKClass::RegisterFunc("DKCEFWindow::MessageBox", &DKCEFWindow::MessageBox, this);
	DKClass::RegisterFunc("DKCEFWindow::Minimize", &DKCEFWindow::Minimize, this);
	DKClass::RegisterFunc("DKCEFWindow::Restore", &DKCEFWindow::Restore, this);
	DKClass::RegisterFunc("DKCEFWindow::SetHeight", &DKCEFWindow::SetHeight, this);
	DKClass::RegisterFunc("DKCEFWindow::SetIcon", &DKCEFWindow::SetIcon, this);
	DKClass::RegisterFunc("DKCEFWindow::SetTitle", &DKCEFWindow::SetTitle, this);
	DKClass::RegisterFunc("DKCEFWindow::SetWidth", &DKCEFWindow::SetWidth, this);
	DKClass::RegisterFunc("DKCEFWindow::SetX", &DKCEFWindow::SetX, this);
	DKClass::RegisterFunc("DKCEFWindow::SetY", &DKCEFWindow::SetY, this);
	DKClass::RegisterFunc("DKCEFWindow::Show", &DKCEFWindow::Show, this);
	DKClass::RegisterFunc("DKCEFWindow::Windowed", &DKCEFWindow::Windowed, this);
}

void DKCEFWindow::DoFrame(){
	//DKDEBUGFUNC();  //EXCESSIVE LOGGING
/*
#if WIN32
	//Display FPS
	HWND win = dkCef->current_browser->GetHost()->GetWindowHandle();
	HWND hwnd = GetWindow(win, GW_CHILD);
	HDC hdc = GetDC(hwnd);
	RECT rect;
	GetClientRect(hwnd, &rect);
	rect.top = rect.bottom - 16;
	unsigned int fps;
	DKUtil::GetFps(fps);
	DKString fpsString = toString(fps)+="fps";
	DrawTextA(hdc, fpsString.c_str(), strlen(fpsString.c_str()), &rect, DT_LEFT);
	ReleaseDC(hwnd, hdc);
#endif
*/
	if (!DKApp::active)
		return;
	CefDoMessageLoopWork(); //FIXME: this breaks SDL keyboard events for Mac OSX
}

bool DKCEFWindow::DoClose(CefRefPtr<CefBrowser> browser){
	DKDEBUGFUNC(browser);
	CEF_REQUIRE_UI_THREAD();
	if (browser->IsPopup())
		return DKERROR("browser->IsPopup() is true\n");
	DKApp::Exit();
	return false;
}

bool DKCEFWindow::TestInt(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	int in = *(int*)input;
	int out = in;
	*(int*)output = out;
	return true;
}

bool DKCEFWindow::TestString(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
	std::string in = *(std::string*)input;
	std::string out = in;
	*(std::string*)output = out;
	return true;
}

bool DKCEFWindow::TestReturnInt(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
	int var = 1234;
	*(int*)output = var;
	return true;
}

bool DKCEFWindow::TestReturnString(const void* input, void* output){
	DKDEBUGFUNC(input, output);		
	std::string var = "Return test";
	*(std::string*)output = var;
	return true;
}

bool DKCEFWindow::Fullscreen(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd failed\n");
	DWORD dwStyle = GetWindowLong(hwnd, GWL_STYLE);
	if (!dwStyle)
		return DKERROR("dwStyle invalid\n");
	MONITORINFO mi = { sizeof(mi) };
	if (!GetWindowPlacement(hwnd, &g_wpPrev) && GetMonitorInfo(MonitorFromWindow(hwnd, MONITOR_DEFAULTTOPRIMARY), &mi))
		return DKERROR("GetWindowPlacement() failed\n");
	if (!SetWindowLong(hwnd, GWL_STYLE, dwStyle & ~WS_OVERLAPPEDWINDOW))
		return DKERROR("SetWindowLong() failed\n");
	if (!SetWindowPos(hwnd, HWND_TOP, mi.rcMonitor.left, mi.rcMonitor.top, mi.rcMonitor.right - mi.rcMonitor.left, mi.rcMonitor.bottom - mi.rcMonitor.top, SWP_NOOWNERZORDER | SWP_FRAMECHANGED))
		return DKERROR("SetWindowPos() failed\n");
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
		gdk_window_fullscreen(gdk_window);
		isFullscreen = true;
		return true;
#	endif //USE_GDK
#else
	return false && DKWARN("not implemented on this OS\n");
#endif
}

bool DKCEFWindow::GetHandle(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	*(HWND*)output = hwnd;
	return true;
#elif MAC
	//TODO / FIXME
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
	*(NSView**)output = nsview;
	return true;
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
		*(GdkWindow**)output = gdk_window;
		return true;
#	endif //USE_GDK
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::GetHeight(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	RECT rect;
	if(!GetWindowRect(hwnd, &rect))
		return DKERROR("GetWindowRect() failed\n");
	int height = rect.bottom - rect.top;
	*(int*)output = height;
	return true;
#elif MAC
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
	int height = nsview.frame.size.height;
	*(int*)output = height;
	return true;
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
		int height = gdk_window_get_height(gdk_window);
		*(int*)output = height;
		return true;
#	endif //USE_GDK
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::GetMouseX(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	POINT p;
	if (!GetCursorPos(&p))
		return DKERROR("GetCursorPos() failed\n");
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	if (!ScreenToClient(hwnd, &p))
		return DKERROR("ScreenToClient() failed\n");
	*(int*)output = p.x; //p.x and p.y are now relative to hwnd's client area
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
#	endif //USE_GDK
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::GetMouseY(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	POINT p;
	if (!GetCursorPos(&p))
		return DKERROR("GetCursorPos() failed\n");
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	if (!ScreenToClient(hwnd, &p))
		return DKERROR("ScreenToClient() failed\n");
	*(int*)output = p.y; //p.x and p.y are now relative to hwnd's client area
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
#	endif //USE_GDK
#else //LINUX
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::GetWidth(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	RECT rect;
	if (!GetWindowRect(hwnd, &rect))
		return DKERROR("GetWindowRect() failed\n");
	int width = rect.right - rect.left;
	*(int*)output = width;
	return true;
#elif MAC
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
	int width = nsview.frame.size.width;
	*(int*)output = width;
	return true;
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid");
		int width = gdk_window_get_width(gdk_window);
		*(int*)output = width;
		return true;
#	endif //USE_GDK
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::GetX(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	RECT rect;
	if (!GetWindowRect(hwnd, &rect))
		return DKERROR("GetWindowRect() failed\n");
	int x = rect.left;
	*(int*)output = x;
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
		gint x, y;
		gdk_window_get_position(gdk_window, &x, &y);
		DKINFO("gdk_window_get_position(): x="+toString((int)x)+" y="+toString((int)y)+"\n");
		*(int*)output = (int)x;
		return true;
#	endif
#else
	DKWARN("DKCEFWindow::GetX(): not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::GetY(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	RECT rect;
	if (!GetWindowRect(hwnd, &rect))
		return DKERROR("GetWindowRect() failed\n");
	int y = rect.top;
	*(int*)output = y;
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
		gint x, y;
		gdk_window_get_position(gdk_window, &x, &y);
		DKINFO("gdk_window_get_position(): x="+toString((int)x)+" y="+toString((int)y)+"\n");
		*(int*)output = (int)y;
		return true;
#	endif //USE_GDK
#else //LINUX
	DKWARN("DKCEFWindow::GetY(): not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::Hide(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!hwnd)
		return DKERROR("hwnd invalid\n")
	if (!ShowWindow(hwnd, SW_HIDE))
		return DKERROR("ShowWindow() failed\n");
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
		gdk_window_hide(gdk_window);
		return true;
#	endif //USE_GDK
#else //LINUX
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::IsFullscreen(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	RECT a, b;
	if (!GetWindowRect(hwnd, &a))
		return DKERROR("GetWindowRect(hwnd) failed\n");
	if (!GetWindowRect(GetDesktopWindow(), &b))
		return DKERROR("GetWindowRect() failed\n");
	bool fullscreen = (a.left == b.left && a.top == b.top && a.right == b.right && a.bottom == b.bottom);
	*(bool*)output = fullscreen;
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
		GdkWindowState state = gdk_window_get_state(gdk_window);
		bool isFullscreen = ((state & GDK_WINDOW_STATE_FULLSCREEN) != 0);
		*(bool*)output = isFullscreen;
		return true;
#	endif //USE_GDK
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::IsVisible(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	*(bool*)output = (IsWindowVisible(hwnd) != 0);
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
		bool visible = gdk_window_is_visible(gdk_window);
		*(bool*)output = visible;
		return true;
#	endif //USE_GDK
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::Maximize(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	if (!ShowWindow(hwnd, SW_MAXIMIZE))
		return DKERROR("ShowWindow() failes\n");
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
		gdk_window_maximize(gdk_window);
		return true;
#	endif //USE_GDK
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::MessageBox(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
//#if WIN32
	//TODO
//#elif MAC
	//TODO
//#elif LINUX
	//TODO
//#else
	DKWARN("DKCEFWindow::MessageBox(): not implemented on this OS\n");
	return false;
//#endif
}

bool DKCEFWindow::Minimize(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	if (!ShowWindow(hwnd, SW_MINIMIZE))
		return DKERROR("ShowWindow() failed\n");
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
		gdk_window_iconify(gdk_window);
		return true;
#	endif //USE_GDK
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::Restore(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	if (!ShowWindow(hwnd, SW_RESTORE))
		return DKERROR("ShowWindow() failed\n");
	if (!BringWindowToTop(hwnd))
		return DKERROR("BringWindowToTop() failed\n");
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
		gdk_window_deiconify(gdk_window);
		return true;
#	endif //USE_GDK
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::SetHeight(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	RECT rect;
	if (!GetWindowRect(hwnd, &rect))
		return DKERROR("GetWindowRect() failed\n");
	int width = rect.right - rect.left;
	int height = *(int*)input;
	if (!MoveWindow(hwnd, rect.left, rect.top, width, height, true))
		return DKERROR("MoveWindow() failed\n");
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
		int width;
		if (!GetWidth(NULL, &width))
			return DKERROR("GetWidth() failed\n");
		int height = *(int*)input;
		gdk_window_resize(gdk_window, width, height);
		return true;
#	endif
#else
	DKWARN("DKCEFWindow::SetHeight(): not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::SetIcon(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!hwnd)
		return DKERROR("hwnd is invalid\n");
	HINSTANCE hinstance = (HINSTANCE)(LONG_PTR)GetWindowLong(hwnd, GWLP_HINSTANCE); //WIN32 may require GWL_HINSTANCE
	if(!hinstance)
		return DKERROR("hinstance is invalid\n");
	DKString file = *(DKString*)input;
	HANDLE icon = LoadImage(hinstance, file.c_str(), IMAGE_ICON, 32, 32, LR_LOADFROMFILE);
	if(!icon)
		return DKERROR("icon is invalid\n");
	SendMessage(hwnd, (UINT)WM_SETICON, ICON_BIG, (LPARAM)icon);
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		//TODO
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
#	endif
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::SetTitle(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	if (!SetWindowText(hwnd, "test"))
		return DKERROR("SetWindowText() failed\n");
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
		gdk_window_set_title(gdk_window, "test");
		return true;
#	endif //USE_GDK
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::SetWidth(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid");
	RECT rect;
	if (!GetWindowRect(hwnd, &rect))
		return DKERROR("GetWindowRect() failed\n");
	int height = rect.bottom - rect.top;
	int width = *(int*)input;
	if (!MoveWindow(hwnd, rect.left, rect.top, width, height, true))
		return DKERROR("MoveWindow() failed\n");
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if (!gdk_window)
		return DKERROR("gdk_window invalid\n");
	int height;
	if (!GetHeight(NULL, &height))
		return DKERROR("GetHeight() failed\n");
	int width = *(int*)input;
	gdk_window_resize(gdk_window, width, height);
	return true;
#	endif
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::SetX(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	RECT rect;
	if (!GetWindowRect(hwnd, &rect))
		return DKERROR("GetWindowRect() failed\n");
	int width = rect.right - rect.left;
	int height = rect.bottom - rect.top;
	int x = *(int*)input;
	if(!MoveWindow(hwnd, x, rect.top, width, height, true))
		return DKERROR("MoveWindow() failed\n")
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
		int y;
		if (!GetY(NULL, &y))
			return DKERROR("GetY() failed\n");
		int x = *(int*)input;
		gdk_window_move(gdk_window, x, y);
		return true;
#	endif //USE_GDK
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::SetY(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	RECT rect;
	if (!GetWindowRect(hwnd, &rect))
		return DKERROR("GetWindowRect() failed\n");
	int width = rect.right - rect.left;
	int height = rect.bottom - rect.top;
	int y = *(int*)input;
	if (!MoveWindow(hwnd, rect.left, y, width, height, true))
		return DKERROR("MoveWindow() failed\n");
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
		int x;
		if (!GetX(NULL, &x))
			return DKERROR("GetX() failed\n");
		int y = *(int*)input;
		gdk_window_move(gdk_window, x, y);
#	endif //USE_GDK
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::Show(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	if(!ShowWindow(hwnd, SW_SHOW))
		return DKERROR("ShowWindow() failed\n");
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		/* FIXME
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if(!gdk_window)
			return DKERROR("gdk_window invalid\n");
		gdk_window_show(gdk_window);
		return true;
		*/
#	endif
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKCEFWindow::Windowed(const void* input, void* output){
	DKDEBUGFUNC(input, output);	
#if WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!hwnd)
		return DKERROR("hwnd invalid\n");
	DWORD dwStyle = GetWindowLong(hwnd, GWL_STYLE);
	if (!dwStyle)
		return DKERROR("dwStyle invalid\n");
	if (!SetWindowLong(hwnd, GWL_STYLE, dwStyle | WS_OVERLAPPEDWINDOW))
		return DKERROR("SetWindowLong() failed\n");
	if (!SetWindowPlacement(hwnd, &g_wpPrev))
		return DKERROR("SetWindowPlacement failed\n");
	if (!SetWindowPos(hwnd, NULL, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_NOOWNERZORDER | SWP_FRAMECHANGED))
		return DKERROR("SetWindowPos() failed\n");
	return true;
#elif MAC
	//TODO
	NSView* nsview = (NSView*)dkCef->current_browser->GetHost()->GetWindowHandle();
	if (!nsview)
		return DKERROR("nsview invalid\n");
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
		if (!gdk_window)
			return DKERROR("gdk_window invalid\n");
		gdk_window_unfullscreen(gdk_window);
		isFullscreen = false;
		return true;
#	endif
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

void DKCEFWindow::GetViewRect(CefRefPtr<CefBrowser> browser, CefRect& rect){
	DKDEBUGFUNC(browser, rect);
	CEF_REQUIRE_UI_THREAD();
	//rect = CefRect(0, 0, dkCef->width, dkCef->height);
}

void DKCEFWindow::OnAfterCreated(CefRefPtr<CefBrowser> browser){
	DKDEBUGFUNC(browser);
	CEF_REQUIRE_UI_THREAD();
	//dkCef->browsers.push_back(browser);
}

bool DKCEFWindow::OnBeforePopup(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, const CefString& target_url, const CefString& target_frame_name, CefLifeSpanHandler::WindowOpenDisposition target_disposition, bool user_gesture, const CefPopupFeatures& popupFeatures, CefWindowInfo& windowInfo, CefRefPtr<CefClient>& client, CefBrowserSettings& settings, CefRefPtr<CefDictionaryValue>& extra_info, bool* no_javascript_access){
	DKDEBUGFUNC(browser, frame, target_url, target_frame_name, target_disposition, user_gesture, popupFeatures, /*windowInfo,*/ client, settings, extra_info, no_javascript_access);
#if WIN
	UNREFERENCED_PARAMETER(windowInfo);
#endif
	CEF_REQUIRE_UI_THREAD();
	return false;
}

void DKCEFWindow::OnBeforeContextMenu(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, CefRefPtr<CefMenuModel> model){
	DKDEBUGFUNC(browser, frame, params, model);
	CEF_REQUIRE_UI_THREAD();
}

void DKCEFWindow::OnBeforeDownload(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDownloadItem> download_item, const CefString& suggested_name, CefRefPtr<CefBeforeDownloadCallback> callback){
	DKDEBUGFUNC(browser, download_item, suggested_name, callback);
	CEF_REQUIRE_UI_THREAD();
	callback->Continue(suggested_name, true);
}

bool DKCEFWindow::OnConsoleMessage(CefRefPtr<CefBrowser> browser, cef_log_severity_t level, const CefString& message, const CefString& source, int line){
	DKDEBUGFUNC(browser, level, message, source, line);
	return dkCef->OnConsoleMessage(browser, level, message, source, line);
}

bool DKCEFWindow::OnContextMenuCommand(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefContextMenuParams> params, int command_id, CefContextMenuHandler::EventFlags event_flags){
	DKDEBUGFUNC(browser, frame, params, command_id, event_flags);
	CEF_REQUIRE_UI_THREAD();
	return false;
}

void DKCEFWindow::OnCursorChange(CefRefPtr<CefBrowser> browser, CefCursorHandle cursor, CursorType type, const CefCursorInfo& custom_cursor_info){
	DKDEBUGFUNC(browser, cursor, type, custom_cursor_info);
#if WIN32
	HWND hwnd;
	if (!DKClass::CallFunc("DKSdlWindow::GetHandle", NULL, &hwnd)) {
		DKERROR("DKClass::CallFunc() failed\n");
		return; 
	}
	if (!::IsWindow(hwnd)) {
		DKERROR("::IsWindow() failed\n");
		return; 
	}
	if (!SetClassLongPtr(hwnd, GCLP_HCURSOR, static_cast<LONG>(reinterpret_cast<LONG_PTR>(cursor)))) {
		DKERROR("SetClassLongPtr() failed\n");
		return;
	}
	if (!SetCursor(cursor)) {
		DKERROR("SetCursor() failed\n");
	}
/*
#elif LINUX
	//Display* dpy; = glfwGetX11Display();
	//Cursor c;
	//c = XCreateFontCursor(dpy, XC_xterm); 
	//XDefineCursor(dpy, w, c);
*/
#else
	DKWARN("not implemented on this OS\n");
#endif
}

void DKCEFWindow::OnFindResult(CefRefPtr<CefBrowser> browser, int identifier, int count, const CefRect& selectionRect, int activeMatchOrdinal, bool finalUpdate){
	DKDEBUGFUNC(browser, identifier, count, selectionRect, activeMatchOrdinal, finalUpdate);
	CEF_REQUIRE_UI_THREAD();
}

bool DKCEFWindow::OnFileDialog(CefRefPtr<CefBrowser> browser, CefDialogHandler::FileDialogMode mode, const CefString& title, const CefString& default_file_path, const std::vector<CefString>& accept_filters, int selected_accept_filter, CefRefPtr<CefFileDialogCallback> callback) {
	DKDEBUGFUNC(browser, mode, title, default_file_path, accept_filters, selected_accept_filter, callback);
	return false;
}

void DKCEFWindow::OnFullscreenModeChange(CefRefPtr<CefBrowser> browser, bool fullscreen){
	DKDEBUGFUNC(browser, fullscreen);
	CEF_REQUIRE_UI_THREAD();
#if WIN32
	HWND hwnd = GetActiveWindow();
	if (!hwnd) {
		DKERROR("hwnd invalid\n");
		return;
	}
	DWORD dwStyle = GetWindowLong(hwnd, GWL_STYLE);
	if (!dwStyle) {
		DKERROR("dwStyle invalid\n");
		return;
	}
	if (dwStyle & WS_OVERLAPPEDWINDOW) {
		MONITORINFO mi = { sizeof(mi) };
		if (!GetWindowPlacement(hwnd, &g_wpPrev) && GetMonitorInfo(MonitorFromWindow(hwnd, MONITOR_DEFAULTTOPRIMARY), &mi)) {
			DKERROR("GetWindowPlacement() failed");
			return;
		}
		if (!SetWindowLong(hwnd, GWL_STYLE, dwStyle & ~WS_OVERLAPPEDWINDOW)) {
			DKERROR("SetWindowLong() failed\n");
			return;
		}
		if (!SetWindowPos(hwnd, HWND_TOP, mi.rcMonitor.left, mi.rcMonitor.top, mi.rcMonitor.right - mi.rcMonitor.left, mi.rcMonitor.bottom - mi.rcMonitor.top, SWP_NOOWNERZORDER | SWP_FRAMECHANGED)) {
			DKERROR("SetWindowPos() failed");
			return;
		}
	}
	else {
		if (!SetWindowLong(hwnd, GWL_STYLE, dwStyle | WS_OVERLAPPEDWINDOW)) {
			DKERROR("SetWindowLong() failed");
			return;
		}
		if (!SetWindowPlacement(hwnd, &g_wpPrev)) {
			DKERROR("SetWindowPlacement() failed\n");
		}
		if (!SetWindowPos(hwnd, NULL, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_NOOWNERZORDER | SWP_FRAMECHANGED)) {
			DKERROR("SetWindowPos() failed\n");
		}
	}
#elif LINUX
#	if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(browser->GetHost()->GetWindowHandle());
		if (!gdk_window) {
			DKERROR("gdk_window invalid\n");
			return;
		}
		if (fullscreen) {
			gdk_window_fullscreen(gdk_window);
			isFullscreen = true;
		}
		else {
			gdk_window_unfullscreen(gdk_window);
			isFullscreen = false;
		}
#	endif //USE_GDK
#else 
	DKWARN("not implemented on this OS\n");
#endif
}

void DKCEFWindow::OnLoadEnd(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, int httpStatusCode) {
	DKDEBUGFUNC(browser, frame, httpStatusCode);
	if (!frame->IsMain()) {
		DKERROR("frame in not main\n");
		return;
	}
	DKEvents::SendEvent("window", "DKCef_OnLoadEnd", toString(httpStatusCode));
}

void DKCEFWindow::OnLoadError(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefLoadHandler::ErrorCode errorCode, const CefString& errorText, const CefString& failedUrl){
	DKDEBUGFUNC(browser, frame, errorCode, errorText, failedUrl);
	CEF_REQUIRE_UI_THREAD();
}

void DKCEFWindow::OnLoadingStateChange(CefRefPtr<CefBrowser> browser, bool isLoading, bool canGoBack, bool canGoForward){
	DKDEBUGFUNC(browser, isLoading, canGoBack, canGoForward);
	CEF_REQUIRE_UI_THREAD();
	DKEvents::SendEvent("window", "DKCef_OnLoadingStateChange", toString(browser->GetIdentifier()));
}

void DKCEFWindow::OnPaint(CefRefPtr<CefBrowser> browser, PaintElementType type, const RectList& dirtyRects, const void* buffer, int width, int height){
	DKDEBUGFUNC(browser, type, dirtyRects, buffer, width, height);
	CEF_REQUIRE_UI_THREAD();
}

void DKCEFWindow::OnPopupShow(CefRefPtr<CefBrowser> browser, bool show){
	DKDEBUGFUNC(browser, show);
	CEF_REQUIRE_UI_THREAD();
}

void DKCEFWindow::OnPopupSize(CefRefPtr<CefBrowser> browser, const CefRect& rect){
	DKDEBUGFUNC(browser, rect);
	CEF_REQUIRE_UI_THREAD();
}

bool DKCEFWindow::OnPreKeyEvent(CefRefPtr<CefBrowser> browser, const CefKeyEvent& event, CefEventHandle os_event, bool* is_keyboard_shortcut){
	DKDEBUGFUNC(browser, event, os_event, is_keyboard_shortcut);
	CEF_REQUIRE_UI_THREAD();
	if (event.type == KEYEVENT_RAWKEYDOWN)
		DKEvents::SendEvent("window", "keydown", toString(event.windows_key_code)); //DKKeyboardEvent event = new DKEvents();
	if (event.type == KEYEVENT_KEYDOWN) // TODO
		DKINFO("OnPreKeyEvent(): KeyDown: " + toString(event.character) + "\n");
	if (event.type == KEYEVENT_KEYUP) // TODO
		DKINFO("OnPreKeyEvent(): KeyUp: "+toString(event.character)+"\n");
	if (event.type == KEYEVENT_CHAR)
		DKEvents::SendEvent("window", "keypress", toString(event.character));
	return false;
}

bool DKCEFWindow::OnPrintDialog(CefRefPtr<CefBrowser> browser, bool has_selection, CefRefPtr<CefPrintDialogCallback> callback){
	DKDEBUGFUNC(browser, has_selection, callback);
	return true;
}

bool DKCEFWindow::OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefProcessId source_process, CefRefPtr<CefProcessMessage> message){
	DKDEBUGFUNC(browser, frame, source_process, message);
	CEF_REQUIRE_UI_THREAD();
	if (message->GetName() == "GetFunctions")
		if (!DKV8::GetFunctions(browser))
			return DKERROR("DKV8::GetFunctions() failed\n");
	if (has(message->GetName(), "CallFunc(")) {
		//DKINFO("DKCEFWindow::OnProcessMessageReceived(CallFunc)\n");
		//get function name
		DKString func = message->GetName();
		replace(func, "CallFunc(", "");
		replace(func, ")", "");
		//get arguments
		CefRefPtr<CefListValue> arguments = message->GetArgumentList();
		if (!DKV8::Execute(browser, func, arguments))
			return DKERROR("DKV8::Execute() failed\n");
	}
	return false;
}

bool DKCEFWindow::OnTooltip(CefRefPtr<CefBrowser> browser, CefString& text){
	DKDEBUGFUNC(browser, text);
	CEF_REQUIRE_UI_THREAD();
	return true;
}
