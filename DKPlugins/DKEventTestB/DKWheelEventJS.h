#pragma once
#ifndef DKWheelEventJS_H
#define DKWheelEventJS_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [W3C] https://w3c.github.io/uievents/#events-wheelevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent
class DKWheelEventJS : public DKObjectT<DKWheelEventJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKWheelEvent", DKWheelEventJS::constructor);
	
	
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKWheelEvent_deltaX", 		DKWheelEventJS::deltaX); 		// [WheelEvent.deltaX](Read only)
		DKDuktape::AttachFunction("CPP_DKWheelEvent_deltaY", 		DKWheelEventJS::deltaY); 		// [WheelEvent.deltaY](Read only)
		DKDuktape::AttachFunction("CPP_DKWheelEvent_deltaZ",		DKWheelEventJS::deltaZ); 		// [WheelEvent.deltaZ](Read only)
		DKDuktape::AttachFunction("CPP_DKWheelEvent_deltaMode", 	DKWheelEventJS::deltaMode); 	// [WheelEvent.deltaMode](Read only)
		DKDuktape::AttachFunction("CPP_DKWheelEvent_wheelDelta", 	DKWheelEventJS::wheelDelta); 	// [WheelEvent.wheelDelta](Read only)(Deprecated)(Non-standard)
		DKDuktape::AttachFunction("CPP_DKWheelEvent_wheelDeltaX", 	DKWheelEventJS::wheelDeltaX); 	// [WheelEvent.wheelDeltaX](Read only)(Deprecated)(Non-standard)
		DKDuktape::AttachFunction("CPP_DKWheelEvent_wheelDeltaY", 	DKWheelEventJS::wheelDeltaY); 	// [WheelEvent.wheelDeltaY](Read only)(Deprecated)(Non-standard)
	
	
		////// Events //////
		// [mousewheel](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/mousewheel_event
		// [wheel] https://developer.mozilla.org/en-US/docs/Web/API/Element/wheel_event


		////// Load .js files //////
		DKClass::DKCreate("DKEventTestB/DKWheelEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [WheelEvent()] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/WheelEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKWheelEvent("+type+","+options+")\n");
		DKWheelEvent* event = new DKWheelEvent(type, options);
		//event->eventClass = "WheelEvent";
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [WheelEvent.deltaX](Read only)
	static int deltaX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKWheelEvent* event = (DKWheelEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_number(ctx, event->deltaX);	
		return true;
	}
	// [WheelEvent.deltaY](Read only)
	static int deltaY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKWheelEvent* event = (DKWheelEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_number(ctx, event->deltaY);	
		return true;
	}
	// [WheelEvent.deltaZ](Read only)
	static int deltaZ(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKWheelEvent* event = (DKWheelEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_number(ctx, event->deltaZ);	
		return true;
	}
	// [WheelEvent.deltaMode](Read only)
	static int deltaMode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKWheelEvent* event = (DKWheelEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_uint(ctx, event->deltaMode);	
		return true;
	}
	// [WheelEvent.wheelDelta](Read only)(Deprecated)(Non-standard)
	static int wheelDelta(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKWheelEvent* event = (DKWheelEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_int(ctx, event->wheelDelta);	
		return DKDEPRECATED();
	}
	// [WheelEvent.wheelDeltaX](Read only)(Deprecated)(Non-standard)
	static int wheelDeltaX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKWheelEvent* event = (DKWheelEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_int(ctx, event->wheelDeltaX);	
		return DKDEPRECATED();
	}
	// [WheelEvent.wheelDeltaY](Read only)(Deprecated)(Non-standard)
	static int wheelDeltaY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKWheelEvent* event = (DKWheelEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_int(ctx, event->wheelDeltaY);	
		return DKDEPRECATED();
	}
	
};
REGISTER_OBJECT(DKWheelEventJS, true)


#endif //DKWheelEventJS_H