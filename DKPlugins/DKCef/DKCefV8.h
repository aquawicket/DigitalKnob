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

//#if HAVE_DKCef
#pragma once
#ifndef DKCefV8_H
#define DKCefV8_H

#include "DKCef/DKCef.h"

class DKCefV8 : public DKObjectT<DKCefV8>
{
public:
	bool Init();
	bool End();

	static bool TestFunction(CefArgs args, CefReturn retval);

	static bool _DKCreate(CefArgs args, CefReturn retval);
	static bool _DKValid(CefArgs args, CefReturn retval);
	static bool _Reload(CefArgs args, CefReturn retval);
	static bool _SetLog(CefArgs args, CefReturn retval);
	
	static bool Beep(CefArgs args, CefReturn retval);
	static bool ClickImage(CefArgs args, CefReturn retval);
	static bool CpuUsed(CefArgs args, CefReturn retval);
	static bool CpuUsedByApp(CefArgs args, CefReturn retval);
	static bool DrawTextOnScreen(CefArgs args, CefReturn retval);
	static bool Execute(CefArgs args, CefReturn retval);
	static bool Exit(CefArgs args, CefReturn retval);
	static bool GetClipboard(CefArgs args, CefReturn retval);
	static bool GetFps(CefArgs args, CefReturn retval);
	static bool GetFrames(CefArgs args, CefReturn retval);
	static bool GetFunctions(CefArgs args, CefReturn retval);
	static bool GetLocalIP(CefArgs args, CefReturn retval);
	static bool GetMouseX(CefArgs args, CefReturn retval);
	static bool GetMouseY(CefArgs args, CefReturn retval);
	static bool GetPixelUnderMouse(CefArgs args, CefReturn retval);
	static bool GetScreenHeight(CefArgs args, CefReturn retval);
	static bool GetScreenWidth(CefArgs args, CefReturn retval);
	static bool GetTicks(CefArgs args, CefReturn retval);
	static bool GetVolume(CefArgs args, CefReturn retval);
	static bool HideConsole(CefArgs args, CefReturn retval);
	static bool LeftClick(CefArgs args, CefReturn retval);
	static bool LowPowerMonitor(CefArgs args, CefReturn retval);
	static bool PhysicalMemory(CefArgs args, CefReturn retval);
	static bool PhysicalMemoryUsed(CefArgs args, CefReturn retval);
	static bool PhysicalMemoryUsedByApp(CefArgs args, CefReturn retval);
	static bool PressKey(CefArgs args, CefReturn retval);
	static bool QueueDuktape(CefArgs args, CefReturn retval);
	static bool ReleaseKey(CefArgs args, CefReturn retval);
	static bool Run(CefArgs args, CefReturn retval);
	static bool RunDuktape(CefArgs args, CefReturn retval);
	static bool SetBrightness(CefArgs args, CefReturn retval);
	static bool SetClipboard(CefArgs args, CefReturn retval);
	static bool SetClipboardFiles(CefArgs args, CefReturn retval);
	static bool SetClipboardImage(CefArgs args, CefReturn retval);
	static bool SetFramerate(CefArgs args, CefReturn retval);
	static bool SetMousePos(CefArgs args, CefReturn retval);
	static bool SetVolume(CefArgs args, CefReturn retval);
	static bool ShowConsole(CefArgs args, CefReturn retval);
	static bool StrokeKey(CefArgs args, CefReturn retval);
	static bool System(CefArgs args, CefReturn retval);
	static bool TurnOffMonitor(CefArgs args, CefReturn retval);
	static bool TurnOnMonitor(CefArgs args, CefReturn retval);
	static bool VirtualMemory(CefArgs args, CefReturn retval);
	static bool VirtualMemoryUsed(CefArgs args, CefReturn retval);
	static bool VirtualMemoryUsedByApp(CefArgs args, CefReturn retval);
	static bool WaitForImage(CefArgs args, CefReturn retval);
	
	//Cef JS functions
	static bool CloseBrowser(CefArgs args, CefReturn retval);
	static bool CloseDevTools(CefArgs args, CefReturn retval);
	static bool Copy(CefArgs args, CefReturn retval);
	static bool CopyImage(CefArgs args, CefReturn retval);
	static bool Cut(CefArgs args, CefReturn retval);
	static bool DownloadUrl(CefArgs args, CefReturn retval);
	static bool FileDialog(CefArgs args, CefReturn retval);
	static bool Find(CefArgs args, CefReturn retval);
	static bool GetBrowserId(CefArgs args, CefReturn retval);
	static bool GetBrowsers(CefArgs args, CefReturn retval);
	static bool GetCurrentBrowser(CefArgs args, CefReturn retval);
	static bool GetPageSource(CefArgs args, CefReturn retval);
	static bool GetUrl(CefArgs args, CefReturn retval);
	static bool GoBack(CefArgs args, CefReturn retval);
	static bool GoForward(CefArgs args, CefReturn retval);
	static bool NewBrowser(CefArgs args, CefReturn retval);
	static bool Paste(CefArgs args, CefReturn retval);
	static bool Popup(CefArgs args, CefReturn retval);
	static bool Print(CefArgs args, CefReturn retval);
	static bool Reload(CefArgs args, CefReturn retval);
	static bool RemoveFocus(CefArgs args, CefReturn retval);
	static bool RunJavascript(CefArgs args, CefReturn retval);
	static bool SetFocus(CefArgs args, CefReturn retval);
	static bool SetKeyboardFocus(CefArgs args, CefReturn retval);
	static bool SetUrl(CefArgs args, CefReturn retval);
	static bool ShowDevTools(CefArgs args, CefReturn retval);
	static bool Stop(CefArgs args, CefReturn retval);
	static bool ViewPageSource(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKCefV8, false);
#endif //DKCefV8_H
//#endif //HAVE_DKCef