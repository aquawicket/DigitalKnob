// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/FocusEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-focusevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent
#if HAVE_DKDuktape

#pragma once
#ifndef DKFocusEventDUK_H
#define DKFocusEventDUK_H

#include "DKDuktape/DKDuktape.h"


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface FocusEvent : UIEvent {
class DKFocusEventDUK : public DKObjectT<DKFocusEventDUK>
{
public:
	bool Init(){
		
		// constructor(DOMString type, optional FocusEventInit eventInitDict = {});
		DKDuktape::AttachFunction("CPP_DKFocusEventDUK", DKFocusEventDUK::constructor);
		
		// readonly attribute EventTarget? relatedTarget;
		DKDuktape::AttachFunction("CPP_DKFocusEventDUK_relatedTarget",	DKFocusEventDUK::relatedTarget);
	
		
		////// Load .js files //////
		DKClass::DKCreate("DKFocusEvent/DKFocusEventDUK.js");
		
		return true;
	}
	
	
	// constructor(DOMString type, optional FocusEventInit eventInitDict = {});
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
	
	// readonly attribute EventTarget? relatedTarget;
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