// [IDL] https://w3c.github.io/uievents/#idl-keyboardevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
#pragma once
#ifndef TEST_KeyboardEvent_H
#define TEST_KeyboardEvent_H

#include "DKKeyboardEvent/DKKeyboardEvent.h"


class TEST_KeyboardEvent : public DKObjectT<TEST_KeyboardEvent>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_KeyboardEvent.h //////");
		
		DKEventTarget keyboardEventTarget;
		keyboardEventTarget.addEventListener("keyboardEvent", &TEST_KeyboardEvent::onKeyboardEvent);
		DKKeyboardEvent keyboardEvent("keyboardEvent", "");
		keyboardEventTarget.dispatchEvent(keyboardEvent);
		return true;
	}
	
	static void printKeyboardEventProperties(DKKeyboardEvent& keyboardEvent){
		DKDEBUGFUNC(keyboardEvent);
		
		// constructor(DOMString type, optional KeyboardEventInit eventInitDict = {});
		// function
		
	#if !EMSCRIPTEN
		// KeyLocationCode
		// const unsigned long DOM_KEY_LOCATION_STANDARD = 0x00;
		console.log("keyboardEvent.DOM_KEY_LOCATION_STANDARD() = "	+toString(keyboardEvent.DOM_KEY_LOCATION_STANDARD()));
		
		// const unsigned long DOM_KEY_LOCATION_LEFT = 0x01;
		console.log("keyboardEvent.DOM_KEY_LOCATION_LEFT() = "		+toString(keyboardEvent.DOM_KEY_LOCATION_LEFT()));
		
		// const unsigned long DOM_KEY_LOCATION_RIGHT = 0x02;
		console.log("keyboardEvent.DOM_KEY_LOCATION_RIGHT() = "		+toString(keyboardEvent.DOM_KEY_LOCATION_RIGHT()));
		
		// const unsigned long DOM_KEY_LOCATION_NUMPAD = 0x03;
		console.log("keyboardEvent.DOM_KEY_LOCATION_NUMPAD() = "		+toString(keyboardEvent.DOM_KEY_LOCATION_NUMPAD()));
	#endif
		
		// readonly attribute DOMString key;
		console.log("keyboardEvent.key() = "							+toString(keyboardEvent.key()));
		
		// readonly attribute DOMString code;
		console.log("keyboardEvent.code() = "						+toString(keyboardEvent.code()));	
		
		// readonly attribute unsigned long location;
		console.log("keyboardEvent.location() = "					+toString(keyboardEvent.location()));
		
		// readonly attribute boolean ctrlKey;
		console.log("keyboardEvent.ctrlKey() = "						+toString(keyboardEvent.ctrlKey()));
		
		// readonly attribute boolean shiftKey;
		console.log("keyboardEvent.shiftKey() = "					+toString(keyboardEvent.shiftKey()));
		
		// readonly attribute boolean altKey;
		console.log("keyboardEvent.altKey() = "						+toString(keyboardEvent.altKey()));
		
		// readonly attribute boolean metaKey;
		console.log("keyboardEvent.metaKey() = "						+toString(keyboardEvent.metaKey()));
		
		// readonly attribute boolean repeat;
		console.log("keyboardEvent.repeat() = "						+toString(keyboardEvent.repeat()));
		
		// readonly attribute boolean isComposing;
		console.log("keyboardEvent.isComposing() = "					+toString(keyboardEvent.isComposing()));
		
		// boolean getModifierState(DOMString keyArg);
		// function
		
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
				// function
		// };
		
		// Source: UI Events (https://www.w3.org/TR/uievents/)
		// partial interface KeyboardEvent {
		//		// The following support legacy user agents
		//		readonly attribute unsigned long charCode;
				console.log("keyboardEvent.charCode() = "			+toString(keyboardEvent.charCode()));
		//
		//		readonly attribute unsigned long keyCode;
				console.log("keyboardEvent.keyCode() = "				+toString(keyboardEvent.keyCode()));
		// };
		
		
		TEST_UIEvent::printUIEventProperties(dynamic_cast<DKUIEvent&>(keyboardEvent));	//TODO: try to remove the need for dynamic_cast
	}

	static bool onKeyboardEvent(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_KeyboardEvent::onkeyboardevent()");
		printKeyboardEventProperties(dynamic_cast<DKKeyboardEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		return true;
	}
};
REGISTER_OBJECT(TEST_KeyboardEvent, true);


#endif //TEST_KeyboardEvent_H