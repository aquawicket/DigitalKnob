#pragma once
#ifndef DKCefApp_H
#define DKCefApp_H
#include <boost/function.hpp>
#include <boost/bind/bind.hpp>
#include <include/cef_app.h>
#include <include/wrapper/cef_helpers.h>
#include "DK/DKFile.h"


typedef CefRefPtr<CefListValue> CefArgs;
typedef CefRefPtr<CefListValue> CefReturn;
class DKCefApp;
class DKCefV8Handler;

#ifdef MAC
typedef std::map<DKString, boost::function2<bool, CefArgs, CefReturn> >::iterator it_type;
#else
typedef std::map<DKString, boost::function<bool (CefArgs, CefReturn)>>::iterator it_type;
#endif

//////////
class DKV8
{
public:
	static void SetFlags();
	static bool AttachFunction(const DKString& name, bool (*func)(CefArgs, CefReturn));
	static bool GetFunctions(CefRefPtr<CefBrowser> browser);
	static bool Execute(CefRefPtr<CefBrowser> browser, std::string func, CefRefPtr<CefListValue> args);

	static CefRefPtr<CefBrowser> _browser;
	static CefRefPtr<DKCefV8Handler> v8handler;
	static CefRefPtr<CefV8Value> ctx;
	static bool singleprocess;
#ifdef MAC
	static std::map<DKString, boost::function2<bool, CefArgs, CefReturn> > functions;
#else
	static std::map<DKString, boost::function<bool (CefArgs, CefReturn)>> functions;
#endif
	static std::vector<std::string> funcs;

	//Flags
	static DKString disable_gpu;
	static DKString disable_gpu_compositing;
	static DKString disable_web_security;
	static DKString enable_begin_frame_scheduling;
	static DKString enable_gpu;
	static DKString enable_system_flash;
	static DKString enable_webgl;
	static DKString homepage;
	static DKString ignore_gpu_blacklist;
	static DKString log_severity;
	static DKString multi_process;
	static DKString multi_threaded_message_loop;
	static DKString no_proxy_server;
	static DKString off_screen_rendering_enabled;
	static DKString remote_debugging_port;
	static DKString renderer_process_limit;
	static DKString sandbox;
};

//////////////////////////////////////////
class DKCefV8Handler : public CefV8Handler
{
public:
	DKCefV8Handler(){}

	virtual bool Execute(const CefString& name, CefRefPtr<CefV8Value> object, const CefV8ValueList& arguments, CefRefPtr<CefV8Value>& retval, CefString& exception) OVERRIDE;
	void SetBrowser(CefRefPtr<CefBrowser> _browser);
	
	CefRefPtr<CefBrowser> browser;

	IMPLEMENT_REFCOUNTING(DKCefV8Handler);
};

///////////////////////////////////////////////////////////////////////////////////////////////
class DKCefApp : public CefApp, public CefBrowserProcessHandler, public CefRenderProcessHandler
{
public:
	virtual CefRefPtr<CefBrowserProcessHandler> GetBrowserProcessHandler() OVERRIDE { return this; }
	virtual CefRefPtr<CefRenderProcessHandler> GetRenderProcessHandler() OVERRIDE { return this; }

	//bool SendEvent(const DKString& id, const DKString& type, const DKString& value);

	virtual void OnBeforeCommandLineProcessing(const CefString& process_type, CefRefPtr<CefCommandLine> command_line);
	virtual void OnBrowserCreated(CefRefPtr<CefBrowser> browser);
	virtual void OnContextInitialized();
	virtual void OnContextCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context) OVERRIDE;
	virtual bool OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefProcessId source_process, CefRefPtr<CefProcessMessage> message);
	virtual void OnUncaughtException(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context, CefRefPtr<CefV8Exception> exception, CefRefPtr<CefV8StackTrace> stackTrace);

	IMPLEMENT_REFCOUNTING(DKCefApp);
};



#endif //DKCefApp_H