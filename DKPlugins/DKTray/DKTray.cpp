#include "stdafx.h"
#include "DK/DKFile.h"
#include "DKAssets/DKAssets.h"
#include "DKTray/DKTray.h"

DKString DKTray::icon;
#ifdef WIN32
	CSystemTray DKTray::TrayIcon;
#endif

///////////////////
void DKTray::Init()
{
	DKLog("DKTray::Init()\n", DKDEBUG);
	
	DKCreate("DKTrayJS");
	DKCreate("DKTrayV8");
#ifdef WIN32

	HWND hwnd = ::GetActiveWindow();
	if(!hwnd){
		DKLog("DKTray::Init(): hWnd invalid!\n", DKERROR);
		//return;
	}

	icon = DKFile::local_assets+"icon.ico";
	HICON hIcon = (HICON)LoadImage(NULL, icon.c_str(), IMAGE_ICON, 32, 32, LR_LOADFROMFILE);

	DKApp::hInstance = GetModuleHandle(0);
	if (!TrayIcon.Create(DKApp::hInstance, NULL, WM_ICON_NOTIFY, _T("DKTray Icon"), hIcon/*::LoadIcon(DKApp::hInstance, (LPCTSTR)IDI_TASKBARDEMO)*/, IDR_POPUP_MENU)){
		DKLog("DKTray::Init(): TrayIcon invalid \n", DKERROR);
		return;
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
			DKLog("DKTray::Init(): DKWindow::Hide() - No function available \n", DKERROR);
		}
	}
	
	DKApp::AppendLoopFunc(&DKTray::Process, this);
	return;
#endif

	DKLog("DKTray::Init() not implemented on this OS! \n", DKERROR);
}

//////////////////
void DKTray::End()
{
#ifdef WIN32
	TrayIcon.RemoveIcon();
#endif
}

//////////////////////
void DKTray::Process()
{
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

//////////////////////////////////////////
void DKTray::SetIcon(const DKString& file)
{
#ifdef WIN32
	icon = file;
	HICON hIcon = (HICON)LoadImage(NULL, icon.c_str(), IMAGE_ICON, 32, 32, LR_LOADFROMFILE);
	TrayIcon.SetIcon(hIcon);
#endif
}

//////////////////////////
DKString DKTray::GetIcon()
{
	return icon;
}

//////////////////////////////////////////////////
void DKTray::AddItem(const DKString& name, int id)
{
	//TODO
	DKLog("DKTray::AddItem("+name+")\n", DKDEBUG);
#ifdef WIN32
	TrayIcon.AddItem(name, id);
#endif
	return;
}

///////////////////////////////////////////////
bool DKTray::SetTooltip(const DKString& string)
{
	DKLog("DKTray::SetTooltip("+string+")\n", DKDEBUG);
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
#ifdef WIN32
	TrayIcon.ShowBalloon(string.c_str(), NULL, 0UL, 10);
	return true;
#endif
	return false;
}



#ifdef WIN32
/////////////////////////////////////////////////
void DKTray::setCallback(DKTrayCallback callback)
{
	TrayIcon.userCallback = callback;
}

//////////////////////////////////////////////////////////////////////////////
LRESULT DKTray::OnTrayNotification(UINT message, WPARAM wParam, LPARAM lParam)
{
	if(message == WM_ICON_NOTIFY){
		//DKLog("WM_ICON_NOTIFY: ", DKINFO);
		//DKLog(toString(LOWORD(wParam))+" : ", DKINFO);
		//DKLog(toString(LOWORD(lParam))+"\n", DKINFO);
		if(LOWORD(wParam) == 130 && LOWORD(lParam) == 513){
			//DKLog("Tray Icon Clicked \n", DKDEBUG);
			DKEvent::SendEvent("DKTray", "click", toString(1));
		}
		if(LOWORD(wParam) == 130 && LOWORD(lParam) == 515){
			//DKLog("Tray Icon Double Clicked \n", DKDEBUG);
			DKEvent::SendEvent("DKTray", "doubleclick", toString(1));
		}
	}

	if(message == WM_COMMAND){
		//DKLog("DKTray::OnTrayNotification(): LOWORD(wParam) = "+toString(LOWORD(wParam))+"\n", DKINFO);
		DKEvent::SendEvent("DKTray", toString(LOWORD(wParam)), "");
	}
	
	return 0;
}

#endif //WIN32