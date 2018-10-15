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
	void OnFileDialogDismissed(int selected_accept_filter, const std::vector<CefString>& file_paths);
	IMPLEMENT_REFCOUNTING(DialogCallback);
};

/////////////////////////////////////
class DKCef : public DKObjectT<DKCef>
{
public:
	bool Init();
	bool End();

	static bool CloseBrowser(const int& browser);
	static bool CloseDevTools(const int& browser);
	static bool Copy();
	static bool CopyImage(const DKString& url);
	static bool Cut();
	static bool DownloadUrl(const DKString& url);
	static bool FileDialog(const DKString& type, const DKString& title);
	static bool Find(const int& browser, const DKString& text);
	static bool GetBrowsers(int& num);
	static bool GetCurrentBrowser(int& browser);
	static bool GetPageSource(const int& browser, DKString& _source);
	static bool GetUrl(int& browser, DKString& url);
	static bool GoBack(const int& browser);
	static bool GoForward(const int& browser);
	static bool NewBrowser();
	static bool Paste();
	static bool Popup(const DKString& url);
	static bool Print(const int& browser);
	static bool Reload(const int& browser);
	static bool RunJavascript(const int& browser, DKString& string);
	static bool SelectBrowser(int& browser);
	static bool SetUrl(const int& browser, const DKString& url);
	static bool ShowDevTools(const int& browser);
	static bool Stop(const int& browser);
	static bool ViewPageSource(const int& browser);
	static void Test();

	bool SendEvent(const DKString& id, const DKString& type, const DKString& value);
	static bool RunDuktape(DKString& string);
	static bool QueueDuktape(DKString& string);
	static void RunPluginInfoTest(CefRefPtr<CefBrowser> browser);
	
	DKString id;
	int top;
	int left;
	int width;
	int height;
	static bool inFocus;
	static DKString homepage;
	static DKString source;
	bool fullscreen;
	DKString queue_new_browser;

	static std::vector<CefRefPtr<CefBrowser> > browsers;
	static CefRefPtr<CefBrowser> current_browser;
	static CefRefPtr<DKCefApp> cefApp;
	static CefRefPtr<CefClient> cefHandler; //external handler  (DKCefWindow, DKSDLCef or DKOSGCef)
	DKCefWindow* dkCefWindow;
	static unsigned long cefThreadId;

	static DialogCallback* fileDialogCallback;

	static bool initialized;

#ifdef WIN32
	HMODULE libcef;
	HMODULE libelf;
#endif
};


REGISTER_OBJECT(DKCef, true);

#endif //DKCef_H