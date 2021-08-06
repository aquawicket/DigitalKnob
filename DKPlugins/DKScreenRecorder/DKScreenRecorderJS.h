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
	
	static int Record(duk_context* ctx);
	static int Stop(duk_context* ctx);
};

REGISTER_OBJECT(DKScreenRecorderJS, true)

#endif //DKScreenRecorderJS_H
#endif //USE_DKDuktape