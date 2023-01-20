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
#include "DK/DKFile.h"
#include "DKAssets/DKAssets.h"
#include "DKTray/DKTray.h"


DKString DKTray::icon;
#if WIN
	CSystemTray DKTray::TrayIcon;
#endif

bool DKTray::Init(){
	DKDEBUGFUNC();
#if HAVE_DKDuktape
	DKClass::DKCreate("DKTrayJS");
#endif
#if HAVE_DKCef
	DKClass::DKCreate("DKTrayV8");
#endif
#if WIN

	//HWND hwnd = ::GetActiveWindow();
	//if(!hwnd)
	//	return DKERROR("DKTray::Init(): hWnd invalid\n");

	icon = DKFile::local_assets+"icon.ico";
	HICON hIcon = (HICON)LoadImage(NULL, icon.c_str(), IMAGE_ICON, 32, 32, LR_LOADFROMFILE);

	DKWindows::hInstance = GetModuleHandle(0);
	if (!TrayIcon.Create(DKWindows::hInstance, NULL, WM_ICON_NOTIFY, _T("DKTray Icon"), hIcon/*::LoadIcon(DKApp::hInstance, (LPCTSTR)IDI_TASKBARDEMO)*/, IDR_POPUP_MENU))
		return DKERROR("TrayIcon invalid\n");

	setCallback(&OnTrayNotification);
	//TrayIcon.SetTargetWnd(DKOSGWindow::Instance("DKOSGWindow")->hwnd); //This actually breaks it

	DKString trayed;
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[TRAYED]", trayed);
	if(same(trayed,"ON")){
		//CSystemTray::MinimiseToTray(hwnd);
		if(DKClass::HasFunc("DKSDLWindow::Hide"))
			DKClass::CallFunc("DKSDLWindow::Hide", NULL, NULL);
		else if(DKClass::HasFunc("DKOSGWindow::Hide"))
			DKClass::CallFunc("DKOSGWindow::Hide", NULL, NULL);
		else
			DKERROR("DKWindow::Hide() - No function available\n");
	}
	
	DKApp::AppendLoopFunc(&DKTray::Process, this);
	return true;
#else
	return DKERROR("not implemented on this OS\n");
#endif
}

bool DKTray::End(){
	DKDEBUGFUNC();
#if WIN
	TrayIcon.RemoveIcon();
#endif
	return true;
}


bool DKTray::AddItem(const DKString& name, int& id){
	DKDEBUGFUNC(name, id);
#if WIN
	TrayIcon.AddItem(name, id);
#endif
	return true;
}

bool DKTray::GetIcon(DKString& file){
	DKDEBUGFUNC(file);
	file = icon;
	return true;
}

bool DKTray::SetIcon(const DKString& file){
	DKDEBUGFUNC(file);
#if WIN
	icon = file;
	HICON hIcon = (HICON)LoadImage(NULL, icon.c_str(), IMAGE_ICON, 32, 32, LR_LOADFROMFILE);
	TrayIcon.SetIcon(hIcon);
	return true;
#else
	DKWARN("not implemented on this system\n");
	return false;
#endif
}

bool DKTray::SetTooltip(const DKString& string){
	DKDEBUGFUNC(string);
#if WIN
	if(!TrayIcon.SetTooltipText(string.c_str())){
		return false;
	}
	return true;
#else
	return false;
#endif
}

bool DKTray::ShowBalloon(const DKString& string/*, int seconds*/){
	DKDEBUGFUNC(string);
#if WIN
	TrayIcon.ShowBalloon(string.c_str(), NULL, 0UL, 10);
	return true;
#else
	return false;
#endif
}

void DKTray::Process(){
	//DKDEBUGFUNC();  //EXCESSIVE LOGGING
#if WIN
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


#if WIN

void DKTray::setCallback(DKTrayCallback callback){
	DKDEBUGFUNC(callback);
	TrayIcon.userCallback = callback;
}

LRESULT DKTray::OnTrayNotification(UINT message, WPARAM wParam, LPARAM lParam){
	DKDEBUGFUNC(message, wParam, lParam);
	if(message == WM_ICON_NOTIFY){
		//DKINFO("WM_ICON_NOTIFY:");
		//DKINFO(toString(LOWORD(wParam))+" : ");
		//DKINFO(toString(LOWORD(lParam))+"\n");
		if(LOWORD(wParam) == 130 && LOWORD(lParam) == 513)
			DKEvents::SendEvent("DKTray", "click", toString(1));
		if(LOWORD(wParam) == 130 && LOWORD(lParam) == 515)
			DKEvents::SendEvent("DKTray", "doubleclick", toString(1));
	}
	if(message == WM_COMMAND)
		DKEvents::SendEvent("DKTray", toString(LOWORD(wParam)), "");
	return 0;
}

#endif //WIN32
