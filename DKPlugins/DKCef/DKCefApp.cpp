/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#include "DK/stdafx.h"
#include "DKCef/DKCefApp.h"
#include "DKCef/DKCef.h"


bool DKV8::singleprocess = true;
CefRefPtr<CefBrowser> DKV8::_browser = NULL;
CefRefPtr<DKCefV8Handler> DKV8::v8handler = NULL;
CefRefPtr<CefV8Value> DKV8::ctx = NULL;

//std::map<DKString, boost::function<bool(CefArgs, CefReturn)>> DKV8::functions;
std::map<DKString, std::function<bool(CefArgs, CefReturn)>> DKV8::functions;

std::vector<std::string> DKV8::funcs;

DKString DKV8::disable_gpu;
DKString DKV8::disable_gpu_compositing;
DKString DKV8::disable_web_security;
DKString DKV8::enable_begin_frame_scheduling;
DKString DKV8::enable_gpu;
DKString DKV8::enable_system_flash;
DKString DKV8::enable_webgl;
DKString DKV8::homepage;
DKString DKV8::ignore_gpu_blacklist;
DKString DKV8::log_severity;
DKString DKV8::multi_process;
DKString DKV8::multi_threaded_message_loop;
DKString DKV8::no_proxy_server;
DKString DKV8::remote_debugging_port;
DKString DKV8::renderer_process_limit;
DKString DKV8::sandbox;
//DKString DKV8::off_screen_rendering_enabled;

void DKV8::SetFlags(){
	DKDEBUGFUNC();
	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_HOMEPAGE]", homepage);
	DKINFO("DKV8::homepage = "+homepage+"\n");

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_MULTIPROCESS]", multi_process);
	DKINFO("DKV8::multi_process = "+multi_process+"\n");

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_SANDBOX]", sandbox);
	DKINFO("DKV8::sandbox = "+sandbox+"\n");

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_LOGSEVERITY]", log_severity);
	DKINFO("DKV8::log_severity = "+log_severity+"\n");

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_MULTI_THREADED_MESSAGE_LOOP]", multi_threaded_message_loop);
	DKINFO("DKV8::multithreadedmessageloops = "+multi_threaded_message_loop+"\n");

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_DISABLE_GPU]", disable_gpu);
	DKINFO("DKV8::disablegpu = "+disable_gpu+"\n");

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_DISABLE_GPU_COMPOSITING]", disable_gpu_compositing);
	DKINFO("DKV8::disable_gpu_compositing = "+disable_gpu_compositing+"\n");

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_IGNORE_GPU_BLACKLIST]", ignore_gpu_blacklist);
	DKINFO("DKV8::ignore_gpu_blacklist = "+ignore_gpu_blacklist+"\n");

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_ENABLE_SYSTEM_FLASH]", enable_system_flash);
	DKINFO("DKV8::enable_system_flash = "+enable_system_flash+"\n");

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_ENABLE_BEGIN_FRAME_SCHEDULING]", enable_begin_frame_scheduling);
	DKINFO("DKV8::enable_begin_frame_scheduling = "+enable_begin_frame_scheduling+"\n");

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_ENABLE_WEBGL]", enable_webgl);
	DKINFO("DKV8::enable_webgl = "+enable_webgl+"\n");

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_RENDERER_PROCESS_LIMIT]", renderer_process_limit);
	DKINFO("DKV8::renderer_process_limit = "+renderer_process_limit+"\n");

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_ENABLE_GPU]", enable_gpu);
	DKINFO("DKV8::enable_gpu = "+enable_gpu+"\n");

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_DISABLE_WEB_SECURITY]", disable_web_security);
	DKINFO("DKV8::disable_web_security = "+disable_web_security+"\n");

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_NO_PROXY_SERVER]", no_proxy_server);
	DKINFO("DKV8::no_proxy_server = "+no_proxy_server+"\n");

	DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_REMOTE_DEBUGGING_PORT]", remote_debugging_port);
	DKINFO("DKV8::remote_debugging_port = "+remote_debugging_port+"\n");

	//DKFile::GetSetting(DKFile::local_assets+"settings.txt", "[CEF_OFF_SCREEN_RENDERING_ENABLED]", off_screen_rendering_enabled);
	//DKINFO("DKV8::off_screen_rendering_enabled = "+off_screen_rendering_enabled+"\n");
}

