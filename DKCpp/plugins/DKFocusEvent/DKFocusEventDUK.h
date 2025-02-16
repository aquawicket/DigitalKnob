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
		DKString interfaceAddress = duk_require_string(ctx, 0);
		DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
		DKString focusEventAddress = interface->address["FocusEvent"];
		DKFocusEvent* _focusEvent = (DKFocusEvent*)addressToPointer(focusEventAddress);
		return _focusEvent;
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
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = duk_require_string(ctx, 1);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKString eventTargetAddress = interface->address["EventTarget"];
			DKEventTarget* eventTarget = (DKEventTarget*)addressToPointer(eventTargetAddress);
			focusEvent(ctx)->relatedTarget(eventTarget);
		}
		dukglue_push(ctx, focusEvent(ctx)->relatedTarget()->interfaceAddress);
		return true;
	}
	
};
REGISTER_OBJECT(DKFocusEventDUK, true)


#endif //DKFocusEventDUK_H
#endif //HAVE_DKDuktape