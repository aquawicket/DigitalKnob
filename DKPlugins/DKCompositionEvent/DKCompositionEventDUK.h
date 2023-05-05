// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/CompositionEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-compositionevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent
#if HAVE_DKDuktape

#pragma once
#ifndef DKCompositionEventDUK_H
#define DKCompositionEventDUK_H

#include "DKDuktape/DKDuktape.h"


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface CompositionEvent : UIEvent {
class DKCompositionEventDUK : public DKObjectT<DKCompositionEventDUK>
{
public:
	bool Init(){
		
		// constructor(DOMString type, optional CompositionEventInit eventInitDict = {});
		DKDuktape::AttachFunction("CPP_DKCompositionEventDUK", DKCompositionEventDUK::constructor);
	
		// readonly attribute DOMString data;
		DKDuktape::AttachFunction("CPP_DKCompositionEventDUK_data",	DKCompositionEventDUK::_data); //FIXME: data is already a member of DKObject
		
		// Source: UI Events (https://www.w3.org/TR/uievents/)
		// partial interface CompositionEvent {
		//		// Originally introduced (and deprecated) in this specification
		//		undefined initCompositionEvent(DOMString typeArg,
		//		optional boolean bubblesArg = false,
		//		optional boolean cancelableArg = false,
		//		optional WindowProxy? viewArg = null,
		//		optional DOMString dataArg = "");
				DKDuktape::AttachFunction("CPP_DKCompositionEventDUK_initCompositionEvent", DKCompositionEventDUK::initCompositionEvent);
		// };
	
	
		////// Load .js files //////
		DKClass::DKCreate("DKCompositionEvent/DKCompositionEventDUK.js");
		
		return true;
	}
	
	
	// constructor(DOMString type, optional CompositionEventInit eventInitDict = {});
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
	
	// readonly attribute DOMString data;
	static int _data(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKCompositionEvent* event = (DKCompositionEvent*)addressToPointer(eventAddress);
		if (duk_is_string(ctx, 1))
			event->data = duk_to_string(ctx, 1);
		duk_push_string(ctx, event->data.c_str());	
		return true;
	}
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
		// partial interface CompositionEvent {
		//		// Originally introduced (and deprecated) in this specification
		//		undefined initCompositionEvent(DOMString typeArg,
		//		optional boolean bubblesArg = false,
		//		optional boolean cancelableArg = false,
		//		optional WindowProxy? viewArg = null,
		//		optional DOMString dataArg = "");
				static int initCompositionEvent(duk_context* ctx){
					DKDEBUGFUNC(ctx);
					return DKTODO();
				}
		// };
};
REGISTER_OBJECT(DKCompositionEventDUK, true)


#endif //DKCompositionEventDUK_H
#endif //HAVE_DKDuktape