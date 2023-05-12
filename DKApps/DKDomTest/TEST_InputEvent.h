// [IDL] https://w3c.github.io/uievents/#idl-inputevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent
#pragma once
#ifndef TEST_InputEvent_H
#define TEST_InputEvent_H

#include "DKInputEvent/DKInputEvent.h"


class TEST_InputEvent : public DKObjectT<TEST_InputEvent>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("////// TEST_InputEvent.h ////// \n");
	
		DKINFO("\n");
		DKEventTarget myEventTarget;
		myEventTarget.addEventListener("inputevent", &TEST_InputEvent::oninputevent);
		DKInputEvent inputevent("inputevent", "");
		myEventTarget.dispatchEvent(inputevent);
		return true;
	}
	
	static void printInputEventProperties(DKInputEvent& inputevent){
		DKDEBUGFUNC(inputevent);
		////// Instance properties //////
		DKINFO("inputevent.data = "			+toString(inputevent.data)			+"\n");
		DKINFO("inputevent.dataTransfer = "	+toString(inputevent.dataTransfer)	+"\n");
		DKINFO("inputevent.inputType = "	+toString(inputevent.inputType)		+"\n");
		DKINFO("inputevent.isComposing = "	+toString(inputevent.isComposing)	+"\n");
	}
	
	static bool oninputevent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_InputEvent::oninputevent() \n");
		printInputEventProperties(dynamic_cast<DKInputEvent&>(event));			//TODO: try to remove the need for dynamic_cast
		TEST_UIEvent::printUIEventProperties(dynamic_cast<DKUIEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		TEST_Event::printEventProperties(event);
		return true;
	}
};
REGISTER_OBJECT(TEST_InputEvent, true);


#endif //TEST_InputEvent_H