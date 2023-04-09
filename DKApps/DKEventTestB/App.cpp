#include "DK/stdafx.h"

#include "App.h"

bool App::Init() {
	DKDEBUGFUNC();
	DKINFO("App::Init() \n");
	
	DKClass::DKCreate("DKEventTarget");															
	
	/*
	////// Event //////
	DKString thisAddress = DKDuktape::pointerToAddress(this);
	DKEventTarget::addEventListener<DKEvent>("generic", &App::ongeneric, thisAddress);					
	DKEvent* event = new DKEvent("generic", "");												
	DKEventTarget::dispatchEvent(event, thisAddress);													
	DKEventTarget::removeEventListener<DKEvent>("generic", &App::ongeneric, thisAddress);	
	DKEventTarget::dispatchEvent(event, thisAddress);
	
	DKINFO("/////////// ConsoleWindow ///////////////////// \n");
	DKObject* myConsoleWindow = DKClass::DKCreate("DKConsoleWindow");
	DKString consoleWindowAddress = DKDuktape::pointerToAddress(myConsoleWindow);
	
	
	////// CustomEvent ///////
	

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
bool App::ongeneric(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("ongeneric() \n");
	printEventProperties(event);
	return true;
}

////// CustomEvent //////
void App::printCustomEventProperties(DKCustomEvent* customevent) {
	////// Instance properties //////
	DKINFO("customevent->detail = "	+toString(customevent->detail)	+"\n");
}
