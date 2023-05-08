// [IDL] https://w3c.github.io/uievents/#idl-keyboardevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
#pragma once
#ifndef TEST_KeyboardEvent_H
#define TEST_KeyboardEvent_H

#include "DK/DK.h"
#include "DKKeyboardEvent/DKKeyboardEvent.h"


class TEST_KeyboardEvent : public DKObjectT<TEST_KeyboardEvent>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("////// TEST_KeyboardEvent.h ////// \n");
		
		DKINFO("\n");
		DKEventTarget myEventTarget;
		myEventTarget.addEventListener("keyboardevent", &TEST_KeyboardEvent::onkeyboardevent);
		DKKeyboardEvent keyboardevent("keyboardevent", "");
		myEventTarget.dispatchEvent(keyboardevent);
		return true;
	}
	
	static void printKeyboardEventProperties(DKKeyboardEvent& keyboardevent){
		DKDEBUGFUNC(keyboardevent);
		////// Instance properties //////
		DKINFO("keyboardevent.altKey = "		+toString(keyboardevent.altKey)			+"\n");
		DKINFO("keyboardevent.code = "			+toString(keyboardevent.code)			+"\n");		
		DKINFO("keyboardevent.ctrlKey = "		+toString(keyboardevent.ctrlKey)		+"\n");
		DKINFO("keyboardevent.isComposing = "	+toString(keyboardevent.isComposing)	+"\n");
		DKINFO("keyboardevent.key = "			+toString(keyboardevent.key)			+"\n");
		//DKINFO("keyboardevent.locale = "		+toString(keyboardevent.locale)			+"\n");
		DKINFO("keyboardevent.location = "		+toString(keyboardevent.location)		+"\n");
		DKINFO("keyboardevent.metaKey = "		+toString(keyboardevent.metaKey)		+"\n");
		DKINFO("keyboardevent.repeat = "		+toString(keyboardevent.repeat)			+"\n");
		DKINFO("keyboardevent.shiftKey = "		+toString(keyboardevent.shiftKey)		+"\n");
		////// Obsolete properties //////
		//DKINFO("keyboardevent.char = "		+toString(keyboardevent._char)			+"\n");
		DKINFO("keyboardevent.charCode = "		+toString(keyboardevent.charCode)		+"\n");
		DKINFO("keyboardevent.keyCode = "		+toString(keyboardevent.keyCode)		+"\n");
		//DKINFO("keyboardevent.keyIdentifier = "+toString(keyboardevent.keyIdentifier)	+"\n");
		//DKINFO("keyboardevent.keyLocation = "	+toString(keyboardevent.keyLocation)	+"\n");
		DKINFO("keyboardevent.which = "			+toString(keyboardevent.which)			+"\n");
	}

	static bool onkeyboardevent(DKEvent& event){
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