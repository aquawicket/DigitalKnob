#ifdef USE_DKDuktape
#pragma once
#ifndef DKRmlJS_H
#define DKRmlJS_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////
class DKRmlJS : public DKObjectT<DKRmlJS>
{
public:
	bool Init();

	static int LoadUrl(duk_context* ctx);
	static int ToggleDebugger(duk_context* ctx);

	//events
	static int addEventListener(duk_context* ctx);
	static int removeEventListener(duk_context* ctx);
	
	//window
	static int devicePixelRatio(duk_context* ctx);
	static int innerHeight(duk_context* ctx);
	static int innerWidth(duk_context* ctx);
	static int name(duk_context* ctx);
};

REGISTER_OBJECT(DKRmlJS, true)

#endif //DKRmlJS_H
#endif //USE_DKDuktape