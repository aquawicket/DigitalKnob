#include "stdafx.h"
#include "DKCefApp.h"

bool DKV8::singleprocess = true;
CefRefPtr<CefBrowser> DKV8::_browser = NULL;
CefRefPtr<DKCefV8Handler> DKV8::v8handler = NULL;
CefRefPtr<CefV8Value> DKV8::ctx = NULL;
#ifdef MAC
std::map<DKString, boost::function2<bool, CefArgs, CefReturn> > DKV8::functions;
#else
std::map<DKString, boost::function<bool(CefArgs, CefReturn)>> DKV8::functions;
#endif
std::vector<std::string> DKV8::funcs;

DKString DKV8::log_severity;
DKString DKV8::homepage;
DKString DKV8::sandbox;
DKString DKV8::multi_process;
DKString DKV8::multithreadedmessageloop;