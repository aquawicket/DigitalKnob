#pragma once
#ifndef DKSDLWindowJS_H
#define DKSDLWindowJS_H

#include "DKSDLWindow/DKSDLWindow.h"
#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


class DKSDLWindowJS : public DKObjectT<DKSDLWindowJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKSDLWindow", DKSDLWindowJS::constructor);
			
			
		////// Load .js files
		DKClass::DKCreate("DKEventTargetTest/DKSDLWindow.js");
		
		return true;
	}
	
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKSDLWindow()\n");
		DKSDLWindow* sdlwindow = new DKSDLWindow();
		DKString eventTargetAddress = pointerToAddress(sdlwindow);
		duk_push_string(ctx, eventTargetAddress.c_str());	
		return true;
	}
	
};
REGISTER_OBJECT(DKSDLWindowJS, true)


#endif //DKSDLWindowJS_H