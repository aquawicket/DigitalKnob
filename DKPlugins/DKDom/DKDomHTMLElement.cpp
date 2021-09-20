//https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement

#include "DK/DKApp.h"
#include "DKDom/DKDomHTMLElement.h"


bool DKDomHTMLElement::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKDomHTMLElement_focus", DKDomHTMLElement::focus);
	DKDuktape::AttachFunction("CPP_DKDomHTMLElement_offsetHeight", DKDomHTMLElement::offsetHeight);
	DKDuktape::AttachFunction("CPP_DKDomHTMLElement_offsetLeft", DKDomHTMLElement::offsetLeft);
	DKDuktape::AttachFunction("CPP_DKDomHTMLElement_offsetParent", DKDomHTMLElement::offsetParent);
	DKDuktape::AttachFunction("CPP_DKDomHTMLElement_offsetTop", DKDomHTMLElement::offsetTop);
	DKDuktape::AttachFunction("CPP_DKDomHTMLElement_offsetWidth", DKDomHTMLElement::offsetWidth);
	DKClass::DKCreate("DKDom/DKDomHTMLElement.js");
	return true;
}

int DKDomHTMLElement::focus(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		duk_push_boolean(ctx, false);
		return DKERROR("DKDomElement::focus(): element invalid\n");
	}
	if(!element->Focus()){
		duk_push_boolean(ctx, false);
		return DKERROR("DKDomElement::focus(): focus failed\n");
	}
	duk_push_boolean(ctx, true);
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
