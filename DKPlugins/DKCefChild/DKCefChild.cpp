//#include "DKCefChild/DKCefChild.h"
#include "DKCefChild.h"

//#ifndef LINUX
//#include "include/cef_sandbox_win.h"
//#endif

CefRefPtr<CefListValue> DKCefV8Handler::myRetval;

int main(int argc, char* argv[]){
	printf("[cefchild] main()\n");
#ifdef WIN32
	CefMainArgs main_args;
#else
	CefMainArgs main_args(argc, argv);
#endif
//  void* sandbox_info = NULL;
//#ifndef LINUX
//	CefScopedSandboxInfo scoped_sandbox;
//	sandbox_info = scoped_sandbox.sandbox_info();
//#endif
	CefRefPtr<DKCefApp> app(new DKCefApp);
	return CefExecuteProcess(main_args, app.get(), NULL);
	//return CefExecuteProcess(main_args, app.get(), sandbox_info);
}

bool DKCefV8Handler::Execute(const CefString& name, CefRefPtr<CefV8Value> object, const CefV8ValueList& arguments, CefRefPtr<CefV8Value>& retval, CefString& exception){
	std::string func = name;
	std::string text = "DKCefV8Handler::Execute("+func+", object, arguments, retval, exception)\n";
	printf(text.c_str());
	CefRefPtr<CefProcessMessage> msg = CefProcessMessage::Create(func.c_str());
	CefRefPtr<CefListValue> args = msg->GetArgumentList(); // Retrieve the argument list object.
	std::string str = func.c_str();
	str += "(";
	for(unsigned int i=0; i<arguments.size(); i++){
		if(arguments[i]->IsBool()){
			args->SetBool(i, arguments[i]->GetBoolValue());
			str += args->GetBool(i);
		}
		if(arguments[i]->IsDouble()){
			args->SetInt(i, arguments[i]->GetDoubleValue());
			str += args->GetDouble(i);
		}
		if(arguments[i]->IsInt()){
			args->SetInt(i, arguments[i]->GetIntValue());
			str += args->GetInt(i);
		}
		if(arguments[i]->IsNull()){
			args->SetNull(i);
			str += "NULL";
		}
		if(arguments[i]->IsString()){
			args->SetString(i, arguments[i]->GetStringValue());
			str += std::string(args->GetString(i)).c_str();
		}
		if(i < arguments.size() - 1)
			str += ",";
	}
	str += ")";
	printf(str.c_str());
	printf("\n");
	
	//Here we send off the function to execute over in the app.
	//How do we get the retval to fufill this;
	//Synchronous 
	//is there a way to block this until a return value is available?
	/*
	while(!myRetval){
		
	}
	printf("myRetval has some value now\n");
	*/

	//browser->SendProcessMessage(PID_RENDERER, msg); //FIXME

	/*

	//Transfer retun value into &retval
	if(myRetval->GetType(0) == VTYPE_STRING){
		retval = CefV8Value::CreateString(myRetval->GetString(0));
		//printf("retval = %s\n", std::string(retval->GetStringValue()).c_str());
	}
	else if(myRetval->GetType(0) == VTYPE_INT){
		retval = CefV8Value::CreateInt(myRetval->GetInt(0));
		//printf("retval = %d\n", retval->GetIntValue());
	}
	else if(myRetval->GetType(0) == VTYPE_BOOL){
		retval = CefV8Value::CreateBool(myRetval->GetBool(0));
		//printf("retval = %d\n", retval->GetBoolValue());
	}
	else{
		retval = CefV8Value::CreateNull();
		//printf("retval = NULL\n");
	}
	*/
	return true;
}

void DKCefV8Handler::SetBrowser(CefRefPtr<CefBrowser> _browser){
	std::string text = "DKCefV8Handler::SetBrowser()\n";
	printf(text.c_str());
	browser = _browser;
}




