#if HAVE_DKDuktape

#pragma once
#ifndef DKConsoleWindowDUK_H
#define DKConsoleWindowDUK_H

#include "DKDuktape/DKDuktape.h"


class DKConsoleWindowDUK : public DKObjectT<DKConsoleWindowDUK>
{
public:
	bool Init(){

		DKDuktape::AttachFunction("CPP_DKConsoleWindowDUK_constructor", DKConsoleWindowDUK::constructor);
		DKDuktape::AttachFunction("CPP_DKConsoleWindowDUK_columns", 	DKConsoleWindowDUK::columns);
		DKDuktape::AttachFunction("CPP_DKConsoleWindowDUK_rows", 		DKConsoleWindowDUK::rows);		
			
		////// Load .js files //////
		DKClass::DKCreate("DKConsoleWindow/DKConsoleWindowDUK.js");
		
		return true;
	}
	
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		
		DKINFO("CPP_DKConsoleWindowDUK_constructor()\n");
		DKConsoleWindow* consoleWindow = new DKConsoleWindow();
		dukglue_push(ctx, consoleWindow->interfaceAddress);
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
REGISTER_OBJECT(DKConsoleWindowDUK, true)


#endif //DKConsoleWindowDUK_H
#endif //HAVE_DKDuktape