#if HAVE_DKDuktape

#pragma once
#ifndef DKFocusEventDUK_H
#define DKFocusEventDUK_H

#include "DKDuktape/DKDuktape.h"


// [W3C] https://w3c.github.io/uievents/#events-focusevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent
class DKFocusEventDUK : public DKObjectT<DKFocusEventDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKFocusEventDUK", DKFocusEventDUK::constructor);
		
	
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKFocusEventDUK_relatedTarget",	DKFocusEventDUK::relatedTarget);

		
		////// Events //////
		// [blur] https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event
		// [focus] https://developer.mozilla.org/en-US/docs/Web/API/Element/focus_event
		// [focusin] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusin_event
		// [focusout] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusout_event
	
		
		////// Load .js files
		DKClass::DKCreate("DKFocusEvent/DKFocusEventDUK.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [FocusEvent()] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent/FocusEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKFocusEventDUK("+type+","+options+")\n");
		DKFocusEvent* event = new DKFocusEvent(type, options);
		DKString eventAddress = pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [FocusEvent.relatedTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent/relatedTarget
	static int relatedTarget(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKFocusEvent* event = (DKFocusEvent*)addressToPointer(eventAddress);
		if (duk_is_string(ctx, 1))
			event->relatedTarget = duk_to_string(ctx, 1);
		duk_push_string(ctx, event->relatedTarget.c_str());	
		return true;
	}
	
};
REGISTER_OBJECT(DKFocusEventDUK, true)


#endif //DKFocusEventDUK_H
#endif //HAVE_DKDuktape