#include "DK/stdafx.h"

#include "App.h"
#include "TEST_Event.h"

bool App::Init() {
	DKDEBUGFUNC();
	DKINFO("App::Init() \n");
	
	DKClass::DKCreate("TEST_Event");
	DKClass::DKCreate("TEST_CustomEvent");
	/*
	////// Event //////
	DKINFO("\n");
	DKEventTarget myTargetA;									// EventTarget as 	value
	DKEvent eventA("eventA", "");								// Event as 		value
	myTargetA.addEventListener("eventA", &App::onevent);
	myTargetA.dispatchEvent(eventA);
	
	DKINFO("\n");
	DKEventTarget* myTargetB = new DKEventTarget();  			// EventTarget as 	pointer
	DKEvent eventB("eventB", "");								// Event as 		value
	myTargetB->addEventListener("eventB", &App::onevent);
	myTargetB->dispatchEvent(eventB);
	
	DKINFO("\n");
	DKEventTarget myTargetC;									// EventTarget as 	value
	DKEvent* eventC = new DKEvent("eventC", "");				// Event as 		pointer
	myTargetC.addEventListener("eventC", &App::onevent);
	myTargetC.dispatchEvent(eventC);
	
	DKINFO("\n");
	DKEventTarget* myTargetD = new DKEventTarget();				// EventTarget as 	pointer
	DKEvent* eventD = new DKEvent("eventD", "");				// Event as 		pointer
	myTargetD->addEventListener("eventD", &App::onevent);
	myTargetD->dispatchEvent(eventD);
	
	DKINFO("\n");
	DKEventTarget myTargetE;
	myTargetE.addEventListener("eventE", &App::onevent);
	myTargetE.dispatchEvent(new DKEvent("eventE", ""));			// Event as new pointer, created within dispatchEvent function
	

	////// CustomEvent //////
	DKINFO("\n");
	myTargetA.addEventListener("customevent", &App::oncustom);
	DKCustomEvent customevent("customevent", "");
	customevent.detail = "{name : 'mycustomevent'}";
	myTargetA.dispatchEvent(customevent);
	*/
	
	return true;
}

bool App::End(){
	DKDEBUGFUNC();
	DKINFO("App::End() \n");
	return true;
}


////// Event //////
/*
void App::printEventProperties(DKEvent& event) {
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
bool App::onevent(DKEvent& event) {
	DKDEBUGFUNC(event);
	DKINFO("cpp->onevent() \n");
	printEventProperties(event);
	return true;
}
*/

/*
////// CustomEvent //////
void App::printCustomEventProperties(DKCustomEvent& customevent) {
	////// Instance properties //////
	DKINFO("customevent.detail = "	+toString(customevent.detail)	+"\n");
}
bool App::oncustom(DKEvent& event) {
	DKDEBUGFUNC(event);
	DKINFO("cpp->oncustom() \n");
	printEventProperties(event);
	printCustomEventProperties(dynamic_cast<DKCustomEvent&>(event));	//FIXME: try to remove the need for dynamic_cast
	return true;
}
*/
