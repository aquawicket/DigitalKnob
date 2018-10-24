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

	static int Reload(duk_context* ctx);
	static int ToggleDebugger(duk_context* ctx);
	
	//document
	static int getElementById(duk_context* ctx);

	//element
	static int getAttribute(duk_context* ctx);
	static int hasAttribute(duk_context* ctx);
	static int setAttribute(duk_context* ctx);
	static int getProperty(duk_context* ctx);
	static int setProperty(duk_context* ctx);
};

REGISTER_OBJECT(DKRocketJS, true)

#endif //DKRocketJS_H
#endif //USE_DKDuktape