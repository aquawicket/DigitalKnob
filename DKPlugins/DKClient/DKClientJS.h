//########## THIS PLUGIN IS OBSOLETE, PLEASE USE DKWebSockets ##########

#ifdef USE_DKDuktape 
#pragma once
#ifndef DKClientJS_H
#define DKClientJS_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////
class DKClientJS : public DKObjectT<DKClientJS>
{
public:
	bool Init();
	
	static int Address(duk_context* ctx);
	static int Connect(duk_context* ctx);
	static int Send(duk_context* ctx);
};


REGISTER_OBJECT(DKClientJS, true);
#endif //DKClientJS_H
#endif //USE_DKDuktape