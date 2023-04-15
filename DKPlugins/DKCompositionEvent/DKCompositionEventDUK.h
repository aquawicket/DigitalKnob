#if HAVE_DKDuktape

#pragma once
#ifndef DKCompositionEventDUK_H
#define DKCompositionEventDUK_H

#include "DKDuktape/DKDuktape.h"


// [W3C] https://w3c.github.io/uievents/#events-compositionevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent
class DKCompositionEventDUK : public DKObjectT<DKCompositionEventDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKCompositionEventDUK", DKCompositionEventDUK::constructor);
	
	
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKCompositionEventDUK_data",	DKCompositionEventDUK::_data); //FIXME: data is already a member of DKObject
		DKDuktape::AttachFunction("CPP_DKCompositionEventDUK_locale",	DKCompositionEventDUK::locale);


		////// Instance methods //////
		// [CompositionEvent.initCompositionEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/initCompositionEvent
		DKDuktape::AttachFunction("CPP_DKCompositionEventDUK_initCompositionEvent", DKCompositionEventDUK::initCompositionEvent);

		
		////// Events //////
		// [compositionstart] https://w3c.github.io/uievents/#event-type-compositionstart
		// [compositionupdate] https://w3c.github.io/uievents/#event-type-compositionupdate
		// [compositionend] https://w3c.github.io/uievents/#event-type-compositionend
		
		
		////// Load .js files
		DKClass::DKCreate("DKCompositionEvent/DKCompositionEventDUK.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [CompositionEvent()] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/CompositionEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKCompositionEventDUK("+type+","+options+")\n");
		DKCompositionEvent* event = new DKCompositionEvent(type, options);
		//event->eventClass = "CompositionEvent";
		DKString eventAddress = pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [CompositionEvent.data](Read only) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/data
	//FIXME: data is already a member of DKObject
	static int _data(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKCompositionEvent* event = (DKCompositionEvent*)addressToPointer(eventAddress);
		if (duk_is_string(ctx, 1))
			event->data = duk_to_string(ctx, 1);
		duk_push_string(ctx, event->data.c_str());	
		return true;
	}
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

};
REGISTER_OBJECT(DKCompositionEventDUK, true)


#endif //DKCompositionEventDUK_H
#endif //HAVE_DKDuktape