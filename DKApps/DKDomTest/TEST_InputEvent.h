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
		console.log("\n////// TEST_InputEvent.h //////");
	
		DKEventTarget inputEventTarget;
		inputEventTarget.addEventListener("inputEvent", &TEST_InputEvent::onInputEvent);
		DKInputEvent inputEvent("inputEvent", "");
		inputEventTarget.dispatchEvent(inputEvent);
		return true;
	}
	
	static void printInputEventProperties(DKInputEvent& inputEvent){
		DKDEBUGFUNC(inputEvent);
		
		// constructor(DOMString type, optional InputEventInit eventInitDict = {});
		// function
		
		// readonly attribute DOMString? data;
		console.log("inputEvent.data() = "			+toString(inputEvent.data()));
		
		//readonly attribute boolean isComposing;
		console.log("inputEvent.isComposing() = "	+toString(inputEvent.isComposing()));
		
		//readonly attribute DOMString inputType;
		console.log("inputEvent.inputType() = "		+toString(inputEvent.inputType()));
		
		// Source: Input Events Level 2 (https://www.w3.org/TR/input-events-2/)
		// partial interface InputEvent {
		//    	readonly attribute DataTransfer? dataTransfer;
				console.log("inputEvent.dataTransfer() = "	+toString(inputEvent.dataTransfer()));
		//		
		//    	sequence<StaticRange> getTargetRanges();
				// function
		// };
		
		
		TEST_UIEvent::printUIEventProperties(dynamic_cast<DKUIEvent&>(inputEvent));	//TODO: try to remove the need for dynamic_cast
	}
	
	static bool onInputEvent(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_InputEvent::onInputEvent()");
		printInputEventProperties(dynamic_cast<DKInputEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
};
REGISTER_OBJECT(TEST_InputEvent, true);


#endif //TEST_InputEvent_H