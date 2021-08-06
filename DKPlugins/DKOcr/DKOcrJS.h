#ifdef USE_DKDuktape 
#pragma once
#ifndef DKOcrJS_H
#define DKOcrJS_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////
class DKOcrJS : public DKObjectT<DKOcrJS>
{
public:
	bool Init();

	static int ImageToText(duk_context* ctx);
};


REGISTER_OBJECT(DKOcrJS, true)

#endif //DKOcrJS_H
#endif //USE_DKDuktape