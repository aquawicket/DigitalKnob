#pragma once
#ifndef DKCefApp_H
#define DKCefApp_H
#include <boost/function.hpp>
#include <boost/bind.hpp>
#include <include/cef_app.h>

typedef CefV8ValueList CefArgs;
typedef CefRefPtr<CefV8Value>& CefReturn;
class DKCefApp;

#ifdef MAC
typedef std::map<DKString, boost::function2<bool, CefArgs, CefReturn> >::iterator it_type;
#else
typedef std::map<DKString, boost::function<bool (CefArgs, CefReturn)>>::iterator it_type;
#endif

////////////
class DKV8
{
public:
	//////////////////////////////////////////////////////////////////////////////////
	static void AttachFunction(const DKString& name, bool (*func)(CefArgs, CefReturn))
	{
		//NOTE: stoes the function, it will be attached when OnContextCreated is called.
		printf("DKV8::AttachFunction()\n");
		
		functions[name] = boost::bind(func, _1, _2);
		if(!functions[name]){
			printf("DKV8::AttachFunctions()(): failed to register function \n");
			return;
		}	
	}
	
	////////////////////////
	static void GetFunctions(CefRefPtr<CefBrowser> browser)
	{
		printf("DKV8::GetFunctions()\n");
		CefRefPtr<CefProcessMessage> msg = CefProcessMessage::Create("GetFunctions");
		CefRefPtr<CefListValue> args = msg->GetArgumentList();
		int i=0;
		for(it_type iterator = functions.begin(); iterator != functions.end(); iterator++) {
			//printf("%s\n", iterator->first.c_str());
			args->SetString(i, iterator->first.c_str()); ///////////Get function names
			i++;
		}
		browser->SendProcessMessage(PID_RENDERER, msg);
	}
	
	////////////////////////
	static void Execute(std::string func)
	{
		printf("DKV8::Execute(%s)\n", func.c_str());
		if(!functions[func]) {
			printf("DKCefV8Handler::Execute(): %s not registered\n", func.c_str());
			return;
		}
		//if(!functions[name](arguments, retval)){
		//	printf("DKCefV8Handler::Execute() failed\n");
		//	return false;
		//}
	}

#ifdef MAC
	static std::map<DKString, boost::function2<bool, CefArgs, CefReturn> > functions;
#else
	static std::map<DKString, boost::function<bool (CefArgs, CefReturn)>> functions;
#endif
};

//////////////////////////////////////////
class DKCefV8Handler : public CefV8Handler
{
public:
	DKCefV8Handler(){ printf("DKCefV8Handler::DKCefV8Handler()\n"); }
	CefRefPtr<CefBrowser> browser;
	
	virtual bool Execute(const CefString& name, CefRefPtr<CefV8Value> object, const CefArgs& arguments, CefReturn retval, CefString& exception) OVERRIDE 
	{
		std::string func = name;
		printf("DKCefV8Handler::Execute(%s)\n", func.c_str());
		CefRefPtr<CefProcessMessage> msg = CefProcessMessage::Create("Execute");
		CefRefPtr<CefListValue> args = msg->GetArgumentList();
		args->SetString(0, name);
		browser->SendProcessMessage(PID_BROWSER, msg);
		return true;
	}
	
	void SetBrowser(CefRefPtr<CefBrowser> _browser)
	{
		browser = _browser;
	}
	
	IMPLEMENT_REFCOUNTING(DKCefV8Handler);
};

///////////////////////////////////////////////////////////////////////////////////////////////
class DKCefApp : public CefApp, public CefBrowserProcessHandler, public CefRenderProcessHandler
{
public:
	CefRefPtr<DKCefV8Handler> v8handler = NULL;
	CefRefPtr<CefV8Value> ctx = NULL;
	std::vector<std::string> funcs;
	virtual CefRefPtr<CefBrowserProcessHandler> GetBrowserProcessHandler() OVERRIDE { return this; }
	virtual CefRefPtr<CefRenderProcessHandler> GetRenderProcessHandler() OVERRIDE { return this; }

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	virtual void OnBeforeCommandLineProcessing(const CefString& process_type, CefRefPtr<CefCommandLine> command_line)
	{
		printf("DKCefApp::OnBeforeCommandLineProcessing()\n");
		
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

		if(!v8handler){
			printf("Creating v8handler\n");
			v8handler = new DKCefV8Handler();
		}
	}

	///////////////////////////////////////////////////
	virtual void OnBrowserCreated(CefRefPtr< CefBrowser > browser) 
	{
		printf("DKCefApp::OnBrowserCreated()\n");
		v8handler->SetBrowser(browser);
		CefRefPtr<CefProcessMessage> msg = CefProcessMessage::Create("GetFunctions");
		CefRefPtr<CefListValue> args = msg->GetArgumentList(); // Retrieve the argument list object.
		browser->SendProcessMessage(PID_BROWSER, msg);
	}
	
	/////////////////////////////////////
	virtual void OnContextInitialized()
	{
		printf("DKCefApp::OnContextInitialized()\n");
		CefRefreshWebPlugins();
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	virtual void OnContextCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context) OVERRIDE
	{
		printf("OnContextCreated\n");
		if(!ctx){
			printf("Creating ctx\n");
			ctx = context->GetGlobal();
		}
		
		for(int i=0; i<funcs.size(); i++){
			CefRefPtr<CefV8Value> value = CefV8Value::CreateFunction(funcs[i].c_str(), v8handler);
			ctx->SetValue(funcs[i].c_str(), value, V8_PROPERTY_ATTRIBUTE_NONE);
			funcs.pop_back();
			//printf("registered: %s \n", funcs[i].c_str());
		}
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	virtual bool OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefProcessId source_process, CefRefPtr<CefProcessMessage> message) 
	{
		//printf("DKCefApp::OnProcessMessageReceived()\n");
		if(!v8handler){
			printf("DKCefApp::OnProcessMessageReceived(): v8handler invalid\n");
			return false;
		}
		if(message->GetName() == "GetFunctions"){
			printf("DKCefApp::OnProcessMessageReceived(GetFunctions)\n");
			CefRefPtr<CefListValue> args = message->GetArgumentList();
			for(int i=0; i<args->GetSize(); i++){
				CefString string = args->GetString(i);
				funcs.push_back(std::string(string));
			}
		}	
	}

	IMPLEMENT_REFCOUNTING(DKCefApp);
};



#endif //DKCefApp_H