#include "DK/stdafx.h"

#include "App.h"

bool App::Init() {
	DKDEBUGFUNC();
	DKINFO("App::Init() \n");
	
	DKClass::DKCreate("DKEventTarget");															
	
	
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
	
	
	////// KeyboardEvent ///////
	DKEventTarget::addEventListener<DKKeyboardEvent>("keydown", &App::onkeydown, consoleWindowAddress);
	DKEventTarget::addEventListener<DKKeyboardEvent>("keyup", &App::onkeyup, consoleWindowAddress);
	DKEventTarget::addEventListener<DKKeyboardEvent>("keypress", &App::onkeypress, consoleWindowAddress);

	/*
	//console.log("myConsoleWindow.name="+myConsoleWindow.name)
	//myConsoleWindow.name = "Test 123"
	//console.log("myConsoleWindow.name="+myConsoleWindow.name)
	//myConsoleWindow.fullScreen = true;
	//myConsoleWindow.fullScreen = false;
	//myConsoleWindow.blur()
	//myConsoleWindow.close()
	//myConsoleWindow.focus()
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
	DKINFO("event->bubbles="+toString(event->bubbles)+"\n");
	DKINFO("event->cancelable="+toString(event->cancelable)+"\n");
	DKINFO("event->composed="+toString(event->composed)+"\n");
	DKINFO("event->currentTarget="+event->currentTarget+"\n");
	DKINFO("event->defaultPrevented="+toString(event->defaultPrevented)+"\n");
	DKINFO("event->eventPhase="+toString(event->eventPhase)+"\n");
	DKINFO("event->isTrusted="+toString(event->isTrusted)+"\n");
	DKINFO("event->target="+event->target+"\n");
	DKINFO("event->timeStamp="+toString(event->timeStamp)+"\n");
	DKINFO("event->type="+event->type+"\n");
	
	////// Legacy and non-standard properties //////
	DKINFO("event->cancelBubble="+toString(event->cancelBubble)+"\n");
	DKINFO("event->explicitOriginalTarget="+toString(event->explicitOriginalTarget)+"\n");
	DKINFO("event->originalTarget="+toString(event->originalTarget)+"\n");
	DKINFO("event->returnValue="+toString(event->returnValue)+"\n");
	DKINFO("event->scoped="+toString(event->scoped)+"\n");
}
bool App::ongeneric(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("ongeneric() \n");
	printEventProperties(event);
	return true;
}
bool App::onafterscriptexecute(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("onafterscriptexecute() \n");
	printEventProperties(event);
	return true;
}
bool App::onbeforematch(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("onbeforematch() \n");
	printEventProperties(event);
	return true;
}
bool App::onbeforescriptexecute(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("onbeforescriptexecute() \n");
	printEventProperties(event);
	return true;
}
bool App::onerror(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("onerror() \n");
	printEventProperties(event);
	return true;
}
bool App::onfullscreenchange(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("onfullscreenchange() \n");
	printEventProperties(event);
	return true;
}
bool App::onfullscreenerror(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("onfullscreenerror() \n");
	printEventProperties(event);
	return true;
}
bool App::onscroll(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("onscroll() \n");
	printEventProperties(event);
	return true;
}
bool App::onscrollend(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("onscrollend() \n");
	printEventProperties(event);
	return true;
}


////// UIEvent //////
void App::printUIEventProperties(DKUIEvent* uievent) {
	DKDEBUGFUNC(uievent);
	DKINFO("uievent->detail="+toString(uievent->detail)+"\n");
	DKINFO("uievent->sourceCapabilities="+toString(uievent->sourceCapabilities)+"\n");
	DKINFO("uievent->view="+toString(uievent->view)+"\n");
	DKINFO("uievent->which="+toString(uievent->which)+"\n");
}


////// KeyboardEvent //////
void App::printKeyboardEventProperties(DKKeyboardEvent* keyevent) {
	DKDEBUGFUNC(keyevent);
	DKINFO("keyevent->altKey="+toString(keyevent->altKey)+"\n");
	DKINFO("keyevent->code="+keyevent->code+"\n");
	DKINFO("keyevent->ctrlKey="+toString(keyevent->ctrlKey)+"\n");
	DKINFO("keyevent->isComposing="+toString(keyevent->isComposing)+"\n");
	DKINFO("keyevent->key="+keyevent->key+"\n");
	DKINFO("keyevent->locale="+keyevent->locale+"\n");
	DKINFO("keyevent->location="+toString(keyevent->location)+"\n");
	DKINFO("keyevent->metaKey="+toString(keyevent->metaKey)+"\n");
	DKINFO("keyevent->repeat="+toString(keyevent->repeat)+"\n");
	DKINFO("keyevent->shiftKey="+toString(keyevent->shiftKey)+"\n");
}

bool App::onkeydown(DKKeyboardEvent* keyevent) {
	DKDEBUGFUNC(keyevent);
	DKINFO("onkeydown() \n");
	printEventProperties(keyevent);
	printUIEventProperties(keyevent);
	printKeyboardEventProperties(keyevent);
	return true;
}

bool App::onkeyup(DKKeyboardEvent* keyevent) {
	DKDEBUGFUNC(keyevent);
	DKINFO("onkeyup() \n");
	printEventProperties(keyevent);
	printUIEventProperties(keyevent);
	printKeyboardEventProperties(keyevent);
	return true;
}

bool App::onkeypress(DKKeyboardEvent* keyevent) {
	DKDEBUGFUNC(keyevent);
	DKINFO("onkeypress() \n");
	printEventProperties(keyevent);
	printUIEventProperties(keyevent);
	printKeyboardEventProperties(keyevent);
	return true;
}


////// MouseEvent //////
void App::printMouseEventProperties(DKMouseEvent* mouseevent) {
	DKDEBUGFUNC(mouseevent);
	DKTODO();
}