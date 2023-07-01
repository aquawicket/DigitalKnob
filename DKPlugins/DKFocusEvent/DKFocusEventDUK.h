// [IDL] https://w3c.github.io/uievents/#idl-focusevent
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
		DKDuktape::AttachFunction("CPP_DKFocusEventDUK_constructor", 	DKFocusEventDUK::constructor);
		
		// readonly attribute EventTarget? relatedTarget;
		DKDuktape::AttachFunction("CPP_DKFocusEventDUK_relatedTarget",	DKFocusEventDUK::relatedTarget);
	
		
		////// Load .js files //////
		DKClass::DKCreate("DKFocusEvent/DKFocusEventDUK.js");
		
		return true;
	}
	
	
	static DKFocusEvent* focusEvent(duk_context* ctx){
		DKString focusEventAddress = duk_require_string(ctx, 0);
		return (DKFocusEvent*)addressToPointer(focusEventAddress);
	}
	
	// constructor(DOMString type, optional FocusEventInit eventInitDict = {});
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString type = duk_require_string(ctx, 0);
		FocusEventInit eventInitDict = "{}";	//duk_require_string(ctx, 1);
		
		DKINFO("CPP_DKFocusEventDUK_constructor("+type+","+eventInitDict+")\n");
		DKFocusEvent* focusEvent = new DKFocusEvent(type, eventInitDict);
		dukglue_push(ctx, focusEvent->interfaceAddress);
		return true;
	}
	
	// readonly attribute EventTarget? relatedTarget;
	static int relatedTarget(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_string(ctx, 1))
			focusEvent(ctx)->relatedTarget(*(DKEventTarget*)addressToPointer(duk_to_string(ctx, 1)));
		dukglue_push(ctx, pointerToAddress(&focusEvent(ctx)->relatedTarget()));
		return true;
	}
	
};
REGISTER_OBJECT(DKFocusEventDUK, true)


#endif //DKFocusEventDUK_H
#endif //HAVE_DKDuktape