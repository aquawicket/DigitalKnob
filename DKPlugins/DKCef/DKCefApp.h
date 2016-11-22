#pragma once
#ifndef DKCefApp_H
#define DKCefApp_H
#include <include/cef_app.h>

///////////////////////////////////////////////////////////////////////////////////////////////
class DKCefApp : public CefApp, public CefBrowserProcessHandler, public CefRenderProcessHandler
{
public:
	DKCefApp(){}
	virtual CefRefPtr<CefBrowserProcessHandler> GetBrowserProcessHandler() OVERRIDE { return this; }
	virtual CefRefPtr<CefRenderProcessHandler> GetRenderProcessHandler() OVERRIDE { return this; }

	void OnBeforeCommandLineProcessing(const CefString& process_type, CefRefPtr<CefCommandLine> command_line){
		//DKLog("DKCefApp::OnBeforeCommandLineProcessing() \n", DKDEBUG);
		command_line->AppendSwitchWithValue("enable-system-flash", "1");
		command_line->AppendSwitchWithValue("allow-file-access-from-files", "1");
		command_line->AppendSwitchWithValue("disable-gpu", "1");
		command_line->AppendSwitchWithValue("disable-gpu-compositing", "1");
		command_line->AppendSwitchWithValue("ignore-gpu-blacklist", "1");
		command_line->AppendSwitchWithValue("remote-debugging-port", "2393");
		command_line->AppendSwitchWithValue("disable-web-security", "1");
		command_line->AppendSwitchWithValue("no-proxy-server", "1");
		//command_line->AppendSwitchWithValue("enable-begin-frame-scheduling", "1"); //Breaks Popups
	}

	void OnContextInitialized();

	// FIXME: OnContextCreated never called
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	void OnContextCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context) OVERRIDE
	{
		DKLog("DKCefApp::OnContextCreated() \n", DKDEBUG);
		// Retrieve the context's window object.
		CefRefPtr<CefV8Value> object = context->GetGlobal();
		//CefRefPtr<CefV8Handler> handler = (CefV8Handler*)this;
		//CefRefPtr<CefV8Value> func = CefV8Value::CreateFunction("myfunc", handler);
		//object->SetValue("register", CefV8Value::CreateFunction("register", handler), V8_PROPERTY_ATTRIBUTE_NONE);
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool OnProcessMessageReceived(CefRefPtr< CefBrowser > browser, CefProcessId source_process, CefRefPtr<CefProcessMessage> message)
	{
		DKLog("DKCefApp::OnProcessMessageReceived() \n", DKDEBUG);
		return true;
	}

	IMPLEMENT_REFCOUNTING(DKCefApp);
};


#endif //DKCefApp_H