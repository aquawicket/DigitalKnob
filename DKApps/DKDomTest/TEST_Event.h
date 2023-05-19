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
		DKINFO("\n////// TEST_Event.h //////\n");
		
		DKEventTarget myTargetA;									// EventTarget as 	value
		DKEvent eventA("eventA", "");								// Event as 		value
		myTargetA.addEventListener("eventA", &TEST_Event::onevent);
		myTargetA.dispatchEvent(eventA);
		
		DKINFO("\n");
		DKEventTarget* myTargetB = new DKEventTarget();  			// EventTarget as 	pointer
		DKEvent eventB("eventB", "");								// Event as 		value
		myTargetB->addEventListener("eventB", &TEST_Event::onevent);
		myTargetB->dispatchEvent(eventB);
		
		DKINFO("\n");
		DKEventTarget myTargetC;									// EventTarget as 	value
		DKEvent* eventC = new DKEvent("eventC", "");				// Event as 		pointer
		myTargetC.addEventListener("eventC", &TEST_Event::onevent);
		myTargetC.dispatchEvent(eventC);
		
		DKINFO("\n");
		DKEventTarget* myTargetD = new DKEventTarget();				// EventTarget as 	pointer
		DKEvent* eventD = new DKEvent("eventD", "");				// Event as 		pointer
		myTargetD->addEventListener("eventD", &TEST_Event::onevent);
		myTargetD->dispatchEvent(eventD);
		
		DKINFO("\n");
		DKEventTarget myTargetE;
		myTargetE.addEventListener("eventE", &TEST_Event::onevent);
		myTargetE.dispatchEvent(new DKEvent("eventE", ""));			// Event as new pointer, created within dispatchEvent function
		return true;
	}

	static void printEventProperties(DKEvent& event){
		DKDEBUGFUNC(event);
		
		// readonly attribute DOMString type;
		DKINFO("event.type() = "			+toString(event.type())				+"\n");
		
		// readonly attribute EventTarget? target;
		DKINFO("event.target() = "			+toString(event.target())			+"\n");
		
		// readonly attribute EventTarget? srcElement; // legacy
		DKINFO("event.srcElement() = "		+toString(event.srcElement())		+"\n");
		
		// readonly attribute EventTarget? currentTarget;
		DKINFO("event.currentTarget() = "	+toString(event.currentTarget())	+"\n");
		
		// sequence<EventTarget> composedPath();
		// function
		
		// const unsigned short NONE = 0;
		DKINFO("event.NONE() = "			+toString(event.NONE())				+"\n");
		
		// const unsigned short CAPTURING_PHASE = 1;
		DKINFO("event.CAPTURING_PHASE() = "	+toString(event.CAPTURING_PHASE())	+"\n");
		
		// const unsigned short AT_TARGET = 2;
		DKINFO("event.AT_TARGET() = "		+toString(event.AT_TARGET())		+"\n");
		
		// const unsigned short BUBBLING_PHASE = 3;
		DKINFO("event.BUBBLING_PHASE() = "	+toString(event.BUBBLING_PHASE())	+"\n");
		
		// readonly attribute unsigned short eventPhase;
		DKINFO("event.eventPhase() = "		+toString(event.eventPhase())		+"\n");
		
		// undefined stopPropagation();
		// function 
		
		// attribute boolean cancelBubble; // legacy alias of .stopPropagation()
		DKINFO("event.cancelBubble() = "	+toString(event.cancelBubble())		+"\n");
		
		// undefined stopImmediatePropagation();
		// function
		
		// readonly attribute boolean bubbles;
		DKINFO("event.bubbles() = "			+toString(event.bubbles())			+"\n");
		
		// readonly attribute boolean cancelable;
		DKINFO("event.cancelable() = "		+toString(event.cancelable())		+"\n");
		
		// attribute boolean returnValue;  // legacy
		DKINFO("event.returnValue() = "		+toString(event.returnValue())		+"\n");
		
		// undefined preventDefault();
		// function
		
		// readonly attribute boolean defaultPrevented;
		DKINFO("event.defaultPrevented() = "+toString(event.defaultPrevented())	+"\n");
		
		// readonly attribute boolean composed;
		DKINFO("event.composed() = "			+toString(event.composed())		+"\n");
		
		// [LegacyUnforgeable] readonly attribute boolean isTrusted;
		DKINFO("event.isTrusted() = "			+toString(event.isTrusted())	+"\n");
		
		// readonly attribute DOMHighResTimeStamp timeStamp;
		DKINFO("event.timeStamp() = "			+toString(event.timeStamp())	+"\n");
		
		// undefined initEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false); // legacy
		// function 
	}
	
	static bool onevent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_Event::onevent() \n");
		printEventProperties(event);
		return true;
	}

};
REGISTER_OBJECT(TEST_Event, true);


#endif //TEST_Event_H