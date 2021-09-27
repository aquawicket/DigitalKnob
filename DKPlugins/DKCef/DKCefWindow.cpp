#include "DK/stdafx.h"
#include "DKCef/DKCefWindow.h"

DKCefWindow::DKCefWindow(){
	DKDEBUGFUNC();
	DKClass::RegisterFunc("DKCefWindow::TestInt", &DKCefWindow::TestInt, this);
	DKClass::RegisterFunc("DKCefWindow::TestString", &DKCefWindow::TestString, this);
	DKClass::RegisterFunc("DKCefWindow::TestReturnInt", &DKCefWindow::TestReturnInt, this);
	DKClass::RegisterFunc("DKCefWindow::TestReturnString", &DKCefWindow::TestReturnString, this);

	DKClass::RegisterFunc("DKCefWindow::Fullscreen", &DKCefWindow::Fullscreen, this);
	DKClass::RegisterFunc("DKCefWindow::GetHandle", &DKCefWindow::GetHandle, this);
	DKClass::RegisterFunc("DKCefWindow::GetHeight", &DKCefWindow::GetHeight, this);
	DKClass::RegisterFunc("DKCefWindow::GetMouseX", &DKCefWindow::GetMouseX, this);
	DKClass::RegisterFunc("DKCefWindow::GetMouseY", &DKCefWindow::GetMouseY, this);
	DKClass::RegisterFunc("DKCefWindow::GetWidth", &DKCefWindow::GetWidth, this);
	DKClass::RegisterFunc("DKCefWindow::GetX", &DKCefWindow::GetX, this);
	DKClass::RegisterFunc("DKCefWindow::GetY", &DKCefWindow::GetY, this);
	DKClass::RegisterFunc("DKCefWindow::Hide", &DKCefWindow::Hide, this);
	DKClass::RegisterFunc("DKCefWindow::IsFullscreen", &DKCefWindow::IsFullscreen, this);
	DKClass::RegisterFunc("DKCefWindow::IsVisible", &DKCefWindow::IsVisible, this);
	DKClass::RegisterFunc("DKCefWindow::Maximize", &DKCefWindow::Maximize, this);
	DKClass::RegisterFunc("DKCefWindow::MessageBox", &DKCefWindow::MessageBox, this);
	DKClass::RegisterFunc("DKCefWindow::Minimize", &DKCefWindow::Minimize, this);
	DKClass::RegisterFunc("DKCefWindow::Restore", &DKCefWindow::Restore, this);
	DKClass::RegisterFunc("DKCefWindow::SetHeight", &DKCefWindow::SetHeight, this);
	DKClass::RegisterFunc("DKCefWindow::SetIcon", &DKCefWindow::SetIcon, this);
	DKClass::RegisterFunc("DKCefWindow::SetTitle", &DKCefWindow::SetTitle, this);
	DKClass::RegisterFunc("DKCefWindow::SetWidth", &DKCefWindow::SetWidth, this);
	DKClass::RegisterFunc("DKCefWindow::SetX", &DKCefWindow::SetX, this);
	DKClass::RegisterFunc("DKCefWindow::SetY", &DKCefWindow::SetY, this);
	DKClass::RegisterFunc("DKCefWindow::Show", &DKCefWindow::Show, this);
	DKClass::RegisterFunc("DKCefWindow::Windowed", &DKCefWindow::Windowed, this);
}

