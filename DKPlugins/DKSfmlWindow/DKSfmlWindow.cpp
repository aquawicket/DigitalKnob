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
#include "DKSfmlWindow/DKSfmlWindow.h"

WARNING_DISABLE
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
WARNING_ENABLE


//std::vector<boost::function<bool(sf::Event& e)> > DKSfmlWindow::event_funcs;
//std::vector<boost::function<void()> > DKSfmlWindow::draw_funcs;
std::vector<std::function<bool(sf::Event& e)> > DKSfmlWindow::event_funcs;
std::vector<std::function<void()> > DKSfmlWindow::draw_funcs;

bool DKSfmlWindow::Init(){
	DKDEBUGFUNC();
	window.create(sf::VideoMode({ 800, 600 }), "Window_0");
	DKClass::RegisterFunc("DKSfmlWindow::TestInt", &DKSfmlWindow::TestInt, this);
	DKClass::RegisterFunc("DKSfmlWindow::TestString", &DKSfmlWindow::TestString, this);
	DKClass::RegisterFunc("DKSfmlWindow::TestReturnInt", &DKSfmlWindow::TestReturnInt, this);
	DKClass::RegisterFunc("DKSfmlWindow::TestReturnString", &DKSfmlWindow::TestReturnString, this);

	DKClass::RegisterFunc("DKSfmlWindow::Fullscreen", &DKSfmlWindow::Fullscreen, this);
	DKClass::RegisterFunc("DKSfmlWindow::GetClipboard", &DKSfmlWindow::GetClipboard, this);
	DKClass::RegisterFunc("DKSfmlWindow::GetHandle", &DKSfmlWindow::GetHandle, this);
	DKClass::RegisterFunc("DKSfmlWindow::GetHeight", &DKSfmlWindow::GetHeight, this);
	DKClass::RegisterFunc("DKSfmlWindow::GetMouseX", &DKSfmlWindow::GetMouseX, this);
	DKClass::RegisterFunc("DKSfmlWindow::GetMouseY", &DKSfmlWindow::GetMouseY, this);
	DKClass::RegisterFunc("DKSfmlWindow::GetWidth", &DKSfmlWindow::GetWidth, this);
	DKClass::RegisterFunc("DKSfmlWindow::GetX", &DKSfmlWindow::GetX, this);
	DKClass::RegisterFunc("DKSfmlWindow::GetY", &DKSfmlWindow::GetY, this);
	DKClass::RegisterFunc("DKSfmlWindow::Hide", &DKSfmlWindow::Hide, this);
	DKClass::RegisterFunc("DKSfmlWindow::IsFullscreen", &DKSfmlWindow::IsFullscreen, this);
	DKClass::RegisterFunc("DKSfmlWindow::IsVisible", &DKSfmlWindow::IsVisible, this);
	DKClass::RegisterFunc("DKSfmlWindow::MessageBox", &DKSfmlWindow::MessageBox, this);
	DKClass::RegisterFunc("DKSfmlWindow::Minimize", &DKSfmlWindow::Minimize, this);
	DKClass::RegisterFunc("DKSfmlWindow::Restore", &DKSfmlWindow::Restore, this);
	DKClass::RegisterFunc("DKSfmlWindow::SetClipboard", &DKSfmlWindow::SetClipboard, this);
	DKClass::RegisterFunc("DKSfmlWindow::SetHeight", &DKSfmlWindow::SetHeight, this);
	DKClass::RegisterFunc("DKSfmlWindow::SetIcon", &DKSfmlWindow::SetIcon, this);
	DKClass::RegisterFunc("DKSfmlWindow::SetWidth", &DKSfmlWindow::SetWidth, this);
	DKClass::RegisterFunc("DKSfmlWindow::SetX", &DKSfmlWindow::SetX, this);
	DKClass::RegisterFunc("DKSfmlWindow::SetY", &DKSfmlWindow::SetY, this);
	DKClass::RegisterFunc("DKSfmlWindow::Show", &DKSfmlWindow::Show, this);
	DKClass::RegisterFunc("DKSfmlWindow::Windowed", &DKSfmlWindow::Windowed, this);

	DKApp::AppendLoopFunc(&DKSfmlWindow::Process, this);
	DKSfmlWindow::AddEventFunc(&DKSfmlWindow::handle, this);
	return true;
}

bool DKSfmlWindow::End(){
	DKDEBUGFUNC();
	window.close();
	return true;
}

