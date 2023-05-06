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
		DKDuktape::AttachFunction("CPP_DKRmlLocationDUK", DKRmlLocationDUK::constructor);
			
			
		////// Load .js files
		DKClass::DKCreate("DKRmlLocation/DKRmlLocationDUK.js");
		
		return true;
	}
	
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKRmlLocationDUK()\n");
		DKRmlLocation* _dkRmlLocation = (DKRmlLocation*)DKClass::DKCreate("DKRmlLocation");
		DKString eventTargetAddress = pointerToAddress(_dkRmlLocation);
		duk_push_string(ctx, eventTargetAddress.c_str());	
		return true;
	}
	
};
REGISTER_OBJECT(DKRmlLocationDUK, true)


#endif //DKRmlLocationDUK_H
#endif //HAVE_DKDuktape
