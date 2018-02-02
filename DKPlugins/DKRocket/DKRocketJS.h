#ifdef USE_DKDuktape
#pragma once
#ifndef DKRocketJS_H
#define DKRocketJS_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////
class DKRocketJS : public DKObjectT<DKRocketJS>
{
public:
	bool Init();

	static int ToggleDebugger(duk_context* ctx);
	static int Reload(duk_context* ctx);
};

REGISTER_OBJECT(DKRocketJS, true)

#endif //DKRocketJS_H
#endif //USE_DKDuktape