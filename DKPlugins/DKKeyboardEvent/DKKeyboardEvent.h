// [IDL] https://w3c.github.io/uievents/#events-keyboardevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
#pragma once
#ifndef DKKeyboardEvent_H
#define DKKeyboardEvent_H

#include "DKUIEvent/DKUIEvent.h"


class DKKeyboardEvent : public DKUIEvent
{
public:
	////// Constructor //////
	// [KeyboardEvent()] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/KeyboardEvent
	DKKeyboardEvent(DKString _type, DKString _options) : DKUIEvent(_type, _options) {
		DKINFO("DKKeyboardEvent("+_type+", "+_options+") \n");
		
		eventClass = "KeyboardEvent";
		eventAddress = pointerToAddress(this);
	}
	
	
	////// Constants //////
	////// Keyboard locations //////
	// [DOM_KEY_LOCATION_STANDARD]	0x00 https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent#keyboard_locations
	// [DOM_KEY_LOCATION_LEFT]		0x01 https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent#keyboard_locations
	// [DOM_KEY_LOCATION_RIGHT]		0x02 https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent#keyboard_locations
	// [DOM_KEY_LOCATION_NUMPAD]	0x03 https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent#keyboard_locations
	
	
	////// Instance properties //////
	// [KeyboardEvent.altKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/altKey
	bool altKey = false;
	// [KeyboardEvent.code](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/code
	DKString code = "";
	// [KeyboardEvent.ctrlKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/ctrlKey
	bool ctrlKey = false;
	// [KeyboardEvent.isComposing](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/isComposing
	bool isComposing = false;
	// [KeyboardEvent.key](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key
	DKString key = "";
	// [KeyboardEvent.locale](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/locale
	DKString locale = "";
	// [KeyboardEvent.location](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/location
	unsigned int location = 0;
	// [KeyboardEvent.metaKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/metaKey
	bool metaKey = false;
	// [KeyboardEvent.repeat](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/repeat
	bool repeat = false;
	// [KeyboardEvent.shiftKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/shiftKey
	bool shiftKey = false;
	
	
	////// Instance methods //////
	// [KeyboardEvent.getModifierState()] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/getModifierState
	void getModifierState() {
		DKTODO();
	}
	
	
	////// Obsolete methods //////
	// [KeyboardEvent.initKeyEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/initKeyEvent
	void initKeyEvent() {
		DKDEPRECATED();
	}
	// [KeyboardEvent.initKeyboardEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/initKeyboardEvent
	void initKeyboardEvent() {
		DKDEPRECATED();
	}
	
	
	////// Obsolete properties //////
	// [KeyboardEvent.char](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/char
	DKString _char = "";
	// [KeyboardEvent.charCode](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/charCode
	unsigned int charCode = 0;
	// [KeyboardEvent.keyCode](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyCode
	unsigned int keyCode = 0;
	// [KeyboardEvent.keyIdentifier](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyIdentifier
	DKString keyIdentifier = "";
	// [KeyboardEvent.keyLocation](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyLocation
	unsigned int keyLocation = 0;
	// [KeyboardEvent.which](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/which
	unsigned int which = 0;
	
	
	////// Events //////
	// [keydown] https://developer.mozilla.org/en-US/docs/Web/API/Element/keydown_event
	// [keyup] https://developer.mozilla.org/en-US/docs/Web/API/Element/keyup_event
	
	
	////// Obsolete events //////
	// [keypress](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/keypress_event
};


#endif //DKKeyboardEvent_H