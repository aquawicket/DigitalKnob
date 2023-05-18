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
		DKINFO("\n////// TEST_InputEvent.h //////\n");
	
		DKEventTarget eventTarget;
		eventTarget.addEventListener("inputEvent", &TEST_InputEvent::onInputEvent);
		DKInputEvent inputEvent("inputEvent", "");
		eventTarget.dispatchEvent(inputEvent);
		return true;
	}
	
	static void printInputEventProperties(DKInputEvent& inputEvent){
		DKDEBUGFUNC(inputEvent);
		
		// constructor(DOMString type, optional InputEventInit eventInitDict = {});
		// function
		
		// readonly attribute DOMString? data;
		DKINFO("inputEvent.data = "			+toString(inputEvent.data)			+"\n");
		
		//readonly attribute boolean isComposing;
		DKINFO("inputEvent.isComposing = "	+toString(inputEvent.isComposing)	+"\n");
		
		//readonly attribute DOMString inputType;
		DKINFO("inputEvent.inputType = "	+toString(inputEvent.inputType)		+"\n");
		
		// Source: Input Events Level 2 (https://www.w3.org/TR/input-events-2/)
		// partial interface InputEvent {
		//    	readonly attribute DataTransfer? dataTransfer;
				DKINFO("inputEvent.dataTransfer = "	+toString(inputEvent.dataTransfer)	+"\n");
		//		
		//    	sequence<StaticRange> getTargetRanges();
				// function
		// };
	}
	
	static bool onInputEvent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_InputEvent::onInputEvent() \n");
		printInputEventProperties(dynamic_cast<DKInputEvent&>(event));			//TODO: try to remove the need for dynamic_cast
		TEST_UIEvent::printUIEventProperties(dynamic_cast<DKUIEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		TEST_Event::printEventProperties(event);
		return true;
	}
};
REGISTER_OBJECT(TEST_InputEvent, true);


#endif //TEST_InputEvent_H