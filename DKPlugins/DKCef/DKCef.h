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

/////////////////////////////////////
class DKCef : public DKObjectT<DKCef>
{
public:
	void Init();
	void End();

	bool CloseBrowser(int num);
	bool DownloadUrl(const DKString& url);
	int GetBrowsers();
	int GetCurrentBrowser();
	const DKString GetUrl(int num);
	bool GoBack(int num);
	bool GoForward(int num);
	bool NewBrowser();
	bool Paste();
	bool Print(int num);
	bool Reload(int num);
	static void RunJavascript(DKString& string);
	void RunPluginInfoTest(CefRefPtr<CefBrowser> browser);
	bool SelectBrowser(int num);
	bool SetUrl(const DKString& url, int num);
	bool ShowDevTools(int num);
	bool Stop(int num);
	bool Find(const DKString& text);
	
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

#ifdef WIN32
	HMODULE libcef;
	HMODULE libelf;
#endif
};


REGISTER_OBJECT(DKCef, false);

#endif //DKCef_H