#ifdef USE_DKDuktape 
#pragma once
#ifndef DKDomJS_H
#define DKDomJS_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////
class DKDomJS : public DKObjectT<DKDomJS>
{
public:
	bool Init();
	
	static int Test(duk_context* ctx);
};

REGISTER_OBJECT(DKDomJS, true)

#endif //DKDomJS_H
#endif //USE_DKDuktape