#ifdef USE_DKDuktape 
#pragma once
#ifndef DKMySqlJS_H
#define DKMySqlJS_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////
class DKMySqlJS : public DKObjectT<DKMySqlJS>
{
public:
	bool Init();
	
	static int Connect(duk_context* ctx);
	static int Database(duk_context* ctx);
	static int Query(duk_context* ctx);
};

REGISTER_OBJECT(DKMySqlJS, true)
#endif //DKMySqlJS_H
#endif //USE_DKDuktape