#pragma once
#ifndef DKCef_H
#define DKCef_H
#include "DK.h"
#include "DKApp.h"
#include "DKCefApp.h"
#include <include/cef_client.h>
#include <include/cef_render_handler.h>
#include <include/cef_browser_process_handler.h>


/////////////////////////////////////
class DKCef : public DKObjectT<DKCef>
{
public:
	void Init();
	void End();

	const DKString GetUrl(int num);
	bool SetUrl(const DKString& url, int num);
	bool GoBack(int num);
	bool GoForward(int num);
	bool Stop(int num);
	bool Reload(int num);
	bool DownloadUrl(const DKString& url);
	bool Paste();
	bool ShowDevTools(int num);

	bool NewBrowser();
	int GetBrowsers();
	int GetCurrentBrowser();
	bool SelectBrowser(int num);
	bool CloseBrowser(int num);
	void RunPluginInfoTest(CefRefPtr<CefBrowser> browser);
	static void RunJavascript(DKString& string);
	
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
	CefClient* cefHandler; //external handler  (DKOSGCef or DKSDLCef)
	CefRefPtr<DKCefV8Handler> v8handler;

#ifdef WIN32
	HMODULE libcef;
#endif
};


REGISTER_OBJECT(DKCef, false);

#endif //DKCef_H