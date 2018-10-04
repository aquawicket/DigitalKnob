#include "DK/stdafx.h"
#include "DKCef/DKCefApp.h"

bool DKV8::singleprocess = true;
CefRefPtr<CefBrowser> DKV8::_browser = NULL;
CefRefPtr<DKCefV8Handler> DKV8::v8handler = NULL;
CefRefPtr<CefV8Value> DKV8::ctx = NULL;
#ifdef MAC
std::map<DKString, boost::function2<bool, CefArgs, CefReturn> > DKV8::functions;
#else
std::map<DKString, boost::function<bool(CefArgs, CefReturn)>> DKV8::functions;
#endif
std::vector<std::string> DKV8::funcs;

DKString DKV8::homepage;
DKString DKV8::multi_process;
DKString DKV8::sandbox;
DKString DKV8::log_severity;
DKString DKV8::multi_threaded_message_loop;
DKString DKV8::disable_gpu;
DKString DKV8::disable_gpu_compositing;
DKString DKV8::ignore_gpu_blacklist;
DKString DKV8::remote_debugging_port;
DKString DKV8::enable_system_flash;
DKString DKV8::enable_begin_frame_scheduling;
DKString DKV8::enable_webgl;
DKString DKV8::renderer_process_limit;
DKString DKV8::enable_gpu;
DKString DKV8::disable_web_security;
DKString DKV8::no_proxy_server;
//DKString DKV8::off_screen_rendering_enabled;


/////////////////////
void DKV8::SetFlags()
{
	DKLog("DKV8::SetFlags()\n", DKINFO);

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_HOMEPAGE]", homepage);
	DKLog("DKV8::homepage = "+homepage+"\n", DKINFO);

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_MULTIPROCESS]", multi_process);
	DKLog("DKV8::multi_process = "+multi_process+"\n", DKINFO);

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_SANDBOX]", sandbox);
	DKLog("DKV8::sandbox = "+sandbox+"\n", DKINFO);

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_LOGSEVERITY]", log_severity);
	DKLog("DKV8::log_severity = "+log_severity+"\n", DKINFO);

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_MULTI_THREADED_MESSAGE_LOOP]", multi_threaded_message_loop);
	DKLog("DKV8::multithreadedmessageloops = "+multi_threaded_message_loop+"\n", DKINFO);

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_DISABLE_GPU]", disable_gpu);
	DKLog("DKV8::disablegpu = "+disable_gpu+"\n", DKINFO);

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_DISABLE_GPU_COMPOSITING]", disable_gpu_compositing);
	DKLog("DKV8::disable_gpu_compositing = "+disable_gpu_compositing+"\n", DKINFO);

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_IGNORE_GPU_BLACKLIST]", ignore_gpu_blacklist);
	DKLog("DKV8::ignore_gpu_blacklist = "+ignore_gpu_blacklist+"\n", DKINFO);

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_ENABLE_SYSTEM_FLASH]", enable_system_flash);
	DKLog("DKV8::enable_system_flash = "+enable_system_flash+"\n", DKINFO);

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_ENABLE_BEGIN_FRAME_SCHEDULING]", enable_begin_frame_scheduling);
	DKLog("DKV8::enable_begin_frame_scheduling = "+enable_begin_frame_scheduling+"\n", DKINFO);

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_ENABLE_WEBGL]", enable_webgl);
	DKLog("DKV8::enable_webgl = "+enable_webgl+"\n", DKINFO);

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_RENDERER_PROCESS_LIMIT]", renderer_process_limit);
	DKLog("DKV8::renderer_process_limit = "+renderer_process_limit+"\n", DKINFO);

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_ENABLE_GPU]", enable_gpu);
	DKLog("DKV8::enable_gpu = "+enable_gpu+"\n", DKINFO);

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_DISABLE_WEB_SECURITY]", disable_web_security);
	DKLog("DKV8::disable_web_security = "+disable_web_security+"\n", DKINFO);

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_NO_PROXY_SERVER]", no_proxy_server);
	DKLog("DKV8::no_proxy_server = "+no_proxy_server+"\n", DKINFO);

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_REMOTE_DEBUGGING_PORT]", remote_debugging_port);
	DKLog("DKV8::remote_debugging_port = "+remote_debugging_port+"\n", DKINFO);

	//DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_OFF_SCREEN_RENDERING_ENABLED]", off_screen_rendering_enabled);
	//DKLog("DKV8::off_screen_rendering_enabled = "+off_screen_rendering_enabled+"\n", DKINFO);
}

