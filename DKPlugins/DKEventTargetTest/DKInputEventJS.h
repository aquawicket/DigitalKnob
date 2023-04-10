#pragma once
#ifndef DKInputEventJS_H
#define DKInputEventJS_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [W3C] https://w3c.github.io/uievents/#events-inputevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent
class DKInputEventJS : public DKObjectT<DKInputEventJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKInputEvent", DKInputEventJS::constructor);
	
	
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKInputEvent_data",			DKInputEventJS::_data); //FIXME: data is already a member of DKObject
		DKDuktape::AttachFunction("CPP_DKInputEvent_dataTransfer",	DKInputEventJS::dataTransfer);
		DKDuktape::AttachFunction("CPP_DKInputEvent_inputType",		DKInputEventJS::inputType);
		DKDuktape::AttachFunction("CPP_DKInputEvent_isComposing", 	DKInputEventJS::isComposing);

		
		////// Instance methods //////
		// [InputEvent.getTargetRanges()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/getTargetRanges
		DKDuktape::AttachFunction("CPP_DKInputEvent_getTargetRanges", DKInputEventJS::getTargetRanges);

		
		////// Events //////
		// [beforeinput] https://w3c.github.io/uievents/#event-type-beforeinput
		// [input] https://developer.mozilla.org/en-US/docs/Web/API/Element/keyup_event

			
		////// Load .js files
		DKClass::DKCreate("DKEventTargetTest/DKInputEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [InputEvent()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/InputEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKInputEvent("+type+","+options+")\n");
		DKInputEvent* event = new DKInputEvent(type, options);
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [InputEvent.data](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/data
	//FIXME: data is already a member of DKObject
	static int _data(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKInputEvent* event = (DKInputEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_string(ctx, 1))
			event->data = duk_to_string(ctx, 1);
		duk_push_string(ctx, event->data.c_str());	
		return true;
	}
	// [InputEvent.dataTransfer](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/dataTransfer
	static int dataTransfer(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKInputEvent* event = (DKInputEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->dataTransfer.c_str());	
		return true;
	}
	// [InputEvent.inputType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/inputType
	static int inputType(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKInputEvent* event = (DKInputEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_string(ctx, 1))
			event->inputType = duk_to_string(ctx, 1);
		duk_push_string(ctx, event->inputType.c_str());	
		return true;
	}
	// [InputEvent.isComposing](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/isComposing
	static int isComposing(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKInputEvent* event = (DKInputEvent*)DKDuktape::addressToPointer(eventAddress);
		if (duk_is_boolean(ctx, 1))
			event->isComposing = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, event->isComposing);	
		return true;
	}

	
	////// Instance methods //////
	// [InputEvent.getTargetRanges()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/getTargetRanges
	static int getTargetRanges(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}

};
REGISTER_OBJECT(DKInputEventJS, true)


#endif //DKInputEventJS_H