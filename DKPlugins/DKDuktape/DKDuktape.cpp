#include "stdafx.h"
#include "DKDuktape.h"
#include "DKFile.h"

duk_context* DKDuktape::ctx = NULL;
DKStringArray DKDuktape::filelist;
DKStringArray DKDuktape::functions;

int DKDuktape::c_evloop = 0;
extern void poll_register(duk_context *ctx);
extern void eventloop_register(duk_context *ctx);
extern int eventloop_run(duk_context *ctx);
//extern void ncurses_register(duk_context *ctx);
//extern void socket_register(duk_context *ctx);
//extern void fileio_register(duk_context *ctx);



//////////////////////
void DKDuktape::Init()
{
	//DKLog("DKDuktape::Init() \n", DKDEBUG);
	c_evloop = true;

	if(!ctx){
		ctx = duk_create_heap_default();
		if(!ctx){
			DKLog("Failed to create a Duktape heap.\n", DKERROR);
		    return;
		}

		//////////////////////////////////////////////////////////////////////////////////
		//Register javascript Timers: setTimeout, clearTimeout, setInterval, clearInterval
		poll_register(ctx);

		if(c_evloop){ //c_eventloop.js
			eventloop_register(ctx);
			DKString file = DKFile::local_assets+"DKDuktape/c_eventloop.js";
			if(!LoadFile(file)){ return; }
			if(handle_file(ctx, file.c_str()) != 0) {
				DKLog("DKDuktape::Init(): Error in handle_file\n", DKERROR);
				return;
			}
		}
		else{ //ecma_eventloop.js
			DKString file = DKFile::local_assets+"DKDuktape/ecma_eventloop.js";
			if(!LoadFile(file)){ return; }
			if(handle_file(ctx, file.c_str()) != 0) {
				DKLog("DKDuktape::Init(): Error in handle_file\n", DKERROR);
				return;
			}
		}
		//////////////////////////////////////////////////////////////////////////////////
		
		DKCreate("DKJS");
        DKString user = DKFile::local_assets+"User.js";
		LoadFile(user);
	}

	//DKApp::AddLoopFunc("RENDER", &DKDuktape::EventLoop, this);
}

/////////////////////
void DKDuktape::End()
{
	duk_destroy_heap(ctx);
	ctx = NULL;
}

//////////////////////////////////////////////
bool DKDuktape::LoadFile(const DKString& file)
{
	//DKLog("DKDuktape::LoadFile("+jsfile+") \n", DKDEBUG);
	if(file.empty()){ return false; }
	if(FileLoaded(file)){ return false; } //prevent file from loading twice

	//if the file contains a //BROWSER tag, it's broswer only
	DKString test;
	DKFile::FileToString(file, test);
	if(has(test,"//BROWSER")){
		DKLog("Ignoring: "+file+" is a browser only file. \n", DKINFO);
		return false;
	}
	
	if(duk_peval_file(ctx, file.c_str()) != 0){
		DKLog("Script error: "+DKString(duk_safe_to_string(ctx, -1))+"\n", DKERROR);
		return false;
    }
    duk_pop(ctx);  /* ignore result */

	filelist.push_back(file);
	return true;
}

////////////////////////////////////////////////
bool DKDuktape::FileLoaded(const DKString& file)
{
	for(unsigned int i = 0; i < filelist.size(); ++i){
		if(same(file, filelist[i])){
			DKLog("DKDuktape::FileLoaded(): "+file+" already loaded.\n", DKWARN);
			return true;
		}
	}
	return false;
}

//////////////////////////////////////////////
bool DKDuktape::CallInit(const DKString& file)
{
	//DKLog("DKDuktape::CallInit(" + jsfile + ") \n", DKDEBUG);
	DKString filename;
	DKFile::GetFileName(file, filename);
	DKFile::RemoveExtention(filename);
	DKString init = filename+"_Init";

	duk_push_global_object(ctx);
	duk_get_prop_string(ctx, -1 /*index*/, init.c_str());
	if (duk_pcall(ctx, 0 /*nargs*/) != 0) {
		DKLog(init + " " + DKString(duk_safe_to_string(ctx, -1)) + "\n", DKERROR);
	}
	else {
		//DKLog(DKString(duk_safe_to_string(ctx, -1))+"\n"); //Init function return value;
	}
	duk_pop(ctx);  /* pop result/error */
	return true;
}

