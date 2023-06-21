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
		DKString dkRmlInterfaceAddress = duk_require_string(ctx, 0);
		DKRmlInterface* dkRmlInterface = (DKRmlInterface*)addressToPointer(dkRmlInterfaceAddress);
		DKString dkRmlEventListenerAddress = duk_require_string(ctx, 1);
		DKRmlEventListener* dkRmlEventListener = (DKRmlEventListener*)addressToPointer(dkRmlEventListenerAddress);
		DKINFO("CPP_DKRmlLocationDUK_constructor("+dkRmlInterfaceAddress+","+dkRmlEventListenerAddress+")\n");
		DKRmlLocation* dkRmlLocation = new DKRmlLocation(dkRmlInterface, dkRmlEventListener);
		DKString dkRmlLocationAddress = pointerToAddress(dkRmlLocation);
		duk_push_string(ctx, dkRmlLocationAddress.c_str());	
		return true;
	}
	
};
REGISTER_OBJECT(DKRmlLocationDUK, true)


#endif //DKRmlLocationDUK_H
#endif //HAVE_DKDuktape
