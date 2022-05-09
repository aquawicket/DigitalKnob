#pragma once
#ifndef DKCefApp_H
#define DKCefApp_H
//#include <boost/function.hpp>
//#include <boost/bind/bind.hpp>
#include <include/cef_app.h>
#include <include/wrapper/cef_helpers.h>
#include "DK/DKFile.h"


typedef CefRefPtr<CefListValue> CefArgs;
typedef CefRefPtr<CefListValue> CefReturn;
class DKCefApp;
class DKCefV8Handler;

//#ifdef MAC
	//typedef std::map<DKString, boost::function2<bool, CefArgs, CefReturn> >::iterator it_type;
//typedef std::map<DKString, std::function2<bool, CefArgs, CefReturn> >::iterator it_type;
//#else
//typedef std::map<DKString, boost::function<bool (CefArgs, CefReturn)>>::iterator it_type;
typedef std::map<DKString, std::function<bool(CefArgs, CefReturn)>>::iterator it_type;
//#endif

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
//#ifdef MAC
		//static std::map<DKString, boost::function2<bool, CefArgs, CefReturn> > functions;
	//static std::map<DKString, std::function2<bool, CefArgs, CefReturn> > functions;
//#else
	//static std::map<DKString, boost::function<bool (CefArgs, CefReturn)>> functions;
	static std::map<DKString, std::function<bool(CefArgs, CefReturn)>> functions;
//#endif
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

class DKCefV8Handler : public CefV8Handler
{
public:
	DKCefV8Handler(){}

	// CefV8Handler
	bool Execute(const CefString& name, CefRefPtr<CefV8Value> object, const CefV8ValueList& arguments, CefRefPtr<CefV8Value>& retval, CefString& exception) override;

	void SetBrowser(CefRefPtr<CefBrowser> _browser);
	CefRefPtr<CefBrowser> browser;

	IMPLEMENT_REFCOUNTING(DKCefV8Handler);
};


// CefV8Accessor
//bool Get(const CefString& name, const CefRefPtr<CefV8Value> object, CefRefPtr<CefV8Value>& retval, CefString& exception) override;


class DKCefApp : public CefApp,
					//public CefResourceBundleHandler,  //Error: cannot instantiate abstract class
					public CefBrowserProcessHandler, 
					public CefRenderProcessHandler
{
public:

	// CefApp
	void OnBeforeCommandLineProcessing(const CefString& process_type, CefRefPtr<CefCommandLine> command_line) override;
	void OnRegisterCustomSchemes(CefRawPtr<CefSchemeRegistrar> registrar) override {}
	//CefRefPtr<CefResourceBundleHandler> GetResourceBundleHandler() override;
	CefRefPtr<CefBrowserProcessHandler> GetBrowserProcessHandler() override { return this; }
	CefRefPtr<CefRenderProcessHandler> GetRenderProcessHandler() override { return this; }

	// CefResourceBundleHandler
	//bool GetLocalizedString(int string_id, CefString& string) override;
	//bool GetDataResource(int resource_id, void*& data, size_t& data_size) override;
	//bool GetDataResourceForScale(int resource_id, ScaleFactor scale_factor, void*& data, size_t& data_size) override;
	
	// CefBrowserProcessHandler
	void OnContextInitialized() override;
	void OnBeforeChildProcessLaunch(CefRefPtr<CefCommandLine> command_line) override {}
	void OnRenderProcessThreadCreated(CefRefPtr<CefListValue> extra_info) override {}
	//CefRefPtr<CefPrintHandler> GetPrintHandler() override;
	void OnScheduleMessagePumpWork(int64 delay_ms) override {}

	// CefRenderProcessHandler
	void OnRenderThreadCreated(CefRefPtr<CefListValue> extra_info) override {}
	void OnWebKitInitialized() override {}
	void OnBrowserCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDictionaryValue> extra_info) override;
	void OnBrowserDestroyed(CefRefPtr<CefBrowser> browser) override {}
	//CefRefPtr<CefLoadHandler> GetLoadHandler() override;
	void OnContextCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context) override;
	void OnContextReleased(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context) override {}
	void OnUncaughtException(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context, CefRefPtr<CefV8Exception> exception, CefRefPtr<CefV8StackTrace> stackTrace) override;
	void OnFocusedNodeChanged(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefDOMNode> node) override {}
	bool OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefProcessId source_process, CefRefPtr<CefProcessMessage> message) override;

	// DKCef
	//bool SendEvent(const DKString& id, const DKString& type, const DKString& value);

	IMPLEMENT_REFCOUNTING(DKCefApp);
};

#endif //DKCefApp_H