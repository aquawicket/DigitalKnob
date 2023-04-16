#if HAVE_DKDuktape

#pragma once
#ifndef DKLocationDUK_H
#define DKLocationDUK_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [INTERFACE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location
class DKLocationDUK : public DKObjectT<DKLocationDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKLocationDUK", DKLocationDUK::constructor);
		

		
		////// Load .js files
		DKClass::DKCreate("DKLocation/DKLocationDUK.js");
		
		return true;
	}
	
	////// Constructor //////
	// [Location()]
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKLocationDUK()\n");
		DKLocation* _location = new DKLocation();
		DKString eventTargetAddress = pointerToAddress(_location);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
};
REGISTER_OBJECT(DKLocationDUK, true)


#endif //DKLocationDUK_H
#endif //HAVE_DKDuktape