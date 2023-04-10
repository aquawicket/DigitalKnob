#pragma once
#ifndef DKPointerEventJS_H
#define DKPointerEventJS_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [W3C] https://w3c.github.io/uievents/#events-wheelevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent
class DKPointerEventJS : public DKObjectT<DKPointerEventJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKPointerEvent", DKPointerEventJS::constructor);
	
	
		////// Instance properties //////
		//DKDuktape::AttachFunction("CPP_DKPointerEvent_???", 		DKPointerEventJS::???); 		// [PointerEvent.deltaX](Read only)

	
	
		////// Events //////



		////// Load .js files //////
		DKClass::DKCreate("DKEventTest/DKPointerEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [PointerEvent()] https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/PointerEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKPointerEvent("+type+","+options+")\n");
		DKPointerEvent* event = new DKPointerEvent(type, options);
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [PointerEvent.pointerId](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pointerId
	// [PointerEvent.width](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/width
	// [PointerEvent.height](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/height
	// [PointerEvent.pressure](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pressure
	// [PointerEvent.tangentialPressure) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tangentialPressure
	// [PointerEvent.tiltX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tiltX
	// [PointerEvent.tiltY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tiltY
	// [PointerEvent.twist](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/twist
	// [PointerEvent.pointerType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pointerType
	// [PointerEvent.isPrimary](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/isPrimary
	/*
	static int ???(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKPointerEvent* event = (DKPointerEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_number(ctx, 1))
			event->??? = duk_to_number(ctx, 1);
		duk_push_number(ctx, event->???);	
		return true;
	}
	*/
	
	////// Instance methods //////
	// [PointerEvent.getCoalescedEvents()] https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/getCoalescedEvents
	/*
	void getCoalescedEvents() {
		DKTODO();
	}
	*/
	// [PointerEvent.getPredictedEvents()] https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent
	
};
REGISTER_OBJECT(DKPointerEventJS, true)


#endif //DKPointerEventJS_H