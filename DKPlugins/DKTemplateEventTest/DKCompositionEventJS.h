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
		registerEventType("compositionstart");
		// [compositionupdate] https://w3c.github.io/uievents/#event-type-compositionupdate
		registerEventType("compositionupdate");
		// [compositionend] https://w3c.github.io/uievents/#event-type-compositionend
		registerEventType("compositionend");
		
		
		////// Load .js files
		DKClass::DKCreate("DKTemplateEventTest/DKCompositionEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [CompositionEvent()] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/CompositionEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKCompositionEvent("+type+","+options+")\n");
		DKCompositionEventJS::Get()->registerEventType(type);
		DKCompositionEvent* event = new DKCompositionEvent(type, options);
		DKString eventAddress = pointerToAddress(event);
		DKEventTarget::LinkDispatchEventFunc(eventAddress, &DKCompositionEventJS::dispatchEvent, DKCompositionEventJS::Get());
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [CompositionEvent.data](Read only) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/data
	/* //FIXME: data is already a member of DKObject
	static int data(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKCompositionEvent* event = (DKCompositionEvent*)addressToPointer(eventAddress);
		duk_push_string(ctx, event->data.c_str());	
		return true;
	}
	*/
	// [CompositionEvent.locale](Read only)(Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/locale
	static int locale(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKCompositionEvent* event = (DKCompositionEvent*)addressToPointer(eventAddress);
		duk_push_string(ctx, event->locale.c_str());	
		return true;
	}

	
	////// Instance methods //////
	// [CompositionEvent.initCompositionEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/initCompositionEvent
	static int initCompositionEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}



	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool registerEventType(const DKString& _type){
		DKEventTarget::LinkAddEventListenerFunc		(_type, &DKCompositionEventJS::addEventListener, 	this);
		DKEventTarget::LinkRemoveEventListenerFunc	(_type,	&DKCompositionEventJS::removeEventListener, this);
		return true;
	}
	
	bool addEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::addEventListener<DKCompositionEvent>(_type, &DKCompositionEventJS::onCompositionEvent, eventTargetAddress);
		return true;
	}
	
	bool removeEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::removeEventListener<DKCompositionEvent>(_type, &DKCompositionEventJS::onCompositionEvent, eventTargetAddress);
		return true;
	}
	
	bool dispatchEvent(const DKString& eventAddress, const DKString& eventTargetAddress){
		DKINFO("DKCompositionEventJS::dispatchEvent("+eventAddress+", "+eventTargetAddress+") \n");
		DKCompositionEvent* event = (DKCompositionEvent*)addressToPointer(eventAddress);
		DKEventTarget::dispatchEvent(event, eventTargetAddress);
		return true;
	}
	
	static bool onCompositionEvent(DKCompositionEvent* event) {
		DKDEBUGFUNC(event);
		DKINFO("onCompositionEvent("+event->type+") \n");
		
		// get the globally stored js callback function
		DKString eventAddress = pointerToAddress(event);
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