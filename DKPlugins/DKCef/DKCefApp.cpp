#include "stdafx.h"
#include "DKCef/DKCefApp.h"

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

DKString DKV8::homepage;
DKString DKV8::multi_process;
DKString DKV8::sandbox;
DKString DKV8::log_severity;
DKString DKV8::multi_threaded_message_loop;
DKString DKV8::disable_gpu;
DKString DKV8::disable_gpu_compositing;
DKString DKV8::ignore_gpu_blacklist;
DKString DKV8::remote_debugging_port;
DKString DKV8::enable_system_flash;
DKString DKV8::enable_begin_frame_scheduling;
DKString DKV8::enable_webgl;
DKString DKV8::renderer_process_limit;
DKString DKV8::enable_gpu;
DKString DKV8::disable_web_security;
DKString DKV8::no_proxy_server;
//DKString DKV8::off_screen_rendering_enabled;