#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DKDuktape/DKDuktape.h"

duk_context* DKDuktape::ctx;
DKStringArray DKDuktape::filelist;
DKStringArray DKDuktape::functions;
DKStringArray DKDuktape::codeToRun;

int DKDuktape::c_evloop = 0;
extern void poll_register(duk_context *ctx);
extern void eventloop_register(duk_context *ctx);
extern int eventloop_run(duk_context *ctx, void *udata);
//extern void ncurses_register(duk_context *ctx);
//extern void socket_register(duk_context *ctx);
//extern void fileio_register(duk_context *ctx);

//////////////////////////////////////////////////////////////////////////////////////////
const char *duk_push_string_file_raw(duk_context *ctx, const char *path, duk_uint_t flags) 
{
	FILE *f = NULL;
	char *buf;
	long sz;  /* ANSI C typing */

	if(!path){
		goto fail;
	}
	f = fopen(path, "rb");
	if(!f){
		goto fail;
	}
	if(fseek(f, 0, SEEK_END) < 0){
		goto fail;
	}
	sz = ftell(f);
	if(sz < 0){
		goto fail;
	}
	if(fseek(f, 0, SEEK_SET) < 0){
		goto fail;
	}
	buf = (char *)duk_push_fixed_buffer(ctx, (duk_size_t) sz);
	if((size_t) fread(buf, 1, (size_t) sz, f) != (size_t) sz){
		duk_pop(ctx);
		goto fail;
	}
	(void) fclose(f);  /* ignore fclose() error */
	return duk_buffer_to_string(ctx, -1);

fail:
	if(f){
		(void) fclose(f);  /* ignore fclose() error */
	}

	if(flags & DUK_STRING_PUSH_SAFE){
		duk_push_undefined(ctx);
	}
	else{
		(void) duk_type_error(ctx, "read file error");
	}
	return NULL;
}

////////////////////////////////////////////////////////////
duk_int_t duk_peval_file(duk_context *ctx, const char *path) 
{
	duk_int_t rc;

	duk_push_string_file_raw(ctx, path, DUK_STRING_PUSH_SAFE);
	duk_push_string(ctx, path);
	rc = duk_pcompile(ctx, DUK_COMPILE_EVAL);
	if(rc != 0){
		return rc;
	}
	duk_push_global_object(ctx);  /* 'this' binding */
	rc = duk_pcall_method(ctx, 0);
	return rc;
}

//////////////////////
bool DKDuktape::Init()
{
	DKDEBUGFUNC();
	ctx = NULL;
	c_evloop = true;

	if(!ctx){
		ctx = duk_create_heap_default();
		if(!ctx){
			DKERROR("Failed to create a Duktape heap.\n");
		    return false;
		}

		DKClass::DKCreate("DKDuktapeJS");
		DKClass::DKCreate("DKConsole");
		DKClass::DKCreate("DKNavigator");
		DKClass::DKCreate("DKEventTarget");
		DKClass::DKCreate("DKDuktape/DKGlobalEventHandlers.js");
		DKClass::DKCreate("DKXMLHttpRequest");
		DKClass::DKCreate("DKScreen");
		DKClass::DKCreate("DKDuktape/DKWindow.js");

		//////////////////////////////////////////////////////////////////////////////////
		//Register javascript Timers: setTimeout, clearTimeout, setInterval, clearInterval
		poll_register(ctx);

		if(c_evloop){ //c_eventloop.js
			eventloop_register(ctx);
			DKString file = DKFile::local_assets+"DKDuktape/c_eventloop.js";
			if(!LoadFile(file)){ return false; }
			if(handle_file(ctx, file.c_str()) != 0) {
				DKERROR("DKDuktape::Init(): Error in handle_file\n");
				return false;
			}
		}
		else{ //ecma_eventloop.js
			DKString file = DKFile::local_assets+"DKDuktape/ecma_eventloop.js";
			if(!LoadFile(file)){ return false; }
			if(handle_file(ctx, file.c_str()) != 0) {
				DKERROR("DKDuktape::Init(): Error in handle_file\n");
				return false;
			}
		}
		//////////////////////////////////////////////////////////////////////////////////

        DKString app = DKFile::local_assets+"app.js";
		LoadFile(app);
	}

	DKApp::AppendLoopFunc(&DKDuktape::EventLoop, this);
	return true;
}

