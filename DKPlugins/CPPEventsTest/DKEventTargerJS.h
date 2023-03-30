#pragma once
#ifndef DKEventTargetJS_H
#define DKEventTargetJS_H

#include "DKDuktape/DKDuktape.h"
#include "CPPEventsTest/DKEvent.h"
#include "CPPEventsTest/DKEventTarget.h"

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
		return DKTODO();
	}
	static int removeEventListener(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	static int dispatchEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}	
};
REGISTER_OBJECT(DKEventTargetJS, true)


#endif //DKEventTargetJS_H