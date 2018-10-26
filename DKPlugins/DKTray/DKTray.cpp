#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DKAssets/DKAssets.h"
#include "DKTray/DKTray.h"

DKString DKTray::icon;
#ifdef WIN32
	CSystemTray DKTray::TrayIcon;
#endif

///////////////////
bool DKTray::Init()
{
	DKDEBUGFUNC();
	DKClass::DKCreate("DKTrayJS");
	DKClass::DKCreate("DKTrayV8");
#ifdef WIN32

	//HWND hwnd = ::GetActiveWindow();
	//if(!hwnd){
	//	DKLog("DKTray::Init(): hWnd invalid!\n", DKERROR);
		//return;
	//}

	icon = DKFile::local_assets+"icon.ico";
	HICON hIcon = (HICON)LoadImage(NULL, icon.c_str(), IMAGE_ICON, 32, 32, LR_LOADFROMFILE);

	DKWindows::hInstance = GetModuleHandle(0);
	if (!TrayIcon.Create(DKWindows::hInstance, NULL, WM_ICON_NOTIFY, _T("DKTray Icon"), hIcon/*::LoadIcon(DKApp::hInstance, (LPCTSTR)IDI_TASKBARDEMO)*/, IDR_POPUP_MENU)){
		DKERROR("DKTray::Init(): TrayIcon invalid\n");
		return false;
	}

	setCallback(&OnTrayNotification);
	//TrayIcon.SetTargetWnd(DKOSGWindow::Instance("DKOSGWindow")->hwnd); //This actually breaks it

	DKString trayed;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[TRAYED]", trayed);
	if(same(trayed,"ON")){
		//CSystemTray::MinimiseToTray(hwnd);
		if(DKClass::HasFunc("DKSDLWindow::Hide")){
			DKClass::CallFunc("DKSDLWindow::Hide", NULL, NULL);
		}
		else if(DKClass::HasFunc("DKOSGWindow::Hide")){
			DKClass::CallFunc("DKOSGWindow::Hide", NULL, NULL);
		}
		else{
			DKERROR("DKTray::Init(): DKWindow::Hide() - No function available\n");
		}
	}
	
	DKApp::AppendLoopFunc(&DKTray::Process, this);
	return true;
#endif

	DKERROR("DKTray::Init() not implemented on this OS\n");
	return false; //TODO - double check this. 
}

//////////////////
bool DKTray::End()
{
	DKDEBUGFUNC();
#ifdef WIN32
	TrayIcon.RemoveIcon();
#endif
	return true;
}



///////////////////////////////////////////////////
bool DKTray::AddItem(const DKString& name, int& id)
{
	DKDEBUGFUNC(name, id);
#ifdef WIN32
	TrayIcon.AddItem(name, id);
#endif
	return true;
}

////////////////////////////////////
bool DKTray::GetIcon(DKString& file)
{
	DKDEBUGFUNC(file);
	file = icon;
	return true;
}

//////////////////////////////////////////
bool DKTray::SetIcon(const DKString& file)
{
	DKDEBUGFUNC(file);
#ifdef WIN32
	icon = file;
	HICON hIcon = (HICON)LoadImage(NULL, icon.c_str(), IMAGE_ICON, 32, 32, LR_LOADFROMFILE);
	TrayIcon.SetIcon(hIcon);
	return true;
#endif
	DKWARN("DKTray::SetIcon(): not implemented on this system\n");
	return false;
}

///////////////////////////////////////////////
bool DKTray::SetTooltip(const DKString& string)
{
	DKDEBUGFUNC(string);
#ifdef WIN32
	if(!TrayIcon.SetTooltipText(string.c_str())){
		return false;
	}
	return true;
#endif
	return false;
}

/////////////////////////////////////////////////////////////////
bool DKTray::ShowBalloon(const DKString& string/*, int seconds*/)
{
	DKDEBUGFUNC(string);
#ifdef WIN32
	TrayIcon.ShowBalloon(string.c_str(), NULL, 0UL, 10);
	return true;
#endif
	return false;
}

//////////////////////
void DKTray::Process()
{
	//DKDEBUGFUNC();
#ifdef WIN32
    //Process Tray Icon Messages
    MSG msg;
	PeekMessage(&msg, NULL, 0, 0, PM_NOREMOVE);
	if(msg.message == WM_COMMAND){
		PeekMessage(&msg, NULL, 0, 0, PM_REMOVE);
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}
#endif
}




#ifdef WIN32
/////////////////////////////////////////////////
void DKTray::setCallback(DKTrayCallback callback)
{
	DKDEBUGFUNC(callback);
	TrayIcon.userCallback = callback;
}

//////////////////////////////////////////////////////////////////////////////
LRESULT DKTray::OnTrayNotification(UINT message, WPARAM wParam, LPARAM lParam)
{
	DKDEBUGFUNC(message, wParam, lParam);
	if(message == WM_ICON_NOTIFY){
		//DKLog("WM_ICON_NOTIFY: ");
		//DKLog(toString(LOWORD(wParam))+" : ");
		//DKLog(toString(LOWORD(lParam))+"\n");
		if(LOWORD(wParam) == 130 && LOWORD(lParam) == 513){
			//DKLog("Tray Icon Clicked \n");
			DKEvent::SendEvent("DKTray", "click", toString(1));
		}
		if(LOWORD(wParam) == 130 && LOWORD(lParam) == 515){
			//DKLog("Tray Icon Double Clicked \n");
			DKEvent::SendEvent("DKTray", "doubleclick", toString(1));
		}
	}

	if(message == WM_COMMAND){
		//DKLog("DKTray::OnTrayNotification(): LOWORD(wParam) = "+toString(LOWORD(wParam))+"\n");
		DKEvent::SendEvent("DKTray", toString(LOWORD(wParam)), "");
	}
	
	return 0;
}

#endif //WIN32