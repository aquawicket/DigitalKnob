#ifdef USE_DKDuktape 
#pragma once
#ifndef DKConsole_H
#define DKConsole_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////
class DKConsole : public DKObjectT<DKConsole>
{
public:
	bool Init();
	
	static int clear(duk_context* ctx);
	static int debug(duk_context* ctx);
	static int error(duk_context* ctx);
	static int info(duk_context* ctx);
	static int warn(duk_context* ctx);
};


REGISTER_OBJECT(DKConsole, true)

#endif //DKConsole_H
#endif //USE_DKDuktape