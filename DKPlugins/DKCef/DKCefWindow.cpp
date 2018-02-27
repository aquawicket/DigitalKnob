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

	DKClass::RegisterFunc("DKCefWindow::Hide", &DKCefWindow::Hide, this);
	DKClass::RegisterFunc("DKCefWindow::IsVisible", &DKCefWindow::IsVisible, this);
	DKClass::RegisterFunc("DKCefWindow::Minimize", &DKCefWindow::Minimize, this);
	DKClass::RegisterFunc("DKCefWindow::Restore", &DKCefWindow::Restore, this);
	DKClass::RegisterFunc("DKCefWindow::SetIcon", &DKCefWindow::SetIcon, this);
	DKClass::RegisterFunc("DKCefWindow::Show", &DKCefWindow::Show, this);
	DKClass::RegisterFunc("DKCefWindow::SetHeight", &DKCefWindow::SetHeight, this);
	DKClass::RegisterFunc("DKCefWindow::SetWidth", &DKCefWindow::SetWidth, this);
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

//////////////////////////////////////////////////////
bool DKCefWindow::SetHeight(void* input, void* output)
{
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	LPRECT rect;
	if(!GetWindowRect(hwnd, rect)){ return false; }
	int width = rect->right - rect->left;
	int height = *(int*)input;
	if(!MoveWindow(hwnd, rect->left, rect->top, width, height, true)){ return false; }
	return true;
#endif
	return false;
}

/////////////////////////////////////////////////////
bool DKCefWindow::SetWidth(void* input, void* output)
{
#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	LPRECT rect;
	if(!GetWindowRect(hwnd, rect)){ return false; }
	int height = rect->bottom - rect->top;
	int width = *(int*)input;
	if(!MoveWindow(hwnd, rect->left, rect->top, width, height, true)){ return false; }
	return true;
#endif
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
	ShowWindow(hwnd, SW_RESTORE);
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