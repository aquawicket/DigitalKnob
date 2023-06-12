// [IDL] https://w3c.github.io/uievents/#idl-focusevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent
#pragma once
#ifndef TEST_FocusEvent_H
#define TEST_FocusEvent_H

#include "DKFocusEvent/DKFocusEvent.h"


class TEST_FocusEvent : public DKObjectT<TEST_FocusEvent>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_FocusEvent.h //////");
		
		DKEventTarget eventTarget;
		eventTarget.addEventListener("focusEvent", &TEST_FocusEvent::onFocusEvent);
		DKFocusEvent focusEvent("focusEvent", "");
		eventTarget.dispatchEvent(focusEvent);
		return true;
	}
	
	static void printFocusEventProperties(DKFocusEvent& focusEvent){
		DKDEBUGFUNC(focusEvent);
		
		console.log("focusEvent = "						+toString(focusEvent));
		
		// constructor(DOMString type, optional FocusEventInit eventInitDict = {});
		// function
		
		// readonly attribute EventTarget? relatedTarget;
		console.log("focusEvent.relatedTarget() = "		+toString(focusEvent.relatedTarget()));
		
		TEST_UIEvent::printUIEventProperties(focusEvent);
	}
	
	static bool onFocusEvent(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_FocusEvent::onFocusEvent()");
		printFocusEventProperties(dynamic_cast<DKFocusEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
};
REGISTER_OBJECT(TEST_FocusEvent, true);


#endif //TEST_FocusEvent_H