//https://developer.mozilla.org/en-US/docs/Web/API/Console

#pragma once
#ifndef DKDomConsole_H
#define DKDomConsole_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////////
class DKDomConsole : public DKObjectT<DKDomConsole>
{
public:
	bool Init();
	
	static int clear(duk_context* ctx);
	static int debug(duk_context* ctx);
	static int error(duk_context* ctx);
	static int info(duk_context* ctx);
	static int warn(duk_context* ctx);
};


REGISTER_OBJECT(DKDomConsole, true)

#endif //DKDomConsole_H