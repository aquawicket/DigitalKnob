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
		
		
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_columns", DKConsoleWindowJS::columns);
		DKDuktape::AttachFunction("CPP_DKConsoleWindow_rows", DKConsoleWindowJS::rows);	
			
			
		////// Load .js files
		DKClass::DKCreate("DKEventTargetTest/DKConsoleWindow.js");
		
		return true;
	}
	
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKConsoleWindow()\n");
		//DKConsoleWindow* consolewindow = new DKConsoleWindow();
		DKConsoleWindow* consolewindow = (DKConsoleWindow*)DKClass::DKCreate("DKConsoleWindow");
		DKString eventTargetAddress = pointerToAddress(consolewindow);
		duk_push_string(ctx, eventTargetAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	static int columns(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKConsoleWindow* eventTarget = (DKConsoleWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->columns = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, eventTarget->columns);	
		return true;
	}
	static int rows(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKConsoleWindow* eventTarget = (DKConsoleWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->rows = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, eventTarget->rows);	
		return true;
	}
	

};
REGISTER_OBJECT(DKConsoleWindowJS, true)


#endif //DKConsoleWindowJS_H