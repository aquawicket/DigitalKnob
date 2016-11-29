#pragma once
#ifndef DKCefApp_H
#define DKCefApp_H
#include <include/cef_app.h>

typedef CefV8ValueList CefArgs;
typedef CefRefPtr<CefV8Value>& CefReturn;
class DKCefApp;

///////////////////////////////////////
class MyV8Handler : public CefV8Handler
{
public:
	MyV8Handler() {}
	static std::map<DKString, boost::function<bool(CefArgs, CefReturn)>> functions;

	virtual bool Execute(const CefString& name, CefRefPtr<CefV8Value> object, const CefArgs& arguments, 
						CefReturn retval, CefString& exception) OVERRIDE {
		//DKLog("MyV8Handler::Execute()\n", DKDEBUG);
		if(!functions[name]) {
			DKLog("MyV8Handler::Execute("+DKString(name)+") not registered\n", DKWARN);
			return false;
		}
		if(!functions[name](arguments, retval)){
			DKLog("MyV8Handler::Execute("+DKString(name)+") failed\n", DKERROR);
			return false;
		}
		return true;
	}

	// Provide the reference counting implementation for this class.
	IMPLEMENT_REFCOUNTING(MyV8Handler);
};

///////////////////////////////////////////////////////////////////////////////////////////////
class DKCefApp : public CefApp, public CefBrowserProcessHandler, public CefRenderProcessHandler
{
public:
	DKCefApp(){}

	static CefRefPtr<MyV8Handler> handler;
	static CefRefPtr<CefV8Value> object;

	virtual CefRefPtr<CefBrowserProcessHandler> GetBrowserProcessHandler() OVERRIDE { return this; }
	virtual CefRefPtr<CefRenderProcessHandler> GetRenderProcessHandler() OVERRIDE { return this; }

	virtual void OnContextInitialized();

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	virtual void OnBeforeCommandLineProcessing(const CefString& process_type, CefRefPtr<CefCommandLine> command_line)
	{
		//DKLog("DKCefApp::OnBeforeCommandLineProcessing()\n", DKDEBUG);
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
		//DKLog("DKCefApp::OnContextCreated()\n", DKDEBUG);
		if(object){ return; }
		object = context->GetGlobal(); // Retrieve the context's window object.
		handler = new MyV8Handler();
		DKCreate("DKCefV8");
	}

	//////////////////////////////////////////////////////////////////////////////////
	static void AttachFunction(const DKString& name, bool (*func)(CefArgs, CefReturn))
	{
		if(!object){
			DKLog("DKCefApp::AttachFunction(): OnContextCreated() has not been called yet. \n", DKERROR);
		}
		CefRefPtr<CefV8Value> value = CefV8Value::CreateFunction(name.c_str(), handler);
		object->SetValue(name.c_str(), value, V8_PROPERTY_ATTRIBUTE_NONE);

		handler->functions[name] = boost::bind(func, _1, _2);
		if (!handler->functions[name]) {
			DKLog("DKCefApp::AttachFunction()(" + name + "): failed to register function \n", DKERROR);
			return;
		}
	}

	IMPLEMENT_REFCOUNTING(DKCefApp);
};



#endif //DKCefApp_H