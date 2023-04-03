#pragma once
#ifndef DKEventTargetJS_H
#define DKEventTargetJS_H

#include "DKDuktape/DKDuktape.h"
#include "DKEventTest/DKEventTarget.h"


// [EventTarget] https://developer.mozilla.org/en-US/docs/Web/API/Event
class DKEventTargetJS : public DKObjectT<DKEventTargetJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKEventTarget", DKEventTargetJS::constructor); // [EventTarget()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/EventTarget
		
		
		////// Instance methods //////
		DKDuktape::AttachFunction("CPP_DKEventTarget_addEventListener", DKEventTargetJS::addEventListener);
		DKDuktape::AttachFunction("CPP_DKEventTarget_removeEventListener", DKEventTargetJS::removeEventListener);
		DKDuktape::AttachFunction("CPP_DKEventTarget_dispatchEvent", DKEventTargetJS::dispatchEvent);
		
		
		////// Load .js files
		DKClass::DKCreate("DKEventTest/DKEventTarget.js");
		DKClass::DKCreate("DKEventTest/DKGlobalEventHandlers.js");
		return true;
	}
	
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	
	////// Instance methods //////
	static int addEventListener(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString targetAddress = duk_require_string(ctx, 0);
		DKString type = duk_require_string(ctx, 1);
		duk_require_function(ctx, 2);
		//DKINFO("DKEventTargetJS::addEventListener("+targetAddress+", "+type+", callback)\n");
		
		// store the js callback function
		// How to persist Duktape/C arguments across calls
		// https://wiki.duktape.org/howtonativepersistentreferences#:~:text=When%20a%20Duktape%2FC%20function,safely%20work%20with%20the%20arguments.
		DKString cb = targetAddress+"_"+type+"_callback";
		duk_dup(ctx, 2);
		duk_put_global_string(ctx, cb.c_str());
		
		DKEventTarget::CallAddEventListenerFunc(type, targetAddress);
		
		return true;
	}
	static int removeEventListener(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString targetAddress = duk_require_string(ctx, 0);
		DKString type = duk_require_string(ctx, 1);
		duk_require_function(ctx, 2);
		//DKINFO("DKEventTargetJS::removeEventListener("+targetAddress+", "+type+", callback)\n");
		
		// remove the js callback function
		// How to persist Duktape/C arguments across calls
		// https://wiki.duktape.org/howtonativepersistentreferences#:~:text=When%20a%20Duktape%2FC%20function,safely%20work%20with%20the%20arguments.
		DKString cb = targetAddress+"_"+type+"_callback";
		duk_push_null(ctx);
		duk_put_global_string(ctx, cb.c_str());
		
		DKEventTarget::CallRemoveEventListenerFunc(type, targetAddress);

		return true;
	}
	static int dispatchEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString targetAddress = duk_require_string(ctx, 0);
		DKString eventAddress = duk_require_string(ctx, 1);
		//DKINFO("DKEventTargetJS::dispatchEvent("+targetAddress+", "+eventAddress+")\n");
		
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		DKEventTarget::dispatchEvent(event, targetAddress);
		return true;
	}
};
REGISTER_OBJECT(DKEventTargetJS, true)


#endif //DKEventTargetJS_H