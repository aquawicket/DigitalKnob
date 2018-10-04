#pragma once
#ifndef DKCefChild_H
#define DKCefChild_H

#define DKCefChild

#include <include/cef_app.h>
#include <include/wrapper/cef_helpers.h>

//////////////////////////////////////////
class DKCefV8Handler : public CefV8Handler
{
public:
	DKCefV8Handler(){}

	virtual bool Execute(const CefString& name, CefRefPtr<CefV8Value> object, const CefV8ValueList& arguments, CefRefPtr<CefV8Value>& retval, CefString& exception) OVERRIDE;
	void SetBrowser(CefRefPtr<CefBrowser> _browser);

	CefRefPtr<CefBrowser> browser;
	static CefRefPtr<CefListValue> myRetval;

	IMPLEMENT_REFCOUNTING(DKCefV8Handler);
};

///////////////////////////////////////////////////////////////////////////////////////////////
class DKCefApp : public CefApp, public CefBrowserProcessHandler, public CefRenderProcessHandler
{
public:
	virtual CefRefPtr<CefBrowserProcessHandler> GetBrowserProcessHandler() OVERRIDE { return this; }
	virtual CefRefPtr<CefRenderProcessHandler> GetRenderProcessHandler() OVERRIDE { return this; }

	virtual void OnBeforeCommandLineProcessing(const CefString& process_type, CefRefPtr<CefCommandLine> command_line);
	virtual void OnBrowserCreated(CefRefPtr<CefBrowser> browser);
	virtual void OnContextInitialized();
	virtual void OnContextCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context) OVERRIDE;
	virtual bool OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefProcessId source_process, CefRefPtr<CefProcessMessage> message);

	CefRefPtr<DKCefV8Handler> cefV8Handler;
	std::vector<std::string> funcs;
	
	IMPLEMENT_REFCOUNTING(DKCefApp);
};

#endif //DKCefChild_H