/////////////////////////////////////////////////////////////////////////////////
bool DKV8::AttachFunction(const DKString& name, bool (*func)(CefArgs, CefReturn))
{
	//NOTE: this stores the function, it will be attached when OnContextCreated is called.
	DKLog("DKV8::AttachFunction("+name+")\n", DKDEBUG);

	functions[name] = boost::bind(func, _1, _2);
	if(!functions[name]){
		printf("DKV8::AttachFunctions(%s): failed to register function\n", name.c_str());
		return false;
	}

	DKV8::funcs.push_back(name);
	//DKV8::funcs2.insert(std::make_pair(name, false));

	if(!DKV8::ctx){ //multi process will fail
		DKLog("DKV8::AttachFunction(): DKV8::ctx is invalid\n", DKWARN);
		return false;
	}

	CefRefPtr<CefV8Value> value = CefV8Value::CreateFunction(name.c_str(), DKV8::v8handler);
	if(!DKV8::ctx->SetValue(name.c_str(), value, V8_PROPERTY_ATTRIBUTE_NONE)){ return false; }

	DKLog("DKV8::AttachFunction(): registered: "+name+"\n", DKINFO);
	return true;
}

//////////////////////////////////////////////////////
bool DKV8::GetFunctions(CefRefPtr<CefBrowser> browser)
{
	DKLog("DKV8::GetFunctions()\n", DKINFO);
	CefRefPtr<CefProcessMessage> msg = CefProcessMessage::Create("GetFunctions");
	CefRefPtr<CefListValue> args = msg->GetArgumentList();
	int i=0;
	for(it_type iterator = functions.begin(); iterator != functions.end(); iterator++) {
		//printf("%s\n", iterator->first.c_str());
		args->SetString(i, iterator->first.c_str()); ///////////Get function names
		i++;
	}
	browser->SendProcessMessage(PID_RENDERER, msg);
	return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////
bool DKV8::Execute(CefRefPtr<CefBrowser> browser, std::string func, CefRefPtr<CefListValue> args)
{
	DKLog("DKV8::Execute(browser, "+func+", args)\n", DKERROR); //do we ever call this?
	DKUtil::CallExit(); //TEST

	_browser = browser;
	DKLog("DKV8::Execute("+func+")\n", DKDEBUG);
	if(!functions[func]) {
		printf("DKCefV8Handler::Execute(): %s not registered\n", func.c_str());
		return false;
	}

	/*
	//Print function call
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
	*/

	CefRefPtr<CefListValue> retval = CefListValue::Create();
	if(!functions[func](args,retval)){
		printf("DKCefV8Handler::Execute() failed\n");
		return false;
	}

	CefRefPtr<CefProcessMessage> msg = CefProcessMessage::Create("retval");
	CefRefPtr<CefListValue> args2 = msg->GetArgumentList();
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
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKCefV8Handler::Execute(const CefString& name, CefRefPtr<CefV8Value> object, const CefV8ValueList& arguments, CefRefPtr<CefV8Value>& retval, CefString& exception)
{
	std::string func = name;
	DKLog("DKCefV8Handler::Execute("+func+", object, arguments, retval, exception)\n", DKINFO);

	if(DKV8::singleprocess == true){ //Single process
		if(!DKV8::functions[name]) {
			printf("DKCefV8Handler::Execute(%s) not registered\n", func.c_str());
			return false;
		}

		//Transfer arguments and print function call
		//printf("%s(", func.c_str());
		CefRefPtr<CefListValue> args = CefListValue::Create();
		for(unsigned int i=0; i<arguments.size(); i++){
			if(arguments[i]->IsString()){
				args->SetString(i, arguments[i]->GetStringValue());
				//printf("%s,", std::string(args->GetString(i)).c_str());
			}
			if(arguments[i]->IsInt()){
				args->SetInt(i, arguments[i]->GetIntValue());
				//printf("%d,", args->GetInt(i));
			}
			if(arguments[i]->IsBool()){
				args->SetBool(i, arguments[i]->GetBoolValue());
				//printf("%d,", args->GetBool(i));
			}
		}
		//printf(")\n");

		CefRefPtr<CefListValue> rval = CefListValue::Create();
		if(!DKV8::functions[name](args, rval)){
			printf("DKCefV8Handler::Execute(%s) failed\n", func.c_str());
			return false;
		}

		//Transfer retrun value into &retval
		if(rval->GetType(0) == VTYPE_STRING){
			retval = CefV8Value::CreateString(rval->GetString(0));
			//printf("retval = %s\n", std::string(retval->GetStringValue()).c_str());
		}
		else if(rval->GetType(0) == VTYPE_INT){
			retval = CefV8Value::CreateInt(rval->GetInt(0));
			//printf("retval = %d\n", retval->GetIntValue());
		}
		else if(rval->GetType(0) == VTYPE_BOOL){
			retval = CefV8Value::CreateBool(rval->GetBool(0));
			//printf("retval = %d\n", retval->GetBoolValue());
		}
		else{
			retval = CefV8Value::CreateNull();
			//printf("retval = NULL\n");
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

///////////////////////////////////////////////////////////////
void DKCefV8Handler::SetBrowser(CefRefPtr<CefBrowser> _browser)
{
	DKLog("DKCefV8Handler::SetBrowser()\n", DKDEBUG);
	browser = _browser;
}

/*
/////////////////////////////////////////////////////////////////////////////////////////
bool DKCefApp::SendEvent(const DKString& id, const DKString& type, const DKString& value)
{
	DKLog("DKCefApp::SendEvent()\n", DKDEBUG);
	
	if(id.empty()){ return false; }
	if(same(id,"DKLog")){ return false; }
	if(type.empty()){ return false; }
	if(same(type,"second")){ return false; }
	if(has(type, "DKCef_")){ return false; }
	if(same(type, "keydown")){ return false; }
	if(same(type, "keypress")){ return false; }

	//CefRefPtr<CefFrame> frame = DKV8::v8handler->browser->GetMainFrame();
	//CefRefPtr<CefFrame> frame = DKV8::_browser->GetMainFrame();
	if(!frame){
		DKLog("DKCefApp::SendEvent("+id+","+type+","+value+"): frame invalid\n", DKWARN);
		return false;
	}
	DKString string = "DKSendEvent(\""+id+"\",\""+type+"\",\""+value+"\");";
	frame->ExecuteJavaScript(string.c_str(), frame->GetURL(), 0);
	return true;
}
*/

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DKCefApp::OnBeforeCommandLineProcessing(const CefString& process_type, CefRefPtr<CefCommandLine> command_line)
{
#ifndef DEBUG
	CEF_REQUIRE_UI_THREAD();
#endif
#ifndef DKCefChild
	DKLog("DKCefApp::OnBeforeCommandLineProcessing()\n", DKINFO);
	if(same(DKV8::multi_process, "OFF")){
		command_line->AppendSwitchWithValue("single-process", "1");
	}
	if(same(DKV8::enable_system_flash, "ON")){
		command_line->AppendSwitchWithValue("enable-system-flash", "1");
	}
	//if(same(DKV8::allow_file_access_from_files, "ON")){
	command_line->AppendSwitchWithValue("allow-file-access-from-files", "1");
	//}
	if(same(DKV8::disable_gpu, "ON")){
		command_line->AppendSwitchWithValue("disable-gpu", "1");
	}
	if(same(DKV8::disable_gpu_compositing, "ON")){
		command_line->AppendSwitchWithValue("disable-gpu-compositing", "1");
	}
	if(same(DKV8::ignore_gpu_blacklist, "ON")){
		command_line->AppendSwitchWithValue("ignore-gpu-blacklist", "1");
	}
	if(!DKV8::remote_debugging_port.empty()){
		command_line->AppendSwitchWithValue("remote-debugging-port", DKV8::remote_debugging_port.c_str());
	}
	if(same(DKV8::disable_web_security, "ON")){
		command_line->AppendSwitchWithValue("disable-web-security", "1");
	}
	if(!same(DKV8::no_proxy_server, "ON")){
		command_line->AppendSwitchWithValue("no-proxy-server", "1");
	}
	if(same(DKV8::enable_webgl, "ON")){
		command_line->AppendSwitchWithValue("enable-webgl", "1");
	}
	if(same(DKV8::sandbox, "OFF")){
		command_line->AppendSwitchWithValue("no-sandbox", "1");
	}
	if(same(DKV8::renderer_process_limit, "ON")){
		command_line->AppendSwitchWithValue("renderer-process-limit", "1");
	}
	if(same(DKV8::enable_begin_frame_scheduling, "ON")){
		command_line->AppendSwitchWithValue("enable-begin-frame-scheduling", "1"); //Breaks Popups
	}
	if(same(DKV8::enable_gpu, "ON")){
		command_line->AppendSwitchWithValue("enable-gpu", "1");
	}
	command_line->AppendSwitchWithValue("disable-extensions", "1");
#ifdef LINUX
	command_line->AppendSwitchWithValue("ppapi-flash-version", "25.0.0.127");
	command_line->AppendSwitchWithValue("ppapi-flash-path", "/usr/lib/pepperflashplugin-nonfree/libpepflashplayer.so");
#endif

#endif //!DKCefChild

	DKV8::v8handler = new DKCefV8Handler();
}

//////////////////////////////////////////////////////////////
void DKCefApp::OnBrowserCreated(CefRefPtr<CefBrowser> browser) 
{
#ifndef DEBUG
	CEF_REQUIRE_UI_THREAD();
#endif
	DKLog("DKCefApp::OnBrowserCreated()\n", DKINFO);
	DKV8::_browser = browser;
	DKV8::v8handler->SetBrowser(browser);
	CefRefPtr<CefProcessMessage> msg = CefProcessMessage::Create("GetFunctions");
	CefRefPtr<CefListValue> args = msg->GetArgumentList(); // Retrieve the argument list object.
	browser->SendProcessMessage(PID_RENDERER, msg);
}

/////////////////////////////////////
void DKCefApp::OnContextInitialized()
{
#ifndef DEBUG
	CEF_REQUIRE_UI_THREAD();
#endif
	DKLog("DKCefApp::OnContextInitialized()\n", DKINFO);
	CefRefreshWebPlugins();
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void DKCefApp::OnContextCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context)
{
#ifndef DEBUG
	CEF_REQUIRE_UI_THREAD();
#endif
	DKLog("DKCefApp::OnContextCreated()\n", DKINFO);

	//Load all of the c++ functions into the V8 context.
	DKV8::ctx = context->GetGlobal();
	for(unsigned int i=0; i<DKV8::funcs.size(); i++){
		CefRefPtr<CefV8Value> value = CefV8Value::CreateFunction(DKV8::funcs[i].c_str(), DKV8::v8handler);
		if(DKV8::ctx->SetValue(DKV8::funcs[i].c_str(), value, V8_PROPERTY_ATTRIBUTE_NONE)){
			DKLog("DKCefApp::OnContextCreated(): registered: "+DKV8::funcs[i]+"\n", DKDEBUG);
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool DKCefApp::OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefProcessId source_process, CefRefPtr<CefProcessMessage> message) 
{
#ifndef DEBUG
	CEF_REQUIRE_UI_THREAD();
#endif
	DKLog("DKCefApp::OnProcessMessageReceived("+DKString(message->GetName())+")\n", DKINFO);
	if(!DKV8::v8handler){
		DKLog("DKCefApp::OnProcessMessageReceived(): v8handler invalid\n", DKINFO);
		return false;
	}

	/*
	if(message->GetName() == "GetFunctions"){
	//printf("DKCefApp::OnProcessMessageReceived(GetFunctions)\n");
	CefRefPtr<CefListValue> args = message->GetArgumentList();
	for(unsigned int i=0; i<args->GetSize(); i++){
	CefString string = args->GetString(i);
	DKV8::funcs.push_back(std::string(string));
	}
	}
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