#pragma once
#ifndef DKKeyboardEventJS_H
#define DKKeyboardEventJS_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
// [INTERFACE] https://w3c.github.io/uievents/#interface-keyboardevent
class DKKeyboardEventJS : public DKObjectT<DKKeyboardEventJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent", DKKeyboardEventJS::constructor);
		
		
		////// Constants //////
		// [DOM_KEY_LOCATION_STANDARD]	0x00
		// [DOM_KEY_LOCATION_LEFT]		0x01
		// [DOM_KEY_LOCATION_RIGHT]		0x02
		// [DOM_KEY_LOCATION_NUMPAD]	0x03
	
	
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_altKey", DKKeyboardEventJS::altKey);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_code", DKKeyboardEventJS::code);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_ctrlKey", DKKeyboardEventJS::ctrlKey);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_isComposing", DKKeyboardEventJS::isComposing);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_key", DKKeyboardEventJS::key);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_locale", DKKeyboardEventJS::locale);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_location", DKKeyboardEventJS::location);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_metaKey", DKKeyboardEventJS::metaKey);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_repeat", DKKeyboardEventJS::repeat);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_shiftKey", DKKeyboardEventJS::shiftKey);
		
		
		////// Instance methods //////
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_getModifierState", DKKeyboardEventJS::getModifierState);
		
		
		////// Register Events //////
		DKEventTarget::LinkAddEventListenerFunc("keydown", &DKKeyboardEventJS::addEventListener, this);
		DKEventTarget::LinkAddEventListenerFunc("keyup", &DKKeyboardEventJS::addEventListener, this);
		DKEventTarget::LinkAddEventListenerFunc("keypress", &DKKeyboardEventJS::addEventListener, this);
		
		
		////// Load .js files
		DKClass::DKCreate("DKEventTest/DKKeyboardEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = duk_require_string(ctx, 1);
		DKINFO("CPP_DKKeyboardEvent("+type+","+options+")\n");
		DKKeyboardEvent* event = new DKKeyboardEvent(type, options);
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	static int altKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->altKey);	
		return true;
	}
	static int code(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->code.c_str());	
		return true;
	}
	static int ctrlKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->ctrlKey);	
		return true;
	}
	static int isComposing(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->isComposing);	
		return true;
	}
	static int key(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->key.c_str());	
		return true;
	}
	static int locale(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->locale.c_str());	
		return true;
	}
	static int location(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_int(ctx, event->location);	
		return true;
	}
	static int metaKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->metaKey);	
		return true;
	}
	static int repeat(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->repeat);	
		return true;
	}
	static int shiftKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->shiftKey);	
		return true;
	}	
	
	
	////// Instance methods //////
	static int getModifierState(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		/*
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		*/
		return DKTODO();
	}



	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool addEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::addEventListener<DKKeyboardEvent>(_type, &DKKeyboardEventJS::onKeyboardEvent, eventTargetAddress);
		return true;
	}
	
	static bool onKeyboardEvent(DKKeyboardEvent* event) {
		DKDEBUGFUNC(event);
		DKINFO("onKeyboardEvent("+event->type+") \n");
		
		// get the globally stored js callback function
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		DKString cb = event->type+"_callback";
		duk_get_global_string(DKDuktape::ctx, cb.c_str());
		
		// create and push the Event(eventAddress) object		
		DKString eventObjStr = "var eventObj = new KeyboardEvent('', '', '"+eventAddress+"'); eventObj;";  // returns eventObj
		DukValue eventObj = dukglue_peval<DukValue>(DKDuktape::ctx, eventObjStr.c_str());
		dukglue_push(DKDuktape::ctx, eventObj);	 //push event object
		
		// delete duktape callback
		//duk_push_null(DKDuktape::ctx);
		//duk_put_global_string(DKDuktape::ctx, cb.c_str());
		
		// call callback function
		if(duk_pcall(DKDuktape::ctx, 1) != 0){ //1 = num or args
			DKDuktape::DumpError(eventAddress);
		}
	
		return true;
	}	
	
};
REGISTER_OBJECT(DKKeyboardEventJS, true)


#endif //DKKeyboardEventJS_H