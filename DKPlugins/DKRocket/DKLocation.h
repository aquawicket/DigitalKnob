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
	
	static int href(duk_context* ctx);
};


REGISTER_OBJECT(DKLocation, true)

#endif //DKLocation_H
#endif //USE_DKDuktape