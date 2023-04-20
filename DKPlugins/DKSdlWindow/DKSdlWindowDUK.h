#if HAVE_DKDuktape

#pragma once
#ifndef DKSDLWindowDUK_H
#define DKSDLWindowDUK_H

#include "DKSDLWindow/DKSDLWindow.h"
#include "DKDuktape/DKDuktape.h"


class DKSDLWindowDUK : public DKObjectT<DKSDLWindowDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKSDLWindowDUK", DKSDLWindowDUK::constructor);
			
			
		////// Load .js files
		DKClass::DKCreate("DKSDLWindow/DKSDLWindowDUK.js");
		
		return true;
	}
	
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKSDLWindowDUK()\n");
		DKSDLWindow* sdlwindow = (DKSDLWindow*)DKClass::DKCreate("DKSDLWindow");
		DKString eventTargetAddress = pointerToAddress(sdlwindow);
		duk_push_string(ctx, eventTargetAddress.c_str());	
		return true;
	}
	
};
REGISTER_OBJECT(DKSDLWindowDUK, true)


#endif //DKSDLWindowDUK_H
#endif //HAVE_DKDuktape
