#ifdef WIN32
#ifdef USE_DKDuktape 
#pragma once
#ifndef DKHandlesJS_H
#define DKHandlesJS_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////
class DKHandlesJS : public DKObjectT<DKHandlesJS>
{
public:
	bool Init();

	static int Click(duk_context* ctx);
	static int CurrentHandle(duk_context* ctx);
	static int GetBottom(duk_context* ctx);
	static int GetClass(duk_context* ctx);
	static int GetIndex(duk_context* ctx);
	static int GetLeft(duk_context* ctx);
	static int GetParent(duk_context* ctx);
	static int GetRight(duk_context* ctx);
	static int GetTop(duk_context* ctx);
	static int GetValue(duk_context* ctx);
	static int GetWindow(duk_context* ctx);
	static int GetWindowIndex(duk_context* ctx);
	static int GetWindows(duk_context* ctx);
	static int NextHandle(duk_context* ctx);
	static int PrevHandle(duk_context* ctx);
	//static int SendHook(duk_context* ctx);
	static int SetHandle(duk_context* ctx);
	static int SetValue(duk_context* ctx);
	static int SetWindowHandle(duk_context* ctx);
	static int ShowWindow(duk_context* ctx);
	static int StartSearch(duk_context* ctx);
	static int ToggleHighlight(duk_context* ctx);
	static int WaitForHandle(duk_context* ctx);
	static int WaitForWindow(duk_context* ctx);
	static int WindowExists(duk_context* ctx);
};

REGISTER_OBJECT(DKHandlesJS, true)

#endif //DKHandlesJS_H
#endif //USE_DKDuktape
#endif //WIN32