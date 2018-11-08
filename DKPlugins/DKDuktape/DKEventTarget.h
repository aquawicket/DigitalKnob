#ifdef USE_DKDuktape 
#pragma once
#ifndef DKEventTarget_H
#define DKEventTarget_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////////
class DKEventTarget : public DKObjectT<DKEventTarget>
{
public:
	bool Init();
	static bool OnEvent(DKEvent* event);

	static int addEventListner(duk_context* ctx);
	static int removeEventListner(duk_context* ctx);

	// non-standard
	static int type(duk_context* ctx);
};


REGISTER_OBJECT(DKEventTarget, true)

#endif //DKEventTarget_H
#endif //USE_DKDuktape