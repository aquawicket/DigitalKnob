#if HAVE_DKDuktape

#pragma once
#ifndef DKSdlWindowDUK_H
#define DKSdlWindowDUK_H

#include "DKSdlWindow/DKSdlWindow.h"
#include "DKDuktape/DKDuktape.h"


class DKSdlWindowDUK : public DKObjectT<DKSdlWindowDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKSdlWindowDUK_constructor", DKSdlWindowDUK::constructor);
			
			
		////// Load .js files
		DKClass::DKCreate("DKSdlWindow/DKSdlWindowDUK.js");
		
		return true;
	}
	
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKSdlWindowDUK_constructor()\n");
		//DKSdlWindow* sdlwindow = (DKSdlWindow*)DKClass::DKCreate("DKSdlWindow");
		DKSdlWindow* sdlwindow = new DKSdlWindow();
		DKString eventTargetAddress = pointerToAddress(sdlwindow);
		duk_push_string(ctx, eventTargetAddress.c_str());	
		return true;
	}
	
};
REGISTER_OBJECT(DKSdlWindowDUK, true)


#endif //DKSdlWindowDUK_H
#endif //HAVE_DKDuktape
