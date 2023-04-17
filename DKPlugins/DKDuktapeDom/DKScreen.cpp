/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

//https://developer.mozilla.org/en-US/docs/Web/API/Screen

#ifdef HAVE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDuktapeDom/DKScreen.h"


bool DKScreen::Init(){
	DKDEBUGFUNC();

	//Properties
	DKDuktape::AttachFunction("CPP_DKScreen_availTop", DKScreen::availTop);
	DKDuktape::AttachFunction("CPP_DKScreen_availLeft", DKScreen::availLeft);
	DKDuktape::AttachFunction("CPP_DKScreen_availHeight", DKScreen::availHeight);
	DKDuktape::AttachFunction("CPP_DKScreen_availWidth", DKScreen::availWidth);
	DKDuktape::AttachFunction("CPP_DKScreen_colorDepth", DKScreen::colorDepth);
	DKDuktape::AttachFunction("CPP_DKScreen_height", DKScreen::height);
	DKDuktape::AttachFunction("CPP_DKScreen_left", DKScreen::left);
	DKDuktape::AttachFunction("CPP_DKScreen_orientation", DKScreen::orientation);
	DKDuktape::AttachFunction("CPP_DKScreen_pixelDepth", DKScreen::pixelDepth);
	DKDuktape::AttachFunction("CPP_DKScreen_top", DKScreen::top);
	DKDuktape::AttachFunction("CPP_DKScreen_width", DKScreen::width);
	DKDuktape::AttachFunction("CPP_DKScreen_mozEnabled", DKScreen::mozEnabled);
	DKDuktape::AttachFunction("CPP_DKScreen_mozBrightness", DKScreen::mozBrightness);

	//Methods
	DKDuktape::AttachFunction("CPP_DKScreen_lockOrientation", DKScreen::lockOrientation);
	DKDuktape::AttachFunction("CPP_DKScreen_unlockOrientations", DKScreen::unlockOrientation);

	DKClass::DKCreate("DKDuktapeDom/DKScreen.js");
	return true;
}


//Properties
int DKScreen::availTop(duk_context* ctx){
	//TODO
	DKDEBUGFUNC(ctx);
	return false;
}

int DKScreen::availLeft(duk_context* ctx){
	//TODO
	DKDEBUGFUNC(ctx);
	return false;
}

int DKScreen::availHeight(duk_context* ctx){
	//TODO
	DKDEBUGFUNC(ctx);
	return false;
}

int DKScreen::availWidth(duk_context* ctx){
	//TODO
	DKDEBUGFUNC(ctx);
	return false;
}

int DKScreen::colorDepth(duk_context* ctx){
	//TODO
	DKDEBUGFUNC(ctx);
	return false;
}

int DKScreen::height(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	unsigned int height;
	if(!DKUtil::GetScreenHeight(height)){ return 0; }
	duk_push_uint(ctx, height);
	return 1;
}

int DKScreen::left(duk_context* ctx){
	//TODO
	DKDEBUGFUNC(ctx);
	return false;
}

int DKScreen::orientation(duk_context* ctx){
	//TODO
	DKDEBUGFUNC(ctx);
	return false;
}

int DKScreen::pixelDepth(duk_context* ctx){
	//TODO
	DKDEBUGFUNC(ctx);
	return false;
}

int DKScreen::top(duk_context* ctx){
	//TODO
	DKDEBUGFUNC(ctx);
	return false;
}

int DKScreen::width(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	unsigned int width;
	if(!DKUtil::GetScreenWidth(width)) { return 0; }
	duk_push_uint(ctx, width);
	return 1;
}

int DKScreen::mozEnabled(duk_context* ctx){
	//TODO
	DKDEBUGFUNC(ctx);
	return false;
}

int DKScreen::mozBrightness(duk_context* ctx){
	//TODO
	DKDEBUGFUNC(ctx);
	return false;
}



//Methods
int DKScreen::lockOrientation(duk_context* ctx) {
	//TODO - https://developer.mozilla.org/en-US/docs/Web/API/Screen/lockOrientation
	DKDEBUGFUNC(ctx);
	DKString orientation = duk_require_string(ctx, 0);
	return false;
}

int DKScreen::unlockOrientation(duk_context* ctx){
	//TODO - https://developer.mozilla.org/en-US/docs/Web/API/Screen/unlockOrientation
	DKDEBUGFUNC(ctx);
	return false;
}

#endif //HAVE_DKDuktape