/////////////////////
bool DKDuktape::End()
{
	DKDEBUGFUNC();
	duk_destroy_heap(ctx);
	ctx = NULL;
	return true;
}


/////////////////////////////////////////////////////////////////////////
bool DKDuktape::AttachFunction(const DKString& name, duk_c_function func)
{
	DKDEBUGFUNC(name, func);
	if(!ctx){
		DKWARN("DKDuktape::AttachFunction(): ctx invalid\n");
		return false; 
	}

	duk_require_stack(ctx, 1);
	duk_push_global_object(ctx);
	duk_push_c_function(ctx, func, DUK_VARARGS);
	duk_put_prop_string(ctx, -2, name.c_str());
	functions.push_back(name+"()");
	return true;
}

/////////////////////////////////////////////
bool DKDuktape::CallEnd(const DKString& file)
{
	DKDEBUGFUNC(file);
	if(!FileLoaded(file)){ return false; }
	DKString filename;
	DKFile::GetFileName(file, filename);
	DKFile::RemoveExtention(filename);
	DKString func = filename+"_End";

	DKString rval;
	RunDuktape("(typeof "+func+" === 'function')", rval);
	if(!toBool(rval)){
		DKWARN(func+" undefined\n");
		return true;
	}

	func += "()";
	if(duk_peval_string(ctx, func.c_str()) != 0){
		duk_get_prop_string(ctx, -1, "name");  // push `err.name`
		DKString name = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.name`
		duk_get_prop_string(ctx, -1, "message");  // push `err.message`
		DKString message = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.message`
		message = name +": "+message;
		duk_get_prop_string(ctx, -1, "fileName");  // push `err.fileName`
		DKString fileName = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.fileName`
		duk_get_prop_string(ctx, -1, "lineNumber");  // push `err.lineNumber`
		DKString lineNumber = toString(duk_get_int(ctx, -1));
		duk_pop(ctx);  // pop `err.lineNumber`
		duk_get_prop_string(ctx, -1, "stack");  // push `err.stack`
		DKString stack = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.stack`

		DKERROR(message+"\n");

		replace(stack,"'","\\'");
		replace(stack,"\n","\\n");
		replace(message,"'","\\'");

		DKString str;
		str += "var err_error = {stack:'"+stack+"'};";
		str += "var err_event = {type:'error', message:'"+message+"', filename:'"+fileName+"', lineno:'"+lineNumber+"', colno:'0', error:err_error};";
		str += "EventFromCPP('window', err_event);";
		duk_eval_string(ctx, str.c_str());
	}
	duk_pop(ctx);  // ignore result?

	for (unsigned int i = 0; i < DKDuktape::filelist.size(); ++i) {
		if (has(DKDuktape::filelist[i], filename)) {
			DKDuktape::filelist.erase(DKDuktape::filelist.begin() + i);
		}
	}
	return true;
}

//////////////////////////////////////////////
bool DKDuktape::CallInit(const DKString& file)
{
	DKDEBUGFUNC(file);
	if(!FileLoaded(file)){ return false; }
	DKString filename;
	DKFile::GetFileName(file, filename);
	DKFile::RemoveExtention(filename);
	DKString func = filename+"_Init";

	DKString rval;
	RunDuktape("(typeof "+func+" === 'function')", rval);
	if(!toBool(rval)){
		DKWARN(func+" undefined\n");
		return true;
	}

	func += "()";
	if(duk_peval_string(ctx, func.c_str()) != 0){
		duk_get_prop_string(ctx, -1, "name");  // push `err.name`
		DKString name = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.name`
		duk_get_prop_string(ctx, -1, "message");  // push `err.message`
		DKString message = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.message`
		message = name +": "+message;
		duk_get_prop_string(ctx, -1, "fileName");  // push `err.fileName`
		DKString fileName = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.fileName`
		duk_get_prop_string(ctx, -1, "lineNumber");  // push `err.lineNumber`
		DKString lineNumber = toString(duk_get_int(ctx, -1));
		duk_pop(ctx);  // pop `err.lineNumber`
		duk_get_prop_string(ctx, -1, "stack");  // push `err.stack`
		DKString stack = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.stack`

		DKERROR(message+"\n");

		replace(stack,"'","\\'");
		replace(stack,"\n","\\n");
		replace(message,"'","\\'");

		DKString str;
		str += "var err_error = {stack:'"+stack+"'};";
		str += "var err_event = {type:'error', message:'"+message+"', filename:'"+fileName+"', lineno:'"+lineNumber+"', colno:'0', error:err_error};";
		str += "EventFromCPP('window', err_event);";
		duk_eval_string(ctx, str.c_str());
	}
	duk_pop(ctx);
	
	return true;
}

