#include "DK/stdafx.h"
#include "DKCef/DKCefWindow.h"

//////////////////////////
DKCefWindow::DKCefWindow()
{
	DKLog("DKCefWindow::DKCefWindow()\n", DKDEBUG);
	
	DKClass::RegisterFunc("DKCefWindow::TestInt", &DKCefWindow::TestInt, this);
	DKClass::RegisterFunc("DKCefWindow::TestString", &DKCefWindow::TestString, this);
	DKClass::RegisterFunc("DKCefWindow::TestReturnInt", &DKCefWindow::TestReturnInt, this);
	DKClass::RegisterFunc("DKCefWindow::TestReturnString", &DKCefWindow::TestReturnString, this);

	DKClass::RegisterFunc("DKCefWindow::Fullscreen", &DKCefWindow::Fullscreen, this);
	DKClass::RegisterFunc("DKCefWindow::GetHeight", &DKCefWindow::GetHeight, this);
	DKClass::RegisterFunc("DKCefWindow::GetMouseX", &DKCefWindow::GetMouseX, this);
	DKClass::RegisterFunc("DKCefWindow::GetMouseY", &DKCefWindow::GetMouseY, this);
	DKClass::RegisterFunc("DKCefWindow::GetWidth", &DKCefWindow::GetWidth, this);
	DKClass::RegisterFunc("DKCefWindow::GetX", &DKCefWindow::GetX, this);
	DKClass::RegisterFunc("DKCefWindow::GetY", &DKCefWindow::GetY, this);
	DKClass::RegisterFunc("DKCefWindow::Hide", &DKCefWindow::Hide, this);
	DKClass::RegisterFunc("DKCefWindow::IsFullscreen", &DKCefWindow::IsFullscreen, this);
	DKClass::RegisterFunc("DKCefWindow::IsVisible", &DKCefWindow::IsVisible, this);
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

///////////////////////////
void DKCefWindow::DoFrame()
{ 
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
	DKLog("DKCefWindow::DoClose()\n", DKDEBUG);
	
	CEF_REQUIRE_UI_THREAD();
	if(browser->IsPopup()){ return false; }
	DKApp::Exit();
	return false;
}

////////////////////////////////////////////////////
bool DKCefWindow::TestInt(void* input, void* output)
{
	DKLog("DKCefWindow::TestInt()\n", DKDEBUG);
	
	int in = *(int*)input;
	int out = in;
	*(int*)output = out;
	return true;
}

///////////////////////////////////////////////////////
bool DKCefWindow::TestString(void* input, void* output)
{
	DKLog("DKCefWindow::TestString()\n", DKDEBUG);
	
	std::string in = *(std::string*)input;
	std::string out = in;
	*(std::string*)output = out;
	return true;
}

//////////////////////////////////////////////////////////
bool DKCefWindow::TestReturnInt(void* input, void* output)
{
	DKLog("DKCefWindow::TestReturnInt()\n", DKDEBUG);
	
	int var = 1234;
	*(int*)output = var;
	return true;
}

/////////////////////////////////////////////////////////////
bool DKCefWindow::TestReturnString(void* input, void* output)
{
	DKLog("DKCefWindow::TestReturnString()\n", DKDEBUG);
	
	std::string var = "Return test";
	*(std::string*)output = var;
	return true;
}


///////////////////////////////////////////////////////
bool DKCefWindow::Fullscreen(void* input, void* output)
{
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
	return false;
}

//////////////////////////////////////////////////////
bool DKCefWindow::GetHeight(void* input, void* output)
{
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	RECT rect;
	if(!GetWindowRect(hwnd, &rect)){ 
		DKLog("DKCefWindow::GetHeight(): GetWindowRect() failed\n", DKWARN);
		return false; 
	}
	int height = rect.bottom - rect.top;
	*(int*)output = height;
	return true;
#endif
	DKLog("DKCefWindow::GetHeight(): not implemented on this OS\n", DKWARN);
	return false;
}

//////////////////////////////////////////////////////
bool DKCefWindow::GetMouseX(void* input, void* output)
{
	POINT p;
	if(!GetCursorPos(&p)){ return false; }
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!hwnd){ return false; }
	if(!ScreenToClient(hwnd, &p)){ return false; }		
	*(int*)output = p.x; //p.x and p.y are now relative to hwnd's client area
	return true;
}

//////////////////////////////////////////////////////
bool DKCefWindow::GetMouseY(void* input, void* output)
{
	POINT p;
	if(!GetCursorPos(&p)){ return false; }
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!hwnd){ return false; }
	if(!ScreenToClient(hwnd, &p)){ return false; }		
	*(int*)output = p.y; //p.x and p.y are now relative to hwnd's client area
	return true;
}

/////////////////////////////////////////////////////
bool DKCefWindow::GetWidth(void* input, void* output)
{
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	RECT rect;
	if(!GetWindowRect(hwnd, &rect)){ return false; }
	int width = rect.right - rect.left;
	*(int*)output = width;
	return true;
#endif
	DKLog("DKCefWindow::GetWidth(): not implemented on this OS\n", DKWARN);
	return false;
}

/////////////////////////////////////////////////
bool DKCefWindow::GetX(void* input, void* output)
{
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	RECT rect;
	if(!GetWindowRect(hwnd, &rect)){ return false; }
	int x = rect.left;
	*(int*)output = x;
	return true;
#endif
	DKLog("DKCefWindow::GetX(): not implemented on this OS\n", DKWARN);
	return false;
}

