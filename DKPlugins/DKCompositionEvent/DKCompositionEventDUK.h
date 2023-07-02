// [IDL] https://w3c.github.io/uievents/#idl-compositionevent
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
		DKDuktape::AttachFunction("CPP_DKCompositionEventDUK_constructor", 			DKCompositionEventDUK::constructor);
	
		// readonly attribute DOMString data;
		DKDuktape::AttachFunction("CPP_DKCompositionEventDUK_data",					DKCompositionEventDUK::_data); //FIXME: data is already a member of DKObject
		
		// Source: UI Events (https://www.w3.org/TR/uievents/)
		// partial interface CompositionEvent {
		//		// Originally introduced (and deprecated) in this specification
		//		undefined initCompositionEvent(DOMString typeArg,
		//		optional boolean bubblesArg = false,
		//		optional boolean cancelableArg = false,
		//		optional WindowProxy? viewArg = null,
		//		optional DOMString dataArg = "");
		DKDuktape::AttachFunction("CPP_DKCompositionEventDUK_initCompositionEvent",	DKCompositionEventDUK::initCompositionEvent);
		// };
	
	
		////// Load .js files //////
		DKClass::DKCreate("DKCompositionEvent/DKCompositionEventDUK.js");
		
		return true;
	}
	
	
	static DKCompositionEvent* compositionEvent(duk_context* ctx){
		DKString interfaceAddress = duk_require_string(ctx, 0);
		DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
		DKString compositionEventAddress = interface->address["CompositionEvent"];
		DKCompositionEvent* _compositionEvent = (DKCompositionEvent*)addressToPointer(compositionEventAddress);
		return _compositionEvent;
	}
	
	// constructor(DOMString type, optional CompositionEventInit eventInitDict = {});
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString eventInitDict = "{}";	//duk_require_string(ctx, 1);
		
		DKINFO("CPP_DKCompositionEventDUK_constructor("+type+","+eventInitDict+")\n");
		DKCompositionEvent* compositionEvent = new DKCompositionEvent(type, eventInitDict);
		dukglue_push(ctx, compositionEvent->interfaceAddress);	
		return true;
	}
	
	// readonly attribute DOMString data;
	static int _data(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_string(ctx, 1))
			compositionEvent(ctx)->data(duk_to_string(ctx, 1));
		dukglue_push(ctx, compositionEvent(ctx)->data());	
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