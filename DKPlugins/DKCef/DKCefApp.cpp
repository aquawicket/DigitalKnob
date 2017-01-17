#include "stdafx.h"
#include "DKCefApp.h"
#include "DKFile.h"

CefRefPtr<CefV8Value> DKCefApp::object = NULL;

//#ifndef MAC
CefRefPtr<MyV8Handler> DKCefApp::handler = NULL;
//#endif

#ifdef MAC
std::map<DKString, boost::function2<bool, CefArgs, CefReturn> > MyV8Handler::functions;
#else
std::map<DKString, boost::function<bool(CefArgs, CefReturn)>> MyV8Handler::functions;
#endif


/////////////////////////////////////
void DKCefApp::OnContextInitialized()
{
	DKLog("DKCefApp::OnContextInitialized()\n", DKDEBUG);
	
	DKString pp = DKFile::local_assets + "cef/plugins"; 
	//DKString flash = pp + "/pepflashplayer32_19_0_0_185.dll";
	
	//FIXME
	//CefAddWebPluginDirectory(CefString(pp));
	
	//CefAddWebPluginPath(CefString(flash));
	CefRefreshWebPlugins();
}