#ifdef USE_DKDuktape 
#pragma once
#ifndef DKScreenRecorderJS_H
#define DKScreenRecorderJS_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////////////////////
class DKScreenRecorderJS : public DKObjectT<DKScreenRecorderJS>
{
public:
	bool Init();
	
	static int Test(duk_context* ctx);
};

REGISTER_OBJECT(DKScreenRecorderJS, true)

#endif //DKScreenRecorderJS_H
#endif //USE_DKDuktape