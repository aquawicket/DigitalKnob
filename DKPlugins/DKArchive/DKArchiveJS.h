#ifdef USE_DKDuktape 
#pragma once
#ifndef DKArchiveJS_H
#define DKArchiveJS_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////
class DKArchiveJS : public DKObjectT<DKArchiveJS>
{
public:
	bool Init();
	
	static int Compress(duk_context* ctx);
	static int Extract(duk_context* ctx);
};

REGISTER_OBJECT(DKArchiveJS, true)

#endif //DKArchiveJS_H
#endif //USE_DKDuktape