////////////////////////////////////////////////
bool DKDuktape::FileLoaded(const DKString& path)
{
	DKDEBUGFUNC(path);
	for(unsigned int i = 0; i < filelist.size(); ++i){
		if(has(path, filelist[i])){
			//DKINFO("DKDuktape::FileLoaded(): "+path+" is loaded\n");
			return true;
		}
	}
	return false;
}

//////////////////////////////////////////////
bool DKDuktape::LoadFile(const DKString& path)
{
	DKDEBUGFUNC(path);
	if(path.empty()){ return false; }
	if(FileLoaded(path)){ return false; } //prevent file from loading twice

	DKString js;
	DKFile::FileToString(path, js);
	if(has(js,"//BROWSER")){
		DKWARN("Ignoring: "+path+" is a browser only file. \n");
		return true;
	}

	if(duk_peval_file(ctx, path.c_str()) != 0){
		duk_get_prop_string(ctx, -1, "name");  // push `err.name`
		DKString name = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.name`
		duk_get_prop_string(ctx, -1, "message");  // push `err.message`
		DKString message = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.message`
		message = name +": "+message;
		duk_get_prop_string(ctx, -1, "fileName");  // push `err.fileName`
		DKString fileName = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.fileName`
		duk_get_prop_string(ctx, -1, "lineNumber");  // push `err.lineNumber`
		DKString lineNumber = toString(duk_get_int(ctx, -1));
		duk_pop(ctx);  // pop `err.lineNumber`
		duk_get_prop_string(ctx, -1, "stack");  // push `err.stack`
		DKString stack = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.stack`
		
		DKERROR(message+"\n");

		replace(stack,"'","\\'");
		replace(stack,"\n","\\n");
		replace(message,"'","\\'");

		DKString str;
		str += "var err_error = {stack:'"+stack+"'};";
		str += "var err_event = {type:'error', message:'"+message+"', filename:'"+fileName+"', lineno:'"+lineNumber+"', colno:'0', error:err_error};";
		str += "EventFromCPP('window', err_event);";
		duk_eval_string(ctx, str.c_str());
	}
	duk_pop(ctx);  // ignore result?

	//DKString filename;
	//DKFile::GetFileName(path, filename);
	filelist.push_back(path);
	return true;
}

/////////////////////////////////////////////////////////////////////////
bool DKDuktape::LoadJSString(const DKString& url, const DKString& string)
{
	DKDEBUGFUNC(url, string);
	if(url.empty()){ return false; }
	if(string.empty()){ return false; }
	if(FileLoaded(url)){ return false; } //prevent url from loading twice

	if(has(string,"//BROWSER")){
		DKINFO("Ignoring: "+url+" is a browser only file. \n");
		return false;
	}

	if(duk_peval_string(ctx, string.c_str()) != 0){
		duk_get_prop_string(ctx, -1, "name");  // push `err.name`
		DKString name = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.name`
		duk_get_prop_string(ctx, -1, "message");  // push `err.message`
		DKString message = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.message`
		message = name +": "+message;
		duk_get_prop_string(ctx, -1, "fileName");  // push `err.fileName`
		DKString fileName = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.fileName`
		duk_get_prop_string(ctx, -1, "lineNumber");  // push `err.lineNumber`
		DKString lineNumber = toString(duk_get_int(ctx, -1));
		duk_pop(ctx);  // pop `err.lineNumber`
		duk_get_prop_string(ctx, -1, "stack");  // push `err.stack`
		DKString stack = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.stack`

		DKERROR(message+"\n");

		replace(stack,"'","\\'");
		replace(stack,"\n","\\n");
		replace(message,"'","\\'");

		DKString str;
		str += "var err_error = {stack:'"+stack+"'};";
		str += "var err_event = {type:'error', message:'"+message+"', filename:'"+fileName+"', lineno:'"+lineNumber+"', colno:'0', error:err_error};";
		str += "EventFromCPP('window', err_event);";
		duk_eval_string(ctx, str.c_str());
	}

	filelist.push_back(url);
	return true;
}

