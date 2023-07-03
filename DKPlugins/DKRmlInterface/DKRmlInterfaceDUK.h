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
		
		DKString windowInterfaceAddress = duk_require_string(ctx, 0);
		DKInterface* windowInterface = (DKInterface*)addressToPointer(windowInterfaceAddress);
		DKString windowAddress = windowInterface->address["Window"];
		DKWindow* window = (DKWindow*)addressToPointer(windowAddress);

		
		DKINFO("CPP_DKRmlInterfaceDUK_constructor("+windowAddress+")\n");
		DKRmlInterface* dkRmlInterface = new DKRmlInterface(window);
		dukglue_push(ctx, dkRmlInterface->interfaceAddress);	
		return true;
	}
	
};
REGISTER_OBJECT(DKRmlInterfaceDUK, true)


#endif //DKRmlInterfaceDUK_H
#endif //HAVE_DKDuktape
