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
		DKINFO("keyboardEvent.altKey = "		+toString(keyboardEvent.altKey)			+"\n");
		DKINFO("keyboardEvent.code = "			+toString(keyboardEvent.code)			+"\n");		
		DKINFO("keyboardEvent.ctrlKey = "		+toString(keyboardEvent.ctrlKey)		+"\n");
		DKINFO("keyboardEvent.isComposing = "	+toString(keyboardEvent.isComposing)	+"\n");
		DKINFO("keyboardEvent.key = "			+toString(keyboardEvent.key)			+"\n");
		DKINFO("keyboardEvent.location = "		+toString(keyboardEvent.location)		+"\n");
		DKINFO("keyboardEvent.metaKey = "		+toString(keyboardEvent.metaKey)		+"\n");
		DKINFO("keyboardEvent.repeat = "		+toString(keyboardEvent.repeat)			+"\n");
		DKINFO("keyboardEvent.shiftKey = "		+toString(keyboardEvent.shiftKey)		+"\n");
		DKINFO("keyboardEvent.charCode = "		+toString(keyboardEvent.charCode)		+"\n");
		DKINFO("keyboardEvent.keyCode = "		+toString(keyboardEvent.keyCode)		+"\n");
		DKINFO("keyboardEvent.which = "			+toString(keyboardEvent.which)			+"\n");
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