// [IDL] https://w3c.github.io/uievents/#idl-compositionevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent
#pragma once
#ifndef TEST_CompositionEvent_H
#define TEST_CompositionEvent_H

#include "DKCompositionEvent/DKCompositionEvent.h"


class TEST_CompositionEvent //: public DKObjectT<TEST_CompositionEvent>
{
public:
	TEST_CompositionEvent(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_CompositionEvent.h //////");
		
		DKEventTarget eventTarget;
		eventTarget.addEventListener("compositionEvent", &TEST_CompositionEvent::onCompositionEvent);
		DKCompositionEvent compositionEvent("compositionEvent", "");
		eventTarget.dispatchEvent(&compositionEvent);
	}
	
	static void printCompositionEventProperties(DKCompositionEvent* compositionEvent){
		DKDEBUGFUNC(compositionEvent);
		
		console.log("compositionEvent = "			+toString(compositionEvent));
		
		// constructor(DOMString type, optional CompositionEventInit eventInitDict = {});
		// function
		
		// readonly attribute DOMString data;
		console.log("compositionEvent->data() = "	+toString(compositionEvent->data()));
		
		// Source: UI Events (https://www.w3.org/TR/uievents/)
		// partial interface CompositionEvent {
		//		// Originally introduced (and deprecated) in this specification
		//		undefined initCompositionEvent(DOMString typeArg,
		//		optional boolean bubblesArg = false,
		//		optional boolean cancelableArg = false,
		//		optional WindowProxy? viewArg = null,
		//		optional DOMString dataArg = "");
				// function
		// };
		
		TEST_UIEvent::printUIEventProperties(compositionEvent);
	}
	
	static bool onCompositionEvent(DKEvent* event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_CompositionEvent::onCompositionEvent()");
		printCompositionEventProperties(dynamic_cast<DKCompositionEvent*>(event));			//TODO: try to remove the need for dynamic_cast
		return true;
	}
};
//REGISTER_OBJECT(TEST_CompositionEvent, true);


#endif //TEST_CompositionEvent_H