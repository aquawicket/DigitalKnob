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
#include "DKSFMLWindow/DKSFMLWindow.h"

//WARNING_DISABLE
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>
//WARNING_ENABLE


//std::vector<boost::function<bool(sf::Event& e)> > DKSFMLWindow::event_funcs;
//std::vector<boost::function<void()> > DKSFMLWindow::draw_funcs;
std::vector<std::function<bool(sf::Event& e)> > DKSFMLWindow::event_funcs;
std::vector<std::function<void()> > DKSFMLWindow::draw_funcs;

bool DKSFMLWindow::Init(){
	DKDEBUGFUNC();
	window.create(sf::VideoMode({ 800, 600 }), "Window_0");
	DKClass::RegisterFunc("DKSFMLWindow::TestInt", &DKSFMLWindow::TestInt, this);
	DKClass::RegisterFunc("DKSFMLWindow::TestString", &DKSFMLWindow::TestString, this);
	DKClass::RegisterFunc("DKSFMLWindow::TestReturnInt", &DKSFMLWindow::TestReturnInt, this);
	DKClass::RegisterFunc("DKSFMLWindow::TestReturnString", &DKSFMLWindow::TestReturnString, this);

	DKClass::RegisterFunc("DKSFMLWindow::Fullscreen", &DKSFMLWindow::Fullscreen, this);
	DKClass::RegisterFunc("DKSFMLWindow::GetClipboard", &DKSFMLWindow::GetClipboard, this);
	DKClass::RegisterFunc("DKSFMLWindow::GetHandle", &DKSFMLWindow::GetHandle, this);
	DKClass::RegisterFunc("DKSFMLWindow::GetHeight", &DKSFMLWindow::GetHeight, this);
	DKClass::RegisterFunc("DKSFMLWindow::GetMouseX", &DKSFMLWindow::GetMouseX, this);
	DKClass::RegisterFunc("DKSFMLWindow::GetMouseY", &DKSFMLWindow::GetMouseY, this);
	DKClass::RegisterFunc("DKSFMLWindow::GetWidth", &DKSFMLWindow::GetWidth, this);
	DKClass::RegisterFunc("DKSFMLWindow::GetX", &DKSFMLWindow::GetX, this);
	DKClass::RegisterFunc("DKSFMLWindow::GetY", &DKSFMLWindow::GetY, this);
	DKClass::RegisterFunc("DKSFMLWindow::Hide", &DKSFMLWindow::Hide, this);
	DKClass::RegisterFunc("DKSFMLWindow::IsFullscreen", &DKSFMLWindow::IsFullscreen, this);
	DKClass::RegisterFunc("DKSFMLWindow::IsVisible", &DKSFMLWindow::IsVisible, this);
	DKClass::RegisterFunc("DKSFMLWindow::MessageBox", &DKSFMLWindow::MessageBox, this);
	DKClass::RegisterFunc("DKSFMLWindow::Minimize", &DKSFMLWindow::Minimize, this);
	DKClass::RegisterFunc("DKSFMLWindow::Restore", &DKSFMLWindow::Restore, this);
	DKClass::RegisterFunc("DKSFMLWindow::SetClipboard", &DKSFMLWindow::SetClipboard, this);
	DKClass::RegisterFunc("DKSFMLWindow::SetHeight", &DKSFMLWindow::SetHeight, this);
	DKClass::RegisterFunc("DKSFMLWindow::SetIcon", &DKSFMLWindow::SetIcon, this);
	DKClass::RegisterFunc("DKSFMLWindow::SetWidth", &DKSFMLWindow::SetWidth, this);
	DKClass::RegisterFunc("DKSFMLWindow::SetX", &DKSFMLWindow::SetX, this);
	DKClass::RegisterFunc("DKSFMLWindow::SetY", &DKSFMLWindow::SetY, this);
	DKClass::RegisterFunc("DKSFMLWindow::Show", &DKSFMLWindow::Show, this);
	DKClass::RegisterFunc("DKSFMLWindow::Windowed", &DKSFMLWindow::Windowed, this);

	DKApp::AppendLoopFunc(&DKSFMLWindow::Process, this);
	DKSFMLWindow::AddEventFunc(&DKSFMLWindow::handle, this);
	return true;
}

bool DKSFMLWindow::End(){
	DKDEBUGFUNC();
	window.close();
	return true;
}

