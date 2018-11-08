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
	
	static int availTop(duk_context* ctx);
	static int availLeft(duk_context* ctx);
	static int availHeight(duk_context* ctx);
	static int availWidth(duk_context* ctx);
	static int colorDepth(duk_context* ctx);
	static int height(duk_context* ctx);
	static int left(duk_context* ctx);
	static int orientation(duk_context* ctx);
	static int pixelDepth(duk_context* ctx);
	static int top(duk_context* ctx);
	static int width(duk_context* ctx);
	static int mozEnabled(duk_context* ctx);
	static int mozBrightness(duk_context* ctx);
};


REGISTER_OBJECT(DKConsole, true)

#endif //DKConsole_H
#endif //USE_DKDuktape