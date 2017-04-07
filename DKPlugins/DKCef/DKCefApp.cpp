#include "stdafx.h"
#include "DKCefApp.h"

bool DKV8::singleprocess = false;
#ifdef MAC
std::map<DKString, boost::function2<bool, CefArgs, CefReturn> > DKV8::functions;
#else
std::map<DKString, boost::function<bool(CefArgs, CefReturn)>> DKV8::functions;
#endif

