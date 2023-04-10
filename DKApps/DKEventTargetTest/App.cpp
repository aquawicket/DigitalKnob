#include "DK/stdafx.h"

#include "App.h"

bool App::Init() {
	DKDEBUGFUNC();
	DKINFO("App::Init() \n");
	
	/*
	////// Event //////
	DKINFO("\n");
	DKEventTarget* myTargetA = new DKEventTarget();
	DKEvent* eventA = new DKEvent("eventA", "");
	myTargetA->addEventListener("eventA", &App::onevent);
	myTargetA->dispatchEvent(eventA);
	
	DKINFO("\n");
	DKEventTarget myTargetB;
	DKEvent* eventB = new DKEvent("eventB", "");
	myTargetB.addEventListener("eventB", &App::onevent);
	myTargetB.dispatchEvent(eventB);
	
	DKINFO("\n");
	DKEventTarget myTargetC;
	DKEvent eventC("eventC", "");
	myTargetC.addEventListener("eventC", &App::onevent);
	myTargetC.dispatchEvent(&eventC);
	
	DKINFO("\n");
	DKEventTarget* myTargetE = new DKEventTarget();
	myTargetE->addEventListener("eventE", &App::onevent);
	myTargetE->dispatchEvent(new DKEvent("eventE", ""));
	
	DKINFO("\n");
	DKEventTarget* myTargetF = new DKEventTarget();
	myTargetF->addEventListener("eventF", &App::onevent);
	myTargetF->dispatchEvent(&DKEvent("eventF", ""));
	
	
	////// CustomEvent //////
	DKINFO("\n");
	myTargetA->addEventListener("customeventA", &App::oncustom);
	myTargetA->dispatchEvent(new DKCustomEvent("customeventA", ""));
	*/
	
	return true;
}

bool App::End(){
	DKDEBUGFUNC();
	DKINFO("App::End() \n");
	return true;
}


////// Event //////
void App::printEventProperties(DKEvent* event) {
	DKDEBUGFUNC(event);
	
	////// Instance properties //////
	DKINFO("event->bubbles = "					+toString(event->bubbles)				+"\n");
	DKINFO("event->cancelable = "				+toString(event->cancelable)			+"\n");
	DKINFO("event->composed = "					+toString(event->composed)				+"\n");
	DKINFO("event->currentTarget = "			+toString(event->currentTarget)			+"\n");
	DKINFO("event->defaultPrevented = "			+toString(event->defaultPrevented)		+"\n");
	DKINFO("event->eventPhase = "				+toString(event->eventPhase)			+"\n");
	DKINFO("event->isTrusted = "				+toString(event->isTrusted)				+"\n");
	DKINFO("event->target = "					+toString(event->target)				+"\n");
	DKINFO("event->timeStamp = "				+toString(event->timeStamp)				+"\n");
	DKINFO("event->type = "						+toString(event->type)					+"\n");
	
	////// Legacy and non-standard properties //////
	DKINFO("event->cancelBubble = "				+toString(event->cancelBubble)			+"\n");
	DKINFO("event->explicitOriginalTarget = "	+toString(event->explicitOriginalTarget)+"\n");
	DKINFO("event->originalTarget = "			+toString(event->originalTarget)		+"\n");
	DKINFO("event->returnValue = "				+toString(event->returnValue)			+"\n");
	DKINFO("event->scoped = "					+toString(event->scoped)				+"\n");
}
bool App::onevent(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("cpp->onevent() \n");
	printEventProperties(event);
	return true;
}

////// CustomEvent //////
void App::printCustomEventProperties(DKCustomEvent* customevent) {
	////// Instance properties //////
	DKINFO("customevent->detail = "	+toString(customevent->detail)	+"\n");
}
bool App::oncustom(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("oncustom() \n");
	printEventProperties(event);
	printCustomEventProperties(dynamic_cast<DKCustomEvent*>(event));
	return true;
}