void DKSfmlWindow::Process(){
	//DKDEBUGFUNC();  //EXCESSIVE LOGGING
	sf::Event e;
	while(window.pollEvent(e)){
		//for(unsigned int i = 0; i < event_funcs.size(); ++i){
		for (size_t i = 0; i < event_funcs.size(); ++i) {
			if(event_funcs[i](e)){ //Call event functions
				i = event_funcs.size();	//eat the event
			}; 
		}
	}

	// Activate the window for OpenGL rendering
	if (!window.setActive())
		DKERROR("window.setActive() failed");

	// OpenGL drawing commands go here...

	// End the current frame and display its contents on screen
	window.display();
}

bool DKSfmlWindow::handle(sf::Event& e){
	DKDEBUGFUNC(e);
	if(e.type == sf::Event::Closed){
		DKApp::Exit();
		return false;
	}
	return false; //allow event to continue
}

bool DKSfmlWindow::TestInt(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	int in = *(int*)input;
	int out = in;
	*(int*)output = out;
	return true;
}

bool DKSfmlWindow::TestString(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	std::string in = *(std::string*)input;
	std::string out = in;
	*(std::string*)output = out;
	return true;
}

bool DKSfmlWindow::TestReturnInt(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	int var = 1234;
	*(int*)output = var;
	return true;
}

bool DKSfmlWindow::TestReturnString(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	std::string var = "Return test";
	*(std::string*)output = var;
	return true;
}

bool DKSfmlWindow::Fullscreen(const void* input, void* output){
	DKDEBUGFUNC(input, output);
#if WIN32
	HWND hwnd = window.getSystemHandle();
	DWORD dwStyle = GetWindowLong(hwnd, GWL_STYLE);
	MONITORINFO mi = { sizeof(mi) };
	if(GetWindowPlacement(hwnd, &g_wpPrev) && GetMonitorInfo(MonitorFromWindow(hwnd, MONITOR_DEFAULTTOPRIMARY), &mi)){
		SetWindowLong(hwnd, GWL_STYLE, dwStyle & ~WS_OVERLAPPEDWINDOW);
		SetWindowPos(hwnd, HWND_TOP,
			mi.rcMonitor.left, mi.rcMonitor.top,
			mi.rcMonitor.right - mi.rcMonitor.left,
			mi.rcMonitor.bottom - mi.rcMonitor.top,
			SWP_NOOWNERZORDER | SWP_FRAMECHANGED);
	}
	return true;
#elif MAC
	//TODO
	//NSView* nsview = window.getSystemHandle();
	//if(!nsview){ return false; }
#elif LINUX
	#if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
		if(!gdk_window)
			return DKERROR("gdk_window is invalid! \n");
		gdk_window_fullscreen(gdk_window);
		//isFullscreen = true;
		return true;
	#else
		return DKERROR("!USE_GDK");
	#endif
#else
	return DKERROR("not implemented on this OS\n");
#endif
}

bool DKSfmlWindow::GetClipboard(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	DKString text;
	if(!DKUtil::GetClipboard(text))
		return DKERROR("DKUtil::GetClipboard() failed \n");
	*(DKString*)output = text;
	return true;
}

bool DKSfmlWindow::GetHandle(const void* input, void* output){
	DKDEBUGFUNC(input, output);
#if WIN32
	HWND hwnd = window.getSystemHandle();
	*(HWND*)output = hwnd;
	return true;
#elif MAC
	//NSView* nsview = window.getSystemHandle();
	//if(!nsview){ return false }
	//*(NSView*)output = nsview;
	//return true;
#elif LINUX
	#if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
		if(!gdk_window)
			return DKERROR("gdk_window is invalid! \n");
		//*(GdkWindow*)output = gdk_window; //FIXME
		return true;
	#else
		return DKERROR("!USE_GDK");
	#endif
#else
	return DKERROR("not implemented on this OS\n");
#endif
}

bool DKSfmlWindow::GetHeight(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	sf::Vector2u size = window.getSize();
	*(int*)output = size.y;
	return true;
}

