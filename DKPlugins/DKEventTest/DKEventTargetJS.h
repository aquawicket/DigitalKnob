#pragma once
#ifndef DKEventTargetJS_H
#define DKEventTargetJS_H

#include "DKDuktape/DKDuktape.h"
#include "DKEventTest/DKEvent.h"
#include "DKEventTest/DKKeyboardEvent.h"
#include "DKEventTest/DKEventTarget.h"

#include "dukglue/dukglue.h"

// How to persist Duktape/C arguments across calls
// https://wiki.duktape.org/howtonativepersistentreferences#:~:text=When%20a%20Duktape%2FC%20function,safely%20work%20with%20the%20arguments.

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
		DKINFO("DKEventTargetJS::addEventListener("+targetAddress+", "+type+", DKEventTargetJS::onEvent)\n");
		
		// store the js callback function
		DKString cb = type+"_callback";
		duk_dup(ctx, 2);
		duk_put_global_string(ctx, cb.c_str());

		// set event Type
		if(same(type, "keydown") || same(type, "keyup") || same(type, "keypress"))
			DKEventTarget::addEventListener<DKKeyboardEvent>(type, &DKEventTargetJS::onEvent, targetAddress);
		else
			DKEventTarget::addEventListener<DKEvent>(type, &DKEventTargetJS::onEvent, targetAddress);	
		return true;
	}
	static int removeEventListener(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString targetAddress = duk_require_string(ctx, 0);
		DKString type = duk_require_string(ctx, 1);
		duk_require_function(ctx, 2);
		DKINFO("DKEventTargetJS::removeEventListener("+targetAddress+", "+type+", DKEventTargetJS::onEvent)\n");
		DKEventTarget::removeEventListener<DKEvent>(type, &DKEventTargetJS::onEvent, targetAddress);	
		return DKTODO();
	}
	static int dispatchEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString targetAddress = duk_require_string(ctx, 0);
		DKString eventAddress = duk_require_string(ctx, 1);
		DKINFO("DKEventTargetJS::dispatchEvent("+targetAddress+", "+eventAddress+")\n");
		
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		DKEventTarget::dispatchEvent(event, targetAddress);
		return true;
	}
	
	// CPP
	static bool onEvent(DKEvent* event) {
		DKDEBUGFUNC(event);
		DKINFO("onEvent("+event->type+") \n");
		
		// get the globally stored js callback function
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		DKString cb = event->type+"_callback";
		duk_get_global_string(DKDuktape::ctx, cb.c_str());
		
		// get event Type
		DKString eventType;
		if(same(event->type, "keydown") || same(event->type, "keyup") || same(event->type, "keypress"))
			eventType = "KeyboardEvent";
		else
			eventType = "Event";
		
		// create and push the Event(eventAddress) object		
		DKString eventObjStr = "var eventObj = new "+eventType+"('', '', '"+eventAddress+"'); eventObj;";  // returns eventObj
		DukValue eventObj = dukglue_peval<DukValue>(DKDuktape::ctx, eventObjStr.c_str());
		dukglue_push(DKDuktape::ctx, eventObj);	 //push event object
		
		//duk_push_null(DKDuktape::ctx);
		//duk_put_global_string(DKDuktape::ctx, cb.c_str());
		
		// call callback function
		if(duk_pcall(DKDuktape::ctx, 1) != 0){ //1 = num or args
			DKDuktape::DumpError(eventAddress);
		}
	
		return true;
	}
};
REGISTER_OBJECT(DKEventTargetJS, true)


#endif //DKEventTargetJS_H