#ifdef USE_DKDuktape 
#pragma once
#ifndef DKLocation_H
#define DKLocation_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////
class DKLocation : public DKObjectT<DKLocation>
{
public:
	bool Init();
	
	static int clear(duk_context* ctx);
	static int debug(duk_context* ctx);
	static int error(duk_context* ctx);
	static int info(duk_context* ctx);
	static int warn(duk_context* ctx);
};


REGISTER_OBJECT(DKLocation, true)

#endif //DKLocation_H
#endif //USE_DKDuktape