#ifdef USE_DKDuktape 
#pragma once
#ifndef DKWindowJS_H
#define DKWindowJS_H

#include "DKDuktape/DKDuktape.h"

class DKWindowJS : public DKObjectT<DKWindowJS>
{
public:
	bool Init();

	static int TestInt(duk_context* ctx);
	static int TestString(duk_context* ctx);
	static int TestReturnInt(duk_context* ctx);
	static int TestReturnString(duk_context* ctx);

	//static int GetGLMajorVersion(duk_context* ctx);
	//static int GetGLMinorVersion(duk_context* ctx);
	//static int GetGLVersion(duk_context* ctx);
	//static int GetGLVendor(duk_context* ctx);
	//static int GetGLRenderer(duk_context* ctx);

	static int Create(duk_context* ctx);
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
	static int Maximize(duk_context* ctx);
	static int MessageBox(duk_context* ctx);
	static int Minimize(duk_context* ctx);
	static int moveTo(duk_context* ctx);
	static int resizeTo(duk_context* ctx);
	static int Restore(duk_context* ctx);
	static int SetHeight(duk_context* ctx);
	static int SetIcon(duk_context* ctx);
	static int SetTitle(duk_context* ctx);
	static int SetWidth(duk_context* ctx);
	static int SetX(duk_context* ctx);
	static int SetY(duk_context* ctx);
	static int Show(duk_context* ctx);
	static int Windowed(duk_context* ctx);
};


REGISTER_OBJECT(DKWindowJS, true)

#endif //DKWindowJS_H
#endif //USE_DKDuktape