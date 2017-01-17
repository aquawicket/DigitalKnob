#include "stdafx.h"
#include "DKCef.h"
#include "DKApp.h"
#include "DKClass.h"
#include "DKLog.h"
#include "DKWindow.h"
#include "DKFile.h"
#include <include/cef_urlrequest.h>

#ifdef WIN32
#include <delayimp.h>
#include "DKWindows.h"
#endif

//CefClient* DKCef::cefHandler = NULL;

//////////////////
void DKCef::Init()
{
	DKLog("DKCef::Init()\n", DKDEBUG);
	
	cefHandler = NULL;
	DKCreate("DKCefJS");
	DKString _data = toString(data, ",");
	//DKLog("DKCef::Init("+_data+")\n", DKDEBUG);
	if(data.size() > 4){
		id = data[1];
		top = toInt(data[2]);
		left = toInt(data[3]);
		width = toInt(data[4]);
		height = toInt(data[5]);
	}
	if(data.size() > 5){
		homepage = data[6];
	}
	fullscreen = false;
	queue_new_browser = "";

	//DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[HOMEPAGE]", homepage);
	//if(homepage.empty()){ homepage = "http://www.google.com"; }

#ifdef WIN32
	//delay loading the DLL to move it's locations 
	DKString cef_dll = DKFile::local_assets + "DKCef/libcef.dll";
	libcef = LoadLibrary(cef_dll.c_str());
	if(!libcef){
		DKLog("Could not load libcef.dll \n", DKERROR);
	}
	__HrLoadAllImportsForDll("libcef.dll");
#endif

#ifdef WIN32
	CefMainArgs args(GetModuleHandle(NULL));
#else
	CefMainArgs args(DKApp::argc, DKApp::argv);
#endif
	cefApp = new DKCefApp();

	//DKLog("CefExecuteProcess \n", DKINFO);
	int result = CefExecuteProcess(args, cefApp.get(), NULL);
	if(result >= 0){
		DKLog("CefExecuteProcess error", DKERROR);
		return;
	}
	if(result == -1){
		// we are here in the father proccess.
	}

	// checkout detailed settings options http://magpcss.org/ceforum/apidocs/projects/%28default%29/_cef_settings_t.html
	// settings.multi_threaded_message_loop = true; // not supported, except windows
	// CefString(&settings.log_file).FromASCII("");
	// settings.log_severity = LOGSEVERITY_DEFAULT;
	
	CefSettings settings;
	settings.windowless_rendering_enabled = true;
//#ifdef LINUX
	DKLog("DKCef::Init(): no_sandbox\n", DKINFO);
	settings.no_sandbox = true;
//#endif
	//settings.command_line_args_disabled = true;
	//settings.multi_threaded_message_loop = true;
//#if !defined(LINUX) && !defined(DEBUG)
	DKLog("DKCef::Init(): single_process\n", DKINFO);
	settings.single_process = true; //CefRenderProcessHandler::OnContextCreated() only works with this
//#endif

#ifndef DEBUG
	settings.log_severity = LOGSEVERITY_DISABLE;
#endif

		
#ifdef WIN32
	DKString rp = DKFile::local_assets + "DKCef";
	CefString(&settings.resources_dir_path) = rp.c_str();

	DKString lp = DKFile::local_assets + "DKCef/locales";
	CefString(&settings.locales_dir_path) = lp.c_str();

	DKString cp = DKFile::local_assets + "USER";
	CefString(&settings.cache_path) = cp.c_str();

	DKString ep = DKFile::local_assets + "DKCef/cefchild.exe";

	if(!DKFile::PathExists(ep)){
        	DKLog("DKCef::Init(): file not found: "+ep+"\n", DKERROR);
        	return;
    	}

	CefString(&settings.browser_subprocess_path) = ep.c_str(); //cefchild.exe
#endif

/*
#ifdef MAC
	DKString exepath;
	DKFile::GetExePath(exepath);
	DKLog("exepath="+exepath+" \n", DKDEBUG);
	DKString exename;
	DKFile::GetExeName(exename);
	DKString ep = exepath+"../Frameworks/"+exename+" Helper.app/Contents/MacOS/"+exename+" Helper";
	CefString(&settings.browser_subprocess_path) = ep.c_str(); //helper
#endif
*/

	CefString(&settings.product_version).FromASCII("Cef/3.2623");

	//DKLog("CefInitialize \n", DKINFO);
	result = CefInitialize(args, settings, cefApp, NULL);
	if (!result){
		DKLog("CefInitialize error", DKERROR);
		return;
	}

	if(DKAvailable("DKSDLCef")){
		DKCreate("DKSDLCef,"+id);
	}
	else if(DKAvailable("DKOSGCef")){
		DKCreate("DKOSGCef,"+id);
	}
	else{
		DKLog("DKCef::Init(): No Cef window available \n", DKERROR);
		return;
	}
}

/////////////////
void DKCef::End()
{
	DKLog("DKCef::End()\n", DKDEBUG);
	
	current_browser = NULL;
	for(unsigned int i = 0; i < browsers.size(); ++i){
		browsers[i]	= NULL;
		browsers.clear();
	}
	cefHandler = NULL;

	if(instance_count == 1){
		CefShutdown();
	}
#ifdef WIN32
	FreeLibrary(libcef);
#endif
}

