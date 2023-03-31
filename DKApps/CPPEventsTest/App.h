#pragma once
#ifndef App_H
#define App_H

#include "DK/DK.h"


class App : public DKObjectT<App>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("App::Init() \n");
		
		//DKClass::DKCreate("DKEvent");																	// CPP
		DKClass::DKCreate("DKEventTarget");																// CPP
		
		//////////// GENERIC EVENT
		DKString eventTargetAddress = DKDuktape::pointerToAddress(this);
		DKEventTarget::addEventListener<DKEvent>("generic", &App::onGeneric, eventTargetAddress);		// CPP
		DKEvent* event = new DKEvent("generic", "");													// CPP
		DKEventTarget::dispatchEvent(event, eventTargetAddress);										// CPP
		

		// console.log("/////////// ConsoleWindow /////////////////////")								// JS
		DKINFO("/////////// ConsoleWindow ///////////////////// \n");									// CPP

		// CPP_DK_Create("DKDuktape/ConsoleWindow.js");													// JS
		// const myConsoleWindow = new ConsoleWindow('myConsoleWindow')									// JS
		DKObject* myConsoleWindow = DKClass::DKCreate("DKConsoleWindow");								// CPP

		//myConsoleWindow.addEventListener('keydown', onKeyDown)										// JS
		DKString addressB = DKDuktape::pointerToAddress(myConsoleWindow);	
		DKEventTarget::addEventListener<DKKeyboardEvent>("keydown", &App::onKeyDown, addressB);			// CPP

		//myConsoleWindow.addEventListener('keyup', onKeyUp)											// JS
		//DKEventTarget::addEventListener<DKKeyboardEvent>("keyup", &App::onKeyUp, myConsoleWindow);	// CPP


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
	
	bool End(){
		DKDEBUGFUNC();
		DKINFO("App::End() \n");
		return true;
	}

	////// KeyboardEvents //////
	static void printEventProperties(DKEvent* event){
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
	static void printKeyboardEventProperties(DKKeyboardEvent* keyevent){
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
	static bool onKeyDown(DKKeyboardEvent* keyevent) {
		DKDEBUGFUNC(keyevent);
		DKINFO("onKeyDown() \n");
		printEventProperties(keyevent);
		printKeyboardEventProperties(keyevent);
		return true;
	}
	static bool onKeyUp(DKKeyboardEvent* keyevent) {
		DKDEBUGFUNC(keyevent);
		DKINFO("onKeyUp() \n");
		printEventProperties(keyevent);
		printKeyboardEventProperties(keyevent);
		return true;
	}
	static bool onGeneric(DKEvent* event){
		DKDEBUGFUNC(event);
		DKINFO("onGeneric() \n");
		printEventProperties(event);
		return true;
	}
};
REGISTER_OBJECT(App, false);


#endif //App_H