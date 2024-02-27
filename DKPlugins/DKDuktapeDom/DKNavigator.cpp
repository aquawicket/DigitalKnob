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

#ifdef HAVE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDuktapeDom/DKNavigator.h"


bool DKNavigator::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKNavigator_onLine", DKNavigator::onLine);
	DKDuktape::AttachFunction("CPP_DKNavigator_platform", DKNavigator::platform);
	DKDuktape::AttachFunction("CPP_DKNavigator_productSub", DKNavigator::productSub);
	DKClass::DKCreate("DKDuktapeDom/DKNavigator.js");
	return true;
}

int DKNavigator::onLine(duk_context* ctx){
	//TODO
	DKDEBUGFUNC(ctx);
	return false;
}

int DKNavigator::platform(duk_context* ctx){
	//TODO - complete this for all OS's
	DKDEBUGFUNC(ctx);
#ifdef WIN_X86_64
	duk_push_string(ctx, "WIN_X86_64");
	return true;
#elif WIN_X86
	duk_push_string(ctx, "WIN_X86");
	return true;
#elif MAC
	duk_push_string(ctx, "MacIntel");
	return true;
#else
	DKERROR("platform invalid\n");
	return false;
#endif
}

int DKNavigator::productSub(duk_context* ctx){
	//TODO
	DKDEBUGFUNC(ctx);
	return false;
}


#endif //HAVE_DKDuktape