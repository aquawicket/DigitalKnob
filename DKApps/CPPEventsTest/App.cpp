#include "DK/stdafx.h"

#include "App.h"
#include "CPPEventsTest/DKEventTarget.h"
#include "CPPEventsTest/DKConsoleWindow.h"


bool App::Init() {
	DKDEBUGFUNC();
	DKINFO("App::Init() \n");
	
	DKClass::DKCreate("DKEvent");													// CPP
	DKClass::DKCreate("DKEventTarget");												// CPP
	

	// console.log("/////////// ConsoleWindow /////////////////////")				// JS
	DKINFO("/////////// ConsoleWindow ///////////////////// \n");					// CPP

	// CPP_DK_Create("DKDuktape/ConsoleWindow.js");									// JS
	// const myConsoleWindow = new ConsoleWindow('myConsoleWindow')					// JS
	DKObject* myConsoleWindow = DKClass::DKCreate("DKConsoleWindow");				// CPP

	//myConsoleWindow.addEventListener('keydown', onKeyDown)						// JS
	DKEventTarget::addEventListener("keydown", &App::onKeyDown, myConsoleWindow);	// CPP

	//myConsoleWindow.addEventListener('keyup', onKeyUp)							// JS
	DKEventTarget::addEventListener("keyup", &App::onKeyUp, myConsoleWindow);		// CPP

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
function printKeyboardEventProperties(event){
	console.log("event.altKey="+event.altKey)
	console.log("event.code="+event.code)			
	console.log("event.ctrlKey="+event.ctrlKey)
	console.log("event.isComposing="+event.isComposing)
	console.log("event.key="+event.key)
	console.log("event.locale="+event.locale)
	console.log("event.location="+event.location)
	console.log("event.metaKey="+event.metaKey)
	console.log("event.repeat="+event.repeat)
	console.log("event.shiftKey="+event.shiftKey)
}
*/
// CPP
void App::printKeyboardEventProperties(DKEvent event) {

	//DKINFO("event.altKey="+toString(event.altKey)+"\n");
	/*
	DKINFO("event.code="+event.code+"\n");
	DKINFO("event.ctrlKey="+toString(event.ctrlKey)+"\n");
	DKINFO("event.isComposing="+toString(event.isComposing)+"\n");
	DKINFO("event.key="+event.key+"\n");
	DKINFO("event.locale="+event.locale+"\n");
	DKINFO("event.location="+toString(event.location)+"\n");
	DKINFO("event.metaKey="+toString(event.metaKey)+"\n");
	DKINFO("event.repeat="+toString(event.repeat)+"\n");
	DKINFO("event.shiftKey="+toString(event.shiftKey)+"\n");
	*/
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
bool App::onKeyDown(DKEvent event) {
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
bool App::onKeyUp(DKEvent event) {
	DKINFO("onKeyUp() \n");
	printEventProperties(event);
	printKeyboardEventProperties(event);
	return true;
}