bool DKV8::AttachFunction(const DKString& name, bool (*func)(CefArgs, CefReturn)){
	DKDEBUGFUNC(name, func);
	//FIXME - this is very unstable, not thread safe
	// 
	//multi process will fail
	if(DKV8::ctx){
		CefRefPtr<CefV8Value> value = CefV8Value::CreateFunction(name.c_str(), DKV8::v8handler);
		if(!DKV8::ctx->SetValue(name.c_str(), value, V8_PROPERTY_ATTRIBUTE_NONE))
			return DKERROR("DKV8::ctx->SetValue() failed");
		DKINFO("registered: "+name+"\n");
	}
	else{
		//NOTE: this stores the function, it will be attached when OnContextCreated is called.
		//functions[name] = boost::bind(func, boost::placeholders::_1, boost::placeholders::_2);
		functions[name] = std::bind(func, std::placeholders::_1, std::placeholders::_2);
		if(!functions[name])
			return DKERROR("failed to register function\n");
		DKV8::funcs.push_back(name);
	}
	return true;
}

bool DKV8::GetFunctions(CefRefPtr<CefBrowser> browser){
	DKDEBUGFUNC(browser);
	CefRefPtr<CefProcessMessage> msg = CefProcessMessage::Create("GetFunctions");
	CefRefPtr<CefListValue> args = msg->GetArgumentList();
	int i=0;
	for(it_type iterator = functions.begin(); iterator != functions.end(); iterator++) {
		//printf("%s\n", iterator->first.c_str());
		args->SetString(i, iterator->first.c_str()); // Get function names
		i++;
	}
#ifndef DEBUG
	//browser->SendProcessMessage(PID_RENDERER, msg); //FIXME
#endif
	return true;
}

//Multi process Execute
bool DKV8::Execute(CefRefPtr<CefBrowser> browser, std::string func, CefRefPtr<CefListValue> args) {
	DKDEBUGFUNC(browser, func, args);
	_browser = browser;
	if(!functions[func])
		return DKERROR("DKCefV8Handler::Execute(): "+func+" not registered\n");

	//TODO - print full function here
	CefRefPtr<CefListValue> rval = CefListValue::Create();
	if(!functions[func](args,rval))
		return DKERROR("DKCefV8Handler::Execute(): "+func+" failed\n");

	CefRefPtr<CefProcessMessage> msg = CefProcessMessage::Create("retval");
	CefRefPtr<CefListValue> args2 = msg->GetArgumentList();
	if(rval->GetType(0) == VTYPE_STRING)
		args2->SetString(0, rval->GetString(0));
	else if(rval->GetType(0) == VTYPE_INT)
		args2->SetInt(0, rval->GetInt(0));
	else if(rval->GetType(0) == VTYPE_BOOL)
		args2->SetBool(0, rval->GetBool(0));
	else
		args2->SetBool(0, true);
#ifndef DEBUG
	//browser->SendProcessMessage(PID_RENDERER, msg); //FIXME
#endif
	//FIXME - not sure how to send this back to a waiting sub-process
	return true;
}

