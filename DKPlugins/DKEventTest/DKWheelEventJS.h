#pragma once
#ifndef DKWheelEventJS_H
#define DKWheelEventJS_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent
// [INTERFACE] https://w3c.github.io/uievents/#interface-wheelevent
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
		DKEventTarget::LinkAddEventListenerFunc		("mousewheel", 	&DKWheelEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("mousewheel", 	&DKWheelEventJS::removeEventListener, 	this);
		// [wheel] https://developer.mozilla.org/en-US/docs/Web/API/Element/wheel_event
		DKEventTarget::LinkAddEventListenerFunc		("wheel", 		&DKWheelEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("wheel", 		&DKWheelEventJS::removeEventListener, 	this);


		////// Load .js files //////
		DKClass::DKCreate("DKEventTest/DKWheelEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [WheelEvent()] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/WheelEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = duk_require_string(ctx, 1);
		DKINFO("CPP_DKWheelEvent("+type+","+options+")\n");
		DKWheelEvent* event = new DKWheelEvent(type, options);
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
	


	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool addEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::addEventListener<DKWheelEvent>(_type, &DKWheelEventJS::onWheelEvent, eventTargetAddress);
		return true;
	}
	
	bool removeEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::removeEventListener<DKWheelEvent>(_type, &DKWheelEventJS::onWheelEvent, eventTargetAddress);
		return true;
	}
	
	static bool onWheelEvent(DKWheelEvent* event) {
		DKDEBUGFUNC(event);
		DKINFO("onWheelEvent("+event->type+") \n");
		
		// get the globally stored js callback function
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		DKString cb = event->target+"_"+event->type+"_callback";
		duk_get_global_string(DKDuktape::ctx, cb.c_str());
		
		// create and push the Event(eventAddress) object		
		DKString eventObjStr = "var eventObj = new WheelEvent('', '', '"+eventAddress+"'); eventObj;";  // returns eventObj
		DukValue eventObj = dukglue_peval<DukValue>(DKDuktape::ctx, eventObjStr.c_str());
		dukglue_push(DKDuktape::ctx, eventObj);	 //push event object
		
		// call callback function
		if(duk_pcall(DKDuktape::ctx, 1) != 0) //1 = num or args
			DKDuktape::DumpError(eventAddress);
	
		return true;
	}	
	
};
REGISTER_OBJECT(DKWheelEventJS, true)


#endif //DKWheelEventJS_H