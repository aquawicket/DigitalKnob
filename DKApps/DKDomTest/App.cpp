#include "DK/stdafx.h"

#include "App.h"

// https://console.spec.whatwg.org
#include "TEST_Console.h"

// https://dom.spec.whatwg.org
#include "TEST_Event.h"
#include "TEST_CustomEvent.h"
#include "TEST_EventTarget.h"

// https://w3c.github.io/uievents
#include "TEST_UIEvent.h"
#include "TEST_FocusEvent.h"
#include "TEST_MouseEvent.h"
#include "TEST_WheelEvent.h"
#include "TEST_InputEvent.h"
#include "TEST_KeyboardEvent.h"
#include "TEST_CompositionEvent.h"

// https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface
#include "TEST_DragEvent.h"

// https://html.spec.whatwg.org/
#include "TEST_Window.h"

// https://w3c.github.io/csswg-drafts/cssom-view/#the-screen-interface
#include "TEST_Screen.h"

// https://html.spec.whatwg.org/multipage/system-state.html#the-navigator-object
#include "TEST_Navigator.h"

// https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
#include "TEST_Location.h"

// https://dom.spec.whatwg.org/#interface-node
#include "TEST_Node.h"

// https://dom.spec.whatwg.org/#interface-document
#include "TEST_Document.h"


// ConsoleWindow
#include "TEST_ConsoleWindow.h"

// SDLWindow
#include "TEST_SDLWindow.h"


///////////////////////////////////////
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
	
	// https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface
	DKClass::DKCreate("TEST_DragEvent");
	
	// https://html.spec.whatwg.org/
	DKClass::DKCreate("TEST_Window");

	// https://w3c.github.io/csswg-drafts/cssom-view/#the-screen-interface
	DKClass::DKCreate("TEST_Screen");

	// https://html.spec.whatwg.org/multipage/system-state.html#the-navigator-object
	DKClass::DKCreate("TEST_Navigator");
	
	// https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
	DKClass::DKCreate("TEST_Location");

	// https://dom.spec.whatwg.org/#interface-node
	DKClass::DKCreate("TEST_Node");

	// https://dom.spec.whatwg.org/#interface-document
	DKClass::DKCreate("TEST_Document");
	
	
	// ConsoleWindow
	DKClass::DKCreate("TEST_ConsoleWindow");

	// SDLWindow
	DKClass::DKCreate("TEST_SDLWindow");

	return true;
}

bool App::End(){
	DKDEBUGFUNC();
	return true;
}
