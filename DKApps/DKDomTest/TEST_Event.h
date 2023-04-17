#pragma once
#ifndef TEST_Event_H
#define TEST_Event_H

#include "DK/DK.h"
#include "DKEvent/DKEvent.h"


class TEST_Event : public DKObjectT<TEST_Event>
{
public:
	bool Init(){
		////// Event //////
		DKINFO("\n");
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
	
	bool End(){
		return DKTODO();
	}

	// https://dom.spec.whatwg.org
	////// Event //////
	static void printEventProperties(DKEvent& event){
		DKDEBUGFUNC(event);
	
		////// Instance properties //////
		DKINFO("event.bubbles = "				+toString(event.bubbles)			+"\n");
		DKINFO("event.cancelable = "			+toString(event.cancelable)			+"\n");
		DKINFO("event.composed = "				+toString(event.composed)			+"\n");
		DKINFO("event.currentTarget = "			+toString(event.currentTarget)		+"\n");
		DKINFO("event.defaultPrevented = "		+toString(event.defaultPrevented)	+"\n");
		DKINFO("event.eventPhase = "			+toString(event.eventPhase)			+"\n");
		DKINFO("event.isTrusted = "				+toString(event.isTrusted)			+"\n");
		DKINFO("event.target = "				+toString(event.target)				+"\n");
		DKINFO("event.timeStamp = "				+toString(event.timeStamp)			+"\n");
		DKINFO("event.type = "					+toString(event.type)				+"\n");
		
		////// Legacy and non-standard properties //////
		DKINFO("event.cancelBubble = "			+toString(event.cancelBubble)			+"\n");
		DKINFO("event.explicitOriginalTarget = "+toString(event.explicitOriginalTarget)	+"\n");
		DKINFO("event.originalTarget = "		+toString(event.originalTarget)			+"\n");
		DKINFO("event.returnValue = "			+toString(event.returnValue)			+"\n");
		DKINFO("event.scoped = "				+toString(event.scoped)					+"\n");
	}
	static bool onevent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("cpp->onevent() \n");
		printEventProperties(event);
		return true;
	}

};
REGISTER_OBJECT(TEST_Event, false);


#endif //TEST_Event_H