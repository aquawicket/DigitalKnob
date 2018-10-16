#include "DK/stdafx.h"
#include <sstream>
#include <string>
#include <include/cef_urlrequest.h>
#include <include/cef_version.h>
#include "include/base/cef_bind.h"
#include "include/wrapper/cef_closure_task.h"
#include "include/wrapper/cef_helpers.h"
#include "DK/DKApp.h"
#include "DK/DKClass.h"
#include "DK/DKFile.h"
#include "DK/DKLog.h"
#include "DKCef/DKCef.h"
#include "DKCef/DKCefWindow.h"
#include "DKDuktape/DKDuktape.h"


#ifdef WIN32
#include <delayimp.h>
#include <include/cef_sandbox_win.h>
#include "DK/DKWindows.h"
#endif

CefRefPtr<CefClient> DKCef::cefHandler;
unsigned long DKCef::cefThreadId;
CefRefPtr<DKCefApp> DKCef::cefApp;
bool DKCef::initialized = false;


//////////////////
bool DKCef::Init()
{
	DKLog("DKCef::Init()\n", DKDEBUG);
	
	//int major_version = cef_version_info(0);
	//int build_version = cef_version_info(4);
	//DKString version_string = "Cef/"+toString(major_version)+"."+toString(build_version);
	//DKLog("Cef version "+version_string+"\n", DKINFO);
	//CefString(&settings.product_version).FromASCII(version_string.c_str());

	cefHandler = NULL;
	//source = "";

	/*
	DKString id;
	int top;
	int left;
	int width;
	int height;
	DKString url;

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
		url = data[6];
	}
	*/

	/*
	if(dkBrowsers.size() > 0){
		NewBrowser(id,top,left,width,height,url);
		return true;
	}
	*/

	DKClass::DKCreate("DKCefJS");
	DKClass::DKCreate("DKCefV8");

	fullscreen = false;

#if defined(WIN32) && !defined(WIN64)
	DKString elf_dll;
	DKString cef_dll;
#ifdef DEBUG
	elf_dll = DKFile::local_assets + "DKCef/win32Debug/chrome_elf.dll";
	cef_dll = DKFile::local_assets + "DKCef/win32Debug/libcef.dll";
#else
	elf_dll = DKFile::local_assets + "DKCef/win32Release/chrome_elf.dll";
	cef_dll = DKFile::local_assets + "DKCef/win32Release/libcef.dll";
#endif
	libelf = LoadLibrary(elf_dll.c_str());
	if (!libelf) {
		DKString error;
		DKWindows::GetLastError(error);
		DKLog("Could not load " + elf_dll + ": " + error + "\n", DKERROR);
		FreeLibrary(libelf);
	}
	__HrLoadAllImportsForDll("chrome_elf.dll"); //delay loading the DLL from another location

	libcef = LoadLibrary(cef_dll.c_str());
	if(!libcef){
		DKString error;
		DKWindows::GetLastError(error);
		DKLog("Could not load "+cef_dll+": "+error+"\n", DKERROR);
		FreeLibrary(libcef);
	}
	__HrLoadAllImportsForDll("libcef.dll"); //delay loading the DLL from another location 
#endif


#ifdef WIN64
	DKString elf_dll;
	DKString cef_dll;
#ifdef DEBUG
	elf_dll = DKFile::local_assets + "DKCef/win64Debug/chrome_elf.dll";
	cef_dll = DKFile::local_assets + "DKCef/win64Debug/libcef.dll";
#else
	elf_dll = DKFile::local_assets + "DKCef/win64Release/chrome_elf.dll";
	cef_dll = DKFile::local_assets + "DKCef/win64Release/libcef.dll";
#endif
	libelf = LoadLibrary(elf_dll.c_str());
	if (!libelf) {
		DKString error;
		DKWindows::GetLastError(error);
		DKLog("Could not load " + elf_dll + ": " + error + "\n", DKERROR);
		FreeLibrary(libelf);
	}
	__HrLoadAllImportsForDll("chrome_elf.dll"); //delay loading the DLL to move it's locations

	libcef = LoadLibrary(cef_dll.c_str());
	if(!libcef){
		DKString error;
		DKWindows::GetLastError(error);
		DKLog("Could not load "+cef_dll+": "+error+"\n", DKERROR);
		FreeLibrary(libcef);
	}
	__HrLoadAllImportsForDll("libcef.dll"); //delay loading the DLL to move it's locations  
#endif

	//IMPORTANT INFORMATION
	//https://bitbucket.org/chromiumembedded/cef/wiki/GeneralUsage.md#markdown-header-application-structure

#ifdef WIN32
	CefMainArgs args(GetModuleHandle(NULL));
#else
	CefMainArgs args(DKApp::argc, DKApp::argv);
#endif
	if(!initialized){
		cefApp = new DKCefApp();
		initialized = true;
	}
	
	int exit_code = CefExecuteProcess(args, cefApp.get(), NULL);
	if(exit_code >= 0) {
	  // The sub-process has completed so return here.
		return false;
		DKClass::_Close("DKSDLWindow0");
	}

	// checkout detailed settings options http://magpcss.org/ceforum/apidocs/projects/%28default%29/_cef_settings_t.html
	// CefString(&settings.log_file).FromASCII("");
	
	DKV8::SetFlags();

	CefSettings settings;

	if(DKClass::DKValid("DKWindow,DKWindow0")){
		settings.windowless_rendering_enabled = true;
	}
	
	void* sandbox_info = NULL;
	if(same(DKV8::sandbox, "OFF")){
		settings.no_sandbox = true;
	}
	else{
		settings.no_sandbox = false;
#ifndef LINUX
		//CefScopedSandboxInfo scoped_sandbox;
		//sandbox_info = scoped_sandbox.sandbox_info();
#endif
	}
	
	if(same(DKV8::multi_threaded_message_loop, "ON")){
		settings.multi_threaded_message_loop = true;
	}

	if(same(DKV8::multi_process, "ON")){
		DKV8::singleprocess = false;
	}
	else{
		DKV8::singleprocess = true;
	}

	if(!same(DKV8::log_severity, "ON")){ //OFF
		settings.log_severity = LOGSEVERITY_DISABLE;
	}
	settings.uncaught_exception_stack_size = 100;

	//settings.accept_language_list;
	//settings.background_color;
	//settings.command_line_args_disabled;
	//settings.context_safety_implementation;
	//settings.ignore_certificate_errors;
	//settings.javascript_flags;
	//settings.pack_loading_disabled;
	//settings.persist_session_cookies;
	//settings.persist_user_preferences;

	//MAC's resources are in the bundle
#ifndef MAC
	DKString rp = DKFile::local_assets + "DKCef";
	CefString(&settings.resources_dir_path) = rp.c_str();

	DKString lp = DKFile::local_assets + "DKCef/locales";
	CefString(&settings.locales_dir_path) = lp.c_str();
#endif

	DKString cp = DKFile::local_assets + "USER";
	CefString(&settings.cache_path) = cp.c_str();

	DKString lf = DKFile::local_assets + "cef.log";
	CefString(&settings.log_file) = lf.c_str();

#ifdef WIN32
	#if defined(WIN32) && !defined(WIN64)
		#ifdef DEBUG
			DKString ep = DKFile::local_assets + "DKCef/win32Debug/cefchild.exe";
		#else
			DKString ep = DKFile::local_assets + "DKCef/win32Release/cefchild.exe";
		#endif
	#endif
	#ifdef WIN64
		#ifdef DEBUG
			DKString ep = DKFile::local_assets + "DKCef/win64Debug/cefchild.exe";
		#else
			DKString ep = DKFile::local_assets + "DKCef/win64Release/cefchild.exe";
		#endif
	#endif
	if(!DKFile::PathExists(ep)){
        DKLog("DKCef::Init(): file not found: "+ep+"\n", DKWARN);
        //TODO: disable multi-process
    }
	CefString(&settings.browser_subprocess_path) = ep.c_str(); //cefchild.exe
#endif
	
#ifdef MAC
	DKString exepath;
	DKFile::GetExePath(exepath);
	DKLog("exepath="+exepath+" \n", DKDEBUG);
	DKString exename;
	DKFile::GetExeName(exename);
	DKString ep = exepath+"../Frameworks/"+exename+" Helper.app/Contents/MacOS/"+exename+" Helper";
	CefString(&settings.browser_subprocess_path) = ep.c_str(); //helper
#endif
	
#ifdef LINUX
	DKString ep = DKFile::local_assets + "DKCef/cefchild";
	if(!DKFile::PathExists(ep)){
        DKLog("DKCef::Init(): file not found: "+ep+"\n", DKERROR);
        //TODO: disable multi-process
    }
	CefString(&settings.browser_subprocess_path) = ep.c_str(); //cefchild
#endif

	int major_version = cef_version_info(0);
	int build_version = cef_version_info(4);
	DKString version_string = "Cef/"+toString(major_version)+"."+toString(build_version);
	//CefString(&settings.product_version).FromASCII(version_string.c_str());
	DKLog("Cef Version: "+version_string+"\n", DKINFO);

	DKString userAgent = "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36 "+version_string;
	CefString(&settings.user_agent).FromASCII(userAgent.c_str());
	DKLog("Cef User Agent: "+CefString(&settings.user_agent).ToString()+"\n", DKINFO);


	int result2 = CefInitialize(args, settings, cefApp.get(), sandbox_info);
	if (!result2){
		DKLog("CefInitialize error", DKERROR);
		return false;
	}

	DKUtil::GetThreadId(cefThreadId); //store the main Cef threadId

	if(DKClass::DKValid("DKSDLWindow,DKSDLWindow0")){
		if(DKClass::DKAvailable("DKSDLCef")){
			DKClass::DKCreate("DKSDLCef");
			//NewBrowser(id, top, left, width, height, url);
		}
	}
	else if(DKClass::DKValid("DKOSGWindow,DKOSGWindow0")){
		if(DKClass::DKAvailable("DKOSGCef")){
			DKClass::DKCreate("DKOSGCef");
			//NewBrowser(id, top, left, width, height, url);
		}
	}
	else{
		dkCefWindow = new DKCefWindow();
		cefHandler = dkCefWindow;
		dkCefWindow->dkCef = this;
		//NewBrowser(id, top, left, width, height, url);
		DKApp::AppendLoopFunc(&DKCefWindow::DoFrame, dkCefWindow);
		DKString icon = DKFile::local_assets+"icon.ico";
		DKClass::CallFunc("DKCefWindow::SetIcon", &icon, NULL);
	}
	
	DKEvent::AddSendEventFunc(&DKCef::SendEvent, this);
	DKClass::RegisterFunc("DKCef::NewBrowser", &DKCef::NewBrowser, this);
	return true;
}