//Single process Execute
bool DKCefV8Handler::Execute(const CefString& name, CefRefPtr<CefV8Value> object, const CefV8ValueList& arguments, CefRefPtr<CefV8Value>& retval, CefString& exception){
	DKDEBUGFUNC(name, object, arguments, retval, exception);
	//DK_UNUSED(exception);
	if(DKV8::singleprocess == true){ //Single process
		if(!DKV8::functions[name])
			return DKERROR(name.ToString()+" not registered\n");
		//Set the function arguments and show the function in log
		DKString text = name.ToString()+"(";
		CefRefPtr<CefListValue> args = CefListValue::Create();
		for(unsigned int i=0; i<arguments.size(); i++){
			if(arguments[i]->IsString()){
				args->SetString(i, arguments[i]->GetStringValue());
				text += DKString(args->GetString(i));
			}
			if(arguments[i]->IsInt()){
				args->SetInt(i, arguments[i]->GetIntValue());
				text += toString(args->GetInt(i));
			}
			if(arguments[i]->IsBool()){
				args->SetBool(i, arguments[i]->GetBoolValue());
				text += toString(args->GetBool(i));
			}
			if(arguments[i]->IsFunction()){
				text += arguments[i]->GetFunctionName();
				text += "()";
			}
			if(i < arguments.size() - 1){
				text += ",";
			}
		}
		text += ")";
		//DKINFO(text+"\n");

		CefRefPtr<CefListValue> rval = CefListValue::Create();
		if(!DKV8::functions[name](args, rval))
			return DKERROR(name.ToString()+"() failed\n");
		//Transfer retun value into &retval
		if(rval->GetType(0) == VTYPE_STRING){
			retval = CefV8Value::CreateString(rval->GetString(0));
			//DKINFO("retval = "+DKString(retval->GetStringValue())+"\n");
		}
		else if(rval->GetType(0) == VTYPE_INT){
			retval = CefV8Value::CreateInt(rval->GetInt(0));
			//DKINFO("retval = "+toString(retval->GetIntValue())+"\n");
		}
		else if(rval->GetType(0) == VTYPE_BOOL){
			retval = CefV8Value::CreateBool(rval->GetBool(0));
			//DKINFO("retval = "+toString(retval->GetBoolValue())+"\n");
		}
		else{
			retval = CefV8Value::CreateNull();
			//DKINFO("retval = NULL\n");
		}
	}
	return true;
}

void DKCefV8Handler::SetBrowser(CefRefPtr<CefBrowser> _browser){
	DKDEBUGFUNC(browser);
	browser = _browser;
}

/*
bool DKCefApp::SendEvent(const DKString& id, const DKString& type, const DKString& value){
	DKDEBUGFUNC(id, type, value);
	if(id.empty()){ return false; }
	if(same(id,"DKLog")){ return false; }
	if(type.empty()){ return false; }
	if(same(type,"second")){ return false; }
	if(has(type, "DKCef_")){ return false; }
	if(same(type, "keydown")){ return false; }
	if(same(type, "keypress")){ return false; }
	//CefRefPtr<CefFrame> frame = DKV8::v8handler->browser->GetMainFrame();
	//CefRefPtr<CefFrame> frame = DKV8::_browser->GetMainFrame();
	if(!frame)
		return DKERROR("frame invalid\n");
	DKString string = "DKSendEvent(\""+id+"\",\""+type+"\",\""+value+"\");";
	frame->ExecuteJavaScript(string.c_str(), frame->GetURL(), 0);
	return true;
}
*/

void DKCefApp::OnBeforeCommandLineProcessing(const CefString& process_type, CefRefPtr<CefCommandLine> command_line){
#ifdef DKCefChild
	return;
#endif
	DKDEBUGFUNC(process_type, command_line);

	if(!same(DKV8::multi_process, "ON"))
		command_line->AppendSwitchWithValue("single-process", "1");
	if(same(DKV8::enable_system_flash, "ON"))
		command_line->AppendSwitchWithValue("enable-system-flash", "1");
	//if(same(DKV8::allow_file_access_from_files, "ON")){
	command_line->AppendSwitchWithValue("allow-file-access-from-files", "1");
	//}
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
#	ifdef LINUX
		//TODO - only do this is the flash flag is turned on
		//command_line->AppendSwitchWithValue("ppapi-flash-version", "25.0.0.127");
		//command_line->AppendSwitchWithValue("ppapi-flash-path", "/usr/lib/pepperflashplugin-nonfree/libpepflashplayer.so");
#	endif

//#endif //!DKCefChild

//#if USE_DKV8
	DKV8::v8handler = new DKCefV8Handler();
//#endif
}

void DKCefApp::OnBrowserCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefDictionaryValue> extra_info) {
	CEF_REQUIRE_RENDERER_THREAD();
	DKDEBUGFUNC(browser, extra_info);

//#if USE_DKV8
	DKV8::_browser = browser;
	DKV8::v8handler->SetBrowser(browser);
//#endif
	CefRefPtr<CefProcessMessage> msg = CefProcessMessage::Create("GetFunctions");
	CefRefPtr<CefListValue> args = msg->GetArgumentList();
//#ifndef DEBUG
	//browser->SendProcessMessage(PID_RENDERER, msg); //FIXME
//#endif
}