bool DKSfmlWindow::GetMouseX(const void* input, void* output){
	DKDEBUGFUNC(input, output);
#if WIN32
	POINT p;
	if(!GetCursorPos(&p))
		return DKERROR("GetCursorPos() failed! \n");
	HWND hwnd = window.getSystemHandle();
	if(!hwnd)
		return DKERROR("hwnd is invalid! \n");
	if(!ScreenToClient(hwnd, &p))
		return DKERROR("ScreenToClient() failed! \n");	
	*(int*)output = p.x; //p.x and p.y are now relative to hwnd's client area
	return true;
#elif MAC
	//TODO
	//NSView* nsview = window.getSystemHandle();
	//if(!nsview){ return false; }
#elif LINUX
	#if USE_GDK
		//TODO
		GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
		if(!gdk_window)
			return DKERROR("gdk_window is invalid! \n");
		return true;
	#else
		return DKERROR("!USE_GDK");
	#endif
#else
	return DKERROR("not implemented on this OS \n");
#endif
}

bool DKSfmlWindow::GetMouseY(const void* input, void* output){
	DKDEBUGFUNC(input, output);
#if WIN
	POINT p;
	if(!GetCursorPos(&p))
		return DKERROR("GetCursorPos() failed! \n");
	HWND hwnd = window.getSystemHandle();
	if(!hwnd)
		return DKERROR("hwnd is invalid! \n");
	if(!ScreenToClient(hwnd, &p))
		return DKERROR("ScreenToClient() failed! \n");		
	*(int*)output = p.y; //p.x and p.y are now relative to hwnd's client area
	return true;
#elif MAC
	//TODO
	//NSView* nsview = window.getSystemHandle();
	//if(!nsview){ return false; }
#elif LINUX
	#if USE_GDK
		//TODO
		GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
		if(!gdk_window)
			return DKERROR("gdk_window is invalid! \n");
		return true;
	#else
		return DKERROR("!USE_GDK")
	#endif
#else
	return DKERROR("not implemented on this OS\n");
#endif
}

bool DKSfmlWindow::GetWidth(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	sf::Vector2u size = window.getSize();
	*(int*)output = size.x;
	return true;
}

bool DKSfmlWindow::GetX(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	sf::Vector2i position = window.getPosition();
	*(int*)output = position.x;
	return true;
}

bool DKSfmlWindow::GetY(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	sf::Vector2i position = window.getPosition();
	*(int*)output = position.x;
	return true;
}

bool DKSfmlWindow::Hide(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	window.setVisible(false);
	return true;
}

bool DKSfmlWindow::IsFullscreen(const void* input, void* output){
	DKDEBUGFUNC(input, output);
#if WIN32
	HWND hwnd = window.getSystemHandle();
	RECT a, b;
	if(!GetWindowRect(hwnd, &a))
		return DKERROR("GetWindowRect(hwnd) failed! \n");
	if(!GetWindowRect(GetDesktopWindow(), &b))
		return DKERROR("GetWindowRect() failed! \n");
	bool fullscreen = (a.left == b.left && a.top == b.top && a.right == b.right && a.bottom == b.bottom);
	*(bool*)output = fullscreen;
	return true;
#elif MAC
	//TODO
	//NSView* nsview = window.getSystemHandle();
	//if(!nsview){ return false; }
#elif LINUX
	#if USE_GDK
		/*
		GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
		if(!gdk_window)
			return DKERROR("gdk_window is invalid! \n");
		GdkWindowState state = gdk_window_get_state(gdk_window);
		bool fullscreen = ((state & GDK_WINDOW_STATE_FULLSCREEN) != 0);
		*(bool*)output = fullscreen;
		*/
		//*(bool*)output = isFullscreen;
		return true;
	#else
		return DKERROR("!USE_GDK");
	#endif
#else
	return DKERROR("not implemented on this OS\n");
#endif
}

bool DKSfmlWindow::IsVisible(const void* input, void* output){
	DKDEBUGFUNC(input, output);
#if WIN32
	HWND hwnd = window.getSystemHandle();
	*(bool*)output = (IsWindowVisible(hwnd) != 0);
	return true;
#elif MAC
	//TODO
	//NSView* nsview = window.getSystemHandle();
	//if(!nsview){ return false; }
#elif LINUX
	#if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
		if(!gdk_window)
			return DKERROR("gdk_window is invalid! \n");
		bool visible = gdk_window_is_visible(gdk_window);
		*(bool*)output = visible;
		return true;
	#else
		return DKERROR("!USE_GDK");
	#endif
#else
	return DKERROR("not implemented on this OS\n");
#endif
}

bool DKSfmlWindow::MessageBox(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	//TODO
	return DKERROR("not implemented on this OS\n");
}

