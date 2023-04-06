#pragma once
#ifndef DKKeyboardEventJS_H
#define DKKeyboardEventJS_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [W3C] https://w3c.github.io/uievents/#events-keyboardevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
class DKKeyboardEventJS : public DKObjectT<DKKeyboardEventJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent", DKKeyboardEventJS::constructor);
		
		
		////// Constants //////
		////// Keyboard locations //////
		// [DOM_KEY_LOCATION_STANDARD]	0x00 https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent#keyboard_locations
		// [DOM_KEY_LOCATION_LEFT]		0x01 https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent#keyboard_locations
		// [DOM_KEY_LOCATION_RIGHT]		0x02 https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent#keyboard_locations
		// [DOM_KEY_LOCATION_NUMPAD]	0x03 https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent#keyboard_locations
	
	
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_altKey",			DKKeyboardEventJS::altKey);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_code",			DKKeyboardEventJS::code);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_ctrlKey",		DKKeyboardEventJS::ctrlKey);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_isComposing", 	DKKeyboardEventJS::isComposing);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_key", 			DKKeyboardEventJS::key);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_locale",			DKKeyboardEventJS::locale);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_location", 		DKKeyboardEventJS::location);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_metaKey", 		DKKeyboardEventJS::metaKey);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_repeat",			DKKeyboardEventJS::repeat);
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_shiftKey",		DKKeyboardEventJS::shiftKey);
		
		
		////// Instance methods //////
		// [KeyboardEvent.getModifierState()] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/getModifierState
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_getModifierState", DKKeyboardEventJS::getModifierState);
		
		
		////// Obsolete methods //////
		// [KeyboardEvent.initKeyEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/initKeyEvent
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_initKeyEvent", DKKeyboardEventJS::initKeyEvent);
		// [KeyboardEvent.initKeyboardEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/initKeyboardEvent
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_initKeyboardEvent", DKKeyboardEventJS::initKeyboardEvent);

	
		////// Obsolete properties //////
		// [KeyboardEvent.char](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/char
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_char",			DKKeyboardEventJS::_char);
		// [KeyboardEvent.charCode](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/charCode
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_charCode",		DKKeyboardEventJS::charCode);
		// [KeyboardEvent.keyCode](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyCode
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_keyCode",		DKKeyboardEventJS::keyCode);
		// [KeyboardEvent.keyIdentifier](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyIdentifier
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_keyIdentifier",	DKKeyboardEventJS::keyIdentifier);
		// [KeyboardEvent.keyLocation](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyLocation
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_keyLocation",	DKKeyboardEventJS::keyLocation);
		// [KeyboardEvent.which](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/which
		DKDuktape::AttachFunction("CPP_DKKeyboardEvent_which",			DKKeyboardEventJS::which);
		
		
		////// Events //////
		// [keydown] https://developer.mozilla.org/en-US/docs/Web/API/Element/keydown_event
		DKEventTarget::LinkAddEventListenerFunc		("keydown", 	&DKKeyboardEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("keydown", 	&DKKeyboardEventJS::removeEventListener, 	this);
		// [keyup] https://developer.mozilla.org/en-US/docs/Web/API/Element/keyup_event
		DKEventTarget::LinkAddEventListenerFunc		("keyup", 		&DKKeyboardEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("keyup", 		&DKKeyboardEventJS::removeEventListener, 	this);
		
		
		////// Obsolete events //////
		// [keypress](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/keypress_event
		DKEventTarget::LinkAddEventListenerFunc		("keypress", 	&DKKeyboardEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("keypress",	&DKKeyboardEventJS::removeEventListener, 	this);
		
		
		////// Load .js files
		DKClass::DKCreate("DKEventTest/DKKeyboardEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [KeyboardEvent()] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/KeyboardEvent
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
	// [KeyboardEvent.altKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/altKey
	static int altKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->altKey);	
		return true;
	}
	// [KeyboardEvent.code](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/code
	static int code(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->code.c_str());	
		return true;
	}
	// [KeyboardEvent.ctrlKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/ctrlKey
	static int ctrlKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->ctrlKey);	
		return true;
	}
	// [KeyboardEvent.isComposing](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/isComposing
	static int isComposing(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->isComposing);	
		return true;
	}
	// [KeyboardEvent.key](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key
	static int key(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->key.c_str());	
		return true;
	}
	// [KeyboardEvent.locale](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/locale
	static int locale(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->locale.c_str());	
		return true;
	}
	// [KeyboardEvent.location](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/location
	static int location(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_int(ctx, event->location);	
		return true;
	}
	// [KeyboardEvent.metaKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/metaKey
	static int metaKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->metaKey);	
		return true;
	}
	// [KeyboardEvent.repeat](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/repeat
	static int repeat(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->repeat);	
		return true;
	}
	// [KeyboardEvent.shiftKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/shiftKey
	static int shiftKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->shiftKey);	
		return true;
	}	
	
	
	////// Instance methods //////
	// [KeyboardEvent.getModifierState()] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/getModifierState
	static int getModifierState(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}


	////// Obsolete methods //////
	// [KeyboardEvent.initKeyEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/initKeyEvent
	static int initKeyEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKDEPRECATED();
	}
	// [KeyboardEvent.initKeyboardEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/initKeyboardEvent
	static int initKeyboardEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKDEPRECATED();
	}
	
	
	////// Obsolete properties //////
	// [KeyboardEvent.char](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/char
	static int _char(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->_char.c_str());	
		return DKDEPRECATED();
	}
	// [KeyboardEvent.charCode](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/charCode
	static int charCode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_uint(ctx, event->charCode);	
		return DKDEPRECATED();
	}
	// [KeyboardEvent.keyCode](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyCode
	static int keyCode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_uint(ctx, event->keyCode);	
		return DKDEPRECATED();
	}
	// [KeyboardEvent.keyIdentifier](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyIdentifier
	static int keyIdentifier(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->keyIdentifier.c_str());	
		return DKDEPRECATED();
	}
	// [KeyboardEvent.keyLocation](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyLocation
	static int keyLocation(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_uint(ctx, event->keyLocation);	
		return DKDEPRECATED();
	}
	// [KeyboardEvent.which](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/which
	static int which(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKKeyboardEvent* event = (DKKeyboardEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_uint(ctx, event->which);	
		return DKDEPRECATED();
	}


	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool addEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::addEventListener<DKKeyboardEvent>(_type, &DKKeyboardEventJS::onKeyboardEvent, eventTargetAddress);
		return true;
	}
	
	bool removeEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::removeEventListener<DKKeyboardEvent>(_type, &DKKeyboardEventJS::onKeyboardEvent, eventTargetAddress);
		return true;
	}
	
	static bool onKeyboardEvent(DKKeyboardEvent* event) {
		DKDEBUGFUNC(event);
		DKINFO("onKeyboardEvent("+event->type+") \n");
		
		// get the globally stored js callback function
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		DKString cb = event->target+"_"+event->type+"_callback";
		duk_get_global_string(DKDuktape::ctx, cb.c_str());
		
		// create and push the Event(eventAddress) object		
		DKString eventObjStr = "var eventObj = new KeyboardEvent('', '', '"+eventAddress+"'); eventObj;";  // returns eventObj
		DukValue eventObj = dukglue_peval<DukValue>(DKDuktape::ctx, eventObjStr.c_str());
		dukglue_push(DKDuktape::ctx, eventObj);	 //push event object
		
		// call callback function
		if(duk_pcall(DKDuktape::ctx, 1) != 0){ //1 = num or args
			DKDuktape::DumpError(eventAddress);
		}
	
		return true;
	}	
	
};
REGISTER_OBJECT(DKKeyboardEventJS, true)


#endif //DKKeyboardEventJS_H