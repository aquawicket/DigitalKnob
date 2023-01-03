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
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#pragma once
#ifndef DKCefChild_H
#define DKCefChild_H

#define DKCefChild

//WARNING_DISABLE
	#include <include/cef_app.h>
	#include <include/wrapper/cef_helpers.h>
//WARNING_ENABLE


class DKCefChildV8Handler : public CefV8Handler
{
public:
	DKCefChildV8Handler(){}
	virtual bool Execute(const CefString& name, CefRefPtr<CefV8Value> object, const CefV8ValueList& arguments, CefRefPtr<CefV8Value>& retval, CefString& exception) OVERRIDE;
	void SetBrowser(CefRefPtr<CefBrowser> _browser);
	CefRefPtr<CefBrowser> browser;
	static CefRefPtr<CefListValue> myRetval;
	IMPLEMENT_REFCOUNTING(DKCefChildV8Handler);
};

class DKCefChildApp : public CefApp, public CefBrowserProcessHandler, public CefRenderProcessHandler
{
public:
	virtual CefRefPtr<CefBrowserProcessHandler> GetBrowserProcessHandler() OVERRIDE { 
		return this;
	}
	virtual CefRefPtr<CefRenderProcessHandler> GetRenderProcessHandler() OVERRIDE { 
		return this;
	}
	virtual void OnBeforeCommandLineProcessing(const CefString& process_type, CefRefPtr<CefCommandLine> command_line);
	virtual void OnBrowserCreated(CefRefPtr<CefBrowser> browser);
	virtual void OnContextInitialized();
	virtual void OnContextCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context) OVERRIDE;
	virtual bool OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefProcessId source_process, CefRefPtr<CefProcessMessage> message);
	CefRefPtr<DKCefChildV8Handler> cefV8Handler;
	std::vector<std::string> funcs;
	IMPLEMENT_REFCOUNTING(DKCefChildApp);
};

#endif //DKCefChild_H