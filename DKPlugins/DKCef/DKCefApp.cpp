#include "stdafx.h"
#include "DKCefApp.h"
#include "DKFile.h"

CefRefPtr<CefV8Value> DKCefV8Handler::object = NULL;
DKCefV8Handler* DKCefV8Handler::instance = NULL;

#ifdef MAC
std::map<DKString, boost::function2<bool, CefArgs, CefReturn> > DKCefV8Handler::functions;
#else
std::map<DKString, boost::function<bool(CefArgs, CefReturn)>> DKCefV8Handler::functions;
#endif


