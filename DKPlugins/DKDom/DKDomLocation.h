//https://developer.mozilla.org/en-US/docs/Web/API/Location

#pragma once
#ifndef DKDomLocation_H
#define DKDomLocation_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////////
class DKDomLocation : public DKObjectT<DKDomLocation>
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

REGISTER_OBJECT(DKDomLocation, true)

#endif //DKDomLocation_H