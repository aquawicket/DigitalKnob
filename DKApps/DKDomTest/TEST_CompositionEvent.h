// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/CompositionEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-compositionevents
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
		
		DKINFO("\n");
		DKEventTarget myEventTarget;
		myEventTarget.addEventListener("compositionevent", &TEST_CompositionEvent::oncompositionevent);
		DKCompositionEvent compositionevent("compositionevent", "");
		myEventTarget.dispatchEvent(compositionevent);
		return true;
	}
	
	static void printCompositionEventProperties(DKCompositionEvent& compositionevent){
		DKDEBUGFUNC(compositionevent);
		////// Instance properties //////
		DKINFO("compositionevent.data = "		+toString(compositionevent.data)	+"\n");
		//DKINFO("compositionevent.locale = "	+toString(compositionevent.locale)	+"\n");
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