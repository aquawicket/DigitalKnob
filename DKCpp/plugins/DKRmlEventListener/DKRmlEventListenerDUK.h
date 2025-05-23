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
		
		DKINFO("CPP_DKRmlEventListenerDUK_constructor()\n");
		DKRmlEventListener* dkRmlEventListener = new DKRmlEventListener();
		dukglue_push(ctx, dkRmlEventListener->interfaceAddress);
		return true;
	}
	
};
REGISTER_OBJECT(DKRmlEventListenerDUK, true)


#endif //DKRmlEventListenerDUK_H
#endif //HAVE_DKDuktape
