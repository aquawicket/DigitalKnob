#pragma once
#ifndef DKEventJS_H
#define DKEventJS_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [INTERFACE] https://dom.spec.whatwg.org/#interface-event
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Event
class DKEventJS : public DKObjectT<DKEventJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKEvent", DKEventJS::constructor);
		
		
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKEvent_bubbles", DKEventJS::bubbles);
		DKDuktape::AttachFunction("CPP_DKEvent_cancelable", DKEventJS::cancelable);
		DKDuktape::AttachFunction("CPP_DKEvent_composed", DKEventJS::composed);
		DKDuktape::AttachFunction("CPP_DKEvent_currentTarget", DKEventJS::currentTarget);
		DKDuktape::AttachFunction("CPP_DKEvent_defaultPrevented", DKEventJS::defaultPrevented);
		DKDuktape::AttachFunction("CPP_DKEvent_eventPhase", DKEventJS::eventPhase);
		DKDuktape::AttachFunction("CPP_DKEvent_isTrusted", DKEventJS::isTrusted);
		DKDuktape::AttachFunction("CPP_DKEvent_target", DKEventJS::target);
		DKDuktape::AttachFunction("CPP_DKEvent_timeStamp", DKEventJS::timeStamp);
		DKDuktape::AttachFunction("CPP_DKEvent_type", DKEventJS::type);
		
		
		////// Legacy and non-standard properties //////
		DKDuktape::AttachFunction("CPP_DKEvent_cancelBubble", DKEventJS::cancelBubble);
		DKDuktape::AttachFunction("CPP_DKEvent_explicitOriginalTarget", DKEventJS::explicitOriginalTarget);
		DKDuktape::AttachFunction("CPP_DKEvent_originalTarget", DKEventJS::originalTarget);
		DKDuktape::AttachFunction("CPP_DKEvent_returnValue", DKEventJS::returnValue);
		DKDuktape::AttachFunction("CPP_DKEvent_scoped", DKEventJS::scoped);
		

		////// Instance methods //////
		DKDuktape::AttachFunction("CPP_DKEvent_composedPath", DKEventJS::composedPath);
		DKDuktape::AttachFunction("CPP_DKEvent_preventDefault", DKEventJS::preventDefault);
		DKDuktape::AttachFunction("CPP_DKEvent_stopImmediatePropagation", DKEventJS::stopImmediatePropagation);
		DKDuktape::AttachFunction("CPP_DKEvent_stopPropagation", DKEventJS::stopPropagation);
		
		
		////// Deprecated methods //////
		DKDuktape::AttachFunction("CPP_DKEvent_initEvent", DKEventJS::initEvent);
		
		
		////// Events //////
		DKEventTarget::LinkAddEventListenerFunc		("generic", 			&DKEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("generic",				&DKEventJS::removeEventListener, 	this);
		// [afterscriptexecute] https://developer.mozilla.org/en-US/docs/Web/API/Element/afterscriptexecute_event
		DKEventTarget::LinkAddEventListenerFunc		("afterscriptexecute",	&DKEventJS::addEventListener,		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("afterscriptexecute",	&DKEventJS::removeEventListener, 	this);
		// [beforematch] https://developer.mozilla.org/en-US/docs/Web/API/Element/beforematch_event
		DKEventTarget::LinkAddEventListenerFunc		("beforematch", 		&DKEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("beforematch", 		&DKEventJS::removeEventListener, 	this);
		// [beforescriptexecute] https://developer.mozilla.org/en-US/docs/Web/API/Element/beforescriptexecute_event
		DKEventTarget::LinkAddEventListenerFunc		("beforescriptexecute", &DKEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("beforescriptexecute", &DKEventJS::removeEventListener, 	this);
		// [error] https://developer.mozilla.org/en-US/docs/Web/API/Element/error_event
		DKEventTarget::LinkAddEventListenerFunc		("error", 				&DKEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("error", 				&DKEventJS::removeEventListener, 	this);
		// [fullscreenchange] https://developer.mozilla.org/en-US/docs/Web/API/Element/fullscreenchange_event
		DKEventTarget::LinkAddEventListenerFunc		("fullscreenchange", 	&DKEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("fullscreenchange", 	&DKEventJS::removeEventListener, 	this);
		// [fullscreenerror] https://developer.mozilla.org/en-US/docs/Web/API/Element/fullscreenerror_event
		DKEventTarget::LinkAddEventListenerFunc		("fullscreenerror",		&DKEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("fullscreenerror", 	&DKEventJS::removeEventListener, 	this);
		// [scroll] https://developer.mozilla.org/en-US/docs/Web/API/Element/scroll_event
		DKEventTarget::LinkAddEventListenerFunc		("scroll", 				&DKEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("scroll", 				&DKEventJS::removeEventListener, 	this);
		// [scrollend] https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollend_event
		DKEventTarget::LinkAddEventListenerFunc		("scrollend", 			&DKEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("scrollend", 			&DKEventJS::removeEventListener, 	this);
	
		
		////// Load .js files
		DKClass::DKCreate("DKEventTest/DKEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [Event()] https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = duk_require_string(ctx, 1);
		DKINFO("CPP_DKEvent("+type+","+options+")\n");
		DKEvent* event = new DKEvent(type, options);
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [Event.bubbles](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/bubbles
	static int bubbles(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_boolean(ctx, 1))
			event->bubbles = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, event->bubbles);	
		return true;
	}
	// [Event.cancelable](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelable
	static int cancelable(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->cancelable);	
		return true;
	}
	// [Event.composed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/composed
	static int composed(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->composed);	
		return true;
	}
	// [Event.currentTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/currentTarget
	static int currentTarget(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->currentTarget.c_str());	
		return true;
	}
	// [Event.defaultPrevented](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/defaultPrevented
	static int defaultPrevented(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->defaultPrevented);	
		return true;
	}
	// [Event.eventPhase](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/eventPhase
	static int eventPhase(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_number(ctx, event->eventPhase);	
		return true;
	}
	// [Event.isTrusted](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/isTrusted
	static int isTrusted(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->isTrusted);	
		return true;
	}
	// [Event.target](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/target
	static int target(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->target.c_str());	
		return true;
	}
	// [Event.timeStamp](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/timeStamp
	static int timeStamp(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_number(ctx, event->timeStamp);	
		return true;
	}
	// [Event.type](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/type
	static int type(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->type.c_str());	
		return true;
	}
	
	
	////// Legacy and non-standard properties //////
	// [Event.cancelBubble](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelBubble
	static int cancelBubble(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKDEPRECATED();
	}
	// [Event.explicitOriginalTarget](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/explicitOriginalTarget
	static int explicitOriginalTarget(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	// [Event.originalTarget](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/originalTarget
	static int originalTarget(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	// [Event.returnValue](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/returnValue
	static int returnValue(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKDEPRECATED();
	}
	// [Event.scoped](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/scoped
	static int scoped(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKDEPRECATED();
	}
	
	
	////// Instance methods //////
	// [Event.composedPath()] https://developer.mozilla.org/en-US/docs/Web/API/Event/composedPath
	static int composedPath(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	// [Event.preventDefault()] https://developer.mozilla.org/en-US/docs/Web/API/Event/preventDefault
	static int preventDefault(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	// [Event.stopImmediatePropagation()] https://developer.mozilla.org/en-US/docs/Web/API/Event/stopImmediatePropagation
	static int stopImmediatePropagation(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	// [Event.stopPropagation()] https://developer.mozilla.org/en-US/docs/Web/API/Event/stopPropagation
	static int stopPropagation(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	
	////// Deprecated methods //////
	// [Event.initEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/initEvent
	static int initEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKDEPRECATED();
	}
	
	
	
	/////////////////////////////////////////////////////////////////////////////////
	bool addEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::addEventListener<DKEvent>(_type, &DKEventJS::onEvent, eventTargetAddress);
		return true;
	}
	
	bool removeEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::removeEventListener<DKEvent>(_type, &DKEventJS::onEvent, eventTargetAddress);
		return true;
	}
	
	static bool onEvent(DKEvent* event) {
		DKDEBUGFUNC(event);
		DKINFO("onEvent("+event->type+") \n");
		
		// get the globally stored js callback function
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		DKString cb = event->target+"_"+event->type+"_callback";
		duk_get_global_string(DKDuktape::ctx, cb.c_str());
		
		// create and push the Event(eventAddress) object		
		DKString eventObjStr = "var eventObj = new Event('', '', '"+eventAddress+"'); eventObj;";  // returns eventObj
		DukValue eventObj = dukglue_peval<DukValue>(DKDuktape::ctx, eventObjStr.c_str());
		dukglue_push(DKDuktape::ctx, eventObj);	 //push event object
		
		// call callback function
		if(duk_pcall(DKDuktape::ctx, 1) != 0){ //1 = num or args
			DKDuktape::DumpError(eventAddress);
		}
	
		return true;
	}
	
};
REGISTER_OBJECT(DKEventJS, true)


#endif //DKEventJS_H