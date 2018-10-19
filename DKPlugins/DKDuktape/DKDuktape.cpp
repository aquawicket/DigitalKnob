#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DKDuktape/DKDuktape.h"

duk_context* DKDuktape::ctx = NULL;
DKStringArray DKDuktape::filelist;
DKStringArray DKDuktape::functions;

DKStringArray DKDuktape::codeToRun;

int DKDuktape::c_evloop = 0;
extern void poll_register(duk_context *ctx);
extern void eventloop_register(duk_context *ctx);
extern int eventloop_run(duk_context *ctx);
//extern void ncurses_register(duk_context *ctx);
//extern void socket_register(duk_context *ctx);
//extern void fileio_register(duk_context *ctx);



//////////////////////
bool DKDuktape::Init()
{
	DKDebug();
	c_evloop = true;

	if(!ctx){
		ctx = duk_create_heap_default();
		if(!ctx){
			DKLog("Failed to create a Duktape heap.\n", DKERROR);
		    return false;
		}

		//////////////////////////////////////////////////////////////////////////////////
		//Register javascript Timers: setTimeout, clearTimeout, setInterval, clearInterval
		poll_register(ctx);

		if(c_evloop){ //c_eventloop.js
			eventloop_register(ctx);
			DKString file = DKFile::local_assets+"DKDuktape/c_eventloop.js";
			if(!LoadFile(file)){ return false; }
			if(handle_file(ctx, file.c_str()) != 0) {
				DKLog("DKDuktape::Init(): Error in handle_file\n", DKERROR);
				return false;
			}
		}
		else{ //ecma_eventloop.js
			DKString file = DKFile::local_assets+"DKDuktape/ecma_eventloop.js";
			if(!LoadFile(file)){ return false; }
			if(handle_file(ctx, file.c_str()) != 0) {
				DKLog("DKDuktape::Init(): Error in handle_file\n", DKERROR);
				return false;
			}
		}
		//////////////////////////////////////////////////////////////////////////////////

		DKClass::DKCreate("DKJS");

		DKString duktape = DKFile::local_assets+"DKDuktape/DKDuktape.js";
		LoadFile(duktape);
        DKString app = DKFile::local_assets+"app.js";
		LoadFile(app);
	}

	DKApp::AppendLoopFunc(&DKDuktape::EventLoop, this);
	return true;
}

/////////////////////
bool DKDuktape::End()
{
	DKDebug();
	duk_destroy_heap(ctx);
	ctx = NULL;
	return true;
}


/////////////////////////////////////////////////////////////////////////
bool DKDuktape::AttachFunction(const DKString& name, duk_c_function func)
{
	DKDebug(name, func);
	if(!ctx){
		DKLog("DKDuktape::AttachFunction(): ctx invalid\n", DKWARN);
		return false; 
	}
	duk_push_global_object(ctx);
	duk_push_c_function(ctx, func, DUK_VARARGS);
	duk_put_prop_string(ctx, -2, name.c_str());
	functions.push_back(name+"()");
	return true;
}

/////////////////////////////////////////////
bool DKDuktape::CallEnd(const DKString& file)
{
	DKDebug(file);
	DKString filename;
	DKFile::GetFileName(file, filename);
	DKFile::RemoveExtention(filename);
	DKString init = filename+"_End";
	DKFile::RemoveExtention(init);

	duk_push_global_object(ctx);
	duk_get_prop_string(ctx, -1 /*index*/, init.c_str());
	if (duk_pcall(ctx, 0 /*nargs*/) != 0) {
		DKLog(init + " " + DKString(duk_safe_to_string(ctx, -1)) + "\n", DKWARN);
	}
	else {
		//DKLog(DKString(duk_safe_to_string(ctx, -1))+"\n"); //End function return value;
	}
	duk_pop(ctx);  /* pop result/error */

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
	DKDebug(file);
	DKString filename;
	DKFile::GetFileName(file, filename);
	DKFile::RemoveExtention(filename);
	DKString init = filename+"_Init";

	duk_push_global_object(ctx);
	duk_get_prop_string(ctx, -1 /*index*/, init.c_str());
	if (duk_pcall(ctx, 0 /*nargs*/) != 0) {
		DKLog(init + " " + DKString(duk_safe_to_string(ctx, -1)) + "\n", DKWARN);
	}
	else {
		//DKLog(DKString(duk_safe_to_string(ctx, -1))+"\n"); //Init function return value;
	}
	duk_pop(ctx);  /* pop result/error */
	return true;
}

