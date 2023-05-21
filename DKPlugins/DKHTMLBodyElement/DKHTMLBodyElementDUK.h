#if HAVE_DKDuktape

#pragma once
#ifndef DKHTMLBodyElementDUK_H
#define DKHTMLBodyElementDUK_H

#include "DKDuktape/DKDuktape.h"


class DKHTMLBodyElementDUK : public DKObjectT<DKHTMLBodyElementDUK>
{
public:
	bool Init(){	
		DKDuktape::AttachFunction("CPP_DKHTMLBodyElementDUK", DKHTMLBodyElementDUK::constructor);
		
		// TODO

		////// Load .js files //////
		DKClass::DKCreate("DKHTMLElement/DKHTMLBodyElementDUK.js");
		
		return true;
	}
	
	static DKHTMLElement* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKHTMLElement*)addressToPointer(eventTargetAddress);
	}

	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKHTMLBodyElementDUK()\n");
		DKHTMLBodyElement* _htmlBodyElement = new DKHTMLBodyElement();
		DKString eventTargetAddress = pointerToAddress(_htmlBodyElement);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	// TODO
		
};
REGISTER_OBJECT(DKHTMLBodyElementDUK, true)


#endif //DKHTMLBodyElementDUK_H
#endif //HAVE_DKDuktape