/////////////////////////////////////////////////
bool DKCefWindow::GetY(void* input, void* output)
{
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	RECT rect;
	if(!GetWindowRect(hwnd, &rect)){ return false; }
	int y = rect.top;
	*(int*)output = y;
	return true;
#endif
	DKLog("DKCefWindow::GetY(): not implemented on this OS\n", DKWARN);
	return false;
}

/////////////////////////////////////////////////
bool DKCefWindow::Hide(void* input, void* output)
{
	DKLog("DKCefWindow::Hide()\n", DKDEBUG);

#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	ShowWindow(hwnd, SW_HIDE);
	return true;
#endif

	return false;
}

/////////////////////////////////////////////////////////
bool DKCefWindow::IsFullscreen(void* input, void* output)
{
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	RECT a, b;
	if(!GetWindowRect(hwnd, &a)){ return false; }
	if(!GetWindowRect(GetDesktopWindow(), &b)){ return false; }
	bool fullscreen = (a.left == b.left && a.top == b.top && a.right == b.right && a.bottom == b.bottom);
	*(bool*)output = fullscreen;
	return true;
#endif
	return false;
}

//////////////////////////////////////////////////////
bool DKCefWindow::IsVisible(void* input, void* output)
{
	DKLog("DKCefWindow::IsVisible()\n", DKDEBUG);

#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	*(bool*)output = (IsWindowVisible(hwnd) != 0);
	return true;
#endif

	return false;
}

///////////////////////////////////////////////////////
bool DKCefWindow::MessageBox(void* input, void* output)
{
	//TODO
	return false;
}

/////////////////////////////////////////////////////
bool DKCefWindow::Minimize(void* input, void* output)
{
	DKLog("DKCefWindow::Minimize()\n", DKDEBUG);

#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	ShowWindow(hwnd, SW_MINIMIZE);
	return true;
#endif

	return false;
}

////////////////////////////////////////////////////
bool DKCefWindow::Restore(void* input, void* output)
{
	DKLog("DKCefWindow::Restore()\n", DKDEBUG);

#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!hwnd){ return false; }
	if(!ShowWindow(hwnd, SW_RESTORE)){ return false; }
	if(!BringWindowToTop(hwnd)){ return false; }
	return true;
#endif

	return false;
}

//////////////////////////////////////////////////////
bool DKCefWindow::SetHeight(void* input, void* output)
{
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	RECT rect;
	if(!GetWindowRect(hwnd, &rect)){ return false; }
	int width = rect.right - rect.left;
	int height = *(int*)input;
	if(!MoveWindow(hwnd, rect.left, rect.top, width, height, true)){ return false; }
	return true;
#endif
	return false;
}

////////////////////////////////////////////////////
bool DKCefWindow::SetIcon(void* input, void* output)
{
	DKLog("DKCefWindow::SetIcon()\n", DKDEBUG);
	//DKString file = *(DKString*)input;

#ifdef WIN32
	if(!dkCef){
		DKLog("DKCefWindow::SetIcon(): dkCef is invalid \n", DKERROR);
		return false;
	}
	if(!dkCef->current_browser){
		DKLog("DKCefWindow::SetIcon(): dkCef->current_browser is invalid \n", DKERROR);
		return false;
	}
	if(!dkCef->current_browser->GetHost()){
		DKLog("DKCefWindow::SetIcon(): dkCef->current_browser->GetHost() is invalid \n", DKERROR);
		return false;
	}
	if(!dkCef->current_browser->GetHost()->GetWindowHandle()){
		DKLog("DKCefWindow::SetIcon(): dkCef->current_browser->GetHost()->GetWindowHandle() is invalid \n", DKERROR);
		return false;
	}

	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!hwnd){
		DKLog("DKCefWindow::SetIcon(): hwnd is invalid \n", DKERROR);
		return false;
	}
	HINSTANCE hinstance = (HINSTANCE)GetWindowLong(hwnd, GWLP_HINSTANCE); //WIN32 may require GWL_HINSTANCE
	if(!hinstance){
		DKLog("DKCefWindow::SetIcon(): hinstance is invalid \n", DKERROR);
		return false;
	}
	DKString file = *(DKString*)input;
	HANDLE icon = LoadImage(hinstance, file.c_str(), IMAGE_ICON, 32, 32, LR_LOADFROMFILE);
	if(!icon){
		DKLog("DKCefWindow::SetIcon(): icon is invalid \n", DKERROR);
		return false;
	}

	SendMessage(hwnd, (UINT)WM_SETICON, ICON_BIG, (LPARAM)icon);
	return true;
#endif

	return false;
}

/////////////////////////////////////////////////////
bool DKCefWindow::SetTitle(void* input, void* output)
{
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!hwnd){ return false; }
	if(!SetWindowText(hwnd, "test")){ return false; }
	return true;
#endif
	return false;
}

/////////////////////////////////////////////////////
bool DKCefWindow::SetWidth(void* input, void* output)
{
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
	return false;
}

/////////////////////////////////////////////////
bool DKCefWindow::SetX(void* input, void* output)
{
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
	return false;
}

/////////////////////////////////////////////////
bool DKCefWindow::SetY(void* input, void* output)
{
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
	return false;
}

/////////////////////////////////////////////////
bool DKCefWindow::Show(void* input, void* output)
{
	DKLog("DKCefWindow::Show()\n", DKDEBUG);

#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	ShowWindow(hwnd, SW_SHOW);
	return true;
#endif
	return false;
}

/////////////////////////////////////////////////////
bool DKCefWindow::Windowed(void* input, void* output)
{
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
	return false;
}