#pragma once
#ifndef DKCompositionEventJS_H
#define DKCompositionEventJS_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [W3C] https://w3c.github.io/uievents/#events-compositionevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent
class DKCompositionEventJS : public DKObjectT<DKCompositionEventJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKCompositionEvent", DKCompositionEventJS::constructor);
	
	
		////// Instance properties //////
		//DKDuktape::AttachFunction("CPP_DKCompositionEvent_data",	DKCompositionEventJS::data); //FIXME: data is already a member of DKObject
		DKDuktape::AttachFunction("CPP_DKCompositionEvent_locale",	DKCompositionEventJS::locale);


		////// Instance methods //////
		// [CompositionEvent.initCompositionEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/initCompositionEvent
		DKDuktape::AttachFunction("CPP_DKCompositionEvent_initCompositionEvent", DKCompositionEventJS::initCompositionEvent);

		
		////// Events //////
		// [compositionstart] https://w3c.github.io/uievents/#event-type-compositionstart
		DKEventTarget::LinkAddEventListenerFunc		("compositionstart", 	&DKCompositionEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("compositionstart", 	&DKCompositionEventJS::removeEventListener, 	this);
		// [compositionupdate] https://w3c.github.io/uievents/#event-type-compositionupdate
		DKEventTarget::LinkAddEventListenerFunc		("compositionupdate", 	&DKCompositionEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("compositionupdate", 	&DKCompositionEventJS::removeEventListener, 	this);
		// [compositionend] https://w3c.github.io/uievents/#event-type-compositionend
		DKEventTarget::LinkAddEventListenerFunc		("compositionend", 		&DKCompositionEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("compositionend", 		&DKCompositionEventJS::removeEventListener, 	this);
		
		
		////// Load .js files
		DKClass::DKCreate("DKEventTest/DKCompositionEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [CompositionEvent()] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/CompositionEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = duk_require_string(ctx, 1);
		DKINFO("CPP_DKCompositionEvent("+type+","+options+")\n");
		DKCompositionEvent* event = new DKCompositionEvent(type, options);
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [CompositionEvent.data](Read only) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/data
	/* //FIXME: data is already a member of DKObject
	static int data(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKCompositionEvent* event = (DKCompositionEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->data.c_str());	
		return true;
	}
	*/
	// [CompositionEvent.locale](Read only)(Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/locale
	static int locale(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKCompositionEvent* event = (DKCompositionEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->locale.c_str());	
		return true;
	}

	
	////// Instance methods //////
	// [CompositionEvent.initCompositionEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/initCompositionEvent
	static int initCompositionEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}



	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool addEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::addEventListener<DKCompositionEvent>(_type, &DKCompositionEventJS::onCompositionEvent, eventTargetAddress);
		return true;
	}
	
	bool removeEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::removeEventListener<DKCompositionEvent>(_type, &DKCompositionEventJS::onCompositionEvent, eventTargetAddress);
		return true;
	}
	
	static bool onCompositionEvent(DKCompositionEvent* event) {
		DKDEBUGFUNC(event);
		DKINFO("onCompositionEvent("+event->type+") \n");
		
		// get the globally stored js callback function
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		DKString cb = event->target+"_"+event->type+"_callback";
		duk_get_global_string(DKDuktape::ctx, cb.c_str());
		
		// create and push the Event(eventAddress) object		
		DKString eventObjStr = "var eventObj = new CompositionEvent('', '', '"+eventAddress+"'); eventObj;";
		DukValue eventObj = dukglue_peval<DukValue>(DKDuktape::ctx, eventObjStr.c_str());
		dukglue_push(DKDuktape::ctx, eventObj);
		
		// call callback function
		if(duk_pcall(DKDuktape::ctx, 1) != 0) //1 = num or args
			DKDuktape::DumpError(eventAddress);
	
		return true;
	}	
};
REGISTER_OBJECT(DKCompositionEventJS, true)


#endif //DKCompositionEventJS_H