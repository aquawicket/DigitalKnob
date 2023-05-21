// [IDL] https://dom.spec.whatwg.org/#interface-htmlcollection
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection
#if HAVE_DKDuktape

#pragma once
#ifndef DKHTMLCollectionDUK_H
#define DKHTMLCollectionDUK_H

#include "DKInterface/DKInterface.h"

// [Exposed=Window, LegacyUnenumerableNamedProperties]
// interface HTMLCollection {
class DKHTMLCollectionDUK : public DKObjectT<DKHTMLCollectionDUK>
{
public:
	bool Init(){
		
		DKDuktape::AttachFunction("CPP_DKHTMLCollectionDUK", DKHTMLCollectionDUK::constructor);
		
		// readonly attribute unsigned long length;
		DKDuktape::AttachFunction("CPP_DKHTMLCollectionDUK_length", DKHTMLCollectionDUK::length);

		// getter Element? item(unsigned long index);
		DKDuktape::AttachFunction("CPP_DKHTMLCollectionDUK_item", DKHTMLCollectionDUK::item);
	
		// getter Element? namedItem(DOMString name);
		DKDuktape::AttachFunction("CPP_DKHTMLCollectionDUK_namedItem", DKHTMLCollectionDUK::namedItem);
		
	
		////// Load .js files
		DKClass::DKCreate("DKHTMLElement/DKHTMLCollectionDUK.js");
		
		return true;
	}
	
	static DKHTMLElement* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKHTMLElement*)addressToPointer(eventTargetAddress);
	}

	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKHTMLCollectionDUK()\n");
		DKHTMLElement* _htmlelement = new DKHTMLElement();
		DKString eventTargetAddress = pointerToAddress(_htmlelement);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	// readonly attribute unsigned long length;
	static int length(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->length(GetUint(ctx));
		dukglue_push(ctx, eventTarget(ctx)->length());
		return true;
	}
	
	// getter Element? item(unsigned long index);
	// TODO
	
	// getter Element? namedItem(DOMString name);
	// TODO
		
};
REGISTER_OBJECT(DKHTMLCollectionDUK, true)


#endif //DKHTMLCollectionDUK_H
#endif //HAVE_DKDuktape