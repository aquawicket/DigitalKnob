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
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

//https://developer.mozilla.org/en-US/docs/Web/API/Screen

#include "DK/DKApp.h"
#include "DKDom/DKDomScreen.h"


bool DKDomScreen::Init(){
	DKDEBUGFUNC();

	//Properties
	DKDuktape::AttachFunction("CPP_DKDomScreen_availTop", DKDomScreen::availTop);
	DKDuktape::AttachFunction("CPP_DKDomScreen_availLeft", DKDomScreen::availLeft);
	DKDuktape::AttachFunction("CPP_DKDomScreen_availHeight", DKDomScreen::availHeight);
	DKDuktape::AttachFunction("CPP_DKDomScreen_availWidth", DKDomScreen::availWidth);
	DKDuktape::AttachFunction("CPP_DKDomScreen_colorDepth", DKDomScreen::colorDepth);
	DKDuktape::AttachFunction("CPP_DKDomScreen_height", DKDomScreen::height);
	DKDuktape::AttachFunction("CPP_DKDomScreen_left", DKDomScreen::left);
	DKDuktape::AttachFunction("CPP_DKDomScreen_orientation", DKDomScreen::orientation);
	DKDuktape::AttachFunction("CPP_DKDomScreen_pixelDepth", DKDomScreen::pixelDepth);
	DKDuktape::AttachFunction("CPP_DKDomScreen_top", DKDomScreen::top);
	DKDuktape::AttachFunction("CPP_DKDomScreen_width", DKDomScreen::width);
	DKDuktape::AttachFunction("CPP_DKDomScreen_mozEnabled", DKDomScreen::mozEnabled);
	DKDuktape::AttachFunction("CPP_DKDomScreen_mozBrightness", DKDomScreen::mozBrightness);

	//Methods
	DKDuktape::AttachFunction("CPP_DKDomScreen_lockOrientation", DKDomScreen::lockOrientation);
	DKDuktape::AttachFunction("CPP_DKDomScreen_unlockOrientations", DKDomScreen::unlockOrientation);

	DKClass::DKCreate("DKDom/DKDomScreen.js");
	return true;
}


//Properties
int DKDomScreen::availTop(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

int DKDomScreen::availLeft(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

int DKDomScreen::availHeight(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

int DKDomScreen::availWidth(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

int DKDomScreen::colorDepth(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

int DKDomScreen::height(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int height;
	if (!DKUtil::GetScreenHeight(height))
		return DKERROR("DKUtil::GetScreenHeight() failed! \n");
	duk_push_number(ctx, height);
	return true;
}

int DKDomScreen::left(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

int DKDomScreen::orientation(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

int DKDomScreen::pixelDepth(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

int DKDomScreen::top(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

int DKDomScreen::width(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int width;
	if(!DKUtil::GetScreenWidth(width))
		return DKERROR("DKUtil::GetScreenWidth() failed! \n");
	duk_push_number(ctx, width);
	return true;
}

int DKDomScreen::mozEnabled(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}

int DKDomScreen::mozBrightness(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return false;
}



//Methods
int DKDomScreen::lockOrientation(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	//TODO - https://developer.mozilla.org/en-US/docs/Web/API/Screen/lockOrientation
	DKString orientation = duk_require_string(ctx, 0);
	return false;
}

int DKDomScreen::unlockOrientation(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO - https://developer.mozilla.org/en-US/docs/Web/API/Screen/unlockOrientation
	return false;
}