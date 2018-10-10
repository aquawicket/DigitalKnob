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

///////////////////////////////////////////////
class SourceCallback : public CefStringVisitor 
{
public:
	explicit SourceCallback(CefRefPtr<CefBrowser> browser) : browser_(browser) {}
	virtual void Visit(const CefString& string);
private:
	CefRefPtr<CefBrowser> browser_;
	IMPLEMENT_REFCOUNTING(SourceCallback);
};

/////////////////////////////////////
class DKCef : public DKObjectT<DKCef>
{
public:
	bool Init();
	bool End();

	bool CloseBrowser(const int& browser);
	bool CloseDevTools(const int& browser);
	bool DownloadUrl(const DKString& url);
	bool FileDialog(const DKString& type, const DKString& title);
	bool Find(const int& browser, const DKString& text);
	bool GetBrowsers(int& num);
	bool GetCurrentBrowser(int& browser);
	bool GetPageSource(const int& browser);
	bool GetUrl(int& browser, DKString& url);
	bool GoBack(const int& browser);
	bool GoForward(const int& browser);
	bool NewBrowser();
	bool Paste();
	bool Popup(const DKString& url);
	bool Print(const int& browser);
	bool Reload(const int& browser);
	static bool RunJavascript(const int& browser, DKString& string);
	bool SelectBrowser(int& browser);
	bool SetUrl(const int& browser, const DKString& url);
	bool ShowDevTools(const int& browser);
	bool Stop(const int& browser);
	bool ViewPageSource(const int& browser);
	static void Test();

	bool SendEvent(const DKString& id, const DKString& type, const DKString& value);
	static bool RunDuktape(DKString& string);
	static bool QueueDuktape(DKString& string);
	void RunPluginInfoTest(CefRefPtr<CefBrowser> browser);
	
	DKString id;
	int top;
	int left;
	int width;
	int height;
	bool inFocus;
	DKString homepage;
	DKString source;
	bool fullscreen;
	DKString queue_new_browser;

	std::vector<CefRefPtr<CefBrowser> > browsers;
	CefRefPtr<CefBrowser> current_browser;
	static CefRefPtr<DKCefApp> cefApp;
	CefRefPtr<CefClient> cefHandler; //external handler  (DKCefWindow, DKSDLCef or DKOSGCef)
	DKCefWindow* dkCefWindow;
	static unsigned long cefThreadId;

	DialogCallback* fileDialogCallback;
	//SourceCallback* sourceCallback;

	static bool initialized;

#ifdef WIN32
	HMODULE libcef;
	HMODULE libelf;
#endif
};


REGISTER_OBJECT(DKCef, false);

#endif //DKCef_H