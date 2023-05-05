// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/KeyboardEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-keyboardevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
#pragma once
#ifndef DKKeyboardEventDUK_H
#define DKKeyboardEventDUK_H

#include "DKDuktape/DKDuktape.h"


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface KeyboardEvent : UIEvent {
class DKKeyboardEventDUK : public DKObjectT<DKKeyboardEventDUK>
{
public:
	bool Init(){
		
		// constructor(DOMString type, optional KeyboardEventInit eventInitDict = {});
		DKDuktape::AttachFunction("CPP_DKKeyboardEventDUK", 				DKKeyboardEventDUK::constructor);
		
		// KeyLocationCode
		// const unsigned long DOM_KEY_LOCATION_STANDARD = 0x00;
		
		// const unsigned long DOM_KEY_LOCATION_LEFT = 0x01;
		
		// const unsigned long DOM_KEY_LOCATION_RIGHT = 0x02;
		
		// const unsigned long DOM_KEY_LOCATION_NUMPAD = 0x03;
	
		// readonly attribute DOMString key;
		DKDuktape::AttachFunction("CPP_DKKeyboardEventDUK_key", 			DKKeyboardEventDUK::key);
		
		// readonly attribute DOMString code;
		DKDuktape::AttachFunction("CPP_DKKeyboardEventDUK_code",			DKKeyboardEventDUK::code);
		
		// readonly attribute unsigned long location;
		DKDuktape::AttachFunction("CPP_DKKeyboardEventDUK_location", 		DKKeyboardEventDUK::location);
		
		// readonly attribute boolean ctrlKey;
		DKDuktape::AttachFunction("CPP_DKKeyboardEventDUK_ctrlKey",			DKKeyboardEventDUK::ctrlKey);
		
		// readonly attribute boolean shiftKey;
		DKDuktape::AttachFunction("CPP_DKKeyboardEventDUK_shiftKey",		DKKeyboardEventDUK::shiftKey);
		
		// readonly attribute boolean altKey;
		DKDuktape::AttachFunction("CPP_DKKeyboardEventDUK_altKey",			DKKeyboardEventDUK::altKey);
		
		// readonly attribute boolean metaKey;
		DKDuktape::AttachFunction("CPP_DKKeyboardEventDUK_metaKey", 		DKKeyboardEventDUK::metaKey);
		
		// readonly attribute boolean repeat;
		DKDuktape::AttachFunction("CPP_DKKeyboardEventDUK_repeat",			DKKeyboardEventDUK::repeat);
		
		// readonly attribute boolean isComposing;
		DKDuktape::AttachFunction("CPP_DKKeyboardEventDUK_isComposing", 	DKKeyboardEventDUK::isComposing);
		
		// boolean getModifierState(DOMString keyArg);
		DKDuktape::AttachFunction("CPP_DKKeyboardEventDUK_getModifierState", DKKeyboardEventDUK::getModifierState);
		
		// Source: UI Events (https://www.w3.org/TR/uievents/)
		// partial interface KeyboardEvent {
		//		// Originally introduced (and deprecated) in this specification
		//		undefined initKeyboardEvent(DOMString typeArg,
		// 		optional boolean bubblesArg = false,
		// 		optional boolean cancelableArg = false,
		//		optional Window? viewArg = null,
		//		optional DOMString keyArg = "",
		//		optional unsigned long locationArg = 0,
		//		optional boolean ctrlKey = false,
		//		optional boolean altKey = false,
		//		optional boolean shiftKey = false,
		//		optional boolean metaKey = false);
				DKDuktape::AttachFunction("CPP_DKKeyboardEventDUK_initKeyboardEvent", DKKeyboardEventDUK::initKeyboardEvent);
		// };
	
		// Source: UI Events (https://www.w3.org/TR/uievents/)
		// partial interface KeyboardEvent {
		//		// The following support legacy user agents
		//		readonly attribute unsigned long charCode;
				DKDuktape::AttachFunction("CPP_DKKeyboardEventDUK_charCode",		DKKeyboardEventDUK::charCode);
		//		readonly attribute unsigned long keyCode;
				DKDuktape::AttachFunction("CPP_DKKeyboardEventDUK_keyCode",		DKKeyboardEventDUK::keyCode);
		// };
	

		////// Load .js files //////
		DKClass::DKCreate("DKKeyboardEvent/DKKeyboardEventDUK.js");
		
		return true;
	}
	
	
	// constructor(DOMString type, optional KeyboardEventInit eventInitDict = {});
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKKeyboardEventDUK("+type+","+options+")\n");
		DKKeyboardEvent* event = new DKKeyboardEvent(type, options);
		DKString eventAddress = pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	// KeyLocationCode
	// const unsigned long DOM_KEY_LOCATION_STANDARD = 0x00;
		
	// const unsigned long DOM_KEY_LOCATION_LEFT = 0x01;
		
	// const unsigned long DOM_KEY_LOCATION_RIGHT = 0x02;
		
	// const unsigned long DOM_KEY_LOCATION_NUMPAD = 0x03;
	
	// readonly attribute DOMString key;
	static int key(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)addressToPointer(eventAddress);
		if (duk_is_string(ctx, 1))
			event->key = duk_to_string(ctx, 1);
		duk_push_string(ctx, event->key.c_str());	
		return true;
	}
	
	// readonly attribute DOMString code;
	static int code(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)addressToPointer(eventAddress);
		if (duk_is_string(ctx, 1))
			event->code = duk_to_string(ctx, 1);
		duk_push_string(ctx, event->code.c_str());	
		return true;
	}
	
	// readonly attribute unsigned long location;
	static int location(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)addressToPointer(eventAddress);
		if (duk_is_number(ctx, 1))
			event->location = duk_to_int(ctx, 1);
		duk_push_int(ctx, event->location);	
		return true;
	}
	
	// readonly attribute boolean ctrlKey;
	static int ctrlKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)addressToPointer(eventAddress);
		if (duk_is_boolean(ctx, 1))
			event->ctrlKey = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, event->ctrlKey);	
		return true;
	}
	
	// readonly attribute boolean shiftKey;
	static int shiftKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)addressToPointer(eventAddress);
		if (duk_is_boolean(ctx, 1))
			event->shiftKey = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, event->shiftKey);	
		return true;
	}
	
	// readonly attribute boolean altKey;
	static int altKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)addressToPointer(eventAddress);
		if (duk_is_boolean(ctx, 1))
			event->altKey = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, event->altKey);	
		return true;
	}
	
	// readonly attribute boolean metaKey;
	static int metaKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)addressToPointer(eventAddress);
		if (duk_is_boolean(ctx, 1))
			event->metaKey = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, event->metaKey);	
		return true;
	}
	
	// readonly attribute boolean repeat;
	static int repeat(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)addressToPointer(eventAddress);
		if (duk_is_boolean(ctx, 1))
			event->repeat = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, event->repeat);	
		return true;
	}
	
	// readonly attribute boolean isComposing;
	static int isComposing(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)addressToPointer(eventAddress);
		if (duk_is_boolean(ctx, 1))
			event->isComposing = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, event->isComposing);	
		return true;
	}
	
	// boolean getModifierState(DOMString keyArg);
	static int getModifierState(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface KeyboardEvent {
	//		// Originally introduced (and deprecated) in this specification
	//		undefined initKeyboardEvent(DOMString typeArg,
	// 		optional boolean bubblesArg = false,
	// 		optional boolean cancelableArg = false,
	//		optional Window? viewArg = null,
	//		optional DOMString keyArg = "",
	//		optional unsigned long locationArg = 0,
	//		optional boolean ctrlKey = false,
	//		optional boolean altKey = false,
	//		optional boolean shiftKey = false,
	//		optional boolean metaKey = false);
			static int initKeyboardEvent(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				return DKDEPRECATED();
			}
	// };
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface KeyboardEvent {
	//		// The following support legacy user agents
	//		readonly attribute unsigned long charCode;
			static int charCode(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				DKString eventAddress = duk_require_string(ctx, 0);
				DKKeyboardEvent* event = (DKKeyboardEvent*)addressToPointer(eventAddress);
				duk_push_uint(ctx, event->charCode);	
				return DKDEPRECATED();
			}
	//		readonly attribute unsigned long keyCode;
			static int keyCode(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				DKString eventAddress = duk_require_string(ctx, 0);
				DKKeyboardEvent* event = (DKKeyboardEvent*)addressToPointer(eventAddress);
				duk_push_uint(ctx, event->keyCode);	
				return DKDEPRECATED();
			}
	// };
};
REGISTER_OBJECT(DKKeyboardEventDUK, true)


#endif //DKKeyboardEventDUK_H