/////////////////
bool DKCef::End()
{
	DKLog("DKCef::End()\n", DKDEBUG);
	//FIXME - many crashes at CefShutdown
	unsigned long threadId;
	DKUtil::GetThreadId(threadId);
	if(cefThreadId != threadId){
		DKLog("DKCef::End(): Error: not in the main cef thread\n", DKERROR);
		return false;
	}
	DKLog("DKCef::End(): CefShutdown();\n", DKINFO);
	CefShutdown(); //call on same thread as CefInitialize

#ifdef WIN32
	FreeLibrary(libcef);
#endif
	return true;
}



////////////////////////////////////////////
bool DKCef::CloseBrowser(const int& browser)
{
	DKLog("DKCef::CloseBrowser("+toString(browser)+")\n", DKDEBUG);
	current_browser = dkBrowsers[0].browser;
	current_browser->GetHost()->Invalidate(PET_VIEW);
	dkBrowsers[browser].browser = NULL;
	dkBrowsers.erase(dkBrowsers.begin() + browser);
	return true;
}

/////////////////////////////////////////////
bool DKCef::CloseDevTools(const int& browser)
{
	DKLog("DKCef::CloseDevTools("+toString(browser)+")\n", DKDEBUG);
	dkBrowsers[browser].browser->GetHost()->CloseDevTools();
	return true;
}

