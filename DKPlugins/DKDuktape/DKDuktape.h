#pragma once
#ifndef DKDuktape_H
#define DKDuktape_H

#include "DK/DK.h"
#include "duktape.h"

/////////////////////////////////////////////
class DKDuktape : public DKObjectT<DKDuktape>
{
public:
	bool Init();
	void End();
	
	static bool AttachFunction(const DKString& name, duk_c_function func);
	static bool CallEnd(const DKString& file);
	static bool CallInit(const DKString& file);
	static bool FileLoaded(const DKString& path);
	static bool LoadFile(const DKString& path);
	static bool OnEvent(DKEvent* event);
	static void Reload();
	static DKString RunJavascript(const DKString& code);

	//TODO
	//static void AttachFunction(const DKString& name, const DKString& object, duk_c_function func, int nargs);
	//static void CreateObject(const DKString& name);

	static duk_context* ctx;
	static DKStringArray filelist;
	static DKStringArray functions;

	//eventloop stuff
	static int c_evloop;
	int handle_file(duk_context *ctx, const char *filename);
	int handle_fh(duk_context *ctx, FILE *f, const char *filename);
	static int wrapped_compile_execute(duk_context *ctx);
	void EventLoop();
};


REGISTER_OBJECT(DKDuktape, true);

#endif //DKDuktape_H