/*
///////////////////////////////////////
bool DKDuktape::OnEvent(DKEvent* event)
{
	DKDEBUGFUNC(event);
	DKString id = event->GetId();
	if(id.empty()){ return false; } //we need an id
	DKString type = event->GetType();
	if(type.empty()){ return false; } //we need a type
	DKString value = event->GetValue();
	DKString jsreturn = event->GetJSReturn();
	//replace(jsreturn, "() { [ecmascript code] }", ""); //remove () { [ecmascript code] }
	if(jsreturn.empty() || same(jsreturn,"0")){
		DKERROR("DKDuktape::OnEvent: jsreturn variable invalid\n");
		return false;
	}

	DKString evt = id +","+ type;

	if(same(type,"keydown")){
		value = toString(event->GetKeyNum());
	}

	if(!value.empty()){
		evt += "," + value;
	}

	duk_require_stack(ctx, 1);
	duk_push_global_object(ctx);
	duk_get_prop_string(ctx, -1, jsreturn.c_str());
	duk_push_string(ctx, evt.c_str()); //add id as string parameter
    if(duk_pcall(ctx, 1) != 0){
		duk_get_prop_string(ctx, -1, "name");  // push `err.name`
		DKString name = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.name`
		duk_get_prop_string(ctx, -1, "message");  // push `err.message`
		DKString message = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.message`
		message = name +": "+message;
		duk_get_prop_string(ctx, -1, "fileName");  // push `err.fileName`
		DKString fileName = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.fileName`
		duk_get_prop_string(ctx, -1, "lineNumber");  // push `err.lineNumber`
		DKString lineNumber = toString(duk_get_int(ctx, -1));
		duk_pop(ctx);  // pop `err.lineNumber`
		duk_get_prop_string(ctx, -1, "stack");  // push `err.stack`
		DKString stack = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.stack`

		DKERROR(message+"\n");

		replace(stack,"'","\\'");
		replace(stack,"\n","\\n");
		replace(message,"'","\\'");

		DKString str;
		str += "var err_error = {stack:'"+stack+"'};";
		str += "var err_event = {type:'error', message:'"+message+"', filename:'"+fileName+"', lineno:'"+lineNumber+"', colno:'0', error:err_error};";
		str += "EventFromCPP('window', err_event);";
		duk_eval_string(ctx, str.c_str());
    }
	else{
		//DKINFO(DKString(duk_safe_to_string(ctx, -1))+"\n"); //return value?
    }
    duk_pop(ctx);

	return true;
}
*/

////////////////////////
bool DKDuktape::Reload()
{
	DKDEBUGFUNC();
	DKEvent::events.clear();
	filelist.clear();

	DKStringArray list;
	DKClass::GetObjects(list);
	for(unsigned int i=list.size()-1; i>0; --i){
		if(!has(list[i],"DKJavascript,")){
			if(has(list[i],"App0")){ continue; }
			if(has(list[i],"DKAssets")){ continue; }
			if(has(list[i],"DKDebug")){ continue; }
			if(has(list[i],"DKDuktape")){ continue; }
			if(has(list[i],"Window0")){ continue; }
			if(has(list[i],"DKJS")){ continue; }
			if(has(list[i],"Rocket")){ continue; }
			if(has(list[i],"DKCef")){ continue; }
			if(has(list[i],"DKSDLCef")){ continue; }
		}
		//DKINFO("DKDuktape::Reload(): "+list[i]+"\n"); //DEBUG
		DKClass::DKClose(list[i]);
	}

	//DEBUG
	//list.clear();
	//DKClass::GetObjects(list);

    DKString app = DKFile::local_assets+"app.js";
	LoadFile(app);
	return true;
}

