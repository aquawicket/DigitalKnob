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

#pragma once
#ifndef DKCef_H
#define DKCef_H

//#define USE_DKV8 1

//WARNING_DISABLE
	#include <include/cef_client.h>
	#include <include/cef_render_handler.h>
	#include <include/cef_browser_process_handler.h>
//WARNING_ENABLE

#include "DK/DK.h"
#include "DK/DKApp.h"
#include "DKCef/DKCefApp.h"
#include "DKCef/DKCEFWindow.h"

class DKCEFWindow;

struct DKBrowser{
	DKString id;
	int top;
	int left;
	int width;
	int height;
	DKString url;
	CefRefPtr<CefBrowser> browser;
};

class DialogCallback : public CefRunFileDialogCallback 
{
public:
	void OnFileDialogDismissed(int selected_accept_filter, const std::vector<CefString>& file_paths) override;
	IMPLEMENT_REFCOUNTING(DialogCallback);
};

class DKCef : public DKObjectT<DKCef>
{
public:
	bool Init();
	bool End();
	bool CloseBrowser(const int& browser);
	bool CloseDevTools(const int& browser);
	bool Copy();
	bool CopyImage(const DKString& url);
	bool Cut();
	bool DownloadUrl(const DKString& url);
	bool FileDialog(const DKString& type, const DKString& title);
	bool Find(const int& browser, const DKString& text);
	bool GetBrowserId(const int& browser, DKString& id);
	bool GetBrowserNumber(const DKString& id, int& browser);
	bool GetBrowsers(int& num);
	bool GetCurrentBrowser(int& browser);
	bool GetPageSource(const int& browser, DKString& _source);
	bool GetUrl(const int& browser, DKString& url);
	bool GoBack(const int& browser);
	bool GoForward(const int& browser);
	bool NewBrowser(const DKString& id, const int& top, const int& left, const int& width, const int& height, const DKString& url);
	bool Paste();
	bool Popup(const DKString& url);
	bool Print(const int& browser);
	bool Reload(const int& browser);
	bool RemoveFocus(const int& browser);
	bool RunJavascript(const int& browser, DKString& string);
	bool SetFocus(const int& browser);
	bool SetKeyboardFocus(const int& browser);
	bool SetUrl(const int& browser, const DKString& url);
	bool ShowDevTools(const int& browser);
	bool Stop(const int& browser);
	bool ViewPageSource(const int& browser);
	void Test();
	bool OnConsoleMessage(CefRefPtr<CefBrowser> browser, cef_log_severity_t level, const CefString& message, const CefString& source, int line);

	bool SendEvent(const DKString& id, const DKString& type, const DKString& value);
	bool RunDuktape(const DKString& string, DKString& rval);
	bool QueueDuktape(DKString& string);
	void RunPluginInfoTest(CefRefPtr<CefBrowser> browser);
	bool NewBrowser(const void* input, void* output);
	
	bool fullscreen;
	std::vector<DKBrowser> dkBrowsers;
	CefRefPtr<CefBrowser> current_browser;
	int keyboardFocus;
	static CefRefPtr<DKCefApp> cefApp;
	static CefRefPtr<CefClient> cefHandler; //external handler  (DKCEFWindow, DKSDLCef or DKOSGCef)
	DKCEFWindow* dkCefWindow;
	static unsigned long cefThreadId;
	DialogCallback* fileDialogCallback;
	static bool initialized;

#if WIN
	HMODULE libcef;
	HMODULE libelf;
#endif
};

REGISTER_OBJECT(DKCef, true);
#endif //DKCef_H