// [IDL] https://www.w3.org/TR/DOM-Parsing/#widl-Element-innerHTML
#if HAVE_DKDuktape

#pragma once
#ifndef DKInnerHTMLDUK_H
#define DKInnerHTMLDUK_H

#include "DKDuktape/DKDuktape.h"
#include "DKElement/DKElement.h"

// Source: DOM Parsing and Serialization (https://www.w3.org/TR/DOM-Parsing/)
// interface mixin InnerHTML {
class DKInnerHTMLDUK : public DKObjectT<DKInnerHTMLDUK>
{
public:
	bool Init(){
		
		// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerHTML;
		DKDuktape::AttachFunction("CPP_DKInnerHTMLDUK_innerHTML", 	DKInnerHTMLDUK::innerHTML);
		
		DKClass::DKCreate("DKInnerHTML/DKInnerHTMLDUK.js");
		
		return true;
	}
	
	//FIXME: since this is a mixin, we need to know which base class called
	static DKElement* element(duk_context* ctx){		
		DKString interfaceAddress = duk_require_string(ctx, 0);
		DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
		DKASSERT(interface);
		
		DKString elementAddress = interface->address["Element"];			
		DKElement* _element = (DKElement*)addressToPointer(elementAddress);
		DKASSERT(_element);
		return _element;
	}
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerHTML;
	static int innerHTML(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("DKInnerHTMLDUK::innerHTML()\n");
		if (duk_is_valid_index(ctx, 1)){
			element(ctx)->innerHTML(duk_require_string(ctx, 1));
		}
		else {
			dukglue_push(ctx, element(ctx)->innerHTML());
		}
		return true;
	}
};
REGISTER_OBJECT(DKInnerHTMLDUK, true)

#endif //DKInnerHTMLDUK_H
#endif //HAVE_DKDuktape