//////////////////
bool DKCef::Copy()
{
	DKLog("DKCef::Copy()\n", DKDEBUG);
	current_browser->GetFocusedFrame()->Copy();
	return true;
}


//////////////////////////////////////////
bool DKCef::CopyImage(const DKString& url)
{
	DKLog("DKCef::CopyImage("+url+")\n", DKDEBUG);
	/*
	NewBrowser();
	int num;
	GetBrowsers(num);
	DKLog("DKCef::CopyImage("+url+"): num = "+toString(num)+"\n", DKINFO);
	SetUrl(num-1, url);

	//FIXME - we can't copy until the frame is loaded with the image. 
	//        need to use a callback or something. :P
	//while(browsers[num-1]->IsLoading()){}
	dkBrowsers[num-1].browser->GetMainFrame()->Copy();  //NOT WORKING, url not loaded yet. 

	CloseBrowser(num-1);
	*/
	return false; //return false until this is working
}

/////////////////
bool DKCef::Cut()
{
	DKLog("DKCef::Cut()\n", DKDEBUG);
	current_browser->GetFocusedFrame()->Cut();
	return true;
}

////////////////////////////////////////////
bool DKCef::DownloadUrl(const DKString& url)
{
	DKLog("DKCef::DownloadUrl("+url+")\n", DKDEBUG);
	DKLog("Downloading... "+url+"\n", DKINFO);
	current_browser->GetHost()->StartDownload(url);
	return false;
}

