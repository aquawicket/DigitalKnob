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

//https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement

#include "DK/DKApp.h"
#include "DKDom/DKDom.h"
#include "DKDom/DKDomHTMLElement.h"


bool DKDomHTMLElement::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKDomHTMLElement_click", DKDomHTMLElement::click);
	DKDuktape::AttachFunction("CPP_DKDomHTMLElement_focus", DKDomHTMLElement::focus);
	DKDuktape::AttachFunction("CPP_DKDomHTMLElement_innerText", DKDomHTMLElement::innerText);
	DKDuktape::AttachFunction("CPP_DKDomHTMLElement_offsetHeight", DKDomHTMLElement::offsetHeight);
	DKDuktape::AttachFunction("CPP_DKDomHTMLElement_offsetLeft", DKDomHTMLElement::offsetLeft);
	DKDuktape::AttachFunction("CPP_DKDomHTMLElement_offsetParent", DKDomHTMLElement::offsetParent);
	DKDuktape::AttachFunction("CPP_DKDomHTMLElement_offsetTop", DKDomHTMLElement::offsetTop);
	DKDuktape::AttachFunction("CPP_DKDomHTMLElement_offsetWidth", DKDomHTMLElement::offsetWidth);
	DKClass::DKCreate("DKDom/DKDomHTMLElement.js");
	return true;
}

int DKDomHTMLElement::click(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomElement::focus(): element invalid\n");
	}
	element->Click();
	return true;
}

int DKDomHTMLElement::focus(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomElement::focus(): element invalid\n");
	}
	if(!element->Focus()){
		duk_push_undefined(ctx);
		return DKERROR("DKDomElement::focus(): focus failed\n");
	}
	duk_push_boolean(ctx, true);
	return true;
}

int DKDomHTMLElement::innerText(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("DKDomElement::offsetParent(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Rml::String innerRml = element->GetInnerRML(); //FIXME: this is not exactly what we need, but close
	duk_push_string(ctx, innerRml.c_str());
	return true;
}

int DKDomHTMLElement::offsetHeight(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("DKDomElement::offsetParent(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	float offsetHeight = element->GetOffsetHeight();
	duk_push_number(ctx, offsetHeight);
	return true;
}

int DKDomHTMLElement::offsetLeft(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("DKDomElement::offsetParent(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	float offsetLeft = element->GetOffsetLeft();
	duk_push_number(ctx, offsetLeft);
	return true;
}

int DKDomHTMLElement::offsetParent(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("DKDomElement::offsetParent(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	Rml::Element* offsetParent = element->GetOffsetParent();
	if(!offsetParent){ 
		DKERROR("DKDomElement::offsetParent(): offsetParent invalid, setting to parent\n");
		offsetParent = element->GetParentNode();
	}
	const DKString string = DKRml::elementToAddress(offsetParent);
	duk_push_string(ctx, string.c_str());
	return true;
}

int DKDomHTMLElement::offsetTop(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("DKDomElement::offsetTop(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	float offsetTop = element->GetOffsetTop();
	duk_push_number(ctx, offsetTop);
	return true;
}

int DKDomHTMLElement::offsetWidth(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		DKERROR("DKDomElement::offsetParent(): element invalid\n");
		duk_push_boolean(ctx, false);
		return true;
	}
	float offsetLeft = element->GetOffsetWidth();
	duk_push_number(ctx, offsetLeft);
	return true;
}
