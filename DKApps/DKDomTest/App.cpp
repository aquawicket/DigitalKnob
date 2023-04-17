#include "DK/stdafx.h"

#include "App.h"

// https://console.spec.whatwg.org
#include "TEST_Console.h"

// https://dom.spec.whatwg.org
#include "TEST_Event.h"
#include "TEST_CustomEvent.h"
#include "TEST_EventTarget.h"

// https://w3c.github.io/uievents
#include "TEST_UIEvent"
#include "TEST_FocusEvent"
#include "TEST_MouseEvent"
#include "TEST_WheelEvent"
#include "TEST_InputEvent"
#include "TEST_KeyboardEvent"
#include "TEST_CompositionEvent"


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
	DKClass::DKCreate("TEST_MouseEvent");
	DKClass::DKCreate("TEST_WheelEvent");
	DKClass::DKCreate("TEST_InputEvent");
	DKClass::DKCreate("TEST_KeyboardEvent");
	DKClass::DKCreate("TEST_CompositionEvent");
	
	return true;
}

bool App::End(){
	DKDEBUGFUNC();
	return true;
}