////////////////////////
bool DKCef::NewBrowser()
{
	CefWindowInfo window_info;
	CefBrowserSettings browserSettings;
	browserSettings.windowless_frame_rate = 60;
#ifdef WIN32
	window_info.SetAsWindowless(DKWindow::GetHwnd(), false);
#else
	window_info.SetAsWindowless(NULL, false);
#endif
	CefRefPtr<CefBrowser> _browser;
	_browser = CefBrowserHost::CreateBrowserSync(window_info, cefHandler, homepage, browserSettings, NULL);
	if(!_browser){
		DKLog("DKCef::NewBrowser(): _browser invalid\n", DKERROR);
		return false; 
	}
	browsers.push_back(_browser);
	current_browser = browsers[0];
	current_browser->GetHost()->SetWindowlessFrameRate(60);
	return true;
}

////////////////////////
int DKCef::GetBrowsers()
{
	return browsers.size();
}

//////////////////////////////
int DKCef::GetCurrentBrowser()
{
	for(unsigned int i=0; i<browsers.size(); ++i){
		if(browsers[i] == current_browser){
			return i;
		}
	}
	return 0; //error
}

//////////////////////////////////
bool DKCef::SelectBrowser(int num)
{
	//DKLog("SelectBrowser: "+toString(num)+"\n");
	current_browser = browsers[num];
	current_browser->GetHost()->Invalidate(PET_VIEW);
	return true;
}

/////////////////////////////////
bool DKCef::CloseBrowser(int num)
{
	//DKLog("CloseBrowser: "+toString(num)+"\n");
	current_browser = browsers[0];
	current_browser->GetHost()->Invalidate(PET_VIEW);

	browsers[num] = NULL;
	browsers.erase(browsers.begin() + num);
	return true;
}

/////////////////////////////////////
const DKString DKCef::GetUrl(int num)
{
	if(num > (int)browsers.size()-1){ return ""; } //error
	DKString url = browsers[num]->GetMainFrame()->GetURL().ToString();
	return url;
}

////////////////////////////////////////////////
bool DKCef::SetUrl(const DKString& url, int num)
{
	if(num > (int)browsers.size()-1){ return false; } //error
	if (same(url, "plugins")){
		RunPluginInfoTest(current_browser);
		return true;
	}
	browsers[num]->GetMainFrame()->LoadURL(url.c_str());
	return true;
}

///////////////////////////
bool DKCef::GoBack(int num)
{
	if(num > (int)browsers.size()-1){ return false; } //error
	if (browsers[num]->CanGoBack()){
		browsers[num]->GoBack();
		return true;
	}
	return false;
}

//////////////////////////////
bool DKCef::GoForward(int num)
{
	if(num > (int)browsers.size()-1){ return false; } //error
	if (browsers[num]->CanGoForward()){
		browsers[num]->GoForward();
		return true;
	}
	return false;
}

/////////////////////////
bool DKCef::Stop(int num)
{
	if(num > (int)browsers.size()-1){ return false; } //error
	browsers[num]->StopLoad();
	return true;
}

///////////////////////////
bool DKCef::Reload(int num)
{
	if(num > (int)browsers.size()-1){ return false; } //error
	browsers[num]->Reload();
	return true;
}

////////////////////////////////////////////
bool DKCef::DownloadUrl(const DKString& url)
{
	DKLog("Downloading.. "+url+"\n", DKINFO);
	current_browser->GetHost()->StartDownload(url);
	return false;
}

///////////////////
bool DKCef::Paste()
{
	current_browser->GetFocusedFrame()->Paste();
	return true;
}

/////////////////////////////////
bool DKCef::ShowDevTools(int num)
{
	//TODO
	/*)
	CefWindowInfo windowInfo;
	CefBrowserSettings settings;
	CefPoint inspectElementAt;

#ifdef WIN32
	windowInfo.SetAsPopup(browsers[num]->GetHost()->GetWindowHandle(), "DevTools");
#endif

	SetUrl("chrome-devtools://devtools/devtools.html", num);
	browsers[num]->GetHost()->ShowDevTools(windowInfo, cefHandler, settings, inspectElementAt);
	return true;
	*/
	return false;
}

////////////////////////////////////////////////////////////
void DKCef::RunPluginInfoTest(CefRefPtr<CefBrowser> browser) 
{
	class Visitor : public CefWebPluginInfoVisitor {
	public:
		explicit Visitor(CefRefPtr<CefBrowser> browser)
			: browser_(browser) {
			html_ = "<html><head><title>Plugin Info Test</title></head>"
				"<body bgcolor=\"white\">"
				"\n<b>Installed plugins:</b>";
		}
		~Visitor() {
			html_ += "\n</body></html>";

			// Load the html in the browser.
			browser_->GetMainFrame()->LoadString(html_, "http://tests/plugin_info");
		}

		virtual bool Visit(CefRefPtr<CefWebPluginInfo> info, int count, int total)
			OVERRIDE{
			html_ += "\n<br/><br/>Name: " + info->GetName().ToString() +
			"\n<br/>Description: " + info->GetDescription().ToString() +
			"\n<br/>Version: " + info->GetVersion().ToString() +
			"\n<br/>Path: " + info->GetPath().ToString();
			return true;
		}

	private:
		std::string html_;
		CefRefPtr<CefBrowser> browser_;
		IMPLEMENT_REFCOUNTING(Visitor);
	};

	CefVisitWebPluginInfo(new Visitor(browser));
}

///////////////////////////////////////////
void DKCef::RunJavascript(DKString& string)
{
	CefRefPtr<CefFrame> frame = DKCef::Get("")->current_browser->GetMainFrame();
	frame->ExecuteJavaScript(string.c_str(), frame->GetURL(), 0);
}
