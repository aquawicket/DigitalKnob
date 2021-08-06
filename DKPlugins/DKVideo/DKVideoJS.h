#ifdef USE_DKDuktape 
#pragma once
#ifndef DKVideoJS_H
#define DKVideoJS_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////
class DKVideoJS : public DKObjectT<DKVideoJS>
{
public:
	bool Init();
	
	static int Play(duk_context* ctx);
};

REGISTER_OBJECT(DKVideoJS, true)

#endif //DKVideoJS_H
#endif //USE_DKDuktape