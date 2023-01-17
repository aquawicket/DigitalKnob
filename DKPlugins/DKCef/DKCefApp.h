/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#pragma once
#ifndef DKCefApp_H
#define DKCefApp_H

//WARNING_DISABLE
	//#include <boost/function.hpp>
	//#include <boost/bind/bind.hpp>
	#include <include/cef_app.h>
	#include <include/wrapper/cef_helpers.h>
//WARNING_ENABLE

#include "DK/DKFile.h"


typedef CefRefPtr<CefListValue> CefArgs;
typedef CefRefPtr<CefListValue> CefReturn;
class DKCefApp;
class DKCefV8Handler;

//typedef std::map<DKString, boost::function<bool (CefArgs, CefReturn)>>::iterator it_type;
typedef std::map<DKString, std::function<bool(CefArgs, CefReturn)>>::iterator it_type;

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

	//static std::map<DKString, boost::function<bool (CefArgs, CefReturn)>> functions;
	static std::map<DKString, std::function<bool(CefArgs, CefReturn)>> functions;
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
	DKCefV8Handler(){
		DKDEBUGFUNC();
	}
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
	/*
	void OnRegisterCustomSchemes(CefRawPtr<CefSchemeRegistrar> registrar) override {
		DKDEBUGFUNC(registrar);
		//DK_UNUSED(registrar);
	}
	*/
	//CefRefPtr<CefResourceBundleHandler> GetResourceBundleHandler() override;
	CefRefPtr<CefBrowserProcessHandler> GetBrowserProcessHandler() override {
		DKDEBUGFUNC();
		return this; 
	}
	CefRefPtr<CefRenderProcessHandler> GetRenderProcessHandler() override {
		DKDEBUGFUNC();
		return this; 
	}

	// CefResourceBundleHandler
	//bool GetLocalizedString(int string_id, CefString& string) override;
	//bool GetDataResource(int resource_id, void*& data, size_t& data_size) override;
	//bool GetDataResourceForScale(int resource_id, ScaleFactor scale_factor, void*& data, size_t& data_size) override;
	
	// CefBrowserProcessHandler
	void OnContextInitialized() override;
	void OnBeforeChildProcessLaunch(CefRefPtr<CefCommandLine> command_line) override {
		DKDEBUGFUNC(command_line);
		//DK_UNUSED(command_line);
	}
	void OnRenderProcessThreadCreated(CefRefPtr<CefListValue> extra_info) override {
		DKDEBUGFUNC(extra_info);
		//DK_UNUSED(extra_info);
	}
	//CefRefPtr<CefPrintHandler> GetPrintHandler() override;
	void OnScheduleMessagePumpWork(int64 delay_ms) override {
		DKDEBUGFUNC(delay_ms);
		//DK_UNUSED(delay_ms);
	}

	// CefRenderProcessHandler
	void OnRenderThreadCreated(CefRefPtr<CefListValue> extra_info) override {
		DKDEBUGFUNC();
		//DK_UNUSED(extra_info);
	}
	void OnWebKitInitialized() override {
		DKDEBUGFUNC();
	}
	void OnBrowserCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDictionaryValue> extra_info) override;
	void OnBrowserDestroyed(CefRefPtr<CefBrowser> browser) override {
		DKDEBUGFUNC(browser);
		//DK_UNUSED(browser);
	}
	//CefRefPtr<CefLoadHandler> GetLoadHandler() override;
	void OnContextCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context) override;
	void OnContextReleased(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context) override {
		DKDEBUGFUNC(browser, frame, context);
		//DK_UNUSED(browser);
		//DK_UNUSED(frame); 
		//DK_UNUSED(context);
	}
	void OnUncaughtException(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context, CefRefPtr<CefV8Exception> exception, CefRefPtr<CefV8StackTrace> stackTrace) override;
	void OnFocusedNodeChanged(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefDOMNode> node) override {
		DKDEBUGFUNC(browser, frame, node);
		//DK_UNUSED(browser);
		//DK_UNUSED(frame);
		//DK_UNUSED(node);
	}
	bool OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefProcessId source_process, CefRefPtr<CefProcessMessage> message) override;

	// DKCef
	//bool SendEvent(const DKString& id, const DKString& type, const DKString& value);

	IMPLEMENT_REFCOUNTING(DKCefApp);
};

#endif //DKCefApp_H