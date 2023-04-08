#pragma once
#ifndef DKFocusEventJS_H
#define DKFocusEventJS_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
//#include "dukglue/dukglue.h"
#include "dukglue/public_util.h"
#include "dukglue/dukvalue.h"
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
		registerEventType("blur");
		// [focus] https://developer.mozilla.org/en-US/docs/Web/API/Element/focus_event
		registerEventType("focus");
		// [focusin] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusin_event
		registerEventType("focusin");
		// [focusout] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusout_event
		registerEventType("focusout");
	
		
		////// Load .js files
		DKClass::DKCreate("DKEventTest/DKFocusEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [FocusEvent()] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent/FocusEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = duk_require_string(ctx, 1);
		DKINFO("CPP_DKFocusEvent("+type+","+options+")\n");
		DKFocusEventJS::Get()->registerEventType(type);
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
		duk_push_string(ctx, event->relatedTarget.c_str());	
		return true;
	}


	//////////////////////////////////////////////////////////////////////////////////////////////////////
	bool registerEventType(const DKString& _type){
		DKEventTarget::LinkAddEventListenerFunc		(_type, &DKFocusEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	(_type,	&DKFocusEventJS::removeEventListener, 	this);
		return true;
	}
	
	bool addEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::addEventListener<DKFocusEvent>(_type, &DKFocusEventJS::onFocusEvent, eventTargetAddress);
		return true;
	}
	
	bool removeEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::removeEventListener<DKFocusEvent>(_type, &DKFocusEventJS::onFocusEvent, eventTargetAddress);
		return true;
	}
	
	static bool onFocusEvent(DKFocusEvent* event) {
		DKDEBUGFUNC(event);
		DKINFO("onFocusEvent("+event->type+") \n");
		
		// get the globally stored js callback function
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		DKString cb = event->target+"_"+event->type+"_callback";
		duk_get_global_string(DKDuktape::ctx, cb.c_str());
		
		// create and push the Event(eventAddress) object		
		DKString eventObjStr = "var eventObj = new FocusEvent('', '', '"+eventAddress+"'); eventObj;";
		DukValue eventObj = dukglue_peval<DukValue>(DKDuktape::ctx, eventObjStr.c_str());
		dukglue_push(DKDuktape::ctx, eventObj);
		
		// call callback function
		if(duk_pcall(DKDuktape::ctx, 1) != 0) //1 = num or args
			DKDuktape::DumpError(eventAddress);
	
		return true;
	}	
};
REGISTER_OBJECT(DKFocusEventJS, true)


#endif //DKFocusEventJS_H