////////////////////////////////////////////////
bool DKDuktape::FileLoaded(const DKString& path)
{
	DKDebug(path);
	for(unsigned int i = 0; i < filelist.size(); ++i){
		if(has(path, filelist[i])){
			DKLog("DKDuktape::FileLoaded(): "+path+" already loaded.\n", DKWARN);
			return true;
		}
	}
	return false;
}

//////////////////////////////////////////////
bool DKDuktape::LoadFile(const DKString& path)
{
	DKDebug(path);
	if(path.empty()){ return false; }
	if(FileLoaded(path)){ return false; } //prevent file from loading twice

	//if the file contains a //BROWSER tag, it's broswer only
	DKString test;
	DKFile::FileToString(path, test);
	if(has(test,"//BROWSER")){
		DKLog("Ignoring: "+path+" is a browser only file. \n");
		return false;
	}
	
	if(duk_peval_file(ctx, path.c_str()) != 0){
		DKLog(path+" "+DKString(duk_safe_to_string(ctx, -1))+"\n", DKERROR);
		return false;
    }
    duk_pop(ctx);  /* ignore result ?? */

	//DKString filename;
	//DKFile::GetFileName(path, filename);
	filelist.push_back(path);
	return true;
}

///////////////////////////////////////
bool DKDuktape::OnEvent(DKEvent* event)
{
	DKDebug(event);
	DKString id = event->GetId();
	if(id.empty()){ return false; } //we need an id
	DKString type = event->GetType();
	if(type.empty()){ return false; } //we need a type
	DKString value = event->GetValue();
	DKString jsreturn = event->GetJSReturn();
	//replace(jsreturn, "() {\"ecmascript\"}", "");
	if(jsreturn.empty() || same(jsreturn,"0")){
		DKLog("DKDuktape::OnEvent: jsreturn variable invalid. \n", DKERROR);
		return false;
	}

	DKString evt = id +","+ type;

	if(same(type,"keydown")){
		value = toString(event->GetKeyNum());
	}

	if(!value.empty()){
		evt += "," + value;
	}

	//call JS_OnEvent(evt);
	duk_push_global_object(ctx);
	duk_get_prop_string(ctx, -1, jsreturn.c_str());
	duk_push_string(ctx, evt.c_str()); //add id as string parameter
    if (duk_pcall(ctx, 1) != 0) {
		DKLog("DKDuktape::OnEvent(): "+DKString(duk_safe_to_string(ctx, -1))+": "+jsreturn+" "+evt+"\n", DKERROR);
    }
	else{
		//DKLog(DKString(duk_safe_to_string(ctx, -1))+"\n"); //return value??
    }
    duk_pop(ctx);  /* pop result/error */
	return true;
}

////////////////////////
bool DKDuktape::Reload()
{
	DKDebug();
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
		//DKLog("DKDuktape::Reload(): "+list[i]+"\n",DKINFO); //DEBUG
		DKClass::DKClose(list[i]);
	}

	//DEBUG
	//list.clear();
	//DKClass::GetObjects(list);

    DKString app = DKFile::local_assets+"app.js";
	LoadFile(app);
	return true;
}

////////////////////////////////////////////////
bool DKDuktape::RunDuktape(const DKString& code)
{
	//DKDebug(code);
	if(!DKUtil::InMainThread()){ return false; }
	if(!DKDuktape::ctx){ DKLog("DKDuktape::RunDuktape("+code+"): context is invalid\n", DKERROR); return false; }
	duk_eval_string(DKDuktape::ctx, code.c_str());
	return true;
}

////////////////////////////////////////////////////////////////
bool DKDuktape::RunDuktape(const DKString& code, DKString& rval)
{
	//DKDebug(code, rval);
	if(!DKUtil::InMainThread()){ return false; }
	if(!DKDuktape::ctx){
		DKLog("DKDuktape::RunDuktape("+code+", rval): context is invalid\n", DKERROR);
		return false;
	}
	duk_eval_string(DKDuktape::ctx, code.c_str());

	if(duk_check_type(ctx, -1, DUK_TYPE_STRING)){
		rval = duk_get_string(ctx, -1);
		if(!rval.empty()){
			//DKLog("DKDuktape::RunDuktape(" + code + "): rval = "+rval+"\n");
		}
	}

	return true;
}

