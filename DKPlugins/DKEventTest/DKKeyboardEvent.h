#pragma once
#ifndef DKKeyboardEvent_H
#define DKKeyboardEvent_H

#include "DKEventTest/DKUIEvent.h"


// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
class DKKeyboardEvent : public DKUIEvent
{
public:
	////// Constructor //////
	// [KeyboardEvent()] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/KeyboardEvent
	DKKeyboardEvent(DKString _type, DKString _options) : DKUIEvent(_type, _options) {
		altKey = false;
		code = "TODO";
		ctrlKey = false;
		isComposing = false;
		key = "TODO";
		locale = "TODO";
		location = 0;
		metaKey = false;
		repeat = false;
		shiftKey = false;
		
		//DKEventTarget::LinkAddEventListenerFunc("keydown", &DKKeyboardEvent::addEventListener, this);
	}
	
	
	////// Constants //////
	// [DOM_KEY_LOCATION_STANDARD]	0x00
	// [DOM_KEY_LOCATION_LEFT]		0x01
	// [DOM_KEY_LOCATION_RIGHT]		0x02
	// [DOM_KEY_LOCATION_NUMPAD]	0x03
	
	
	////// Instance properties //////
	// [KeyboardEvent.altKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/altKey
	bool altKey;
	// [KeyboardEvent.code](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/code
	DKString code;
	// [KeyboardEvent.ctrlKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/ctrlKey
	bool ctrlKey;
	// [KeyboardEvent.isComposing](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/isComposing
	bool isComposing;
	// [KeyboardEvent.key](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key
	DKString key;
	// [KeyboardEvent.locale](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/locale
	DKString locale;
	// [KeyboardEvent.location](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/location
	unsigned int location;
	// [KeyboardEvent.metaKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/metaKey
	bool metaKey;
	// [KeyboardEvent.repeat](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/repeat
	bool repeat;
	// [KeyboardEvent.shiftKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/shiftKey
	bool shiftKey;
	
	
	////// Instance methods //////
	// [KeyboardEvent.getModifierState()] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/getModifierState
	
	
	////// Obsolete methods //////
	// [KeyboardEvent.initKeyEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/initKeyEvent
	// [KeyboardEvent.initKeyboardEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/initKeyboardEvent
	
	
	////// Obsolete properties //////
	// [KeyboardEvent.char](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/char
	// [KeyboardEvent.charCode](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/charCode
	// [KeyboardEvent.keyCode](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyCode
	// [KeyboardEvent.keyIdentifier](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyIdentifier
	// [KeyboardEvent.keyLocation](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyLocation
	// [KeyboardEvent.which](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/which
	
	
	////// Events //////
	// [keydown] https://developer.mozilla.org/en-US/docs/Web/API/Element/keydown_event
	// [keyup] https://developer.mozilla.org/en-US/docs/Web/API/Element/keyup_event
	
	
	////// Obsolete events //////
	// [keypress](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/keypress_event
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/*
	bool addEventListener(const DKString& type, const DKString& eventTargetAddress){
		DKEventTarget::addEventListener<DKKeyboardEvent>(type, &DKKeyboardEvent::onKeyboardEvent, eventTargetAddress);
		return DKTODO();
	}
	
	static bool onKeyboardEvent(DKKeyboardEvent* event) {
		DKDEBUGFUNC(event);
		DKINFO("onKeyboardEvent("+event->type+") \n");
		return DKTODO();
	}
	*/
};


#endif //DKKeyboardEvent_H