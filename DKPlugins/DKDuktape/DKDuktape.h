// https://kangax.github.io/compat-table/es6/#duktape2_3

#pragma once
#ifndef DKDuktape_H
#define DKDuktape_H

#include "DK/DK.h"

#include "duktape.h"
//#include "duk_v1_compat.h"

/* Flags for duk_push_string_file_raw() */
#define DUK_STRING_PUSH_SAFE              (1 << 0)    /* no error if file does not exist */
const char *duk_push_string_file_raw(duk_context *ctx, const char *path, duk_uint_t flags);
duk_int_t duk_peval_file(duk_context *ctx, const char *path);

/////////////////////////////////////////////
class DKDuktape : public DKObjectT<DKDuktape>
{
public:
	bool Init();
	bool End();
	
	static bool AttachFunction(const DKString& name, duk_c_function func);
	static bool CallEnd(const DKString& file);
	static bool CallInit(const DKString& file);
	static bool DumpError(const DKString& code);
	static bool FileLoaded(const DKString& path);
	static bool LoadFile(const DKString& path);
	static bool LoadJSString(const DKString& url, const DKString& string);
	static bool OnEvent(DKEvents* event);
	static bool Reload();
	//static bool RunDuktape(const DKString& code);
	static bool RunDuktape(const DKString& code, DKString& rval);
	static bool Trace();
	static bool QueueDuktape(const DKString& code);
	static bool UnloadFile(const DKString& path);

	//TODO
	//static void AttachFunction(const DKString& name, const DKString& object, duk_c_function func, int nargs);
	//static void CreateObject(const DKString& name);

	static duk_context* ctx;
	static DKStringArray filelist;
	static DKStringArray functions;

	//Main event loop
	static DKStringArray codeToRun;
	void EventLoop();

	//other eventloop stuff
	static bool c_evloop;
	int handle_file(duk_context *ctx, const char *filename);
	int handle_fh(duk_context *ctx, FILE *f, const char *filename);
	static int wrapped_compile_execute(duk_context *ctx, void *udata);
};


REGISTER_OBJECT(DKDuktape, true);

#endif //DKDuktape_H
