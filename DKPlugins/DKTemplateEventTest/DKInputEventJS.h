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
		//DKDuktape::AttachFunction("CPP_DKInputEvent_data",			DKInputEventJS::data); //FIXME: data is already a member of DKObject
		DKDuktape::AttachFunction("CPP_DKInputEvent_dataTransfer",	DKInputEventJS::dataTransfer);
		DKDuktape::AttachFunction("CPP_DKInputEvent_inputType",		DKInputEventJS::inputType);
		DKDuktape::AttachFunction("CPP_DKInputEvent_isComposing", 	DKInputEventJS::isComposing);

		
		////// Instance methods //////
		// [InputEvent.getTargetRanges()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/getTargetRanges
		DKDuktape::AttachFunction("CPP_DKInputEvent_getTargetRanges", DKInputEventJS::getTargetRanges);

		
		////// Events //////
		// [beforeinput] https://w3c.github.io/uievents/#event-type-beforeinput
		registerEventType("beforeinput");
		// [input] https://developer.mozilla.org/en-US/docs/Web/API/Element/keyup_event
		registerEventType("input");

			
		////// Load .js files
		DKClass::DKCreate("DKTemplateEventTest/DKInputEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [InputEvent()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/InputEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKInputEvent("+type+","+options+")\n");
		DKInputEventJS::Get()->registerEventType(type);
		DKInputEvent* event = new DKInputEvent(type, options);
		DKString eventAddress = pointerToAddress(event);
		DKEventTarget::LinkDispatchEventFunc(eventAddress, &DKInputEventJS::dispatchEvent, DKInputEventJS::Get());
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [InputEvent.data](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/data
	/* //FIXME: data is already a member of DKObject
	static int data(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKInputEvent* event = (DKInputEvent*)addressToPointer(eventAddress);
		duk_push_string(ctx, event->data.c_str());	
		return true;
	}
	*/
	// [InputEvent.dataTransfer](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/dataTransfer
	static int dataTransfer(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKInputEvent* event = (DKInputEvent*)addressToPointer(eventAddress);
		duk_push_string(ctx, event->dataTransfer.c_str());	
		return true;
	}
	// [InputEvent.inputType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/inputType
	static int inputType(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKInputEvent* event = (DKInputEvent*)addressToPointer(eventAddress);
		duk_push_string(ctx, event->inputType.c_str());	
		return true;
	}
	// [InputEvent.isComposing](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/isComposing
	static int isComposing(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKInputEvent* event = (DKInputEvent*)addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->isComposing);	
		return true;
	}

	
	////// Instance methods //////
	// [InputEvent.getTargetRanges()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/getTargetRanges
	static int getTargetRanges(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}



	//////////////////////////////////////////////////////////////////////////////////////////////////////
	bool registerEventType(const DKString& _type){
		DKEventTarget::LinkAddEventListenerFunc		(_type, &DKInputEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	(_type,	&DKInputEventJS::removeEventListener, 	this);
		return true;
	}
	
	bool addEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::addEventListener<DKInputEvent>(_type, &DKInputEventJS::onInputEvent, eventTargetAddress);
		return true;
	}
	
	bool removeEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::removeEventListener<DKInputEvent>(_type, &DKInputEventJS::onInputEvent, eventTargetAddress);
		return true;
	}
	
	bool dispatchEvent(const DKString& eventAddress, const DKString& eventTargetAddress){
		DKINFO("DKInputEventJS::dispatchEvent("+eventAddress+", "+eventTargetAddress+") \n");
		DKInputEvent* event = (DKInputEvent*)addressToPointer(eventAddress);
		DKEventTarget::dispatchEvent(event, eventTargetAddress);
		return true;
	}
	
	static bool onInputEvent(DKInputEvent* event) {
		DKDEBUGFUNC(event);
		DKINFO("onInputEvent("+event->type+") \n");
		
		// get the globally stored js callback function
		DKString eventAddress = pointerToAddress(event);
		DKString cb = event->target+"_"+event->type+"_callback";
		duk_get_global_string(DKDuktape::ctx, cb.c_str());
		
		// create and push the Event(eventAddress) object		
		DKString eventObjStr = "var eventObj = new InputEvent('', '', '"+eventAddress+"'); eventObj;";
		DukValue eventObj = dukglue_peval<DukValue>(DKDuktape::ctx, eventObjStr.c_str());
		dukglue_push(DKDuktape::ctx, eventObj);
		
		// call callback function
		if(duk_pcall(DKDuktape::ctx, 1) != 0) //1 = num or args
			DKDuktape::DumpError(eventAddress);
	
		return true;
	}	
};
REGISTER_OBJECT(DKInputEventJS, true)


#endif //DKInputEventJS_H