// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/InputEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-inputevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent
#pragma once
#ifndef DKInputEventDUK_H
#define DKInputEventDUK_H

#include "DKDuktape/DKDuktape.h"


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface InputEvent : UIEvent {
class DKInputEventDUK : public DKObjectT<DKInputEventDUK>
{
public:
	bool Init(){
		
		// constructor(DOMString type, optional InputEventInit eventInitDict = {});
		DKDuktape::AttachFunction("CPP_DKInputEventDUK", 				DKInputEventDUK::constructor);
	
		// readonly attribute DOMString? data;
		DKDuktape::AttachFunction("CPP_DKInputEventDUK_data",			DKInputEventDUK::_data); //FIXME: data is already a member of DKObject
		
		// readonly attribute boolean isComposing;
		DKDuktape::AttachFunction("CPP_DKInputEventDUK_isComposing", 	DKInputEventDUK::isComposing);
		
		// readonly attribute DOMString inputType;
		DKDuktape::AttachFunction("CPP_DKInputEventDUK_inputType",		DKInputEventDUK::inputType);
		
		// Source: Input Events Level 2 (https://www.w3.org/TR/input-events-2/)
		// partial interface InputEvent {
		//    	readonly attribute DataTransfer? dataTransfer;
				DKDuktape::AttachFunction("CPP_DKInputEventDUK_dataTransfer",	DKInputEventDUK::dataTransfer);
		//    	sequence<StaticRange> getTargetRanges();
				DKDuktape::AttachFunction("CPP_DKInputEventDUK_getTargetRanges", DKInputEventDUK::getTargetRanges);
		// };
		

		////// Load .js files //////
		DKClass::DKCreate("DKInputEvent/DKInputEventDUK.js");
		
		return true;
	}
	
	
	// constructor(DOMString type, optional InputEventInit eventInitDict = {});
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKInputEventDUK("+type+","+options+")\n");
		DKInputEvent* event = new DKInputEvent(type, options);
		DKString eventAddress = pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	// readonly attribute DOMString? data;
	static int _data(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKInputEvent* event = (DKInputEvent*)addressToPointer(eventAddress);
		if (duk_is_string(ctx, 1))
			event->data = duk_to_string(ctx, 1);
		duk_push_string(ctx, event->data.c_str());	
		return true;
	}
	
	//readonly attribute boolean isComposing;
	static int isComposing(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKInputEvent* event = (DKInputEvent*)addressToPointer(eventAddress);
		if (duk_is_boolean(ctx, 1))
			event->isComposing = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, event->isComposing);	
		return true;
	}
	
	//readonly attribute DOMString inputType;
	static int inputType(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKInputEvent* event = (DKInputEvent*)addressToPointer(eventAddress);
		if (duk_is_string(ctx, 1))
			event->inputType = duk_to_string(ctx, 1);
		duk_push_string(ctx, event->inputType.c_str());	
		return true;
	}
	
	// Source: Input Events Level 2 (https://www.w3.org/TR/input-events-2/)
	// partial interface InputEvent {
	//    	readonly attribute DataTransfer? dataTransfer;
			static int dataTransfer(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				DKString eventAddress = duk_require_string(ctx, 0);
				DKInputEvent* event = (DKInputEvent*)addressToPointer(eventAddress);
				duk_push_string(ctx, event->dataTransfer.c_str());	
				return true;
			}
	//    	sequence<StaticRange> getTargetRanges();
			static int getTargetRanges(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				return DKTODO();
			}
	// };
};
REGISTER_OBJECT(DKInputEventDUK, true)


#endif //DKInputEventDUK_H