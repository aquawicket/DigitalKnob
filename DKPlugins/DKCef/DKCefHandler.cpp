//NOTE - This is soon to be replaced by DKCefWindow

#include "stdafx.h"
#include "DKCefHandler.h"

////////////////////////////
DKCefHandler::DKCefHandler()
{
	DKClass::RegisterFunc("DKCefHandler::TestInt", &DKCefHandler::TestInt, this);
	DKClass::RegisterFunc("DKCefHandler::TestString", &DKCefHandler::TestString, this);
	DKClass::RegisterFunc("DKCefHandler::TestReturnInt", &DKCefHandler::TestReturnInt, this);
	DKClass::RegisterFunc("DKCefHandler::TestReturnString", &DKCefHandler::TestReturnString, this);

	DKClass::RegisterFunc("DKCefHandler::SetIcon", &DKCefHandler::SetIcon, this);
	DKClass::RegisterFunc("DKCefHandler::Minimize", &DKCefHandler::Minimize, this);
	DKClass::RegisterFunc("DKCefHandler::Restore", &DKCefHandler::Restore, this);
	DKClass::RegisterFunc("DKCefHandler::Hide", &DKCefHandler::Hide, this);
	DKClass::RegisterFunc("DKCefHandler::Show", &DKCefHandler::Show, this);
}

/////////////////////////////////////////////////////////
bool DKCefHandler::DoClose(CefRefPtr<CefBrowser> browser)
{
	CEF_REQUIRE_UI_THREAD();
	if(browser->IsPopup()){ return false; }
	DKApp::Exit();
	return false;
}

/////////////////////////////////////////////////////
bool DKCefHandler::TestInt(void* input, void* output)
{
	int in = *(int*)input;
	int out = in;
	*(int*)output = out;
	return true;
}

////////////////////////////////////////////////////////
bool DKCefHandler::TestString(void* input, void* output)
{
	std::string in = *(std::string*)input;
	std::string out = in;
	*(std::string*)output = out;
	return true;
}

///////////////////////////////////////////////////////////
bool DKCefHandler::TestReturnInt(void* input, void* output)
{
	int var = 1234;
	*(int*)output = var;
	return true;
}

//////////////////////////////////////////////////////////////
bool DKCefHandler::TestReturnString(void* input, void* output)
{
	std::string var = "Return test";
	*(std::string*)output = var;
	return true;
}

/////////////////////////////////////////////////////
bool DKCefHandler::SetIcon(void* input, void* output)
{
	DKLog("DKCefHandler::SetIcon()\n", DKINFO);
	//DKString file = *(DKString*)input;

#ifdef WIN32
	if(!dkCef){
		DKLog("DKCefHandler::SetIcon(): dkCef is invalid \n", DKERROR);
		return false;
	}
	if(!dkCef->current_browser){
		DKLog("DKCefHandler::SetIcon(): dkCef->current_browser is invalid \n", DKERROR);
		return false;
	}
	if(!dkCef->current_browser->GetHost()){
		DKLog("DKCefHandler::SetIcon(): dkCef->current_browser->GetHost() is invalid \n", DKERROR);
		return false;
	}
	if(!dkCef->current_browser->GetHost()->GetWindowHandle()){
		DKLog("DKCefHandler::SetIcon(): dkCef->current_browser->GetHost()->GetWindowHandle() is invalid \n", DKERROR);
		return false;
	}
	
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	if(!hwnd){
		DKLog("DKCefHandler::SetIcon(): hwnd is invalid \n", DKERROR);
		return false;
	}
	HINSTANCE hinstance = (HINSTANCE)GetWindowLong(hwnd, GWLP_HINSTANCE); //WIN32 may require GWL_HINSTANCE
	if(!hinstance){
		DKLog("DKCefHandler::SetIcon(): hinstance is invalid \n", DKERROR);
		return false;
	}
	DKString file = *(DKString*)input;
	HANDLE icon = LoadImage(hinstance, file.c_str(), IMAGE_ICON, 32, 32, LR_LOADFROMFILE);
	if(!icon){
		DKLog("DKCefHandler::SetIcon(): icon is invalid \n", DKERROR);
		return false;
	}

	SendMessage(hwnd, (UINT)WM_SETICON, ICON_BIG, (LPARAM)icon);
	return true;
#endif

	return false;
}

//////////////////////////////////////////////////////
bool DKCefHandler::Minimize(void* input, void* output)
{
	DKLog("DKCefHandler::Minimize()\n", DKINFO);

#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	ShowWindow(hwnd, SW_MINIMIZE);
#endif

	return false;
}

/////////////////////////////////////////////////////
bool DKCefHandler::Restore(void* input, void* output)
{
	DKLog("DKCefHandler::Restore()\n", DKINFO);

#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	ShowWindow(hwnd, SW_RESTORE);
#endif

	return false;
}

//////////////////////////////////////////////////
bool DKCefHandler::Hide(void* input, void* output)
{
	DKLog("DKCefHandler::Hide()\n", DKINFO);

#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	ShowWindow(hwnd, SW_HIDE);
#endif

	return true;
}

//////////////////////////////////////////////////
bool DKCefHandler::Show(void* input, void* output)
{
	DKLog("DKCefHandler::Show()\n", DKINFO);

#ifdef WIN32
	HWND hwnd = dkCef->current_browser->GetHost()->GetWindowHandle();
	ShowWindow(hwnd, SW_SHOW);
#endif

	return true;
}