void DKCefWindow::DoFrame(){ 
/*
#ifdef WIN32
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

	CefDoMessageLoopWork(); //FIXME: this breaks SDL keyboard events for Mac OSX
};

////////////////////////////////////////////////////////
bool DKCefWindow::DoClose(CefRefPtr<CefBrowser> browser)
{
	DKDEBUGFUNC(browser);
	CEF_REQUIRE_UI_THREAD();
	if(browser->IsPopup()){ return false; }
	DKApp::Exit();
	return false;
}


//////////////////////////////////////////////////////////
bool DKCefWindow::TestInt(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);
	int in = *(int*)input;
	int out = in;
	*(int*)output = out;
	return true;
}

/////////////////////////////////////////////////////////////
bool DKCefWindow::TestString(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
	std::string in = *(std::string*)input;
	std::string out = in;
	*(std::string*)output = out;
	return true;
}

////////////////////////////////////////////////////////////////
bool DKCefWindow::TestReturnInt(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
	int var = 1234;
	*(int*)output = var;
	return true;
}

///////////////////////////////////////////////////////////////////
bool DKCefWindow::TestReturnString(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);		
	std::string var = "Return test";
	*(std::string*)output = var;
	return true;
}


/////////////////////////////////////////////////////////////
bool DKCefWindow::Fullscreen(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
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
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	gdk_window_fullscreen(gdk_window);
	isFullscreen = true;
	return true;
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::Fullscreen(): not implemented on this OS\n");
	return false;
}

////////////////////////////////////////////////////////////
bool DKCefWindow::GetHandle(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	*(HWND*)output = hwnd;
	return true;
#endif
#ifdef MAC
	//TODO / FIXME
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
	*(NSView**)output = nsview;
	return true;
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	*(GdkWindow**)output = gdk_window;
	return true;
#endif //USE_GDK
#endif //LINUX

	return false;
}

////////////////////////////////////////////////////////////
bool DKCefWindow::GetHeight(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	RECT rect;
	if(!GetWindowRect(hwnd, &rect)){ 
		DKWARN("DKCefWindow::GetHeight(): GetWindowRect() failed\n");
		return false; 
	}
	int height = rect.bottom - rect.top;
	*(int*)output = height;
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	int height = gdk_window_get_height(gdk_window);
	*(int*)output = height;
	return true;
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::GetHeight(): not implemented on this OS\n");
	return false;
}

////////////////////////////////////////////////////////////
bool DKCefWindow::GetMouseX(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	POINT p;
	if(!GetCursorPos(&p)){ return false; }
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!hwnd){ return false; }
	if(!ScreenToClient(hwnd, &p)){ return false; }		
	*(int*)output = p.x; //p.x and p.y are now relative to hwnd's client area
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::GetMouseX(): not implemented on this OS\n");
	return false;
}

////////////////////////////////////////////////////////////
bool DKCefWindow::GetMouseY(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	POINT p;
	if(!GetCursorPos(&p)){ return false; }
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!hwnd){ return false; }
	if(!ScreenToClient(hwnd, &p)){ return false; }		
	*(int*)output = p.y; //p.x and p.y are now relative to hwnd's client area
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::GetMouseY(): not implemented on this OS\n");
	return false;
}

///////////////////////////////////////////////////////////
bool DKCefWindow::GetWidth(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	RECT rect;
	if(!GetWindowRect(hwnd, &rect)){ return false; }
	int width = rect.right - rect.left;
	*(int*)output = width;
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	int width = gdk_window_get_width(gdk_window);
	*(int*)output = width;
	return true;
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::GetWidth(): not implemented on this OS\n");
	return false;
}

///////////////////////////////////////////////////////
bool DKCefWindow::GetX(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	RECT rect;
	if(!GetWindowRect(hwnd, &rect)){ return false; }
	int x = rect.left;
	*(int*)output = x;
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	gint x, y;
	gdk_window_get_position(gdk_window, &x, &y);
	DKINFO("gdk_window_get_position(): x="+toString((int)x)+" y="+toString((int)y)+"\n");
	*(int*)output = (int)x;
	return true;
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::GetX(): not implemented on this OS\n");
	return false;
}

///////////////////////////////////////////////////////
bool DKCefWindow::GetY(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	RECT rect;
	if(!GetWindowRect(hwnd, &rect)){ return false; }
	int y = rect.top;
	*(int*)output = y;
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	gint x, y;
	gdk_window_get_position(gdk_window, &x, &y);
	DKINFO("gdk_window_get_position(): x="+toString((int)x)+" y="+toString((int)y)+"\n");
	*(int*)output = (int)y;
	return true;
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::GetY(): not implemented on this OS\n");
	return false;
}

///////////////////////////////////////////////////////
bool DKCefWindow::Hide(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	ShowWindow(hwnd, SW_HIDE);
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	gdk_window_hide(gdk_window);
	return true;
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::Hide(): not implemented on this OS\n");
	return false;
}

///////////////////////////////////////////////////////////////
bool DKCefWindow::IsFullscreen(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	RECT a, b;
	if(!GetWindowRect(hwnd, &a)){ return false; }
	if(!GetWindowRect(GetDesktopWindow(), &b)){ return false; }
	bool fullscreen = (a.left == b.left && a.top == b.top && a.right == b.right && a.bottom == b.bottom);
	*(bool*)output = fullscreen;
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	GdkWindowState state = gdk_window_get_state(gdk_window);
	bool fullscreen = ((state & GDK_WINDOW_STATE_FULLSCREEN) != 0);
	*(bool*)output = fullscreen;
	*(bool*)output = isFullscreen;
	return true;
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::IsFullscreen(): not implemented on this OS\n");
	return false;
}

////////////////////////////////////////////////////////////
bool DKCefWindow::IsVisible(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	*(bool*)output = (IsWindowVisible(hwnd) != 0);
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	bool visible = gdk_window_is_visible(gdk_window);
	*(bool*)output = visible;
	return true;
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::IsVisible(): not implemented on this OS\n");
	return false;
}

///////////////////////////////////////////////////////////
bool DKCefWindow::Maximize(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	ShowWindow(hwnd, SW_MAXIMIZE);
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	gdk_window_maximize(gdk_window);
	return true;
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::Maximize(): not implemented on this OS\n");
	return false;
}

/////////////////////////////////////////////////////////////
bool DKCefWindow::MessageBox(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	//TODO
#endif
#ifdef MAC
	//TODO
#endif
#ifdef LINUX
	//TODO
#endif
	DKWARN("DKCefWindow::MessageBox(): not implemented on this OS\n");
	return false;
}

///////////////////////////////////////////////////////////
bool DKCefWindow::Minimize(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	ShowWindow(hwnd, SW_MINIMIZE);
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	gdk_window_iconify(gdk_window);
	return true;
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::Minimize(): not implemented on this OS\n");
	return false;
}

//////////////////////////////////////////////////////////
bool DKCefWindow::Restore(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!hwnd){ return false; }
	if(!ShowWindow(hwnd, SW_RESTORE)){ return false; }
	if(!BringWindowToTop(hwnd)){ return false; }
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	gdk_window_deiconify(gdk_window);
	return true;
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::Restore(): not implemented on this OS\n");
	return false;
}

////////////////////////////////////////////////////////////
bool DKCefWindow::SetHeight(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	RECT rect;
	if(!GetWindowRect(hwnd, &rect)){ return false; }
	int width = rect.right - rect.left;
	int height = *(int*)input;
	if(!MoveWindow(hwnd, rect.left, rect.top, width, height, true)){ return false; }
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	int width;
	if(!GetWidth(NULL, &width)){ return false; }
	int height = *(int*)input;
	gdk_window_resize(gdk_window, width, height);
	return true;
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::SetHeight(): not implemented on this OS\n");
	return false;
}

//////////////////////////////////////////////////////////
bool DKCefWindow::SetIcon(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	if(!dkCef){
		DKERROR("DKCefWindow::SetIcon(): dkCef is invalid \n");
		return false;
	}
	if(!dkCef->current_browser){
		DKERROR("DKCefWindow::SetIcon(): dkCef->current_browser is invalid \n");
		return false;
	}
	if(!dkCef->current_browser->GetHost()){
		DKERROR("DKCefWindow::SetIcon(): dkCef->current_browser->GetHost() is invalid \n");
		return false;
	}
	if(!dkCef->current_browser->GetHost()->GetWindowHandle()){
		DKERROR("DKCefWindow::SetIcon(): dkCef->current_browser->GetHost()->GetWindowHandle() is invalid \n");
		return false;
	}

	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!hwnd){
		DKERROR("DKCefWindow::SetIcon(): hwnd is invalid \n");
		return false;
	}
	HINSTANCE hinstance = (HINSTANCE)GetWindowLong(hwnd, GWLP_HINSTANCE); //WIN32 may require GWL_HINSTANCE
	if(!hinstance){
		DKERROR("DKCefWindow::SetIcon(): hinstance is invalid \n");
		return false;
	}
	DKString file = *(DKString*)input;
	HANDLE icon = LoadImage(hinstance, file.c_str(), IMAGE_ICON, 32, 32, LR_LOADFROMFILE);
	if(!icon){
		DKERROR("DKCefWindow::SetIcon(): icon is invalid \n");
		return false;
	}

	SendMessage(hwnd, (UINT)WM_SETICON, ICON_BIG, (LPARAM)icon);
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::SetIcon(): not implemented on this OS\n");
	return false;
}

///////////////////////////////////////////////////////////
bool DKCefWindow::SetTitle(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!hwnd){ return false; }
	if(!SetWindowText(hwnd, "test")){ return false; }
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	gdk_window_set_title(gdk_window, "test");
	return true;
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::SetTitle(): not implemented on this OS\n");
	return false;
}

///////////////////////////////////////////////////////////
bool DKCefWindow::SetWidth(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!hwnd){ return false; }
	RECT rect;
	if(!GetWindowRect(hwnd, &rect)){ return false; }
	int height = rect.bottom - rect.top;
	int width = *(int*)input;
	if(!MoveWindow(hwnd, rect.left, rect.top, width, height, true)){ return false; }
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	int height;
	if(!GetHeight(NULL, &height)){ return false; }
	int width = *(int*)input;
	gdk_window_resize(gdk_window, width, height);
	return true;
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::SetWidth(): not implemented on this OS\n");
	return false;
}

///////////////////////////////////////////////////////
bool DKCefWindow::SetX(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!hwnd){ return false; }

	RECT rect;
	if(!GetWindowRect(hwnd, &rect)){ return false; }
	int width = rect.right - rect.left;
	int height = rect.bottom - rect.top;
	int x = *(int*)input;
	if(!MoveWindow(hwnd, x, rect.top, width, height, true)){ return false; }
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	int y;
	if(!GetY(NULL, &y)){ return false; }
	int x = *(int*)input;
	gdk_window_move(gdk_window, x, y);
	return true;
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::SetX(): not implemented on this OS\n");
	return false;
}

///////////////////////////////////////////////////////
bool DKCefWindow::SetY(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!hwnd){ return false; }
	RECT rect;
	if(!GetWindowRect(hwnd, &rect)){ return false; }
	int width = rect.right - rect.left;
	int height = rect.bottom - rect.top;
	int y = *(int*)input;
	if(!MoveWindow(hwnd, rect.left, y, width, height, true)){ return false; }
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	int x;
	if(!GetX(NULL, &x)){ return false; }
	int y = *(int*)input;
	gdk_window_move(gdk_window, x, y);
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::SetY(): not implemented on this OS\n");
	return false;
}

///////////////////////////////////////////////////////
bool DKCefWindow::Show(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	ShowWindow(hwnd, SW_SHOW);
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
	/* FIXME
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false; }
	gdk_window_show(gdk_window);
	return true;
	*/
#endif
	DKWARN("DKCefWindow::Show(): not implemented on this OS\n");
	return false;
}

///////////////////////////////////////////////////////////
bool DKCefWindow::Windowed(const void* input, void* output)
{
	DKDEBUGFUNC(input, output);	
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	DWORD dwStyle = GetWindowLong(hwnd, GWL_STYLE);
	SetWindowLong(hwnd, GWL_STYLE, dwStyle | WS_OVERLAPPEDWINDOW);
	SetWindowPlacement(hwnd, &g_wpPrev);
	SetWindowPos(hwnd, NULL, 0, 0, 0, 0,
		SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER |
		SWP_NOOWNERZORDER | SWP_FRAMECHANGED);
	return true;
#endif
#ifdef MAC
	//TODO
	NSView* nsview = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!nsview){ return false; }
#endif
#ifdef LINUX
#ifdef USE_GDK
	GdkWindow* gdk_window = gdk_window_foreign_new(dkCef->current_browser->GetHost()->GetWindowHandle());
	if(!gdk_window){ return false;}
	gdk_window_unfullscreen(gdk_window);
	isFullscreen = false;
	return true;
#endif //USE_GDK
#endif //LINUX
	DKWARN("DKCefWindow::Windowed(): not implemented on this OS\n");
	return false;
}
