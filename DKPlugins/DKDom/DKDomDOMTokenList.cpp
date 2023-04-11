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
#include "DK/DKApp.h"
#include "DKDom/DKDom.h"
#include "DKDom/DKDomDOMTokenList.h"


bool DKDomDOMTokenList::Init(){
	DKDEBUGFUNC();

	////// Instance properties //////
	DKDuktape::AttachFunction("CPP_DKDomDOMTokenList_length",	DKDomDOMTokenList::length);
	DKDuktape::AttachFunction("CPP_DKDomDOMTokenList_value",	DKDomDOMTokenList::value);

	////// Instance methods //////
	DKDuktape::AttachFunction("CPP_DKDomDOMTokenList_item",		DKDomDOMTokenList::item);
	DKDuktape::AttachFunction("CPP_DKDomDOMTokenList_contains",	DKDomDOMTokenList::contains);
	DKDuktape::AttachFunction("CPP_DKDomDOMTokenList_add",		DKDomDOMTokenList::add);
	DKDuktape::AttachFunction("CPP_DKDomDOMTokenList_remove",	DKDomDOMTokenList::remove);
	DKDuktape::AttachFunction("CPP_DKDomDOMTokenList_replace",	DKDomDOMTokenList::replace);
	DKDuktape::AttachFunction("CPP_DKDomDOMTokenList_supports",	DKDomDOMTokenList::supports);
	DKDuktape::AttachFunction("CPP_DKDomDOMTokenList_toggle",	DKDomDOMTokenList::toggle);
	DKDuktape::AttachFunction("CPP_DKDomDOMTokenList_entries",	DKDomDOMTokenList::entries);
	DKDuktape::AttachFunction("CPP_DKDomDOMTokenList_forEach",	DKDomDOMTokenList::forEach);
	DKDuktape::AttachFunction("CPP_DKDomDOMTokenList_keys",		DKDomDOMTokenList::keys);
	DKDuktape::AttachFunction("CPP_DKDomDOMTokenList_values",	DKDomDOMTokenList::values);

	DKClass::DKCreate("DKDom/DKDomDOMTokenList.js");
	return true;
}

////// Instance properties //////
int DKDomDOMTokenList::length(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKTODO();
}

int DKDomDOMTokenList::value(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKTODO();
}


////// Instance methods //////
int DKDomDOMTokenList::item(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKTODO();
}

int DKDomDOMTokenList::contains(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKTODO();
}

int DKDomDOMTokenList::add(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = (Rml::Element*)addressToPointer(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	DKString token = duk_require_string(ctx, 1);
	element->SetPseudoClass(token, true);
	return true;
}

int DKDomDOMTokenList::remove(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = (Rml::Element*)addressToPointer(address);
	if (!element) {
		DKERROR("element invalid\n");
		duk_push_undefined(ctx);
		return true;
	}
	DKString token = duk_require_string(ctx, 1);
	element->SetPseudoClass(token, false);
	return true;
}

int DKDomDOMTokenList::replace(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKTODO();
}

int DKDomDOMTokenList::supports(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKTODO();
}

int DKDomDOMTokenList::toggle(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKTODO();
}

int DKDomDOMTokenList::entries(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKTODO();
}

int DKDomDOMTokenList::forEach(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKTODO();
}

int DKDomDOMTokenList::keys(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKTODO();
}

int DKDomDOMTokenList::values(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKTODO();
}
