#if HAVE_DKDuktape

#pragma once
#ifndef DKElementDUK_H
#define DKElementDUK_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [IDL] https://dom.spec.whatwg.org/#interface-element
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Element
class DKElementDUK : public DKObjectT<DKElementDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKElementDUK", DKElementDUK::constructor);	// [Element()]
		
		
		////// Instance properties //////
		// TODO

		////// Load .js files
		DKClass::DKCreate("DKElement/DKElementDUK.js");
		
		return true;
	}
	
	static DKElement* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKElement*)addressToPointer(eventTargetAddress);
	}

	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKElementDUK()\n");
		DKElement* _element = new DKElement();
		DKString eventTargetAddress = pointerToAddress(_element);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	
	////// Instance properties //////
	// TODO
	
};
REGISTER_OBJECT(DKElementDUK, true)


#endif //DKElementDUK_H
#endif //HAVE_DKDuktape