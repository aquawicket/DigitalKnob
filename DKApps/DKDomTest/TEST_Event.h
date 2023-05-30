// [IDL] https://dom.spec.whatwg.org/#interface-event
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Event
#pragma once
#ifndef TEST_Event_H
#define TEST_Event_H

#include "DKEvent/DKEvent.h"


class TEST_Event : public DKObjectT<TEST_Event>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_Event.h //////");
		
		DKEventTarget myTargetA;									// EventTarget as 	value
		DKEvent eventA("eventA", "");								// Event as 		value
		myTargetA.addEventListener("eventA", &TEST_Event::onevent);
		myTargetA.dispatchEvent(eventA);
		
		DKEventTarget* myTargetB = new DKEventTarget();  			// EventTarget as 	pointer
		DKEvent eventB("eventB", "");								// Event as 		value
		myTargetB->addEventListener("eventB", &TEST_Event::onevent);
		myTargetB->dispatchEvent(eventB);
		
		DKEventTarget myTargetC;									// EventTarget as 	value
		DKEvent* eventC = new DKEvent("eventC", "");				// Event as 		pointer
		myTargetC.addEventListener("eventC", &TEST_Event::onevent);
		myTargetC.dispatchEvent(eventC);
		
		DKEventTarget* myTargetD = new DKEventTarget();				// EventTarget as 	pointer
		DKEvent* eventD = new DKEvent("eventD", "");				// Event as 		pointer
		myTargetD->addEventListener("eventD", &TEST_Event::onevent);
		myTargetD->dispatchEvent(eventD);
		
		DKEventTarget myTargetE;
		myTargetE.addEventListener("eventE", &TEST_Event::onevent);
		myTargetE.dispatchEvent(new DKEvent("eventE", ""));			// Event as new pointer, created within dispatchEvent function
		return true;
	}

	static void printEventProperties(DKEvent& event){
		DKDEBUGFUNC(event);
		
		// readonly attribute DOMString type;
		console.log("event.type() = "			+toString(event.type()));
		
		// readonly attribute EventTarget? target;
		console.log("event.target() = "			+toString(event.target()));
		
		// readonly attribute EventTarget? srcElement; // legacy
		console.log("event.srcElement() = "		+toString(event.srcElement()));
		
		// readonly attribute EventTarget? currentTarget;
		console.log("event.currentTarget() = "	+toString(event.currentTarget()));
		
		// sequence<EventTarget> composedPath();
		// function
		
		// const unsigned short NONE = 0;
		console.log("event.NONE() = "			+toString(event.NONE()));
		
		// const unsigned short CAPTURING_PHASE = 1;
		console.log("event.CAPTURING_PHASE() = "	+toString(event.CAPTURING_PHASE()));
		
		// const unsigned short AT_TARGET = 2;
		console.log("event.AT_TARGET() = "		+toString(event.AT_TARGET()));
		
		// const unsigned short BUBBLING_PHASE = 3;
		console.log("event.BUBBLING_PHASE() = "	+toString(event.BUBBLING_PHASE()));
		
		// readonly attribute unsigned short eventPhase;
		console.log("event.eventPhase() = "		+toString(event.eventPhase()));
		
		// undefined stopPropagation();
		// function 
		
		// attribute boolean cancelBubble; // legacy alias of .stopPropagation()
		console.log("event.cancelBubble() = "	+toString(event.cancelBubble()));
		
		// undefined stopImmediatePropagation();
		// function
		
		// readonly attribute boolean bubbles;
		console.log("event.bubbles() = "			+toString(event.bubbles()));
		
		// readonly attribute boolean cancelable;
		console.log("event.cancelable() = "		+toString(event.cancelable()));
		
		// attribute boolean returnValue;  // legacy
		console.log("event.returnValue() = "		+toString(event.returnValue()));
		
		// undefined preventDefault();
		// function
		
		// readonly attribute boolean defaultPrevented;
		console.log("event.defaultPrevented() = "+toString(event.defaultPrevented()));
		
		// readonly attribute boolean composed;
		console.log("event.composed() = "			+toString(event.composed()));
		
		// [LegacyUnforgeable] readonly attribute boolean isTrusted;
		console.log("event.isTrusted() = "			+toString(event.isTrusted()));
		
		// readonly attribute DOMHighResTimeStamp timeStamp;
		console.log("event.timeStamp() = "			+toString(event.timeStamp()));
		
		// undefined initEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false); // legacy
		// function 
	}
	
	static bool onevent(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_Event::onevent()");
		printEventProperties(event);
		return true;
	}

};
REGISTER_OBJECT(TEST_Event, true);


#endif //TEST_Event_H