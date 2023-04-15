#if HAVE_DKDuktape

#pragma once
#ifndef DKSDLWindowDuktape_H
#define DKSDLWindowDuktape_H

#include "DKSDLWindow/DKSDLWindow.h"
#include "DKDuktape/DKDuktape.h"


class DKSDLWindowDuktape : public DKObjectT<DKSDLWindowDuktape>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKSDLWindow", DKSDLWindowDuktape::constructor);
			
			
		////// Load .js files
		DKClass::DKCreate("DKSDLWindow/DKSDLWindow.js");
		
		return true;
	}
	
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKSDLWindow()\n");
		DKSDLWindow* sdlwindow = (DKSDLWindow*)DKClass::DKCreate("DKSDLWindow");
		DKString eventTargetAddress = pointerToAddress(sdlwindow);
		duk_push_string(ctx, eventTargetAddress.c_str());	
		return true;
	}
	
};
REGISTER_OBJECT(DKSDLWindowDuktape, true)


#endif //DKSDLWindowDuktape_H
#endif //HAVE_DKDuktape
