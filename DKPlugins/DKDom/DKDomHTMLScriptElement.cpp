//https://developer.mozilla.org/en-US/docs/Web/API/HTMLScriptElement

#include "DK/DKApp.h"
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
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		duk_push_undefined(ctx);
		return DKERROR("element invalid\n");
	}
	if(!element->async()){
		duk_push_undefined(ctx);
		return DKERROR("focus failed\n");
	}
	duk_push_boolean(ctx, true);
	return true;
}
