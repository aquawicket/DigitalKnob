// http://www.codeproject.com/Articles/74/Adding-Icons-to-the-System-Tray
#pragma once
#ifndef DKTray_H
#define DKTray_H
#include "DK.h"

#ifdef WIN32
#include "resource.h"
#include "SystemTraySDK.h"
#define	WM_ICON_NOTIFY WM_APP+10
#endif


///////////////////////////////////////
class DKTray : public DKObjectT<DKTray>
{
public:
	void Init();
	void End();
	void Process();
	static void SetIcon(const DKString& file);
	static DKString GetIcon();
	static DKString icon;
	static void AddItem(const DKString& name, int id);
	static bool SetTooltip(const DKString& string);
	static bool ShowBalloon(const DKString& string, int seconds);

private:
#ifdef WIN32
	void setCallback(DKTrayCallback callback);
    static LRESULT DKTray::OnTrayNotification(UINT message, WPARAM wParam, LPARAM lParam);
	static CSystemTray TrayIcon;
#endif

};


REGISTER_OBJECT(DKTray, true);

#endif //DKTray_H