// [IDL] https://dom.spec.whatwg.org/#interface-customevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent
#ifndef TEST_CustomEvent_H
#define TEST_CustomEvent_H

#include "DKCustomEvent/DKCustomEvent.h"
#include "TEST_Event.h"


class TEST_CustomEvent : public DKObjectT<TEST_CustomEvent>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_CustomEvent.h ////// \n");
		
		DKEventTarget eventTarget;
		eventTarget.addEventListener("customEvent", &TEST_CustomEvent::onCustomEvent);
		DKCustomEvent customEvent("customEvent", "");
		customEvent.detail("{name : 'myCustomEvent'}");
		eventTarget.dispatchEvent(customEvent);
		return true;
	}

	static void printCustomEventProperties(DKCustomEvent& customEvent) {
		DKDEBUGFUNC(customEvent);
		
		// constructor(DOMString type, optional CustomEventInit eventInitDict = {});
		// function
		
		// readonly attribute any detail;
		DKINFO("customEvent.detail() = "	+toString(customEvent.detail())	+"\n");
		
		// undefined initCustomEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false, optional any detail = null); // legacy
		// function
	}
	
	static bool onCustomEvent(DKEvent& event) {
		DKDEBUGFUNC(event);
		DKINFO("TEST_CustomEvent::onCustomEvent() \n");
		printCustomEventProperties(dynamic_cast<DKCustomEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		TEST_Event::printEventProperties(event);
		return true;
	}

};
REGISTER_OBJECT(TEST_CustomEvent, true);


#endif //TEST_CustomEvent_H