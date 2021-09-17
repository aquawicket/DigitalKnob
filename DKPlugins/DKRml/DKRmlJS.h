#ifdef USE_DKDuktape
#pragma once
#ifndef DKRmlJS_H
#define DKRmlJS_H

#include "DKDuktape/DKDuktape.h"

class DKRmlJS : public DKObjectT<DKRmlJS>{
public:
	bool Init();

	static int LoadUrl(duk_context* ctx);
	static int DebuggerOff(duk_context* ctx);
	static int DebuggerOn(duk_context* ctx);
	static int DebuggerToggle(duk_context* ctx);
	static int PostProcess(duk_context* ctx);
};

REGISTER_OBJECT(DKRmlJS, true)
#endif //DKRmlJS_H
#endif //USE_DKDuktape