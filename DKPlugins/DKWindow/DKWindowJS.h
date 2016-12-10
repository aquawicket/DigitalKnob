#ifdef USE_DKDuktape 
#pragma once
#ifndef DKWindowJS_H
#define DKWindowJS_H

#include "DKDuktape.h"

///////////////////////////////////////////////
class DKWindowJS : public DKObjectT<DKWindowJS>
{
public:
	void Init();
	static int Fullscreen(duk_context* ctx);
	static int GetHeight(duk_context* ctx);
	static int GetMouseX(duk_context* ctx);
	static int GetMouseY(duk_context* ctx);
	static int GetPixelRatio(duk_context* ctx);
	static int GetWidth(duk_context* ctx);
	static int GetX(duk_context* ctx);
	static int GetY(duk_context* ctx);
	static int Hide(duk_context* ctx);
	static int IsFullscreen(duk_context* ctx);
	static int IsVisible(duk_context* ctx);
	static int Minimize(duk_context* ctx);
	static int Restore(duk_context* ctx);
	static int SetHeight(duk_context* ctx);
	static int SetWidth(duk_context* ctx);
	static int SetX(duk_context* ctx);
	static int SetY(duk_context* ctx);
	static int Show(duk_context* ctx);
	static int Windowed(duk_context* ctx);
};


REGISTER_OBJECT(DKWindowJS, true)

#endif //DKWindowJS_H
#endif //USE_DKDuktape