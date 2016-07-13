#include "stdafx.h"
#include "DKCefApp.h"
#include "DKFile.h"

/////////////////////////////////////
void DKCefApp::OnContextInitialized()
{
	//DKLog("DKCefApp::OnContextInitialized() \n", DKDEBUG);
	DKString pp = DKFile::local_assets + "cef/plugins"; 
	//DKString flash = pp + "/pepflashplayer32_19_0_0_185.dll";
	CefAddWebPluginDirectory(CefString(pp));
	//CefAddWebPluginPath(CefString(flash));
	CefRefreshWebPlugins();
}