void DKSFMLWindow::Process(){
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

bool DKSFMLWindow::handle(sf::Event& e){
	DKDEBUGFUNC(e);
	if(e.type == sf::Event::Closed){
		DKApp::Exit();
		return false;
	}
	return false; //allow event to continue
}

bool DKSFMLWindow::TestInt(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	int in = *(int*)input;
	int out = in;
	*(int*)output = out;
	return true;
}

bool DKSFMLWindow::TestString(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	std::string in = *(std::string*)input;
	std::string out = in;
	*(std::string*)output = out;
	return true;
}

bool DKSFMLWindow::TestReturnInt(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	int var = 1234;
	*(int*)output = var;
	return true;
}

bool DKSFMLWindow::TestReturnString(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	std::string var = "Return test";
	*(std::string*)output = var;
	return true;
}

bool DKSFMLWindow::Fullscreen(const void* input, void* output){
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
	GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
	if(!gdk_window)
		return DKERROR("gdk_window is invalid! \n");
	gdk_window_fullscreen(gdk_window);
	//isFullscreen = true;
	return true;
#else
	return DKERROR("not implemented on this OS\n");
#endif
}

bool DKSFMLWindow::GetClipboard(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	DKString text;
	if(!DKUtil::GetClipboard(text))
		return DKERROR("DKUtil::GetClipboard() failed \n");
	*(DKString*)output = text;
	return true;
}

bool DKSFMLWindow::GetHandle(const void* input, void* output){
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
	GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
	if(!gdk_window)
		return DKERROR("gdk_window is invalid! \n");
	//*(GdkWindow*)output = gdk_window; //FIXME
	return true;
#else
	return DKERROR("not implemented on this OS\n");
#endif
}

bool DKSFMLWindow::GetHeight(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	sf::Vector2u size = window.getSize();
	*(int*)output = size.y;
	return true;
}

bool DKSFMLWindow::GetMouseX(const void* input, void* output){
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
	//TODO
	GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
	if(!gdk_window)
		return DKERROR("gdk_window is invalid! \n");
#else
	return DKERROR("not implemented on this OS \n");
#endif
}

bool DKSFMLWindow::GetMouseY(const void* input, void* output){
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
	//TODO
	GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
	if(!gdk_window)
		return DKERROR("gdk_window is invalid! \n");
#else
	return DKERROR("not implemented on this OS\n");
#endif
}

bool DKSFMLWindow::GetWidth(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	sf::Vector2u size = window.getSize();
	*(int*)output = size.x;
	return true;
}

bool DKSFMLWindow::GetX(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	sf::Vector2i position = window.getPosition();
	*(int*)output = position.x;
	return true;
}

bool DKSFMLWindow::GetY(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	sf::Vector2i position = window.getPosition();
	*(int*)output = position.x;
	return true;
}

bool DKSFMLWindow::Hide(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	window.setVisible(false);
	return true;
}

bool DKSFMLWindow::IsFullscreen(const void* input, void* output){
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
	return DKERROR("not implemented on this OS\n");
#endif
}

bool DKSFMLWindow::IsVisible(const void* input, void* output){
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
	GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
	if(!gdk_window)
		return DKERROR("gdk_window is invalid! \n");
	bool visible = gdk_window_is_visible(gdk_window);
	*(bool*)output = visible;
	return true;
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKSFMLWindow::MessageBox(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	//TODO
	return false;
}

bool DKSFMLWindow::Minimize(const void* input, void* output){
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
	GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
	if(!gdk_window)
		return DKERROR("gdk_window is invalid! \n");
	gdk_window_iconify(gdk_window);
	return true;
#else
	return DKERROR("not implemented on this OS\n");
#endif
}

bool DKSFMLWindow::Restore(const void* input, void* output){
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
	GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
	if(!gdk_window)
		return DKERROR("gdk_window is invalid! \n");
	gdk_window_deiconify(gdk_window);
	return true;
#else
	return DKERROR("not implemented on this OS\n");
#endif
}

bool DKSFMLWindow::SetClipboard(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	//TODO
	return false;
}

bool DKSFMLWindow::SetHeight(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	sf::Vector2u size = window.getSize();
	size.y = *(int*)input;
	window.setSize(size);
	return true;
}

bool DKSFMLWindow::SetIcon(const void* input, void* output){
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
	//TODO
	GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
	if(!gdk_window){ return false; }
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKSFMLWindow::SetWidth(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	sf::Vector2u size = window.getSize();
	size.x = *(int*)input;
	window.setSize(size);	
	return true;
}

bool DKSFMLWindow::SetX(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	sf::Vector2i position = window.getPosition();
	position.x = *(int*)input;
	window.setPosition(position);	
	return true;
}

bool DKSFMLWindow::SetY(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	sf::Vector2i position = window.getPosition();
	position.y = *(int*)input;
	window.setPosition(position);	
	return true;
}

bool DKSFMLWindow::Show(const void* input, void* output){
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
	GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
	if(!gdk_window){ return false; }
	gdk_window_show(gdk_window);
	return true;
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}

bool DKSFMLWindow::Windowed(const void* input, void* output){
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
	GdkWindow* gdk_window = gdk_window_foreign_new(window.getSystemHandle());
	if(!gdk_window){ return false;}
	gdk_window_unfullscreen(gdk_window);
	//isFullscreen = false;
	return true;
#else
	DKWARN("not implemented on this OS\n");
	return false;
#endif
}
