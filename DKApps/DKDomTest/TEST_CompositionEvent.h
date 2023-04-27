// [IDL] https://w3c.github.io/uievents/#events-compositionevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent
#pragma once
#ifndef TEST_CompositionEvent_H
#define TEST_CompositionEvent_H

#include "DK/DK.h"
#include "DKCompositionEvent/DKCompositionEvent.h"
#include "TEST_UIEvent.h"
#include "TEST_Event.h"


class TEST_CompositionEvent : public DKObjectT<TEST_CompositionEvent>
{
public:
	bool Init(){
		DKINFO("////// TEST_CompositionEvent.h ////// \n");
		return DKTODO();
	}
	
	static void printCompositionEventProperties(DKCompositionEvent& compositionevent){
		DKDEBUGFUNC(compositionevent);
		DKTODO();
	}
	
	static bool oncompositionevent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_CompositionEvent::oncompositionevent() \n");
		printCompositionEventProperties(dynamic_cast<DKCompositionEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		TEST_UIEvent::printUIEventProperties(dynamic_cast<DKUIEvent&>(event));		//TODO: try to remove the need for dynamic_cast
		TEST_Event::printEventProperties(event);
		return true;
	}
};
REGISTER_OBJECT(TEST_CompositionEvent, true);


#endif //TEST_CompositionEvent_H