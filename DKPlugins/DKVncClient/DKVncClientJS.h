#ifdef USE_DKDuktape 
#pragma once
#ifndef DKVncClientJS_H
#define DKVncClientJS_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////////
class DKVncClientJS : public DKObjectT<DKVncClientJS>
{
public:
	bool Init();

	static int TestInt(duk_context* ctx);
	static int TestString(duk_context* ctx);
	static int TestReturnInt(duk_context* ctx);
	static int TestReturnString(duk_context* ctx);
};


REGISTER_OBJECT(DKVncClientJS, true)

#endif //DKVncClientJS_H
#endif //USE_DKDuktape