bool DKSfmlWindow::Minimize(const void* input, void* output){
	DKDEBUGFUNC(input, output);
#if WIN32
	HWND hwnd = window.getSystemHandle();
	ShowWindow(hwnd, SW_MINIMIZE);
	return true;
#elif MAC
	//TODO
	//NSView* nsview = window.getSystemHandle();
	//if(!nsview){ return false; }
#elif LINUX
	#if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
		if(!gdk_window)
			return DKERROR("gdk_window is invalid! \n");
		gdk_window_iconify(gdk_window);
		return true;
	#else
		return DKERROR("!USE_GDK");
	#endif
#else
	return DKERROR("not implemented on this OS\n");
#endif
}

bool DKSfmlWindow::Restore(const void* input, void* output){
	DKDEBUGFUNC(input, output);
#if WIN32
	HWND hwnd = window.getSystemHandle();
	if(!hwnd)
		return DKERROR("hwnd is invalid! \n");
	if(!ShowWindow(hwnd, SW_RESTORE))
		return DKERROR("ShowWindow() failed! \n");
	if(!BringWindowToTop(hwnd))
		return DKERROR("BringWindowToTop() failed! \n");
	return true;
#elif MAC
	//TODO
	//NSView* nsview = window.getSystemHandle();
	//if(!nsview){ return false; }
#elif LINUX
	#if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
		if(!gdk_window)
			return DKERROR("gdk_window is invalid! \n");
		gdk_window_deiconify(gdk_window);
		return true;
	#else
		return DKERROR("!USE_GDK")
	#endif
#else
	return DKERROR("not implemented on this OS\n");
#endif
}

bool DKSfmlWindow::SetClipboard(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	//TODO
	return DKERROR("not implemented on this OS\n");
}

bool DKSfmlWindow::SetHeight(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	sf::Vector2u size = window.getSize();
	size.y = *(int*)input;
	window.setSize(size);
	return true;
}

bool DKSfmlWindow::SetIcon(const void* input, void* output){
	DKDEBUGFUNC(input, output);
#if WIN32
	HWND hwnd = window.getSystemHandle();
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
	//NSView* nsview = window.getSystemHandle();
	//if(!nsview){ return false; }
#elif LINUX
	#if USE_GDK
		//TODO
		GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
		if(!gdk_window)
			return false;
	#else
		return DKERROR("!USE_GDK");
	#endif
#else
	return DKERROR("not implemented on this OS\n");
#endif
}

bool DKSfmlWindow::SetWidth(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	sf::Vector2u size = window.getSize();
	size.x = *(int*)input;
	window.setSize(size);	
	return true;
}

bool DKSfmlWindow::SetX(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	sf::Vector2i position = window.getPosition();
	position.x = *(int*)input;
	window.setPosition(position);	
	return true;
}

bool DKSfmlWindow::SetY(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	sf::Vector2i position = window.getPosition();
	position.y = *(int*)input;
	window.setPosition(position);	
	return true;
}

bool DKSfmlWindow::Show(const void* input, void* output){
	DKDEBUGFUNC(input, output);
#if WIN32
	HWND hwnd = window.getSystemHandle();
	ShowWindow(hwnd, SW_SHOW);
	return true;
#elif MAC
	//TODO
	//NSView* nsview = window.getSystemHandle();
	//if(!nsview){ return false; }
#elif LINUX
	#if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
		if(!gdk_window){ return false; }
		gdk_window_show(gdk_window);
		return true;
	#else
		return DKERROR("!USE_GDK");
	#endif
#else
	return DKERROR("not implemented on this OS\n");
#endif
}

bool DKSfmlWindow::Windowed(const void* input, void* output){
	DKDEBUGFUNC(input, output);
#if WIN32
	HWND hwnd = window.getSystemHandle();
	DWORD dwStyle = GetWindowLong(hwnd, GWL_STYLE);
	SetWindowLong(hwnd, GWL_STYLE, dwStyle | WS_OVERLAPPEDWINDOW);
	SetWindowPlacement(hwnd, &g_wpPrev);
	SetWindowPos(hwnd, NULL, 0, 0, 0, 0,
		SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER |
		SWP_NOOWNERZORDER | SWP_FRAMECHANGED);
	return true;
#elif MAC
	//TODO
	//NSView* nsview = window.getSystemHandle();
	//if(!nsview){ return false; }
#elif LINUX
	#if USE_GDK
		GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
		if(!gdk_window){ return false;}
		gdk_window_unfullscreen(gdk_window);
		//isFullscreen = false;
		return true;
	#else
		return DKERROR("!USE_GDK");
	#endif
#else
	return DKERROR("not implemented on this OS\n");
#endif
}
