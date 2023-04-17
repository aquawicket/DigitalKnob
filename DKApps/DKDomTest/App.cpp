#include "DK/stdafx.h"

#include "App.h"
#include "TEST_Event.h"
#include "TEST_CustomEvent.h"


bool App::Init() {
	DKDEBUGFUNC();
	
	// https://console.spec.whatwg.org
	DKClass::DKCreate("TEST_Console");
	
	// https://dom.spec.whatwg.org
	DKClass::DKCreate("TEST_Event");
	DKClass::DKCreate("TEST_CustomEvent");
	DKClass::DKCreate("TEST_EventTarget");
	
	// https://w3c.github.io/uievents
	DKClass::DKCreate("TEST_UIEvent");
	DKClass::DKCreate("TEST_FocusEvent");
	//DKClass::DKCreate("TEST_MouseEvent");
	//DKClass::DKCreate("TEST_WheelEvent");
	//DKClass::DKCreate("TEST_InputEvent");
	//DKClass::DKCreate("TEST_KeyboardEvent");
	//DKClass::DKCreate("TEST_CompositionEvent");
	
	return true;
}

bool App::End(){
	DKDEBUGFUNC();
	return true;
}
