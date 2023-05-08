#if HAVE_DKDuktape

#pragma once
#ifndef DKHTMLElementDUK_H
#define DKHTMLElementDUK_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
	#include "dukglue/dukglue.h"
WARNING_ENABLE


// [IDL] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
class DKHTMLElementDUK : public DKObjectT<DKHTMLElementDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK", DKHTMLElementDUK::constructor);		// [HTMLElement()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/HTMLElement
		
		////// Instance properties //////
		// TODO

		////// Load .js files
		DKClass::DKCreate("DKHTMLElement/DKHTMLElementDUK.js");
		
		return true;
	}
	
	static DKHTMLElement* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKHTMLElement*)addressToPointer(eventTargetAddress);
	}

	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKHTMLElementDUK()\n");
		DKHTMLElement* _htmlelement = new DKHTMLElement();
		DKString eventTargetAddress = pointerToAddress(_htmlelement);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	
	////// Instance properties //////
	// TODO
		
};
REGISTER_OBJECT(DKHTMLElementDUK, true)


#endif //DKHTMLElementDUK_H
#endif //HAVE_DKDuktape