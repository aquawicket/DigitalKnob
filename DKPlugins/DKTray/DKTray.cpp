#include "stdafx.h"
#include "DKTray.h"
#include "DKAssets.h"
#include "DKFile.h"

DKString DKTray::icon;
#ifdef WIN32
	CSystemTray DKTray::TrayIcon;
#endif

///////////////////
void DKTray::Init()
{
	DKLog("DKTray::Init()\n", DKDEBUG);
	
	DKCreate("DKTrayJS");
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
			DKClass::CallFunc("DKSDLWindow::Hide");
		}
		else if(DKClass::HasFunc("DKOSGWindow::Hide")){
			DKClass::CallFunc("DKOSGWindow::Hide");
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
	TrayIcon.RemoveIcon();
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

//////////////////////////////////////////
void DKTray::AddItem(const DKString& name)
{
	//TODO
	DKLog("DKTray::AddItem("+name+")\n", DKINFO);
	TrayIcon.SetMenuText(300,"test");
	return;
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
			DKLog("Tray Icon Clicked \n", DKINFO);
			//SetIcon(DKApp::datapath+"icon2.ico");
			DKEvent::SendEvent("DKTray", "click", toString(1));
		}
	}

	if(message == WM_COMMAND){
		if(LOWORD(wParam) == IDM_RESTORE){
			DKLog("IDM_RESTORE\n", DKINFO);
			//CSystemTray::MaximiseFromTray(DKOSGWindow::Instance("DKOSGWindow")->hwnd);
			DKEvent::SendEvent("DKTray", "Restore", "");
		}
		if(LOWORD(wParam) == IDM_MINTOTRAY){
			DKLog("IDM_MINTOTRAY\n", DKINFO);
			//CSystemTray::MinimiseToTray(DKOSGWindow::Instance("DKOSGWindow")->hwnd);
			DKEvent::SendEvent("DKTray", "Minimize", "");
		}
		if(LOWORD(wParam) == IDM_EXIT){
			DKLog("IDM_EXIT\n", DKINFO);
			DKEvent::SendEvent("DKTray", "Exit", "");
			//DKApp::Exit();
		}
	}
	
	return 0;
}

#endif //WIN32