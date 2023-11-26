// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location
#if HAVE_DKDuktape

#pragma once
#ifndef DKRmlLocationDUK_H
#define DKRmlLocationDUK_H

#include "DKRmlLocation/DKRmlLocation.h"
#include "DKDuktape/DKDuktape.h"


class DKRmlLocationDUK : public DKObjectT<DKRmlLocationDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKRmlLocationDUK_constructor", DKRmlLocationDUK::constructor);
			
			
		////// Load .js files
		DKClass::DKCreate("DKRmlLocation/DKRmlLocationDUK.js");
		
		return true;
	}
	
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString rmlInterfaceAddress = duk_require_string(ctx, 0);
		DKInterface* rmlInterface = (DKInterface*)addressToPointer(rmlInterfaceAddress);
		DKASSERT(rmlInterface);
		
		DKString dkRmlInterfaceAddress = rmlInterface->address["RmlInterface"];
		DKRmlInterface* dkRmlInterface = (DKRmlInterface*)addressToPointer(dkRmlInterfaceAddress);
		DKASSERT(dkRmlInterface);
		
		DKString rmlEventListenerInterfaceAddress = duk_require_string(ctx, 1);
		DKInterface* rmlEventListenerInterface = (DKInterface*)addressToPointer(rmlEventListenerInterfaceAddress);
		DKASSERT(rmlEventListenerInterface);
		
		DKString dkRmlEventListenerAddress = rmlEventListenerInterface->address["RmlEventListener"];
		DKRmlEventListener* dkRmlEventListener = (DKRmlEventListener*)addressToPointer(dkRmlEventListenerAddress);
		DKASSERT(dkRmlEventListener);
		
		DKINFO("CPP_DKRmlLocationDUK_constructor("+dkRmlInterfaceAddress+","+dkRmlEventListenerAddress+")\n");
		DKRmlLocation* dkRmlLocation = new DKRmlLocation(dkRmlInterface, dkRmlEventListener);
		DKASSERT(dkRmlLocation);
		
		dukglue_push(ctx, dkRmlLocation->interfaceAddress);
		return true;
	}
	
};
REGISTER_OBJECT(DKRmlLocationDUK, true)


#endif //DKRmlLocationDUK_H
#endif //HAVE_DKDuktape
