#pragma once
#ifndef DKDuktape_H
#define DKDuktape_H
#include "DK.h"
#include "duktape.h"

/////////////////////////////////////////////
class DKDuktape : public DKObjectT<DKDuktape>
{
public:
	void Init();
	void End();
	static bool LoadFile(const DKString& path);
	static bool FileLoaded(const DKString& file);
	static bool CallInit(const DKString& file);
	static bool CallEnd(const DKString& file);
	static void AttachFunction(const DKString& name, duk_c_function func, int nargs);
	static void Reload();
	static void OnEvent(DKEvent* event);
	static void RunJavascript(const DKString& code);

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
