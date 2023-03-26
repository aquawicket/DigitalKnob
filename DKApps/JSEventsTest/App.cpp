#include "DK/stdafx.h"

#include "App.h"
#include "JSEventsTest/DKEventTarget.h"
#include "JSEventsTest/DKConsoleWindow.h"
#include "JSEventsTest/DKKeyboardEvent.h"


bool App::Init() {
	DKDEBUGFUNC();
	DKINFO("App::Init() \n");
	
	DKClass::DKCreate("DKEvent");																	// CPP
	DKClass::DKCreate("DKEventTarget");																// CPP
	
	// console.log("/////////// ConsoleWindow /////////////////////")								// JS
	DKINFO("/////////// ConsoleWindow ///////////////////// \n");									// CPP

	// CPP_DK_Create("DKDuktape/ConsoleWindow.js");													// JS
	// const myConsoleWindow = new ConsoleWindow('myConsoleWindow')									// JS
	DKObject* myConsoleWindow = DKClass::DKCreate("DKConsoleWindow");								// CPP

	//myConsoleWindow.addEventListener('keydown', onKeyDown)										// JS
	DKEventTarget::addEventListener<DKKeyboardEvent>("keydown", &App::onKeyDown, myConsoleWindow);	// CPP

	//myConsoleWindow.addEventListener('keyup', onKeyUp)											// JS
	DKEventTarget::addEventListener<DKKeyboardEvent>("keyup", &App::onKeyUp, myConsoleWindow);		// CPP

	// JS
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
	// CPP
	/* TODO */

	return true;
}

bool App::End(){
	DKDEBUGFUNC();
	DKINFO("App::End() \n");
	return true;
}


// JS 
/*
function printEventProperties(event){
	console.log("event.bubbles="+event.bubbles)
	console.log("event.cancelable="+event.cancelable)			
	console.log("event.composed="+event.composed)
	console.log("event.currentTarget="+event.currentTarget)
	console.log("event.defaultPrevented="+event.defaultPrevented)
	console.log("event.eventPhase="+event.eventPhase)
	console.log("event.isTrusted="+event.isTrusted)
	console.log("event.target="+event.target)
	console.log("event.timeStamp="+event.timeStamp)
	console.log("event.type="+event.type)
}
*/
// CPP
void App::printEventProperties(DKEvent event) {
	DKDEBUGFUNC(event);
	DKINFO("event.bubbles="+toString(event.bubbles)+"\n");
	DKINFO("event.cancelable="+toString(event.cancelable)+"\n");
	DKINFO("event.composed="+toString(event.composed)+"\n");
	//DKINFO("event.currentTarget="+toString(event.currentTarget)+"\n");
	DKINFO("event.defaultPrevented="+toString(event.defaultPrevented)+"\n");
	DKINFO("event.eventPhase="+toString(event.eventPhase)+"\n");
	DKINFO("event.isTrusted="+toString(event.isTrusted)+"\n");
	//DKINFO("event.target="+toString(event.target)+"\n");
	DKINFO("event.timeStamp="+toString(event.timeStamp)+"\n");
	DKINFO("event.type="+event.type+"\n");
}


// JS 
/*
function printKeyboardEventProperties(keyevent){
	console.log("keyevent.altKey="+keyevent.altKey)
	console.log("keyevent.code="+keyevent.code)			
	console.log("keyevent.ctrlKey="+keyevent.ctrlKey)
	console.log("keyevent.isComposing="+keyevent.isComposing)
	console.log("keyevent.key="+keyevent.key)
	console.log("keyevent.locale="+keyevent.locale)
	console.log("keyevent.location="+keyevent.location)
	console.log("keyevent.metaKey="+keyevent.metaKey)
	console.log("keyevent.repeat="+keyevent.repeat)
	console.log("keyevent.shiftKey="+keyevent.shiftKey)
}
*/
// CPP
void App::printKeyboardEventProperties(DKKeyboardEvent keyevent) {
	DKDEBUGFUNC(keyevent);
	DKINFO("keyevent.altKey="+toString(keyevent.altKey)+"\n");
	DKINFO("keyevent.code="+keyevent.code+"\n");
	DKINFO("keyevent.ctrlKey="+toString(keyevent.ctrlKey)+"\n");
	DKINFO("keyevent.isComposing="+toString(keyevent.isComposing)+"\n");
	DKINFO("keyevent.key="+keyevent.key+"\n");
	DKINFO("keyevent.locale="+keyevent.locale+"\n");
	DKINFO("keyevent.location="+toString(keyevent.location)+"\n");
	DKINFO("keyevent.metaKey="+toString(keyevent.metaKey)+"\n");
	DKINFO("keyevent.repeat="+toString(keyevent.repeat)+"\n");
	DKINFO("keyevent.shiftKey="+toString(keyevent.shiftKey)+"\n");
}


// JS
/*
function onKeyDown(event){
	console.log("\n onKeyDown()")
	printEventProperties(event)
	printKeyboardEventProperties(event)
}
*/
// CPP
bool App::onKeyDown(DKKeyboardEvent event) {
	DKDEBUGFUNC(event);
	DKINFO("onKeyDown() \n");
	printEventProperties(event);
	printKeyboardEventProperties(event);
	return true;
}


// JS
/*
function onKeyUp(event){
	console.log("\n onKeyUp()")
	printEventProperties(event)
	printKeyboardEventProperties(event)
}
*/
// CPP
bool App::onKeyUp(DKKeyboardEvent event) {
	DKDEBUGFUNC(event);
	DKINFO("onKeyUp() \n");
	printEventProperties(event);
	printKeyboardEventProperties(event);
	return true;
}