void DKCefApp::OnContextInitialized() {
	CEF_REQUIRE_UI_THREAD();
	DKDEBUGFUNC();
	//CefRefreshWebPlugins(); //FIXME
}

void DKCefApp::OnContextCreated(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context) {
	CEF_REQUIRE_RENDERER_THREAD();
	DKDEBUGFUNC(browser, frame, context);

//#if USE_DKV8
	//Load all of the c++ functions into the V8 context.
	DKV8::ctx = context->GetGlobal();
	for(unsigned int i=0; i<DKV8::funcs.size(); i++){
		CefRefPtr<CefV8Value> value = CefV8Value::CreateFunction(DKV8::funcs[i].c_str(), DKV8::v8handler);
		if(DKV8::ctx->SetValue(DKV8::funcs[i].c_str(), value, V8_PROPERTY_ATTRIBUTE_NONE))
			DKINFO("registered: "+DKV8::funcs[i]+"\n");
	}
//#endif
}

bool DKCefApp::OnProcessMessageReceived(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefProcessId source_process, CefRefPtr<CefProcessMessage> message) {
	CEF_REQUIRE_UI_THREAD();
	DKDEBUGFUNC(browser, source_process, message);
	//DK_UNUSED(browser);
	//DK_UNUSED(source_process);
	//DK_UNUSED(message);

	if(DKV8::singleprocess)
		return DKERROR("message system disabled in single-process mode\n");
	CefRefPtr<CefListValue> args = message->GetArgumentList();
	std::string str = "DKCefApp::OnProcessMessageReceived(): "; 
	str += message->GetName();
	str += "(";
	for(unsigned int i=0; i<args->GetSize(); i++){
		if(args->GetType(i) == VTYPE_INVALID)
			str += "invalid";
		if(args->GetType(i) == VTYPE_NULL)
			str += "null";
		if(args->GetType(i) == VTYPE_BOOL)
			str += toString(args->GetBool(i));
		if(args->GetType(i) == VTYPE_INT)
			str += toString(args->GetInt(i));
		if(args->GetType(i) == VTYPE_DOUBLE)
			str += toString(args->GetDouble(i));
		if(args->GetType(i) == VTYPE_STRING)
			str += args->GetString(i).ToString();
		if(args->GetType(i) == VTYPE_BINARY)
			str += "binary";
		if(args->GetType(i) == VTYPE_DICTIONARY)
			str += "dictionary";
		if(args->GetType(i) == VTYPE_LIST)
			str += "list";
		if(i < args->GetSize()-1)
			str += ",";
	}
	str += ")";
	DKINFO(str+"\n");
	return false;
}

void DKCefApp::OnUncaughtException(CefRefPtr<CefBrowser> browser, CefRefPtr<CefFrame> frame, CefRefPtr<CefV8Context> context, CefRefPtr<CefV8Exception> exception, CefRefPtr<CefV8StackTrace> stackTrace) {
	DKDEBUGFUNC(browser, frame, context, exception, stackTrace); //DON'T DO THIS
	
	//This isn't working so well, another Error handler is located in DK/Browser.js
	return;

	/*
	DKString msg = exception->GetMessage().ToString();
	if(has(msg,"DKSendEvent is not defined")){ return; } //ignore DKSendEvent not existing

	DKERROR("#################### Uncaught Exception ####################\n");
	DKERROR("Exception: "+msg+"\n");
	std::ostringstream stackFormatted;
	for (int i = 0; i < stackTrace->GetFrameCount(); ++i) {
			stackFormatted << "at "
			<< stackTrace->GetFrame(i)->GetFunctionName().ToString()
			<< "() in "
			<< stackTrace->GetFrame(i)->GetScriptName().ToString()
			<< " on line "
			<< stackTrace->GetFrame(i)->GetLineNumber() << "\n";
	}
	DKERROR(stackFormatted.str()+"\n");
	DKERROR("############################################################\n");
	*/

	/*
	const char* stackFormattedShouldBe =
		"at test2() in http://tests/V8Test.OnUncaughtException on line 3\n"
		"at test() in http://tests/V8Test.OnUncaughtException on line 2\n";
		EXPECT_STREQ(stackFormattedShouldBe, stackFormatted.str().c_str());
	*/
}
