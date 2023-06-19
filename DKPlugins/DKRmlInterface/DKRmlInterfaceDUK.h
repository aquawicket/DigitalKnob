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
		DKRmlInterface* _dkRmlInterface = (DKRmlInterface*)DKClass::DKCreate("DKRmlInterface");
		DKString eventTargetAddress = pointerToAddress(_dkRmlInterface);
		duk_push_string(ctx, eventTargetAddress.c_str());	
		return true;
	}
	
};
REGISTER_OBJECT(DKRmlInterfaceDUK, true)


#endif //DKRmlInterfaceDUK_H
#endif //HAVE_DKDuktape