void DKCefApp::OnBeforeCommandLineProcessing(const CefString& process_type, CefRefPtr<CefCommandLine> command_line){
#ifndef DEBUG
	CEF_REQUIRE_UI_THREAD();
#endif
#ifndef DKCefChild
	printf("[cefchild] DKCefApp::OnBeforeCommandLineProcessing()\n");
	if(same(DKV8::multi_process, "OFF"))
		command_line->AppendSwitchWithValue("single-process", "1");
	if(same(DKV8::enable_system_flash, "ON"))
		command_line->AppendSwitchWithValue("enable-system-flash", "1");
	//if(same(DKV8::allow_file_access_from_files, "ON"))
		command_line->AppendSwitchWithValue("allow-file-access-from-files", "1");
	if(same(DKV8::disable_gpu, "ON"))
		command_line->AppendSwitchWithValue("disable-gpu", "1");
	if(same(DKV8::disable_gpu_compositing, "ON"))
		command_line->AppendSwitchWithValue("disable-gpu-compositing", "1");
	if(same(DKV8::ignore_gpu_blacklist, "ON"))
		command_line->AppendSwitchWithValue("ignore-gpu-blacklist", "1");
	if(!DKV8::remote_debugging_port.empty())
		command_line->AppendSwitchWithValue("remote-debugging-port", DKV8::remote_debugging_port.c_str());
	if(same(DKV8::disable_web_security, "ON"))
		command_line->AppendSwitchWithValue("disable-web-security", "1");
	if(!same(DKV8::no_proxy_server, "ON"))
		command_line->AppendSwitchWithValue("no-proxy-server", "1");
	if(same(DKV8::enable_webgl, "ON"))
		command_line->AppendSwitchWithValue("enable-webgl", "1");
	if(same(DKV8::sandbox, "OFF"))
		command_line->AppendSwitchWithValue("no-sandbox", "1");
	if(same(DKV8::renderer_process_limit, "ON"))
		command_line->AppendSwitchWithValue("renderer-process-limit", "1");
	if(same(DKV8::enable_begin_frame_scheduling, "ON"))
		command_line->AppendSwitchWithValue("enable-begin-frame-scheduling", "1"); //Breaks Popups
	if(same(DKV8::enable_gpu, "ON"))
		command_line->AppendSwitchWithValue("enable-gpu", "1");
	command_line->AppendSwitchWithValue("disable-extensions", "1");
#ifdef LINUX
	command_line->AppendSwitchWithValue("ppapi-flash-version", "25.0.0.127");
	command_line->AppendSwitchWithValue("ppapi-flash-path", "/usr/lib/pepperflashplugin-nonfree/libpepflashplayer.so");
#endif //LINUX
#endif //!DKCefChild
	cefV8Handler = new DKCefV8Handler();
}

void DKCefApp::OnBrowserCreated(CefRefPtr<CefBrowser> browser){
#ifndef DEBUG
	CEF_REQUIRE_UI_THREAD();
#endif
	printf("[cefchild] DKCefApp::OnBrowserCreated()\n");
	cefV8Handler->SetBrowser(browser);
	CefRefPtr<CefProcessMessage> msg = CefProcessMessage::Create("OnBrowserCreated");
	CefRefPtr<CefListValue> args = msg->GetArgumentList(); // Retrieve the argument list object.
	//browser->SendProcessMessage(PID_RENDERER, msg); //FIXME
}

void DKCefApp::OnContextInitialized(){
#ifndef DEBUG
	CEF_REQUIRE_UI_THREAD();
#endif
	printf("[cefchild] DKCefApp::OnContextInitialized()\n");
	//CefRefreshWebPlugins(); //FIXME
}

