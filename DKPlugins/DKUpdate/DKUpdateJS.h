#ifdef USE_DKDuktape 
#pragma once
#ifndef DKUpdateJS_H
#define DKUpdateJS_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////
class DKUpdateJS : public DKObjectT<DKUpdateJS>
{
public:
	bool Init();

	/*
	static int TestInt(duk_context* ctx);
	static int TestString(duk_context* ctx);
	static int TestReturnInt(duk_context* ctx);
	static int TestReturnString(duk_context* ctx);
	*/

	static int CheckForUpdate(duk_context* ctx);
	static int CreateUpdate(duk_context* ctx);
	static int DoUpdate(duk_context* ctx);
	static int UpdatePlugin(duk_context* ctx);
};


REGISTER_OBJECT(DKUpdateJS, true)

#endif //DKUpdateJS_H
#endif //USE_DKDuktape