#include "DK/stdafx.h"

#include "App.h"

bool App::Init() {
	DKDEBUGFUNC();
	DKINFO("App::Init() \n");
	
	DKClass::DKCreate("DKEventTarget");															
	
	//////////// GENERIC EVENT
	DKString address = DKDuktape::pointerToAddress(this);
	DKEventTarget::addEventListener<DKEvent>("generic", &App::onGeneric, address);					
	DKEvent* event = new DKEvent("generic", "");												
	DKEventTarget::dispatchEvent(event, address);													
	

	DKINFO("/////////// ConsoleWindow ///////////////////// \n");
	DKObject* myConsoleWindow = DKClass::DKCreate("DKConsoleWindow");
	DKString addressB = DKDuktape::pointerToAddress(myConsoleWindow);	
	DKEventTarget::addEventListener<DKKeyboardEvent>("keydown", &App::onKeyDown, addressB);
	
	//DKEventTarget::addEventListener<DKKeyboardEvent>("keyup", &App::onKeyUp, myConsoleWindow);

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

void App::printEventProperties(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("event->bubbles="+toString(event->bubbles)+"\n");
	DKINFO("event->cancelable="+toString(event->cancelable)+"\n");
	DKINFO("event->composed="+toString(event->composed)+"\n");
	//DKINFO("event->currentTarget="+toString(event->currentTarget)+"\n");
	DKINFO("event->defaultPrevented="+toString(event->defaultPrevented)+"\n");
	DKINFO("event->eventPhase="+toString(event->eventPhase)+"\n");
	DKINFO("event->isTrusted="+toString(event->isTrusted)+"\n");
	//DKINFO("event->target="+toString(event->target)+"\n");
	DKINFO("event->timeStamp="+toString(event->timeStamp)+"\n");
	DKINFO("event->type="+event->type+"\n");
}

void App::printUIEventProperties(DKUIEvent* uievent) {
	DKDEBUGFUNC(uievent);
	DKINFO("uievent->detail="+toString(uievent->detail)+"\n");
	//DKINFO("uievent->sourceCapabilities="+toString(uievent->sourceCapabilities)+"\n");
	//DKINFO("uievent->view="+toString(uievent->view)+"\n");
	DKINFO("uievent->which="+toString(uievent->which)+"\n");
}

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

bool App::onGeneric(DKEvent* event) {
	DKDEBUGFUNC(event);
	DKINFO("onGeneric() \n");
	printEventProperties(event);
	return true;
}

bool App::onKeyDown(DKKeyboardEvent* keyevent) {
	DKDEBUGFUNC(keyevent);
	DKINFO("onKeyDown() \n");
	printEventProperties(keyevent);
	printUIEventProperties(keyevent);
	printKeyboardEventProperties(keyevent);
	return true;
}

bool App::onKeyUp(DKKeyboardEvent* keyevent) {
	DKDEBUGFUNC(keyevent);
	DKINFO("onKeyUp() \n");
	printEventProperties(keyevent);
	printUIEventProperties(keyevent);
	printKeyboardEventProperties(keyevent);
	return true;
}