/*
////////////////////////////////////////////////
bool DKDuktape::RunDuktape(const DKString& code)
{
	//DKDEBUGFUNC(code);
	if(!DKUtil::InMainThread()){ return false; }
	if(!DKDuktape::ctx){
		DKERROR("DKDuktape::RunDuktape("+code+"): context is invalid\n"); 
		return false; 
	}

	if(duk_peval_string(ctx, code.c_str()) != 0){
		duk_get_prop_string(ctx, -1, "name");  // push `err.name`
		DKString name = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.name`
		duk_get_prop_string(ctx, -1, "message");  // push `err.message`
		DKString message = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.message`
		message = name +": "+message;
		duk_get_prop_string(ctx, -1, "fileName");  // push `err.fileName`
		DKString fileName = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.fileName`
		duk_get_prop_string(ctx, -1, "lineNumber");  // push `err.lineNumber`
		DKString lineNumber = toString(duk_get_int(ctx, -1));
		duk_pop(ctx);  // pop `err.lineNumber`
		duk_get_prop_string(ctx, -1, "stack");  // push `err.stack`
		DKString stack = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.stack`

		DKERROR(message+"\n");

		replace(stack,"'","\\'");
		replace(stack,"\n","\\n");
		replace(message,"'","\\'");

		DKString str;
		str += "var err_error = {stack:'"+stack+"'};";
		str += "var err_event = {type:'error', message:'"+message+"', filename:'"+fileName+"', lineno:'"+lineNumber+"', colno:'0', error:err_error};";
		str += "EventFromCPP('window', err_event);";
		duk_eval_string(ctx, str.c_str());
	}
	duk_pop(ctx);

	return true;
}
*/

