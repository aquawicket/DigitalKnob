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
	
	// Methods
	static int _assert(duk_context* ctx);
	static int clear(duk_context* ctx);
	static int count(duk_context* ctx);
	static int countReset(duk_context* ctx);
	static int debug(duk_context* ctx);
	static int dir(duk_context* ctx);
	static int dirxml(duk_context* ctx);
	static int error(duk_context* ctx);
	static int exception(duk_context* ctx);
	static int group(duk_context* ctx);
	static int groupCollapsed(duk_context* ctx);
	static int groupEnd(duk_context* ctx);
	static int info(duk_context* ctx);
	static int log(duk_context* ctx);
	static int profile(duk_context* ctx);
	static int profileEnd(duk_context* ctx);
	static int table(duk_context* ctx);
	static int time(duk_context* ctx);
	static int timeEnd(duk_context* ctx);
	static int timeLog(duk_context* ctx);
	static int timeStamp(duk_context* ctx);
	static int trace(duk_context* ctx);
	static int warn(duk_context* ctx);
};


REGISTER_OBJECT(DKDomConsole, true)

#endif //DKDomConsole_H