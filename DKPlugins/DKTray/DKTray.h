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

// http://www.codeproject.com/Articles/74/Adding-Icons-to-the-System-Tray
#pragma once
#ifndef DKTray_H
#define DKTray_H

#include "DK/DK.h"

#if WIN
	#include "DKTray/SystemTraySDK.h"
	#include "DKTray/resource.h"
	#define	WM_ICON_NOTIFY WM_APP+10
#endif


class DKTray : public DKObjectT<DKTray>
{
public:
	bool Init();
	bool End();
	
	static bool AddItem(const DKString& name, int& id);
	static bool GetIcon(DKString& file);
	static bool SetIcon(const DKString& file);
	static bool SetTooltip(const DKString& string);
	static bool ShowBalloon(const DKString& string/*, int seconds*/);
	void Process();

	static DKString icon;

private:
#if WIN
	void setCallback(DKTrayCallback callback);
    static LRESULT DKTray::OnTrayNotification(UINT message, WPARAM wParam, LPARAM lParam);
	static CSystemTray TrayIcon;
#endif

};


REGISTER_OBJECT(DKTray, true);
#endif //DKTray_H