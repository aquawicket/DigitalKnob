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
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

// https://kangax.github.io/compat-table/es6/#duktape2_3

#pragma once
#ifndef DKDuktape_H
#define DKDuktape_H

#include "DK/DK.h"
#include "DK/DKEvents.h"

WARNING_DISABLE
	#include "duktape.h"
WARNING_ENABLE

#define DKHAVE_DKDuktape 1

/* Flags for duk_push_string_file_raw() */
#define DUK_STRING_PUSH_SAFE              (1 << 0)    /* no error if file does not exist */
const char *duk_push_string_file_raw(duk_context *ctx, const char *path, duk_uint_t flags);
//void duk_eval_file(duk_context* ctx, const char* path);
duk_int_t duk_peval_file(duk_context *ctx, const char *path);

class DKDuktape : public DKObjectT<DKDuktape>
{
public:
	bool Init();
	bool End();
	
	static bool AttachFunction(const DKString& name, duk_c_function func);
	static bool CallEnd(const DKString& file);
	static bool CallInit(const DKString& file);
	static void my_fatal(void* udata, const char* msg);
	static bool DumpError(const DKString& code);
	static bool FileLoaded(const DKString& path);
	static bool LoadFile(const DKString& path);
	static bool LoadJSString(const DKString& url, const DKString& string);
	static bool OnEvent(DKEvents* event);
	static bool Reload();
	static bool RunDuktape(const DKString& code, DKString& rval);
	static bool Trace();
	static bool QueueDuktape(const DKString& code);
	static bool UnloadFile(const DKString& path);

	////////////////////////////////////////////
	static int createDKObject(duk_context* ctx);
	static bool doEvent(const DKString& address, const DKString& type);
	static DKString pointerToAddress(void* pointer);
	static void* addressToPointer(const DKString& address);

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
