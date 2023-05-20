// [IDL] https://w3c.github.io/uievents/#idl-compositionevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent
#pragma once
#ifndef TEST_CompositionEvent_H
#define TEST_CompositionEvent_H

#include "DKCompositionEvent/DKCompositionEvent.h"
#include "TEST_UIEvent.h"
#include "TEST_Event.h"


class TEST_CompositionEvent : public DKObjectT<TEST_CompositionEvent>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_CompositionEvent.h //////\n");
		
		DKEventTarget eventTarget;
		eventTarget.addEventListener("compositionEvent", &TEST_CompositionEvent::onCompositionEvent);
		DKCompositionEvent compositionEvent("compositionEvent", "");
		eventTarget.dispatchEvent(compositionEvent);
		return true;
	}
	
	static void printCompositionEventProperties(DKCompositionEvent& compositionEvent){
		DKDEBUGFUNC(compositionEvent);
		
		// constructor(DOMString type, optional CompositionEventInit eventInitDict = {});
		// function
		
		// readonly attribute DOMString data;
		DKINFO("compositionEvent.data() = "		+toString(compositionEvent.data())	+"\n");
		
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
	}
	
	static bool onCompositionEvent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_CompositionEvent::onCompositionEvent() \n");
		printCompositionEventProperties(dynamic_cast<DKCompositionEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		TEST_UIEvent::printUIEventProperties(dynamic_cast<DKUIEvent&>(event));		//TODO: try to remove the need for dynamic_cast
		TEST_Event::printEventProperties(event);
		return true;
	}
};
REGISTER_OBJECT(TEST_CompositionEvent, true);


#endif //TEST_CompositionEvent_H