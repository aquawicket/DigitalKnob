#ifdef USE_DKDuktape 
#pragma once
#ifndef DKOSGVideoJS_H
#define DKOSGVideoJS_H

#include "DKDuktape/DKDuktape.h"

class DKOSGVideoJS : public DKObjectT<DKOSGVideoJS>
{
public:
	void Init();
	static int Play(duk_context* ctx);
};

REGISTER_OBJECT(DKOSGVideoJS, true)
#endif //DKOSGVideoJS_H
#endif //USE_DKDuktape
