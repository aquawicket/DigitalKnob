#ifdef USE_DKDuktape 
#pragma once
#ifndef DKDebugJS_H
#define DKDebugJS_H

#include "DKDuktape/DKDuktape.h"

class DKDebugJS : public DKObjectT<DKDebugJS>{
public:
	bool Init();
	static int SendBugReport(duk_context* ctx);
	static int ShowStackTrace(duk_context* ctx);
};

REGISTER_OBJECT(DKDebugJS, true)

#endif //DKDebugJS_H
#endif //USE_DKDuktape