//////////////////////////////////////////////////
bool DKDuktape::QueueDuktape(const DKString& code)
{
	DKDebug(code);
	codeToRun.push_back(code);
	return true;
}

//////////////////////////////////////////////////////////////////
////////////// eventloop stuff  //////////////////////////////////
//////////////////////////////////////////////////////////////////
int DKDuktape::handle_file(duk_context *ctx, const char *filename) 
{
	//DKDebug(ctx, filename);
	FILE *f = NULL;
	int retval;

	f = fopen(filename, "rb");
	if(!f){
		DKLog("DKDuktape::handle_file(): failed to open source file \n", DKERROR);
		return -1;
	}

	retval = handle_fh(ctx, f, filename);

	fclose(f);
	return retval;
}

/////////////////////////////////////////////////////////////////////////
int DKDuktape::handle_fh(duk_context *ctx, FILE *f, const char *filename)
{
	//DKDebug(ctx, f, filename);
	char *buf = NULL;
	int len;
	int got;
	int rc;
	int retval = -1;

	if (fseek(f, 0, SEEK_END) < 0) {
		DKLog("DKDuktape::handle_fh(): SEEK_END Error \n", DKERROR);
		return -1;
	}
	len = (int) ftell(f);
	if (fseek(f, 0, SEEK_SET) < 0) {
		DKLog("DKDuktape::handle_fh(): SEEK_SET Error \n", DKERROR);
		return -1;
	}
	buf = (char *) malloc(len);
	if (!buf) {
		DKLog("DKDuktape::handle_fh(): buf invalid \n", DKERROR);
		return -1;
	}

	got = fread((void *) buf, (size_t) 1, (size_t) len, f);

	duk_push_lstring(ctx, buf, got);
	duk_push_string(ctx, filename);

	free(buf);
	buf = NULL;

	rc = duk_safe_call(ctx, wrapped_compile_execute, 2 /*nargs*/, 1 /*nret*/);
	if (rc != DUK_EXEC_SUCCESS) {
		DKLog("DKDuktape::handle_fh(): DUK_EXEC_SUCCESS failed \n", DKERROR);
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

////////////////////////////////////////////////////////
int DKDuktape::wrapped_compile_execute(duk_context *ctx)
{
	//DKDebug(ctx);
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
	//DKLog("DKDuktape: set _USERCODE timer\n");
	//duk_eval_string(ctx, "setTimeout(function() { _USERCODE(); }, 0);");
	//duk_pop(ctx);

	/*
	if(c_evloop){
		DKLog("DKDuktape: calling eventloop_run()\n");
		rc = duk_safe_call(ctx, eventloop_run, 0 , 1 );
		if (rc != 0) {
			DKLog("DKDuktape: eventloop_run() failed: "+toString(duk_to_string(ctx, -1))+"\n");
		}
		duk_pop(ctx);
	} 
	else{
		//DKLog("DKDuktape: calling EventLoop.run()\n");
		duk_eval_string(ctx, "EventLoop.run();");
		duk_pop(ctx);
	}
	*/

	return 0;
}

///////////////////////////
void DKDuktape::EventLoop()
{
	//DKDebug();
	if(!DKUtil::InMainThread()){ return; }

	//cycle through queue codeToRun
	if(codeToRun.size() > 0){
		DKString rval;
		DKDuktape::RunDuktape(codeToRun[0]);
		codeToRun.erase(codeToRun.begin());
	}
}



/*
///////////////////////////    OLD CODE
void DKDuktape::EventLoop()
{
	DKDebug();
	int rc;
	if(c_evloop){
		DKLog("DKDuktape: calling eventloop_run()\n");
		rc = duk_safe_call(ctx, eventloop_run, 0 , 1 );
		if (rc != 0) {
			DKLog("DKDuktape: eventloop_run() failed: "+toString(duk_to_string(ctx, -1))+"\n");
		}
		duk_pop(ctx);
	} 
	else{
		//DKLog("DKDuktape: calling EventLoop.run()\n");
		duk_eval_string(ctx, "EventLoop.run();");
		duk_pop(ctx);
	}
}
*/

//TODO
//////////////////////////////////////////////////
/*
void DKDuktape::CreateObject(const DKString& name)
{
	DKDebug(name);
	DKString objname = "_"+name;
	duk_put_global_string(ctx, objname.c_str());
	DKString eval = "var "+name+" new "+objname+"()";
	duk_eval_string(ctx, eval.c_str());
}
*/