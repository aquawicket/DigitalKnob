#pragma once
#ifndef DKEventTargetJS_H
#define DKEventTargetJS_H

#include "DKDuktape/DKDuktape.h"
#include "CPPEventsTest/DKEvent.h"
#include "CPPEventsTest/DKKeyboardEvent.h"
#include "CPPEventsTest/DKEventTarget.h"

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
		
		DKString cb = type+"_callback";
		DKINFO("cb = "+cb+"\n");
		duk_dup(ctx, 2);
		duk_put_global_string(ctx, cb.c_str());

		if(same(type, "keyup"))
			DKEventTarget::addEventListener<DKKeyboardEvent>(type, &DKEventTargetJS::onEvent, targetAddress);
		else
			DKEventTarget::addEventListener<DKEvent>(type, &DKEventTargetJS::onEvent, targetAddress);	
		return DKTODO();
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
		//DKEventTarget::dispatchEvent(event, targetAddress);
		return DKTODO();
	}
	
	// CPP
	static bool onEvent(DKEvent event) {
		DKDEBUGFUNC(event);
		DKINFO("onEvent("+event.type+") \n");
		
		DKString cb = event.type+"_callback";
		DKINFO("cb = "+cb+"\n");
		duk_get_global_string(DKDuktape::ctx, cb.c_str());
		
		//DKString ev = "Event('"+event.type+"','')";
		//DKString ev = "test";
		//duk_push_string(DKDuktape::ctx, ev.c_str());  //push event parameter
		
		//duk_push_null(DKDuktape::ctx);
		//duk_put_global_string(DKDuktape::ctx, cb.c_str());
		duk_call(DKDuktape::ctx, 0);
		return true;
	}
};
REGISTER_OBJECT(DKEventTargetJS, true)


#endif //DKEventTargetJS_H