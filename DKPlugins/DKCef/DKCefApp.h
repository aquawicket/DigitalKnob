#pragma once
#ifndef DKCefApp_H
#define DKCefApp_H
#include <include/cef_app.h>

///////////////////////////////////////////////////////////////
class DKCefApp : public CefApp, public CefBrowserProcessHandler
{
public:
	DKCefApp(){}
	virtual CefRefPtr<CefBrowserProcessHandler> GetBrowserProcessHandler(){ return this; }

	void OnBeforeCommandLineProcessing(const CefString& process_type, CefRefPtr<CefCommandLine> command_line){
		//DKLog("DKCefApp::OnBeforeCommandLineProcessing() \n", DKDEBUG);
		command_line->AppendSwitchWithValue("enable-system-flash", "1");
		command_line->AppendSwitchWithValue("allow-file-access-from-files", "1");
		command_line->AppendSwitchWithValue("disable-gpu", "1");
		command_line->AppendSwitchWithValue("disable-gpu-compositing", "1");
		command_line->AppendSwitchWithValue("ignore-gpu-blacklist", "1");
		//command_line->AppendSwitchWithValue("enable-begin-frame-scheduling", "1"); //Breaks Popups
	}

	void OnContextInitialized();

	IMPLEMENT_REFCOUNTING(DKCefApp);
};


#endif //DKCefApp_H