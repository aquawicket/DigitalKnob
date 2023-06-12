// [IDL] https://dom.spec.whatwg.org/#interface-customevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent
#ifndef TEST_CustomEvent_H
#define TEST_CustomEvent_H

#include "DKCustomEvent/DKCustomEvent.h"
#include "TEST_Event.h"


class TEST_CustomEvent //: public DKObjectT<TEST_CustomEvent>
{
public:
	TEST_CustomEvent(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_CustomEvent.h //////");
		
		DKEventTarget eventTarget;
		eventTarget.addEventListener("customEvent", &TEST_CustomEvent::onCustomEvent);
		DKCustomEvent* customEvent = new DKCustomEvent("customEvent", "");
		customEvent->detail("{name : 'myCustomEvent'}");
		eventTarget.dispatchEvent(customEvent);
	}

	static void printCustomEventProperties(DKCustomEvent* customEvent) {
		DKDEBUGFUNC(customEvent);
		
		// constructor(DOMString type, optional CustomEventInit eventInitDict = {});
		// function
		
		// readonly attribute any detail;
		console.log("customEvent->detail() = "	+toString(customEvent->detail()));
		
		// undefined initCustomEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false, optional any detail = null); // legacy
		// function
		
		TEST_Event::printEventProperties(dynamic_cast<DKEvent*>(customEvent));	//TODO: try to remove the need for dynamic_cast
	}
	
	static bool onCustomEvent(DKEvent* event) {
		DKDEBUGFUNC(event);
		console.log("\nTEST_CustomEvent::onCustomEvent()");
		printCustomEventProperties(dynamic_cast<DKCustomEvent*>(event));		//TODO: try to remove the need for dynamic_cast
		return true;
	}

};
//REGISTER_OBJECT(TEST_CustomEvent, true);


#endif //TEST_CustomEvent_H