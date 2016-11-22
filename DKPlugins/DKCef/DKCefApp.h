#pragma once
#ifndef DKCefApp_H
#define DKCefApp_H
#include <include/cef_app.h>


///////////////////////////////////////
class MyV8Handler : public CefV8Handler
{
public:
	MyV8Handler() {}
	virtual bool Execute(const CefString& name, CefRefPtr<CefV8Value> object, const CefV8ValueList& arguments, 
						CefRefPtr<CefV8Value>& retval, CefString& exception) OVERRIDE {
		DKLog("MyV8Handler::Execute() \n", DKDEBUG);
		if (name == "myfunc") {
			// Return my string value.
			retval = CefV8Value::CreateString("My Value!");
			return true;
		}

		// Function does not exist.
		return false;
	}

	// Provide the reference counting implementation for this class.
	IMPLEMENT_REFCOUNTING(MyV8Handler);
};

///////////////////////////////////////////////////////////////////////////////////////////////
class DKCefApp : public CefApp, public CefBrowserProcessHandler, public CefRenderProcessHandler
{
public:
	DKCefApp(){}

	CefRefPtr<CefV8Handler> handler;

	virtual CefRefPtr<CefBrowserProcessHandler> GetBrowserProcessHandler() OVERRIDE { return this; }
	virtual CefRefPtr<CefRenderProcessHandler> GetRenderProcessHandler() OVERRIDE { return this; }

	virtual void OnContextInitialized();

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	virtual void OnBeforeCommandLineProcessing(const CefString& process_type, CefRefPtr<CefCommandLine> command_line)
	{
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

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	virtual void OnContextCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context) OVERRIDE
	{
		DKLog("DKCefApp::OnContextCreated() \n", DKDEBUG);
		CefRefPtr<CefV8Value> object = context->GetGlobal(); // Retrieve the context's window object.
		handler = new MyV8Handler();
		CefRefPtr<CefV8Value> func = CefV8Value::CreateFunction("myfunc", handler);
		//object->SetValue("register", CefV8Value::CreateFunction("register", handler), V8_PROPERTY_ATTRIBUTE_NONE);
	}

	IMPLEMENT_REFCOUNTING(DKCefApp);
};



#endif //DKCefApp_H