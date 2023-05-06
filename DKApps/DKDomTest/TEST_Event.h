// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/Event.idl
// [SOURCE] https://dom.spec.whatwg.org/#interface-event
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Event
#pragma once
#ifndef TEST_Event_H
#define TEST_Event_H

#include "DK/DK.h"
#include "DKEvent/DKEvent.h"


class TEST_Event : public DKObjectT<TEST_Event>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("////// TEST_Event.h ////// \n");
		
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

	static void printEventProperties(DKEvent& event){
		DKDEBUGFUNC(event);
		////// Instance properties //////
		DKINFO("event.bubbles = "				+toString(event.bubbles)				+"\n");	// [Event.bubbles](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/bubbles
		DKINFO("event.cancelable = "			+toString(event.cancelable)				+"\n");	// [Event.cancelable](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelable
		DKINFO("event.composed = "				+toString(event.composed)				+"\n");	// [Event.composed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/composed
		DKINFO("event.currentTarget = "			+toString(event.currentTarget)			+"\n");	// [Event.currentTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/currentTarget
		DKINFO("event.defaultPrevented = "		+toString(event.defaultPrevented)		+"\n");	// [Event.defaultPrevented](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/defaultPrevented
		DKINFO("event.eventPhase = "			+toString(event.eventPhase)				+"\n");	// [Event.eventPhase](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/eventPhase
		DKINFO("event.isTrusted = "				+toString(event.isTrusted)				+"\n");	// [Event.isTrusted](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/isTrusted
		DKINFO("event.target = "				+toString(event.target)					+"\n");	// [Event.target](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/target
		DKINFO("event.timeStamp = "				+toString(event.timeStamp)				+"\n");	// [Event.timeStamp](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/timeStamp
		DKINFO("event.type = "					+toString(event.type)					+"\n");	// [Event.type](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/type
		////// Legacy and non-standard properties //////
		DKINFO("event.cancelBubble = "			+toString(event.cancelBubble)			+"\n");	// [Event.cancelBubble](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelBubble
		//DKINFO("event.explicitOriginalTarget = "+toString(event.explicitOriginalTarget)	+"\n");	// [Event.explicitOriginalTarget](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/explicitOriginalTarget
		//DKINFO("event.originalTarget = "		+toString(event.originalTarget)			+"\n");	// [Event.originalTarget](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/originalTarget
		DKINFO("event.returnValue = "			+toString(event.returnValue)			+"\n");	// [Event.returnValue](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/returnValue
		//DKINFO("event.scoped = "				+toString(event.scoped)					+"\n");	// [Event.scoped](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/scoped
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