///////////////////////////////////////////////////////////////////
bool DKCef::FileDialog(const DKString& type, const DKString& title)
{
	DKLog("DKCef::FileDialog("+type+","+title+")\n", DKDEBUG);
	std::vector<CefString> file_types;
	file_types.push_back("image/*");
	fileDialogCallback = new DialogCallback;

	CefBrowserHost::FileDialogMode _type;
	if(type == "FILE_DIALOG_OPEN"){ _type = FILE_DIALOG_OPEN; }
	else if(type == "FILE_DIALOG_OPEN_MULTIPLE"){ _type = FILE_DIALOG_OPEN_MULTIPLE; }
	else if(type == "FILE_DIALOG_OPEN_FOLDER"){ _type = FILE_DIALOG_OPEN_FOLDER; }
	else if(type == "FILE_DIALOG_SAVE"){ _type = FILE_DIALOG_SAVE; }
	else{
		DKLog("DKCef::FileDialog(): type ("+toString(_type)+") is not a valid selector", DKERROR);
		return false;
	}

	current_browser->GetHost()->RunFileDialog(_type, "Open Files", CefString(), file_types, 0, fileDialogCallback);
	return true;
}

//////////////////////////////////////////////////////////
bool DKCef::Find(const int& browser, const DKString& text)
{
	DKLog("DKCef::Find("+toString(browser)+","+text+")\n", DKDEBUG);
	if(browser > (int)dkBrowsers.size()-1){ return false; } //error
	if(!text.empty()){
		dkBrowsers[browser].browser->GetHost()->Find(0, text.c_str(), true, false, false);
	}
	else{
		dkBrowsers[browser].browser->GetHost()->StopFinding(true);
	}
	return true;
}

/////////////////////////////////
bool DKCef::GetBrowsers(int& num)
{
	DKLog("DKCef::GetBrowsers("+toString(num)+")\n", DKDEBUG);
	num = dkBrowsers.size();
	return true;
}

///////////////////////////////////////////
bool DKCef::GetCurrentBrowser(int& browser)
{
	DKLog("DKCef::GetCurrentBrowser("+toString(browser)+")\n", DKDEBUG);
	for(unsigned int i=0; i<dkBrowsers.size(); ++i){
		if(dkBrowsers[i].browser == current_browser){
			browser = i;
			return true;
		}
	}
	DKLog("DKCef::GetCurrentBrowser("+toString(browser)+"): failed\n", DKERROR);
	return false; //error
}

////////////////////////////////////////////////////////////////
bool DKCef::GetPageSource(const int& browser, DKString& _source)
{
	DKLog("DKCef::GetPageSource()\n", DKDEBUG);
	//_source = source; 
	return true;
}

///////////////////////////////////////////////
bool DKCef::GetUrl(int& browser, DKString& url)
{
	DKLog("DKCef::GetUrl("+toString(browser)+","+url+")\n", DKDEBUG);
	if(browser > (int)dkBrowsers.size()-1){ return false; } //error
	url = dkBrowsers[browser].browser->GetMainFrame()->GetURL().ToString();
	return true;
}

