#if HAVE_DKDuktape

#pragma once
#ifndef DKRmlInterfaceDUK_H
#define DKRmlInterfaceDUK_H

#include "DKRmlInterface/DKRmlInterface.h"
#include "DKDuktape/DKDuktape.h"


class DKRmlInterfaceDUK : public DKObjectT<DKRmlInterfaceDUK>
{
public:
	bool Init(){
		DKDuktape::AttachFunction("CPP_DKRmlInterfaceDUK_constructor", DKRmlInterfaceDUK::constructor);
			
		////// Load .js files
		DKClass::DKCreate("DKRmlInterface/DKRmlInterfaceDUK.js");
		
		return true;
	}
	
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKRmlInterfaceDUK_constructor()\n");
		DKString windowAddress = duk_require_string(ctx, 0);
		DKWindow* window = (DKWindow*)addressToPointer(windowAddress);
		DKRmlInterface* dkRmlInterface = new DKRmlInterface(window);
		DKString dkRmlInterfaceAddress = pointerToAddress(dkRmlInterface);
		duk_push_string(ctx, dkRmlInterfaceAddress.c_str());	
		return true;
	}
	
};
REGISTER_OBJECT(DKRmlInterfaceDUK, true)


#endif //DKRmlInterfaceDUK_H
#endif //HAVE_DKDuktape
