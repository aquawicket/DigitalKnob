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

	static int LoadUrl(duk_context* ctx);
	static int Reload(duk_context* ctx);
	static int ToggleDebugger(duk_context* ctx);

	//events
	static int addEventListener(duk_context* ctx);
	static int removeEventListener(duk_context* ctx);
	
	//window
	static int innerHeight(duk_context* ctx);
	static int innerWidth(duk_context* ctx);
	static int name(duk_context* ctx);

	//element
	static int parentNode(duk_context* ctx);
};

REGISTER_OBJECT(DKRocketJS, true)

#endif //DKRocketJS_H
#endif //USE_DKDuktape