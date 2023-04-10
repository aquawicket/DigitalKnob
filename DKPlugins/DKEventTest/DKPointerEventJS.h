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
		DKDuktape::AttachFunction("CPP_DKPointerEvent_pointerId", 			DKPointerEventJS::pointerId);
		DKDuktape::AttachFunction("CPP_DKPointerEvent_width", 				DKPointerEventJS::width);
		DKDuktape::AttachFunction("CPP_DKPointerEvent_height", 				DKPointerEventJS::height);
		DKDuktape::AttachFunction("CPP_DKPointerEvent_pressure", 			DKPointerEventJS::pressure);
		DKDuktape::AttachFunction("CPP_DKPointerEvent_tangentialPressure", 	DKPointerEventJS::tangentialPressure);
		DKDuktape::AttachFunction("CPP_DKPointerEvent_tiltX", 				DKPointerEventJS::tiltX);
		DKDuktape::AttachFunction("CPP_DKPointerEvent_tiltY", 				DKPointerEventJS::tiltY);
		DKDuktape::AttachFunction("CPP_DKPointerEvent_twist", 				DKPointerEventJS::twist);
		DKDuktape::AttachFunction("CPP_DKPointerEvent_pointerType", 		DKPointerEventJS::pointerType);
		
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
	static int pointerId(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKPointerEvent* event = (DKPointerEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_number(ctx, 1))
			event->pointerId = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, event->pointerId);	
		return true;
	}
	// [PointerEvent.width](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/width
	static int width(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKPointerEvent* event = (DKPointerEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_number(ctx, 1))
			event->width = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, event->width);	
		return true;
	}
	// [PointerEvent.height](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/height
	static int height(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKPointerEvent* event = (DKPointerEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_number(ctx, 1))
			event->height = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, event->height);	
		return true;
	}
	// [PointerEvent.pressure](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pressure
	static int pressure(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKPointerEvent* event = (DKPointerEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_number(ctx, 1))
			event->pressure = duk_to_number(ctx, 1);
		duk_push_number(ctx, event->pressure);	
		return true;
	}
	// [PointerEvent.tangentialPressure) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tangentialPressure
	static int tangentialPressure(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKPointerEvent* event = (DKPointerEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_number(ctx, 1))
			event->tangentialPressure = duk_to_number(ctx, 1);
		duk_push_number(ctx, event->tangentialPressure);	
		return true;
	}
	// [PointerEvent.tiltX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tiltX
	static int tiltX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKPointerEvent* event = (DKPointerEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_number(ctx, 1))
			event->tiltX = duk_to_int(ctx, 1);
		duk_push_int(ctx, event->tiltX);	
		return true;
	}
	// [PointerEvent.tiltY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tiltY
	static int tiltY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKPointerEvent* event = (DKPointerEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_number(ctx, 1))
			event->tiltY = duk_to_int(ctx, 1);
		duk_push_int(ctx, event->tiltY);	
		return true;
	}
	// [PointerEvent.twist](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/twist
	static int twist(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKPointerEvent* event = (DKPointerEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_number(ctx, 1))
			event->twist = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, event->twist);	
		return true;
	}
	// [PointerEvent.pointerType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pointerType
	static int pointerType(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKPointerEvent* event = (DKPointerEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_string(ctx, 1))
			event->pointerType = duk_to_string(ctx, 1);
		duk_push_uint(ctx, event->pointerType);	
		return true;
	}
	// [PointerEvent.isPrimary](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/isPrimary
	static int isPrimary(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKPointerEvent* event = (DKPointerEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_boolean(ctx, 1))
			event->isPrimary = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, event->isPrimary);	
		return true;
	}
	
	////// Instance methods //////
	// [PointerEvent.getCoalescedEvents()] https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/getCoalescedEvents
	static int getCoalescedEvents(duk_context* ctx){
		DKDEBUGFUNC(ctx);	
		return DKTODO();
	}
	// [PointerEvent.getPredictedEvents()] https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent
	static int getPredictedEvents(duk_context* ctx){
		DKDEBUGFUNC(ctx);	
		return DKTODO();
	}
	
};
REGISTER_OBJECT(DKPointerEventJS, true)


#endif //DKPointerEventJS_H