// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/KeyboardEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-keyboardevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
#pragma once
#ifndef DKKeyboardEvent_H
#define DKKeyboardEvent_H

#include "DKUIEvent/DKUIEvent.h"


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface KeyboardEvent : UIEvent {
class DKKeyboardEvent : public DKUIEvent
{
public:
	// constructor(DOMString type, optional KeyboardEventInit eventInitDict = {});
	DKKeyboardEvent(DKString _type, DKString _eventInitDict) : DKUIEvent(_type, _eventInitDict) { // [KeyboardEvent()] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/KeyboardEvent
		DKDEBUGFUNC(_type, _eventInitDict);
		//DKINFO("DKKeyboardEvent("+_type+", "+_eventInitDict+") \n");
		interfaceName = "KeyboardEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKKeyboardEvent("+interfaceAddress+") \n");
	}
	
	// KeyLocationCode
	// const unsigned long DOM_KEY_LOCATION_STANDARD = 0x00;
	
	// const unsigned long DOM_KEY_LOCATION_LEFT = 0x01;
	
	// const unsigned long DOM_KEY_LOCATION_RIGHT = 0x02;
	
	// const unsigned long DOM_KEY_LOCATION_NUMPAD = 0x03;
	
	// readonly attribute DOMString key;
	DKString key = ""; // [KeyboardEvent.key](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key
	
	// readonly attribute DOMString code;
	DKString code = ""; // [KeyboardEvent.code](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/code
	
	// readonly attribute unsigned long location;
	unsigned int location = 0; // [KeyboardEvent.location](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/location
	
	// readonly attribute boolean ctrlKey;
	bool ctrlKey = false; // [KeyboardEvent.ctrlKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/ctrlKey
	
	// readonly attribute boolean shiftKey;
	bool shiftKey = false; // [KeyboardEvent.shiftKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/shiftKey
	
	// readonly attribute boolean altKey;
	bool altKey = false; // [KeyboardEvent.altKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/altKey
	
	// readonly attribute boolean metaKey;
	bool metaKey = false; // [KeyboardEvent.metaKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/metaKey
  
	// readonly attribute boolean repeat;
	bool repeat = false; // [KeyboardEvent.repeat](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/repeat
	
	// readonly attribute boolean isComposing;
	bool isComposing = false; // [KeyboardEvent.isComposing](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/isComposing
	
	// boolean getModifierState(DOMString keyArg);
	void getModifierState() { // [KeyboardEvent.getModifierState()] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/getModifierState
		DKTODO();
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
			void initKeyboardEvent() { // [KeyboardEvent.initKeyboardEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/initKeyboardEvent
				DKDEPRECATED();
			}
	// };
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface KeyboardEvent {
	//		// The following support legacy user agents
	//		readonly attribute unsigned long charCode;
			unsigned int charCode = 0; // [KeyboardEvent.charCode](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/charCode
	//		readonly attribute unsigned long keyCode;
			unsigned int keyCode = 0; // [KeyboardEvent.keyCode](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyCode
	// };
};


#endif //DKKeyboardEvent_H