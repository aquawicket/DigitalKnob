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
		DKINFO("compositionEvent.data = "		+toString(compositionEvent.data)	+"\n");
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