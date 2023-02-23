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

//https://developer.mozilla.org/en-US/docs/Web/API/HTMLScriptElement

#include "DK/DKApp.h"
#include "DKDom/DKDom.h"
#include "DKDom/DKDomHTMLScriptElement.h"


bool DKDomHTMLScriptElement::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKDomHTMLScriptElement_async", DKDomHTMLScriptElement::async);
	DKClass::DKCreate("DKDom/DKDomHTMLScriptElement.js");
	return true;
}

int DKDomHTMLScriptElement::async(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	//Rml::Element* element = DKRml::addressToElement(address);
	Rml::Element* element = (Rml::Element*)DKDuktape::addressToPointer(address);
	if (!element) {
		duk_push_undefined(ctx);
		return DKERROR("element invalid\n");
	}
	//if(!element->async()){
	//	duk_push_undefined(ctx);
	//	return DKERROR("async failed\n");
	//}
	duk_push_boolean(ctx, true);
	return true;
}
