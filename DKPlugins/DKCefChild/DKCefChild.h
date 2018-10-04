#pragma once
#ifndef DKCefChild_H
#define DKCefChild_H

#define DKCefChild

#include <include/cef_app.h>
#include <include/wrapper/cef_helpers.h>

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

	IMPLEMENT_REFCOUNTING(DKCefApp);
};

#endif //DKCefChild_H