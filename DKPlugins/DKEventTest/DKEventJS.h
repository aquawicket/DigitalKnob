#pragma once
#ifndef DKEventJS_H
#define DKEventJS_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [Event] https://developer.mozilla.org/en-US/docs/Web/API/Event
class DKEventJS : public DKObjectT<DKEventJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKEvent", DKEventJS::constructor); // [Event()] https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
		
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
		
		/*
		////// Instance methods //////
		DKDuktape::AttachFunction("CPP_DKEvent_composedPath", DKEventJS::composedPath);
		DKDuktape::AttachFunction("CPP_DKEvent_preventDefault", DKEventJS::preventDefault);
		DKDuktape::AttachFunction("CPP_DKEvent_stopImmediatePropagation", DKEventJS::stopImmediatePropagation);
		DKDuktape::AttachFunction("CPP_DKEvent_stopPropagation", DKEventJS::stopPropagation);
		
		////// Deprecated methods //////
		DKDuktape::AttachFunction("CPP_DKEvent_initEvent", DKEventJS::initEvent);
		*/
		
		
		////// Register Events //////
		DKEventTarget::LinkAddEventListenerFunc("generic", &DKEventJS::addEventListener, this);
		
		
		////// Load .js files
		DKClass::DKCreate("DKEventTest/DKEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
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
	static int bubbles(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_boolean(ctx, 1))
			event->bubbles = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, event->bubbles);	
		return true;
	}
	static int cancelable(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->cancelable);	
		return true;
	}
	static int composed(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->composed);	
		return true;
	}
	static int currentTarget(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->currentTargetAddress.c_str());	
		return true;
	}
	static int defaultPrevented(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->defaultPrevented);	
		return true;
	}
	static int eventPhase(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_number(ctx, event->eventPhase);	
		return true;
	}
	static int isTrusted(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->isTrusted);	
		return true;
	}
	static int target(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->targetAddress.c_str());	
		return true;
	}
	static int timeStamp(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_number(ctx, event->timeStamp);	
		return true;
	}
	static int type(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->type.c_str());	
		return true;
	}
	
	
	////// Legacy and non-standard properties //////
	static int cancelBubble(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		/*
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_boolean(ctx, 1))
			event->cancelBubble = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, event->cancelBubble);	
		return true;
		*/
		return DKTODO();
	}
	static int explicitOriginalTarget(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		/*
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->explicitOriginalTarget);	
		return true;
		*/
		return DKTODO();
	}
	static int originalTarget(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		/*
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->originalTarget);	
		return true;
		*/
		return DKTODO();
	}
	static int returnValue(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		/*
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_boolean(ctx, 1))
			event->returnValue = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, event->returnValue);	
		return true;
		*/
		return DKTODO();
	}
	static int scoped(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		/*
		DKString eventAddress = duk_require_string(ctx, 0);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->scoped);	
		return true;
		*/
		return DKTODO();
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////
	bool addEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::addEventListener<DKEvent>(_type, &DKEventJS::onEvent, eventTargetAddress);
		return true;
	}
	
	static bool onEvent(DKEvent* event) {
		DKDEBUGFUNC(event);
		DKINFO("onEvent("+event->type+") \n");
		
		// get the globally stored js callback function
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		DKString cb = event->type+"_callback";
		duk_get_global_string(DKDuktape::ctx, cb.c_str());
		
		// create and push the Event(eventAddress) object		
		DKString eventObjStr = "var eventObj = new Event('', '', '"+eventAddress+"'); eventObj;";  // returns eventObj
		DukValue eventObj = dukglue_peval<DukValue>(DKDuktape::ctx, eventObjStr.c_str());
		dukglue_push(DKDuktape::ctx, eventObj);	 //push event object
		
		// delete duktape callback
		//duk_push_null(DKDuktape::ctx);
		//duk_put_global_string(DKDuktape::ctx, cb.c_str());
		
		// call callback function
		if(duk_pcall(DKDuktape::ctx, 1) != 0){ //1 = num or args
			DKDuktape::DumpError(eventAddress);
		}
	
		return true;
	}
	
};
REGISTER_OBJECT(DKEventJS, true)


#endif //DKEventJS_H