void DKCefApp::OnContextCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context){
#ifndef DEBUG
	CEF_REQUIRE_UI_THREAD();
#endif
	printf("[cefchild] DKCefApp::OnContextCreated()\n");
	if(!cefV8Handler){
		printf("DKCefApp::OnContextCreated(): v8handler cefV8Handler\n");
		return;
	}
	//cefV8Handler->SetBrowser(browser);
	CefRefPtr<CefV8Value> ctx = context->GetGlobal();
	//Send "OnContextCreated" message to main exe
	CefRefPtr<CefProcessMessage> msg = CefProcessMessage::Create("OnContextCreated");
	CefRefPtr<CefListValue> args = msg->GetArgumentList(); // Retrieve the argument list object.
	//browser->SendProcessMessage(PID_RENDERER, msg); //FIXME
	//Load a TestFunction
	std::string func = "TestFunction";
	CefRefPtr<CefV8Value> value = CefV8Value::CreateFunction(func.c_str(), cefV8Handler);
	if(!ctx->SetValue(func.c_str(), value, V8_PROPERTY_ATTRIBUTE_NONE))
		printf("DKCefApp::OnContextCreated(): ctx->SetValue() failed\n");
	/*
	//Load all of the c++ functions into the V8 context.
	for(unsigned int i=0; i<funcs.size(); i++){
		CefRefPtr<CefV8Value> value = CefV8Value::CreateFunction(funcs[i].c_str(), cefV8Handler);
		if(!ctx->SetValue(funcs[i].c_str(), value, V8_PROPERTY_ATTRIBUTE_NONE))
			printf("DKCefApp::OnContextCreated(): ctx->SetValue() failed\n");
	}
	*/
}

bool DKCefApp::OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefProcessId source_process, CefRefPtr<CefProcessMessage> message){
#ifndef DEBUG
	CEF_REQUIRE_UI_THREAD();
#endif
	std::string name = std::string(message->GetName());
	printf("[cefchild] DKCefApp::OnProcessMessageReceived(");
	printf(name.c_str());
	printf(")\n");
	if(!cefV8Handler){
		printf("DKCefApp::OnProcessMessageReceived(): cefV8Handler invalid\n");
		return false;
	}
	if(message->GetName() == "GetFunctions"){
		printf("###### FUNCTIONS ######\n");
		CefRefPtr<CefListValue> args = message->GetArgumentList();
		for(unsigned int i=0; i<args->GetSize(); i++){
			CefString func = args->GetString(i);
			printf(std::string(func).c_str());
			funcs.push_back(std::string(func));
			printf("\n");
		}
	}
	if(message->GetName() == "AttachFunction"){
		//TODO
	}
	if(message->GetName() == "retval"){
		printf("retval\n");
		CefRefPtr<CefListValue> args = message->GetArgumentList();
		std::string text = "retval = ";
		if(args->GetType(0) == VTYPE_STRING)
			text += std::string(args->GetString(0));
		if(args->GetType(0) == VTYPE_INT)
			text += "int";
		if(args->GetType(0) == VTYPE_BOOL){
			if(!args->GetBool(0)){
				text += "false";
			}
			else{
				text += "true";
			}
		}
		printf(text.c_str());
		cefV8Handler->myRetval = args;
	}
	/*
	if(message->GetName() == "AttachFunction"){
	//printf("DKCefApp::OnProcessMessageReceived(AttachFunction)\n");
	CefRefPtr<CefListValue> args = message->GetArgumentList();
	CefString func = args->GetString(0);
	DKV8::funcs.push_back(std::string(func));
	CefRefPtr<CefV8Value> value = CefV8Value::CreateFunction(func.c_str(), DKV8::v8handler);
	DKV8::ctx->SetValue(func.c_str(), value, V8_PROPERTY_ATTRIBUTE_NONE);
	//printf("registered: %s\n", func.c_str());
	}
	if(message->GetName() == "retval"){
		//printf("DKCefApp::OnProcessMessageReceived(retval)\n");
		CefRefPtr<CefListValue> retval = message->GetArgumentList();

		if(retval->GetType(0) == VTYPE_STRING){
			//printf("retval = %s\n", std::string(retval->GetString(0)).c_str());
			//v8handler->_retval->SetString(0, retval->GetString(0));
		}
		if(retval->GetType(0) == VTYPE_INT){
			//printf("retval = %d\n", retval->GetInt(0));
			//v8handler->_retval->SetInt(0, retval->GetInt(0));
		}
		if(retval->GetType(0) == VTYPE_BOOL){
			//printf("retval = %d\n", retval->GetBool(0));
			//v8handler->_retval->SetBool(0, retval->GetBool(0));
		}	
	}
	*/
	return true;
}