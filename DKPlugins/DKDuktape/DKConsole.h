#ifdef USE_DKDuktape 
#pragma once
#ifndef DKConsole_H
#define DKConsole_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////
class DKConsole : public DKObjectT<DKConsole>
{
public:
	bool Init();
	
	static int _assert(duk_context* ctx);
	static int clear(duk_context* ctx);
	static int debug(duk_context* ctx);
	static int error(duk_context* ctx);
	static int exception(duk_context* ctx);
	static int group(duk_context* ctx);
	static int groupCollapsed(duk_context* ctx);
	static int groupEnd(duk_context* ctx);
	static int info(duk_context* ctx);
	static int log(duk_context* ctx);
	static int trace(duk_context* ctx);
	static int warn(duk_context* ctx);
};


REGISTER_OBJECT(DKConsole, true)

#endif //DKConsole_H
#endif //USE_DKDuktape