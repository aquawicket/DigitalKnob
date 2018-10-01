#pragma once
#ifndef DKCef_H
#define DKCef_H
#include <include/cef_client.h>
#include <include/cef_render_handler.h>
#include <include/cef_browser_process_handler.h>
#include "DK/DK.h"
#include "DK/DKApp.h"
#include "DKCef/DKCefApp.h"
#include "DKCef/DKCefWindow.h"


class DKCefWindow;

//////////////////////////////////////////////////////
class DialogCallback : public CefRunFileDialogCallback 
{
public:
	void OnFileDialogDismissed(int selected_accept_filter, const std::vector<CefString>& file_paths) OVERRIDE
	{
		DKLog("DialogCallback::OnFileDialogDismissed("+toString(selected_accept_filter)+")\n", DKINFO);
	}

	IMPLEMENT_REFCOUNTING(DialogCallback);
};

/////////////////////////////////////
class DKCef : public DKObjectT<DKCef>
{
public:
	bool Init();
	bool End();

	bool CloseBrowser(const int& num);
	bool DownloadUrl(const DKString& url);
	bool FileDialog();
	bool Find(const DKString& text);
	bool GetBrowsers(int& num);
	bool GetCurrentBrowser(int& num);
	bool GetUrl(int& num, DKString& url);
	bool GoBack(const int& num);
	bool GoForward(const int& num);
	bool NewBrowser();
	bool Paste();
	bool Print(const int& num);
	bool Reload(const int& num);
	bool SelectBrowser(int& num);
	bool SetUrl(const DKString& url, const int& num);
	bool ShowDevTools(const int& num);
	bool Stop(const int& num);

	static bool RunDuktape(DKString& string, DKString& rval);
	static bool QueueDuktape(DKString& string);
	static bool RunJavascript(DKString& string);
	void RunPluginInfoTest(CefRefPtr<CefBrowser> browser);
	
	DKString id;
	int top;
	int left;
	int width;
	int height;
	bool inFocus;
	DKString homepage;
	bool fullscreen;
	DKString queue_new_browser;

	std::vector<CefRefPtr<CefBrowser> > browsers;
	CefBrowser* current_browser;
	CefRefPtr<DKCefApp> cefApp;
	CefClient* cefHandler; //external handler  (DKSDLCef or DKOSGCef)
	DKCefWindow* dkCefWindow;

	DialogCallback* fileDialogCallback;

#ifdef WIN32
	HMODULE libcef;
	HMODULE libelf;
#endif
};


REGISTER_OBJECT(DKCef, false);

#endif //DKCef_H