//////////////////////////////////////
bool DKCef::GoBack(const int& browser)
{
	DKLog("DKCef::GoBack("+toString(browser)+")\n", DKDEBUG);
	if(browser > (int)dkBrowsers.size()-1){ return false; } //error
	if (dkBrowsers[browser].browser->CanGoBack()){
		dkBrowsers[browser].browser->GoBack();
		return true;
	}
	return false;
}

/////////////////////////////////////////
bool DKCef::GoForward(const int& browser)
{
	DKLog("DKCef::GoForward("+toString(browser)+")\n", DKDEBUG);
	if(browser > (int)dkBrowsers.size()-1){ return false; } //error
	if (dkBrowsers[browser].browser->CanGoForward()){
		dkBrowsers[browser].browser->GoForward();
		return true;
	}
	return false;
}

///////////////////////////////////////////////////////
bool DKCef::NewBrowser(const void* input, void* output)
{
	DKString data = *(DKString*)input;
	DKStringArray arry;
	toStringArray(arry, data, ",");
	NewBrowser(arry[0], toInt(arry[1]), toInt(arry[2]), toInt(arry[3]), toInt(arry[4]), arry[5]);
	return false;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKCef::NewBrowser(const DKString& id, const int& top, const int& left, const int& width, const int& height, const DKString& url)
{
	DKLog("DKCef::NewBrowser("+id+","+toString(top)+","+toString(left)+","+toString(width)+","+toString(height)+","+url+")\n", DKINFO);
	CefWindowInfo window_info;
	CefBrowserSettings browserSettings;
	if(DKClass::DKValid("DKWindow,DKWindow0")){
		browserSettings.windowless_frame_rate = 60;
		window_info.SetAsWindowless(NULL);
		CefRefPtr<CefBrowser> _browser;
		_browser = CefBrowserHost::CreateBrowserSync(window_info, cefHandler, url, browserSettings, NULL);
		if(!_browser){
			DKLog("DKCef::NewBrowser(): _browser invalid\n", DKERROR);
			return false; 
		}

		DKBrowser dkBrowser;
		dkBrowser.id = id;
		dkBrowser.top = top;
		dkBrowser.width = width;
		dkBrowser.height = height;
		dkBrowser.url = url;
		dkBrowser.browser = _browser;
		dkBrowsers.push_back(dkBrowser);
		current_browser = dkBrowsers[0].browser;
		current_browser->GetHost()->SetWindowlessFrameRate(60);
	}
	else{
		//Create window title
		DKString title; 
		DKFile::GetExeName(title);
		DKFile::RemoveExtention(title);
#if defined(WIN32) && !defined(WIN64)
		title += " - WIN32";
#endif
#ifdef WIN64
		title += " - WIN64";
#endif
#ifdef MAC
		title += " - MAC";
#endif
#ifdef LINUX
		title += " - LINUX";
#endif
#ifdef DEBUG
		title += " DEBUG ";
#else
		title += " RELEASE ";
#endif
		DKString mTime;
		DKString file;
		DKFile::GetExePath(file);
		DKFile::GetModifiedTime(file, mTime);
		title += mTime;
#ifdef WIN32
		window_info.SetAsPopup(NULL, title.c_str());
#endif
		window_info.width = 800;
		window_info.height = 600;
		CefRefPtr<CefBrowser> _browser;
		_browser = CefBrowserHost::CreateBrowserSync(window_info, cefHandler, url, browserSettings, NULL);
		DKBrowser dkBrowser;
		dkBrowser.id = id;
		dkBrowser.top = top;
		dkBrowser.width = width;
		dkBrowser.height = height;
		dkBrowser.url = url;
		dkBrowser.browser = _browser;
		dkBrowsers.push_back(dkBrowser);
		current_browser = dkBrowsers[0].browser;
		
#ifdef LINUX
		gdk_init(NULL, NULL);
		GdkWindow* gdk_window = gdk_window_foreign_new(current_browser->GetHost()->GetWindowHandle());
		if(!gdk_window){
		      DKLog("DKCef::NewBrowser(): gdk_window invalid\n", DKINFO);
		      return false;
		}
		gdk_window_set_title(gdk_window, title.c_str());
#endif
	}
	return true;
}

///////////////////
bool DKCef::Paste()
{
	DKLog("DKCef::Paste()\n", DKDEBUG);
	current_browser->GetFocusedFrame()->Paste();
	return true;
}

//////////////////////////////////////
bool DKCef::Popup(const DKString& url)
{
	DKLog("DKCef::Popup("+url+")\n", DKDEBUG);
	DKString string = "window.open('"+url+"', '_blank', 'width=800,height=600');";
	int browser_num;
	GetCurrentBrowser(browser_num);
	RunJavascript(browser_num, string);
	return false;
}

/////////////////////////////////////
bool DKCef::Print(const int& browser)
{
	DKLog("DKCef::Print("+toString(browser)+")\n", DKDEBUG);
	dkBrowsers[browser].browser->GetHost()->Print();
	return true;
}

//////////////////////////////////////////
bool DKCef::QueueDuktape(DKString& string)
{
	DKLog("DKCef::QueueDuktape("+string+")\n", DKDEBUG);
	return DKDuktape::QueueDuktape(string);
}

//////////////////////////////////////
bool DKCef::Reload(const int& browser)
{
	DKLog("DKCef::Reload("+toString(browser)+")\n", DKDEBUG);
	if(browser > (int)dkBrowsers.size()-1){ return false; } //error
	dkBrowsers[browser].browser->Reload();
	return true;
}

///////////////////////////////////////////
bool DKCef::RemoveFocus(const int& browser)
{
	dkBrowsers[browser].browser->GetHost()->SendFocusEvent(false);
	dkBrowsers[browser].focused = false;
	return 1;
}

////////////////////////////////////////
bool DKCef::RunDuktape(DKString& string)
{
	DKLog("DKCef::RunDuktape("+string+")\n", DKDEBUG);
	return DKDuktape::RunDuktape(string);
}

///////////////////////////////////////////////////////////////
bool DKCef::RunJavascript(const int& browser, DKString& string)
{
	DKLog("DKCef::RunJavascript("+toString(browser)+","+string+")\n", DKDEBUG);
	//FIXME - get CefPostTask working
	//if(!CefCurrentlyOn(TID_UI)){
	//	CefPostTask(TID_UI, base::Bind(&DKCef::RunJavascript, this, string));
	//	return false;
	//}

	if(!DKUtil::InMainThread()){ 
		DKLog("DKCef::RunJavascript("+string+"): not in the main thread\n", DKWARN);
		//return false; 
	}
	CefRefPtr<CefFrame> frame = dkBrowsers[browser].browser->GetMainFrame();
	if(!frame){
		DKLog("DKCef::RunJavascript("+string+"): frame invalid\n", DKERROR);
		return false;
	}
	frame->ExecuteJavaScript(string.c_str(), frame->GetURL(), 0);
	return true;
}

///////////////////////////////////////
bool DKCef::SelectBrowser(int& browser)
{
	DKLog("DKCef::SelectBrowser("+toString(browser)+")\n", DKDEBUG);
	current_browser = dkBrowsers[browser].browser;
	current_browser->GetHost()->Invalidate(PET_VIEW);
	return true;
}

////////////////////////////////////////
bool DKCef::SetFocus(const int& browser)
{
	if(browser+1 > (int)dkBrowsers.size()){
		DKLog("DKCef::SetFocus("+toString(browser)+"): browser invalid\n", DKERROR);
		return false;
	}
	dkBrowsers[browser].browser->GetHost()->SendFocusEvent(true);
	dkBrowsers[browser].focused = true;
	return true;
}

///////////////////////////////////////////////////////////
bool DKCef::SetUrl(const int& browser, const DKString& url)
{
	DKLog("DKCef::SetUrl("+toString(browser)+","+url+")\n", DKDEBUG);
	if(browser > (int)dkBrowsers.size()-1){ return false; } //error
	if (same(url, "plugins")){
		RunPluginInfoTest(current_browser);
		return true;
	}
	dkBrowsers[browser].browser->GetMainFrame()->LoadURL(url.c_str());
	return true;
}

////////////////////////////////////////////
bool DKCef::ShowDevTools(const int& browser)
{
	DKLog("DKCef::ShowDevTools("+toString(browser)+")\n", DKDEBUG);
	CefWindowInfo window_info;
	CefBrowserSettings settings;
	CefPoint inspectElementAt;

#ifdef WIN32
	window_info.SetAsPopup(NULL, "DevTools"); //FIXME for mac
#endif
	window_info.width = 800;
	window_info.height = 600;

	dkBrowsers[browser].browser->GetHost()->ShowDevTools(window_info, cefHandler, settings, inspectElementAt);
	return true;
}

////////////////////////////////////
bool DKCef::Stop(const int& browser)
{
	DKLog("DKCef::Stop("+toString(browser)+")\n", DKDEBUG);
	if(browser > (int)dkBrowsers.size()-1){ return false; } //error
	dkBrowsers[browser].browser->StopLoad();
	return true;
}

//////////////////////////////////////////////////////////////////////////////////////
bool DKCef::SendEvent(const DKString& id, const DKString& type, const DKString& value)
{
	if(same(id,"DKLog")){ return false; }
	if(id.empty()){ return false; }
	if(type.empty()){ return false; }
	if(same(type,"second")){ return false; }
	if(same(type,"mousemove")){ return false; }
	if(same(type,"mousedown")){ return false; }
	if(same(type,"mouseup")){ return false; }
	if(same(type,"wheel")){ return false; }
	if(same(type,"click")){ return false; }
	if(same(type,"contextmenu")){ return false; }
	if(same(type,"keypress")){ return false; }
	if(same(type,"keydown")){ return false; }
	if(same(type,"keyup")){ return false; }
	if(same(type,"move")){ return false; }
	if(same(type,"resize")){ return false; }
	if(same(type,"minimize")){ return false; }
	if(same(type,"maximize")){ return false; }
	if(same(type,"restore")){ return false; }

	DKLog("DKCef::SendEvent("+id+","+type+","+value+")\n", DKDEBUG);
	
	//DKSendEvent to first browsers only
	CefRefPtr<CefFrame> frame = dkBrowsers[0].browser->GetMainFrame();
	if(!frame){
		DKLog("DKCef::SendEvent(): frame invalid \n", DKERROR);
		return false;
	}
	DKString string = "DKSendEvent(\""+id+"\",\""+type+"\",\""+value+"\");";
	frame->ExecuteJavaScript(string.c_str(), frame->GetURL(), 0);

	/*
	//DKSendEvent to all browsers
	for(unsigned int i=0; i<dkcef->browsers.size(); ++i){
		CefRefPtr<CefFrame> frame = dkcef->browsers[i]->GetMainFrame();
		if(!frame){
			DKLog("DKCef::SendEvent(): frame invalid \n", DKERROR);
			return false;
		}
		DKString string = "DKSendEvent(\""+id+"\",\""+type+"\",\""+value+"\");";
		frame->ExecuteJavaScript(string.c_str(), frame->GetURL(), 0);
	}
	*/
	return true;
}

////////////////////////////////////////////////////////////
void DKCef::RunPluginInfoTest(CefRefPtr<CefBrowser> browser) 
{
	DKLog("DKCef::RunPluginInfoTest()\n", DKDEBUG);
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

//////////////////////////////////////////////
bool DKCef::ViewPageSource(const int& browser)
{
	DKLog("DKCef::ViewPageSource()\n", DKDEBUG);
	dkBrowsers[browser].browser->GetMainFrame()->ViewSource();
	return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DialogCallback::OnFileDialogDismissed(int selected_accept_filter, const std::vector<CefString>& file_paths)
{
	DKLog("DialogCallback::OnFileDialogDismissed("+toString(selected_accept_filter)+")\n", DKDEBUG);
	DKString files;
	for(unsigned int i=0; i<file_paths.size(); ++i){
		DKLog(file_paths[i].ToString()+"\n", DKINFO);
		files += file_paths[i].ToString();
		if(i<file_paths.size()-1){
			files += ";";
		}
	}

	replace(files, "\\", "\\\\");
	DKEvent::SendEvent("GLOBAL", "DKCef_OnFileDialogDismissed", files);
}




//////////////////
void DKCef::Test()
{
	DKLog("DKCef::Test()\n", DKDEBUG);
}