/////////////////////////////////////////////
bool DKDuktape::CallEnd(const DKString& file)
{
	//DKLog("DKDuktape::CallEnd(" + jsfile + ") \n", DKDEBUG);
	DKString filename;
	DKFile::GetFileName(file, filename);
	DKFile::RemoveExtention(filename);
	DKString init = filename+"_End";
	DKFile::RemoveExtention(init);

	duk_push_global_object(ctx);
	duk_get_prop_string(ctx, -1 /*index*/, init.c_str());
	if (duk_pcall(ctx, 0 /*nargs*/) != 0) {
		DKLog(init + " " + DKString(duk_safe_to_string(ctx, -1)) + "\n", DKERROR);
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

////////////////////////////////////////////////////////////////////////////////////
void DKDuktape::AttachFunction(const DKString& name, duk_c_function func, int nargs)
{
	duk_push_global_object(ctx);
    duk_push_c_function(ctx, func, nargs);
	duk_put_prop_string(ctx, -2, name.c_str());
	functions.push_back(name+"("+toString(nargs)+")");
}

////////////////////////
void DKDuktape::Reload()
{
	DKEvent::events.clear();
	filelist.clear();

	DKStringArray list;
	DKClass::GetObjects(list);
	for(unsigned int i=list.size()-1; i>0; --i){
		if(has(list[i],"App0")){ continue; }
		if(has(list[i],"DKAssets")){ continue; }
		if(has(list[i],"DKDebug")){ continue; }
		if(has(list[i],"DKDuktape")){ continue; }
		if(has(list[i],"Window0")){ continue; }
		if(has(list[i],"DKJS")){ continue; }
		if(has(list[i],"Rocket")){ continue; }
		//DKLog("DKDuktape::Reload(): "+list[i]+"\n",DKINFO);
		DKClose(list[i]);
	}

	//functions.clear();
	DKClass::GetObjects(list);
    DKString user = DKFile::local_assets+"User.js";
	LoadFile(user);
}

///////////////////////////////////////
void DKDuktape::OnEvent(DKEvent* event)
{
	DKString id = event->GetId();
	if(id.empty()){ return; } //we need an id
	DKString type = event->GetType();
	if(type.empty()){ return; } //we need a type
	DKString value = event->GetValue();
	DKString jsreturn = event->GetJSReturn();
	replace(jsreturn, "() {\"ecmascript\"}", "");
	if(jsreturn.empty() || same(jsreturn,"0")){
		DKLog("DKDuktape::OnEvent: jsreturn variable invalid. \n", DKERROR);
		return;
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
}



//////////////////////////////////////////////////////////////////
////////////// eventloop stuff  //////////////////////////////////
//////////////////////////////////////////////////////////////////
int DKDuktape::handle_file(duk_context *ctx, const char *filename) 
{
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
	int comp_flags = 0;
	int rc;

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
	//DKLog("DKDuktape: set _USERCODE timer\n", DKDEBUG);
	//duk_eval_string(ctx, "setTimeout(function() { _USERCODE(); }, 0);");
	//duk_pop(ctx);

	/*
	if(c_evloop){
		DKLog("DKDuktape: calling eventloop_run()\n", DKDEBUG);
		rc = duk_safe_call(ctx, eventloop_run, 0 , 1 );
		if (rc != 0) {
			DKLog("DKDuktape: eventloop_run() failed: "+toString(duk_to_string(ctx, -1))+"\n", DKDEBUG);
		}
		duk_pop(ctx);
	} 
	else{
		//DKLog("DKDuktape: calling EventLoop.run()\n", DKDEBUG);
		duk_eval_string(ctx, "EventLoop.run();");
		duk_pop(ctx);
	}
	*/

	return 0;
}

///////////////////////////
void DKDuktape::EventLoop()
{
	int rc;
	if(c_evloop){
		DKLog("DKDuktape: calling eventloop_run()\n", DKDEBUG);
		rc = duk_safe_call(ctx, eventloop_run, 0 , 1 );
		if (rc != 0) {
			DKLog("DKDuktape: eventloop_run() failed: "+toString(duk_to_string(ctx, -1))+"\n", DKDEBUG);
		}
		duk_pop(ctx);
	} 
	else{
		//DKLog("DKDuktape: calling EventLoop.run()\n", DKDEBUG);
		duk_eval_string(ctx, "EventLoop.run();");
		duk_pop(ctx);
	}
}
