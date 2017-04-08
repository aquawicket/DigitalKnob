#pragma once
#ifndef DKCefApp_H
#define DKCefApp_H
#include <boost/function.hpp>
#include <boost/bind.hpp>
#include <include/cef_app.h>

typedef CefRefPtr<CefListValue> CefArgs;
typedef CefRefPtr<CefListValue> CefReturn;
class DKCefApp;
class DKCefV8Handler;

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
		printf("DKV8::AttachFunction(%s)\n", name.c_str());
		
		functions[name] = boost::bind(func, _1, _2);
		if(!functions[name]){
			printf("DKV8::AttachFunctions(%s): failed to register function\n", name.c_str());
			return;
		}
		
		//if(_browser){
		//  printf("DKV8::AttachFunction(): _browser invalid\n");
		//  return; 
		//}
		//CefRefPtr<CefProcessMessage> msg = CefProcessMessage::Create("AttachFunction");
		//CefRefPtr<CefListValue> args = msg->GetArgumentList();
		//args->SetString(0, name.c_str());
		//_browser->SendProcessMessage(PID_RENDERER, msg);
		if(!DKV8::ctx){
			printf("DKV8::AttachFunction(): ctx invalid\n");
			return;
		}
		CefRefPtr<CefV8Value> value = CefV8Value::CreateFunction(name.c_str(), DKV8::v8handler);
		DKV8::ctx->SetValue(name.c_str(), value, V8_PROPERTY_ATTRIBUTE_NONE);
		printf("registered: %s\n", name.c_str());
	}
	
	///////////////////////////////////////////////////////
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
	
	//////////////////////////////////////////////////////////////////////////////////////////////////
	static void Execute(CefRefPtr<CefBrowser> browser, std::string func, CefRefPtr<CefListValue> args)
	{
		_browser = browser;
		//printf("DKV8::Execute(%s)\n", func.c_str());
		if(!functions[func]) {
			printf("DKCefV8Handler::Execute(): %s not registered\n", func.c_str());
			return;
		}

		printf("%s(", func.c_str());
		for(unsigned int i=0; i<args->GetSize(); i++){
			if(args->GetType(i) == VTYPE_STRING){
			      printf("%s,", std::string(args->GetString(i)).c_str());
			}
			if(args->GetType(i) == VTYPE_INT){
			      printf("%d,", args->GetInt(i));
			}
		}
		printf(")\n");

		CefRefPtr<CefListValue> retval = CefListValue::Create();
		if(!functions[func](args,retval)){
			printf("DKCefV8Handler::Execute() failed\n");
			return;
		}
		
		CefRefPtr<CefProcessMessage> msg = CefProcessMessage::Create("retval");
		CefRefPtr<CefListValue> args2 = msg->GetArgumentList(); // Retrieve the argument list object.
		
		if(retval->GetType(0) == VTYPE_STRING){
		      //printf("retval = %s\n", std::string(retval->GetString(0)).c_str());
		      args2->SetString(0, retval->GetString(0));
		}
		else if(retval->GetType(0) == VTYPE_INT){
		      //printf("retval = %d\n", retval->GetInt(0));
		      args2->SetInt(0, retval->GetInt(0));
		}
		else if(retval->GetType(0) == VTYPE_BOOL){
		      //printf("retval = %d\n", retval->GetBool(0));
		      args2->SetBool(0, retval->GetBool(0));
		}
		else{
		      args2->SetBool(0, true);
		}
		
		browser->SendProcessMessage(PID_RENDERER, msg);
	}

	static CefRefPtr<CefBrowser> _browser;
	static CefRefPtr<DKCefV8Handler> v8handler;
	static CefRefPtr<CefV8Value> ctx;
	static bool singleprocess;
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
	//CefRefPtr<CefListValue> _retval = CefListValue::Create(); 
	
	virtual bool Execute(const CefString& name, CefRefPtr<CefV8Value> object, const CefV8ValueList& arguments, CefRefPtr<CefV8Value>& retval, CefString& exception) OVERRIDE 
	{
		std::string func = name;
		//printf("DKCefV8Handler::Execute(%s)\n", func.c_str());
		
		if(DKV8::singleprocess == true){ //Single process
			if(!DKV8::functions[name]) {
			printf("DKCefV8Handler::Execute(%s) not registered\n", func.c_str());
				return false;
			}

			printf("%s(", func.c_str());
			CefRefPtr<CefListValue> args = CefListValue::Create();
			for(unsigned int i=0; i<arguments.size(); i++){
				if(arguments[i]->IsString()){
					args->SetString(i, arguments[i]->GetStringValue());
					printf("%s,", std::string(args->GetString(i)).c_str());
				}
				if(arguments[i]->IsInt()){
					args->SetInt(i, arguments[i]->GetIntValue());
					printf("%d,", args->GetInt(i));
				}
				if(arguments[i]->IsBool()){
					args->SetBool(i, arguments[i]->GetBoolValue());
					printf("%d,", args->GetBool(i));
				}
			}
			printf(")\n");

			CefRefPtr<CefListValue> rval = CefListValue::Create();
			if(!DKV8::functions[name](args, rval)){
				printf("DKCefV8Handler::Execute(%s) failed\n", func.c_str());
				return false;
			}

			if(rval->GetType(0) == VTYPE_STRING){
				  retval = CefV8Value::CreateString(rval->GetString(0));
				  printf("retval = %s\n", std::string(retval->GetStringValue()).c_str());
			}
			else if(rval->GetType(0) == VTYPE_INT){
			      retval = CefV8Value::CreateInt(rval->GetInt(0));
				  printf("retval = %d\n", retval->GetIntValue());
			}
			else if(rval->GetType(0) == VTYPE_BOOL){
			      retval = CefV8Value::CreateBool(rval->GetBool(0));
				  printf("retval = %d\n", retval->GetBoolValue());
			}
			else{
				retval = CefV8Value::CreateNull();
				printf("retval = NULL\n");
			}
		}
		else{ //Multi process
			//_retval->Clear();			
			std::string exec = "CallFunc("+func+")";
			CefRefPtr<CefProcessMessage> msg = CefProcessMessage::Create(exec.c_str());

			CefRefPtr<CefListValue> args = msg->GetArgumentList();
			for(unsigned int i=0; i<arguments.size(); i++){
				if(arguments[i]->IsString()){
					args->SetString(i, arguments[i]->GetStringValue());
				}
				if(arguments[i]->IsInt()){
					args->SetInt(i, arguments[i]->GetIntValue());
				}
				if(arguments[i]->IsBool()){
					args->SetBool(i, arguments[i]->GetBoolValue());
				}
			}
			browser->SendProcessMessage(PID_BROWSER, msg);
		}
			
		//while(!_retval->GetSize()){}
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
	//CefRefPtr<DKCefV8Handler> v8handler = NULL;
	//CefRefPtr<CefV8Value> ctx = NULL;
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

		//if(!DKV8::v8handler){
			printf("Creating v8handler\n");
			DKV8::v8handler = new DKCefV8Handler();
		//}
	}

	///////////////////////////////////////////////////
	virtual void OnBrowserCreated(CefRefPtr< CefBrowser > browser) 
	{
		printf("DKCefApp::OnBrowserCreated()\n");
		DKV8::_browser = browser;
		DKV8::v8handler->SetBrowser(browser);
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
		//if(!DKV8::ctx){
			printf("Creating ctx\n");
			DKV8::ctx = context->GetGlobal();
		//}
		
		for(unsigned int i=0; i<funcs.size(); i++){
			CefRefPtr<CefV8Value> value = CefV8Value::CreateFunction(funcs[i].c_str(), DKV8::v8handler);
			DKV8::ctx->SetValue(funcs[i].c_str(), value, V8_PROPERTY_ATTRIBUTE_NONE);
			printf("registered: %s\n", funcs[i].c_str());
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	virtual bool OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefProcessId source_process, CefRefPtr<CefProcessMessage> message) 
	{
		//printf("DKCefApp::OnProcessMessageReceived()\n");
		if(!DKV8::v8handler){
			printf("DKCefApp::OnProcessMessageReceived(): v8handler invalid\n");
			return false;
		}
		if(message->GetName() == "GetFunctions"){
			printf("DKCefApp::OnProcessMessageReceived(GetFunctions)\n");
			CefRefPtr<CefListValue> args = message->GetArgumentList();
			for(unsigned int i=0; i<args->GetSize(); i++){
				CefString string = args->GetString(i);
				funcs.push_back(std::string(string));
			}
		}
		if(message->GetName() == "AttachFunction"){
			printf("DKCefApp::OnProcessMessageReceived(AttachFunction)\n");
			CefRefPtr<CefListValue> args = message->GetArgumentList();
			CefString func = args->GetString(0);
			funcs.push_back(std::string(func));
			
			CefRefPtr<CefV8Value> value = CefV8Value::CreateFunction(func.c_str(), DKV8::v8handler);
			DKV8::ctx->SetValue(func.c_str(), value, V8_PROPERTY_ATTRIBUTE_NONE);
			printf("registered: %s\n", func.c_str());
		}
		if(message->GetName() == "retval"){
			printf("DKCefApp::OnProcessMessageReceived(retval)\n");
			CefRefPtr<CefListValue> retval = message->GetArgumentList();

			if(retval->GetType(0) == VTYPE_STRING){
			      printf("retval = %s\n", std::string(retval->GetString(0)).c_str());
			      //v8handler->_retval->SetString(0, retval->GetString(0));
			}
			if(retval->GetType(0) == VTYPE_INT){
			      printf("retval = %d\n", retval->GetInt(0));
			      //v8handler->_retval->SetInt(0, retval->GetInt(0));
			}
			if(retval->GetType(0) == VTYPE_BOOL){
			      printf("retval = %d\n", retval->GetBool(0));
			      //v8handler->_retval->SetBool(0, retval->GetBool(0));
			}	
		}
		return true;
	}

	IMPLEMENT_REFCOUNTING(DKCefApp);
};



#endif //DKCefApp_H