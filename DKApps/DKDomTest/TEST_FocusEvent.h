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
		DKINFO("\n////// TEST_FocusEvent.h //////\n");
		
		DKEventTarget myEventTarget;
		myEventTarget.addEventListener("focusevent", &TEST_FocusEvent::onfocusevent);
		DKFocusEvent focusevent("focusevent", "");
		myEventTarget.dispatchEvent(focusevent);
		return true;
	}
	
	static void printFocusEventProperties(DKFocusEvent& focusevent){
		DKDEBUGFUNC(focusevent);
		////// Instance properties //////
		DKINFO("focusevent.relatedTarget = "+toString(focusevent.relatedTarget)	+"\n");
	}
	
	static bool onfocusevent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_FocusEvent::onfocusevent() \n");
		printFocusEventProperties(dynamic_cast<DKFocusEvent&>(event));			//TODO: try to remove the need for dynamic_cast
		TEST_UIEvent::printUIEventProperties(dynamic_cast<DKUIEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		TEST_Event::printEventProperties(event);
		return true;
	}
};
REGISTER_OBJECT(TEST_FocusEvent, true);


#endif //TEST_FocusEvent_H