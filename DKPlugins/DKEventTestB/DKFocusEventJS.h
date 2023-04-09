#pragma once
#ifndef DKFocusEventJS_H
#define DKFocusEventJS_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [W3C] https://w3c.github.io/uievents/#events-focusevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent
class DKFocusEventJS : public DKObjectT<DKFocusEventJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKFocusEvent", DKFocusEventJS::constructor);
		
	
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKFocusEvent_relatedTarget",	DKFocusEventJS::relatedTarget);

		
		////// Events //////
		// [blur] https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event
		// [focus] https://developer.mozilla.org/en-US/docs/Web/API/Element/focus_event
		// [focusin] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusin_event
		// [focusout] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusout_event
	
		
		////// Load .js files
		DKClass::DKCreate("DKEventTestB/DKFocusEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [FocusEvent()] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent/FocusEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKFocusEvent("+type+","+options+")\n");
		DKFocusEvent* event = new DKFocusEvent(type, options);
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [FocusEvent.relatedTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent/relatedTarget
	static int relatedTarget(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKFocusEvent* event = (DKFocusEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_string(ctx, 1))
			event->relatedTarget = duk_to_string(ctx, 1);
		duk_push_string(ctx, event->relatedTarget.c_str());	
		return true;
	}
	
};
REGISTER_OBJECT(DKFocusEventJS, true)


#endif //DKFocusEventJS_H