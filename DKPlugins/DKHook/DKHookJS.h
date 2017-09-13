#ifdef WIN32
#ifdef USE_DKDuktape 
#pragma once
#ifndef DKHookJS_H
#define DKHookJS_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////
class DKHookJS : public DKObjectT<DKHookJS>
{
public:
	void Init();

	static int Click(duk_context* ctx);
	static int CurrentHandle(duk_context* ctx);
	static int GetValue(duk_context* ctx);
	static int GetWindows(duk_context* ctx);
	static int NextHandle(duk_context* ctx);
	static int PrevHandle(duk_context* ctx);
	static int SendHook(duk_context* ctx);
	static int SetValue(duk_context* ctx);
	static int SetWindowHandle(duk_context* ctx);
	static int ToggleHighlight(duk_context* ctx);
	static int WaitForWindow(duk_context* ctx);
	static int WindowExists(duk_context* ctx);
};

REGISTER_OBJECT(DKHookJS, true)

#endif //DKHookJS_H
#endif //USE_DKDuktape
#endif //WIN32