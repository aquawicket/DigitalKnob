//TODO

#include "stdafx.h"
#include "DKCefWindow.h"

////////////////////////////
DKCefWindow::DKCefWindow()
{
	DKClass::RegisterFunc("DKCefWindow::TestInt", &DKCefWindow::TestInt, this);
	DKClass::RegisterFunc("DKCefWindow::TestString", &DKCefWindow::TestString, this);
	DKClass::RegisterFunc("DKCefWindow::TestReturnInt", &DKCefWindow::TestReturnInt, this);
	DKClass::RegisterFunc("DKCefWindow::TestReturnString", &DKCefWindow::TestReturnString, this);

	DKClass::RegisterFunc("DKCefWindow::SetIcon", &DKCefWindow::SetIcon, this);
	DKClass::RegisterFunc("DKCefWindow::Minimize", &DKCefWindow::Minimize, this);
	DKClass::RegisterFunc("DKCefWindow::Restore", &DKCefWindow::Restore, this);
	DKClass::RegisterFunc("DKCefWindow::Hide", &DKCefWindow::Hide, this);
	DKClass::RegisterFunc("DKCefWindow::Show", &DKCefWindow::Show, this);

	//TODO
	DKString icon = "icon.ico";
	DKClass::CallFunc("DKCefWindow::SetIcon", &icon, NULL);
}

/////////////////////////////////////////////////////////
bool DKCefWindow::DoClose(CefRefPtr<CefBrowser> browser)
{
	CEF_REQUIRE_UI_THREAD();
	if(browser->IsPopup()){ return false; }
	DKApp::Exit();
	return false;
}

/////////////////////////////////////////////////////
bool DKCefWindow::TestInt(void* input, void* output)
{
	int in = *(int*)input;
	int out = in;
	*(int*)output = out;
	return true;
}

////////////////////////////////////////////////////////
bool DKCefWindow::TestString(void* input, void* output)
{
	std::string in = *(std::string*)input;
	std::string out = in;
	*(std::string*)output = out;
	return true;
}

///////////////////////////////////////////////////////////
bool DKCefWindow::TestReturnInt(void* input, void* output)
{
	int var = 1234;
	*(int*)output = var;
	return true;
}

//////////////////////////////////////////////////////////////
bool DKCefWindow::TestReturnString(void* input, void* output)
{
	std::string var = "Return test";
	*(std::string*)output = var;
	return true;
}

/////////////////////////////////////////////////////
bool DKCefWindow::SetIcon(void* input, void* output)
{
	DKLog("DKCefWindow::SetIcon()\n", DKINFO);
	//DKString file = *(DKString*)input;

#ifdef WIN32
	//TODO
	//HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	//HINSTANCE hinstance = (HINSTANCE)GetWindowLong(hwnd, GWL_HINSTANCE);
	//HANDLE icon = LoadImage(hinstance, file.c_str(), IMAGE_ICON, 32, 32, LR_LOADFROMFILE);
	//SendMessage(hwnd, (UINT)WM_SETICON, ICON_BIG, (LPARAM)icon);
#endif

	return false;
}

//////////////////////////////////////////////////////
bool DKCefWindow::Minimize(void* input, void* output)
{
	DKLog("DKCefWindow::Minimize()\n", DKINFO);

#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	ShowWindow(hwnd, SW_MINIMIZE);
#endif

	return false;
}

/////////////////////////////////////////////////////
bool DKCefWindow::Restore(void* input, void* output)
{
	DKLog("DKCefWindow::Restore()\n", DKINFO);

#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	ShowWindow(hwnd, SW_RESTORE);
#endif

	return false;
}

//////////////////////////////////////////////////
bool DKCefWindow::Hide(void* input, void* output)
{
	DKLog("DKCefWindow::Hide()\n", DKINFO);

#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	ShowWindow(hwnd, SW_HIDE);
#endif

	return true;
}

//////////////////////////////////////////////////
bool DKCefWindow::Show(void* input, void* output)
{
	DKLog("DKCefWindow::Show()\n", DKINFO);

#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	ShowWindow(hwnd, SW_SHOW);
#endif

	return true;
}

