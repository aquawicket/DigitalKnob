#include "DK/stdafx.h"

#include "App.h"
#include "CPPEventsTest/DKEventTarget.h"
#include "CPPEventsTest/DKConsoleWindow.h"


bool App::Init() {
	DKDEBUGFUNC();
	DKINFO("App::Init() \n");
	
	DKClass::DKCreate("DKEvent");										// CPP
	DKClass::DKCreate("DKEventTarget");									// CPP
	

	// console.log("/////////// ConsoleWindow /////////////////////")	// JS
	DKINFO("/////////// ConsoleWindow ///////////////////// \n");		// CPP

	// CPP_DK_Create("DKDuktape/ConsoleWindow.js");						// JS
	// const myConsoleWindow = new ConsoleWindow('myConsoleWindow')		// JS
	DKObject* myConsoleWindow = DKClass::DKCreate("DKConsoleWindow");	// CPP

	//myConsoleWindow.addEventListener('keydown', onKeyDown)			// JS
	DKEventTarget::Get()->addEventListener("keydown");					// CPP

	//myConsoleWindow.addEventListener('keyup', onKeyUp)				// JS
	// TODO																// CPP

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
void App::printKeyboardEventProperties(/*event*/) {
	DKINFO("event.altKey=");//" + event.altKey);
	DKINFO("event.code=");// +event.code);
	DKINFO("event.ctrlKey=");// +event.ctrlKey);
	DKINFO("event.isComposing=");// +event.isComposing);
	DKINFO("event.key=");// +event.key);
	DKINFO("event.locale=");// +event.locale);
	DKINFO("event.location=");// +event.location);
	DKINFO("event.metaKey=");// +event.metaKey);
	DKINFO("event.repeat=");// +event.repeat);
	DKINFO("event.shiftKey=");// +event.shiftKey);
}

// JS
/*
function onKeyDown(event){
	console.log("\n onKeyDown()")
	printKeyboardEventProperties(event)
}
*/
// CPP
void App::onKeyDown(/*event*/) {
	DKINFO("\n onKeyDown()");
	printKeyboardEventProperties(/*event*/);
}

// JS
/*
function onKeyUp(event){
	console.log("\n onKeyUp()")
	printKeyboardEventProperties(event)
}
*/
// CPP
void App::onKeyUp(/*event*/) {
	DKINFO("\n onKeyUp()");
	printKeyboardEventProperties(/*event*/);
}

bool App::End(){
	DKDEBUGFUNC();
	DKINFO("App::End() \n");
	return true;
}