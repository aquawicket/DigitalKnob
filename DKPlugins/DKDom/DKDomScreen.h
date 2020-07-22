//https://developer.mozilla.org/en-US/docs/Web/API/Screen

#pragma once
#ifndef DKDomScreen_H
#define DKDomScreen_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////
class DKDomScreen : public DKObjectT<DKDomScreen>
{
public:
	bool Init();
	
	//Properties
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

	//Methods
	static int lockOrientation(duk_context* ctx);
	static int unlockOrientation(duk_context* ctx);
};


REGISTER_OBJECT(DKDomScreen, true)

#endif //DKDomScreen_H