////////////////////////////////////////////////////////////////
bool DKDuktape::RunDuktape(const DKString& code, DKString& rval)
{
	//DKDEBUGFUNC(code, rval);
	if(!DKUtil::InMainThread()){ return false; }
	if(!DKDuktape::ctx){
		DKERROR("DKDuktape::RunDuktape("+code+", rval): context is invalid\n");
		return false;
	}
	
	if(duk_peval_string(ctx, code.c_str()) != 0){
		duk_get_prop_string(ctx, -1, "name");  // push `err.name`
		DKString name = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.name`
		duk_get_prop_string(ctx, -1, "message");  // push `err.message`
		DKString message = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.message`
		message = name +": "+message;
		duk_get_prop_string(ctx, -1, "fileName");  // push `err.fileName`
		DKString fileName = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.fileName`
		duk_get_prop_string(ctx, -1, "lineNumber");  // push `err.lineNumber`
		DKString lineNumber = toString(duk_get_int(ctx, -1));
		duk_pop(ctx);  // pop `err.lineNumber`
		duk_get_prop_string(ctx, -1, "stack");  // push `err.stack`
		DKString stack = duk_get_string(ctx, -1);
		duk_pop(ctx);  // pop `err.stack`

		DKERROR(message+"\n");

		replace(stack,"'","\\'");
		replace(stack,"\n","\\n");
		replace(message,"'","\\'");

		DKString str;
		str += "var err_error = {stack:'"+stack+"'};";
		str += "var err_event = {type:'error', message:'"+message+"', filename:'"+fileName+"', lineno:'"+lineNumber+"', colno:'0', error:err_error};";
		str += "EventFromCPP('window', err_event);";
		duk_eval_string(ctx, str.c_str());
	}
	
	//get return value
	if(duk_is_string(ctx, -1)){
		rval = duk_get_string(ctx, -1);
	}
	if(duk_is_boolean(ctx, -1)){
		rval = toString(duk_get_boolean(ctx, -1));
	}

	duk_pop(ctx);
	
	return true;
}

//////////////////////////////////////////////////
bool DKDuktape::QueueDuktape(const DKString& code)
{
	DKDEBUGFUNC(code);
	codeToRun.push_back(code);
	return true;
}



//////////////////////////////////////////////////////////////////
////////////// eventloop stuff  //////////////////////////////////
//////////////////////////////////////////////////////////////////
int DKDuktape::handle_file(duk_context *ctx, const char *filename) 
{
	//DKDEBUGFUNC(ctx, filename);
	FILE *f = NULL;
	int retval;

	f = fopen(filename, "rb");
	if(!f){
		DKERROR("DKDuktape::handle_file(): failed to open source file \n");
		return -1;
	}

	retval = handle_fh(ctx, f, filename);

	fclose(f);
	return retval;
}

/////////////////////////////////////////////////////////////////////////
int DKDuktape::handle_fh(duk_context *ctx, FILE *f, const char *filename)
{
	//DKDEBUGFUNC(ctx, f, filename);
	char *buf = NULL;
	int len;
	int got;
	int rc;
	int retval = -1;

	if (fseek(f, 0, SEEK_END) < 0) {
		DKERROR("DKDuktape::handle_fh(): SEEK_END Error \n");
		return -1;
	}
	len = (int) ftell(f);
	if (fseek(f, 0, SEEK_SET) < 0) {
		DKERROR("DKDuktape::handle_fh(): SEEK_SET Error \n");
		return -1;
	}
	buf = (char *) malloc(len);
	if (!buf) {
		DKERROR("DKDuktape::handle_fh(): buf invalid \n");
		return -1;
	}

	got = fread((void *) buf, (size_t) 1, (size_t) len, f);

	duk_push_lstring(ctx, buf, got);
	duk_push_string(ctx, filename);

	free(buf);
	buf = NULL;

	rc = duk_safe_call(ctx, wrapped_compile_execute, NULL, 2 /*nargs*/, 1 /*nret*/);
	if (rc != DUK_EXEC_SUCCESS) {
		DKERROR("DKDuktape::handle_fh(): DUK_EXEC_SUCCESS failed \n");
		return -1;
	} else {
		duk_pop(ctx);
		retval = 0;
	}

	if (buf) {
		free(buf);
	}
	return retval;
}

/////////////////////////////////////////////////////////////////////
int DKDuktape::wrapped_compile_execute(duk_context *ctx, void *udata)
{
	//DKDEBUGFUNC(ctx);
	int comp_flags = 0;
	//int rc;

	//Compile input and place it into global _USERCODE
	duk_compile(ctx, comp_flags);
	duk_push_global_object(ctx);
	duk_insert(ctx, -2);  // [ ... global func ]
	duk_put_prop_string(ctx, -2, "_USERCODE");
	duk_pop(ctx);
#if 0
	printf("compiled usercode\n");
#endif

	//Start a zero timer which will call _USERCODE from within the event loop.
	//DKINFO("DKDuktape: set _USERCODE timer\n");
	//duk_eval_string(ctx, "setTimeout(function() { _USERCODE(); }, 0);");
	//duk_pop(ctx);

	/*
	if(c_evloop){
		DKINFO("DKDuktape: calling eventloop_run()\n");
		rc = duk_safe_call(ctx, eventloop_run, 0 , 1 );
		if (rc != 0) {
			DKINFO("DKDuktape: eventloop_run() failed: "+toString(duk_to_string(ctx, -1))+"\n");
		}
		duk_pop(ctx);
	} 
	else{
		//DKINFO("DKDuktape: calling EventLoop.run()\n");
		duk_eval_string(ctx, "EventLoop.run();");
		duk_pop(ctx);
	}
	*/

	return 0;
}

///////////////////////////
void DKDuktape::EventLoop()
{
	//DKDEBUGFUNC();
	if(!DKUtil::InMainThread()){ return; }

	//cycle through queue codeToRun
	if(codeToRun.size() > 0){
		DKString rval;
		DKDuktape::RunDuktape(codeToRun[0], rval);
		if(!rval.empty()){
			DKWARN("DKDuktape::EventLoop(): rval = "+rval+"\n");
		}
		codeToRun.erase(codeToRun.begin());
	}

	//run the duktape event loop for timers
	int rc;
	if(c_evloop){ //c_eventloop.js
		//DKINFO("DKDuktape: calling c++ eventloop_run()\n");
		rc = duk_safe_call(ctx, eventloop_run, NULL, 0, 1);
		if(rc != 0){
			DKERROR("DKDuktape: eventloop_run() failed: "+toString(duk_to_string(ctx, -1))+"\n");
		}
		duk_pop(ctx);
	} 
	else{ //ecma_eventloop.js
		//DKINFO("DKDuktape: calling javascript EventLoop.run()\n");
		duk_eval_string(ctx, "EventLoop.run();");
		duk_pop(ctx);
	}
}