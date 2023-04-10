#pragma once
#ifndef DKConsoleWindowJS_H
#define DKConsoleWindowJS_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


class DKConsoleWindowJS : public DKObjectT<DKConsoleWindowJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKConsoleWindow", DKConsoleWindowJS::constructor);
		
			
		////// Load .js files
		DKClass::DKCreate("DKEventTargetTest/DKConsoleWindow.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [Event()] https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKConsoleWindow()\n");
		DKConsoleWindow* consolewindow = new DKConsoleWindow();
		DKString eventTargetAddress = DKDuktape::pointerToAddress(consolewindow);
		duk_push_string(ctx, eventTargetAddress.c_str());	
		return true;
	}

};
REGISTER_OBJECT(DKConsoleWindowJS, true)


#endif //DKConsoleWindowJS_H