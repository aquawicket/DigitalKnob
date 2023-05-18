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
		DKINFO("\n////// TEST_KeyboardEvent.h //////\n");
		
		DKEventTarget eventTarget;
		eventTarget.addEventListener("keyboardEvent", &TEST_KeyboardEvent::onKeyboardEvent);
		DKKeyboardEvent keyboardEvent("keyboardEvent", "");
		eventTarget.dispatchEvent(keyboardEvent);
		return true;
	}
	
	static void printKeyboardEventProperties(DKKeyboardEvent& keyboardEvent){
		DKDEBUGFUNC(keyboardEvent);
		
		// constructor(DOMString type, optional KeyboardEventInit eventInitDict = {});
		// function
		
		// KeyLocationCode
		// const unsigned long DOM_KEY_LOCATION_STANDARD = 0x00;
		DKINFO("keyboardEvent.DOM_KEY_LOCATION_STANDARD = "	+toString(keyboardEvent.DOM_KEY_LOCATION_STANDARD)	+"\n");
		
		// const unsigned long DOM_KEY_LOCATION_LEFT = 0x01;
		DKINFO("keyboardEvent.DOM_KEY_LOCATION_LEFT = "		+toString(keyboardEvent.DOM_KEY_LOCATION_LEFT)		+"\n");
		
		// const unsigned long DOM_KEY_LOCATION_RIGHT = 0x02;
		DKINFO("keyboardEvent.DOM_KEY_LOCATION_RIGHT = "	+toString(keyboardEvent.DOM_KEY_LOCATION_RIGHT)		+"\n");
		
		// const unsigned long DOM_KEY_LOCATION_NUMPAD = 0x03;
		DKINFO("keyboardEvent.DOM_KEY_LOCATION_NUMPAD = "	+toString(keyboardEvent.DOM_KEY_LOCATION_NUMPAD)	+"\n");
		
		// readonly attribute DOMString key;
		DKINFO("keyboardEvent.key = "						+toString(keyboardEvent.key)						+"\n");
		
		// readonly attribute DOMString code;
		DKINFO("keyboardEvent.code = "						+toString(keyboardEvent.code)						+"\n");	
		
		// readonly attribute unsigned long location;
		DKINFO("keyboardEvent.location = "					+toString(keyboardEvent.location)					+"\n");
		
		// readonly attribute boolean ctrlKey;
		DKINFO("keyboardEvent.ctrlKey = "					+toString(keyboardEvent.ctrlKey)					+"\n");
		
		// readonly attribute boolean shiftKey;
		DKINFO("keyboardEvent.shiftKey = "					+toString(keyboardEvent.shiftKey)					+"\n");
		
		// readonly attribute boolean altKey;
		DKINFO("keyboardEvent.altKey = "					+toString(keyboardEvent.altKey)						+"\n");
		
		// readonly attribute boolean metaKey;
		DKINFO("keyboardEvent.metaKey = "					+toString(keyboardEvent.metaKey)					+"\n");
		
		// readonly attribute boolean repeat;
		DKINFO("keyboardEvent.repeat = "					+toString(keyboardEvent.repeat)						+"\n");
		
		// readonly attribute boolean isComposing;
		DKINFO("keyboardEvent.isComposing = "				+toString(keyboardEvent.isComposing)				+"\n");
		
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
				DKINFO("keyboardEvent.charCode = "			+toString(keyboardEvent.charCode)					+"\n");
		//
		//		readonly attribute unsigned long keyCode;
				DKINFO("keyboardEvent.keyCode = "			+toString(keyboardEvent.keyCode)					+"\n");
		// };
	}

	static bool onKeyboardEvent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_KeyboardEvent::onkeyboardevent() \n");
		printKeyboardEventProperties(dynamic_cast<DKKeyboardEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		TEST_UIEvent::printUIEventProperties(dynamic_cast<DKUIEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		TEST_Event::printEventProperties(event);
		return true;
	}
};
REGISTER_OBJECT(TEST_KeyboardEvent, true);


#endif //TEST_KeyboardEvent_H