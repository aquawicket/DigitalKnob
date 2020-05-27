#ifdef USE_DKDuktape 
#pragma once
#ifndef DKRocketLocation_H
#define DKRocketLocation_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////////////////
class DKRocketLocation : public DKObjectT<DKRocketLocation>
{
public:
	bool Init();
	
	static int hash(duk_context* ctx);
	static int host(duk_context* ctx);
	static int hostname(duk_context* ctx);
	static int href(duk_context* ctx);
	static int origin(duk_context* ctx);
	static int password(duk_context* ctx);
	static int pathname(duk_context* ctx);
	static int port(duk_context* ctx);
	static int protocol(duk_context* ctx);
	static int search(duk_context* ctx);
	static int username(duk_context* ctx);
};


REGISTER_OBJECT(DKRocketLocation, true)

#endif //DKRocketLocation_H
#endif //USE_DKDuktape