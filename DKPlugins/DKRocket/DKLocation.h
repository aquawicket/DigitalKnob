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
	
	static int assign(duk_context* ctx);
	static int hash(duk_context* ctx);
	static int href(duk_context* ctx);
};


REGISTER_OBJECT(DKLocation, true)

#endif //DKLocation_H
#endif //USE_DKDuktape