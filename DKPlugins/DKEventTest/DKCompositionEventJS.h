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
		DKDuktape::AttachFunction("CPP_DKCompositionEvent_data",	DKCompositionEventJS::_data); //FIXME: data is already a member of DKObject
		DKDuktape::AttachFunction("CPP_DKCompositionEvent_locale",	DKCompositionEventJS::locale);


		////// Instance methods //////
		// [CompositionEvent.initCompositionEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/initCompositionEvent
		DKDuktape::AttachFunction("CPP_DKCompositionEvent_initCompositionEvent", DKCompositionEventJS::initCompositionEvent);

		
		////// Events //////
		// [compositionstart] https://w3c.github.io/uievents/#event-type-compositionstart
		// [compositionupdate] https://w3c.github.io/uievents/#event-type-compositionupdate
		// [compositionend] https://w3c.github.io/uievents/#event-type-compositionend
		
		
		////// Load .js files
		DKClass::DKCreate("DKEventTest/DKCompositionEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [CompositionEvent()] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/CompositionEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKCompositionEvent("+type+","+options+")\n");
		DKCompositionEvent* event = new DKCompositionEvent(type, options);
		//event->eventClass = "CompositionEvent";
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [CompositionEvent.data](Read only) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/data
	//FIXME: data is already a member of DKObject
	static int _data(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKCompositionEvent* event = (DKCompositionEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_string(ctx, 1))
			event->data = duk_to_string(ctx, 1);
		duk_push_string(ctx, event->data.c_str());	
		return true;
	}
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

};
REGISTER_OBJECT(DKCompositionEventJS, true)


#endif //DKCompositionEventJS_H