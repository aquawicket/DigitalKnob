// [IDL] https://w3c.github.io/uievents/#idl-inputevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent
#if HAVE_DKDuktape

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
		DKDuktape::AttachFunction("CPP_DKInputEventDUK_constructor", 		DKInputEventDUK::constructor);
	
		// readonly attribute DOMString? data;
		DKDuktape::AttachFunction("CPP_DKInputEventDUK_data",				DKInputEventDUK::_data); //FIXME: data is already a member of DKObject
		
		// readonly attribute boolean isComposing;
		DKDuktape::AttachFunction("CPP_DKInputEventDUK_isComposing", 		DKInputEventDUK::isComposing);
		
		// readonly attribute DOMString inputType;
		DKDuktape::AttachFunction("CPP_DKInputEventDUK_inputType",			DKInputEventDUK::inputType);
		
		// Source: Input Events Level 2 (https://www.w3.org/TR/input-events-2/)
		// partial interface InputEvent {
		// readonly attribute DataTransfer? dataTransfer;
		DKDuktape::AttachFunction("CPP_DKInputEventDUK_dataTransfer",		DKInputEventDUK::dataTransfer);
		//
		// sequence<StaticRange> getTargetRanges();
		DKDuktape::AttachFunction("CPP_DKInputEventDUK_getTargetRanges",	DKInputEventDUK::getTargetRanges);
		// };
		

		////// Load .js files //////
		DKClass::DKCreate("DKInputEvent/DKInputEventDUK.js");
		
		return true;
	}
	
	
	static DKInputEvent* inputEvent(duk_context* ctx){
		DKString interfaceAddress = duk_require_string(ctx, 0);
		DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
		DKString inputEventAddress = interface->address["InputEvent"];
		DKInputEvent* _inputEvent = (DKInputEvent*)addressToPointer(inputEventAddress);
		return _inputEvent;
	}
	
	// constructor(DOMString type, optional InputEventInit eventInitDict = {});
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString eventInitDict = "{}";	//duk_require_string(ctx, 1);
		
		DKINFO("CPP_DKInputEventDUK_constructor("+type+","+eventInitDict+")\n");
		DKInputEvent* inputEvent = new DKInputEvent(type, eventInitDict);
		dukglue_push(ctx, inputEvent->interfaceAddress);	
		return true;
	}
	
	// readonly attribute DOMString? data;
	static int _data(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_string(ctx, 1))
			inputEvent(ctx)->data(duk_to_string(ctx, 1));
		dukglue_push(ctx, inputEvent(ctx)->data());	
		return true;
	}
	
	//readonly attribute boolean isComposing;
	static int isComposing(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_boolean(ctx, 1))
			inputEvent(ctx)->isComposing(duk_to_boolean(ctx, 1));
		dukglue_push(ctx, inputEvent(ctx)->isComposing());	
		return true;
	}
	
	//readonly attribute DOMString inputType;
	static int inputType(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_string(ctx, 1))
			inputEvent(ctx)->inputType(duk_to_string(ctx, 1));
		dukglue_push(ctx, inputEvent(ctx)->inputType());	
		return true;
	}
	
	// Source: Input Events Level 2 (https://www.w3.org/TR/input-events-2/)
	// partial interface InputEvent {
	//    	readonly attribute DataTransfer? dataTransfer;
			static int dataTransfer(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				dukglue_push(ctx, inputEvent(ctx)->dataTransfer());	
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
#endif //HAVE_DKDuktape