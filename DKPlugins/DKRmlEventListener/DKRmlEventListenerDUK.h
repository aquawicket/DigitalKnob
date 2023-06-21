#if HAVE_DKDuktape

#pragma once
#ifndef DKRmlEventListenerDUK_H
#define DKRmlEventListenerDUK_H

#include "DKRmlEventListener/DKRmlEventListener.h"
#include "DKDuktape/DKDuktape.h"


class DKRmlEventListenerDUK : public DKObjectT<DKRmlEventListenerDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKRmlEventListenerDUK_constructor", DKRmlEventListenerDUK::constructor);
			
			
		////// Load .js files
		DKClass::DKCreate("DKRmlEventListener/DKRmlEventListenerDUK.js");
		
		return true;
	}
	
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString dkRmlInterfaceAddress = duk_require_string(ctx, 0);
		DKRmlInterface* dkRmlInterface = (DKRmlInterface*)addressToPointer(dkRmlInterfaceAddress);
		DKString dkRmlEventListenerAddress = duk_require_string(ctx, 1);
		DKRmlEventListener* dkRmlEventListener = (DKRmlEventListener*)addressToPointer(dkRmlEventListenerAddress);
		DKINFO("CPP_DKRmlEventListenerDUK_constructor("+dkRmlInterfaceAddress+","+dkRmlEventListenerAddress+")\n");
		DKRmlLocation* dkRmlLocation = new DKRmlLocation(dkRmlInterface, dkRmlEventListener);
		DKString dkRmlLocationAddress = pointerToAddress(dkRmlLocation);
		duk_push_string(ctx, dkRmlLocationAddress.c_str());	
		return true;
	}
	
};
REGISTER_OBJECT(DKRmlEventListenerDUK, true)


#endif //DKRmlEventListenerDUK_H
#endif //HAVE_DKDuktape
