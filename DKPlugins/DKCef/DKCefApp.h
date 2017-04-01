#pragma once
#ifndef DKCefApp_H
#define DKCefApp_H
#include <include/cef_app.h>

typedef CefV8ValueList CefArgs;
typedef CefRefPtr<CefV8Value>& CefReturn;
class DKCefApp;


//////////////////////////////////////////
class DKCefV8Handler : public CefV8Handler
{
public:
	DKCefV8Handler()
	{
		DKLog("DKCefV8Handler::DKCefV8Handler()\n",DKDEBUG);
		instance = this;
	}

	static DKCefV8Handler* instance;
#ifdef MAC
	static std::map<DKString, boost::function2<bool, CefArgs, CefReturn> > functions;
#else
	static std::map<DKString, boost::function<bool (CefArgs, CefReturn)>> functions;
#endif
	

	virtual bool Execute(const CefString& name, CefRefPtr<CefV8Value> object, const CefArgs& arguments, 
						CefReturn retval, CefString& exception) OVERRIDE {
		DKLog("DKCefV8Handler::Execute()\n", DKDEBUG);
		if(!functions[name]) {
			DKLog("DKCefV8Handler::Execute("+DKString(name)+") not registered\n", DKWARN);
			return false;
		}
		if(!functions[name](arguments, retval)){
			DKLog("DKCefV8Handler::Execute("+DKString(name)+") failed\n", DKERROR);
			return false;
		}
		return true;
	}
	
	/////////////////////////////////
	static void AttachFunctions()
	{
		if(!object){
			DKLog("DKCefV8Handler::AttachFunctions(): DKCefApp::OnContextCreated() has not been called yet. \n", DKERROR);
			return;
		}

#ifdef MAC
		typedef std::map<DKString, boost::function2<bool, CefArgs, CefReturn> >::iterator it_type;
#else
		typedef std::map<DKString, boost::function<bool (CefArgs, CefReturn)>>::iterator it_type;
#endif
		for(it_type iterator = functions.begin(); iterator != functions.end(); iterator++) {
			CefRefPtr<CefV8Value> value = CefV8Value::CreateFunction(iterator->first.c_str(), instance);
			object->SetValue(iterator->first.c_str(), value, V8_PROPERTY_ATTRIBUTE_NONE);
		}	
	}

	//////////////////////////////////////////////////////////////////////////////////
	static void AttachFunction(const DKString& name, bool (*func)(CefArgs, CefReturn))
	{
		//NOTE: stoes the function, it will be attached when OnContextCreated is called.
		DKLog("DKCefV8Handler::AttachFunction("+name+")\n", DKDEBUG);
		///if(!handler){
			//DKLog("DKCefApp::AttachFunction("+name+"): handler invalid \n", DKWARN);
			//return;
		//}
		functions[name] = boost::bind(func, _1, _2);
		if(object){
			CefRefPtr<CefV8Value> value = CefV8Value::CreateFunction(name.c_str(), instance);
			object->SetValue(name.c_str(), value, V8_PROPERTY_ATTRIBUTE_NONE);
		}
		if(!functions[name]){
			DKLog("DKCefV8Handler::AttachFunctions()("+name+"): failed to register function \n", DKERROR);
			return;
		}	
	}
	
	static CefRefPtr<CefV8Value> object;
	

	IMPLEMENT_REFCOUNTING(DKCefV8Handler);
};

///////////////////////////////////////////////////////////////////////////////////////////////
class DKCefApp : public CefApp, public CefBrowserProcessHandler, public CefRenderProcessHandler
{
public:

	CefRefPtr<DKCefV8Handler> handler;
	
	virtual CefRefPtr<CefBrowserProcessHandler> GetBrowserProcessHandler() OVERRIDE { return this; }
	virtual CefRefPtr<CefRenderProcessHandler> GetRenderProcessHandler() OVERRIDE { return this; }

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	virtual void OnBeforeCommandLineProcessing(const CefString& process_type, CefRefPtr<CefCommandLine> command_line)
	{
		DKLog("DKCefApp::OnBeforeCommandLineProcessing()\n", DKDEBUG);
		
		command_line->AppendSwitchWithValue("enable-system-flash", "1");
		command_line->AppendSwitchWithValue("allow-file-access-from-files", "1");
		command_line->AppendSwitchWithValue("disable-gpu", "1");
		command_line->AppendSwitchWithValue("disable-gpu-compositing", "1");
		command_line->AppendSwitchWithValue("ignore-gpu-blacklist", "1");
		command_line->AppendSwitchWithValue("remote-debugging-port", "2393");
		command_line->AppendSwitchWithValue("disable-web-security", "1");
		command_line->AppendSwitchWithValue("no-proxy-server", "1");
		command_line->AppendSwitchWithValue("enable-webgl", "1");
		//command_line->AppendSwitchWithValue("no-sandbox", "1");
		//command_line->AppendSwitchWithValue("renderer-process-limit", "1");
		//command_line->AppendSwitchWithValue("enable-begin-frame-scheduling", "1"); //Breaks Popups
#ifdef LINUX
		command_line->AppendSwitchWithValue("ppapi-flash-version", "25.0.0.127");
		command_line->AppendSwitchWithValue("ppapi-flash-path", "/usr/lib/pepperflashplugin-nonfree/libpepflashplayer.so");
#endif

		handler = new DKCefV8Handler();	
		DKCreate("DKCefV8");
	}

	/////////////////////////////////////
	virtual void OnContextInitialized()
	{
		DKLog("DKCefApp::OnContextInitialized()\n", DKDEBUG);
	
		//DKString pp = DKFile::local_assets + "cef/plugins"; 
		//DKString flash = pp + "/pepflashplayer32_19_0_0_185.dll";
	
		//FIXME
		//CefAddWebPluginDirectory(CefString(pp));
	
		//CefAddWebPluginPath(CefString(flash));
		CefRefreshWebPlugins();
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	virtual void OnContextCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context) OVERRIDE
	{
		DKLog("DKCefApp::OnContextCreated()\n", DKDEBUG);	
		DKCefV8Handler::object = context->GetGlobal(); // Retrieve the context's window object.
	    DKCefV8Handler::AttachFunctions();
	}

	IMPLEMENT_REFCOUNTING(DKCefApp);
};



#endif //DKCefApp_H