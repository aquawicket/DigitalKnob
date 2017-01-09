#include "stdafx.h"
#include "DKCefApp.h"
#include "DKFile.h"

CefRefPtr<CefV8Value> DKCefApp::object = NULL;

#ifdef WIN32
CefRefPtr<MyV8Handler> DKCefApp::handler = NULL;
std::map<DKString, boost::function<bool(CefArgs, CefReturn)>> MyV8Handler::functions;
#endif

/////////////////////////////////////
void DKCefApp::OnContextInitialized()
{
	DKLog("DKCefApp::OnContextInitialized()\n", DKDEBUG);
	
	DKString pp = DKFile::local_assets + "cef/plugins"; 
	//DKString flash = pp + "/pepflashplayer32_19_0_0_185.dll";
	CefAddWebPluginDirectory(CefString(pp));
	//CefAddWebPluginPath(CefString(flash));
	CefRefreshWebPlugins();
}