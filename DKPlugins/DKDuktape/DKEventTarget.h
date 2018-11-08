#ifdef USE_DKDuktape 
#pragma once
#ifndef DKEventTarget_H
#define DKEventTarget_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////////
class DKEventTarget : public DKObjectT<DKEventTarget>
{
public:
	bool Init();
	
	static int clear(duk_context* ctx);
	static int debug(duk_context* ctx);
	static int error(duk_context* ctx);
	static int info(duk_context* ctx);
	static int warn(duk_context* ctx);
};


REGISTER_OBJECT(DKEventTarget, true)

#endif //DKEventTarget_H
#endif //USE_DKDuktape