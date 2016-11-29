#include "stdafx.h"
#include "DKCefApp.h"
#include "DKFile.h"

CefRefPtr<MyV8Handler> DKCefApp::handler = NULL;
CefRefPtr<CefV8Value> DKCefApp::object = NULL;
std::map<DKString, boost::function<bool(CefArgs, CefReturn)>> MyV8Handler::functions;

/////////////////////////////////////
void DKCefApp::OnContextInitialized()
{
	DKLog("DKCefApp::OnContextInitialized()\n", DKFILTER);
	
	DKString pp = DKFile::local_assets + "cef/plugins"; 
	//DKString flash = pp + "/pepflashplayer32_19_0_0_185.dll";
	CefAddWebPluginDirectory(CefString(pp));
	//CefAddWebPluginPath(CefString(flash));
	CefRefreshWebPlugins();
}