#include "DK/stdafx.h"

#include "App.h"

// [Console] https://console.spec.whatwg.org
#include "TEST_Console.h"

// [DOM] https://dom.spec.whatwg.org
#include "TEST_Event.h"
#include "TEST_CustomEvent.h"
#include "TEST_EventTarget.h"

// [UIEvents] https://w3c.github.io/uievents
#include "TEST_UIEvent.h"
#include "TEST_FocusEvent.h"
#include "TEST_MouseEvent.h"
#include "TEST_WheelEvent.h"
#include "TEST_InputEvent.h"
#include "TEST_KeyboardEvent.h"
#include "TEST_CompositionEvent.h"

// [DragEvent] https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface
#include "TEST_DragEvent.h"

// [Window] https://html.spec.whatwg.org/
#include "TEST_Window.h"

// [Screen] https://w3c.github.io/csswg-drafts/cssom-view/#the-screen-interface
#include "TEST_Screen.h"

// [Navigator] https://html.spec.whatwg.org/multipage/system-state.html#the-navigator-object
#include "TEST_Navigator.h"

// [Location] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
#include "TEST_Location.h"

// [Node] https://dom.spec.whatwg.org/#interface-node
#include "TEST_Node.h"

// [Document] https://dom.spec.whatwg.org/#interface-document
#include "TEST_Document.h"

// [Element] https://dom.spec.whatwg.org/#interface-element
#include "TEST_Element.h"

// [HTMLCollection]
#include "TEST_HTMLCollection.h"

// [HTMLElement] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
#include "TEST_HTMLElement.h"

// [HTMLBodyElement] 
#include "TEST_HTMLBodyElement.h"


////// DigitalKnob //////
// [DKConsoleWindow]
#include "TEST_DKConsoleWindow.h"

// [DKSdlWindow]
#include "TEST_DKSdlWindow.h"

// [DKRmlDocument]
#include "TEST_DKRmlDocument.h"

// [DKRmlLocation]
#include "TEST_DKRmlLocation.h"


///////////////////////////////////////
bool App::Init() {
	DKDEBUGFUNC();
	
	// [Console] https://console.spec.whatwg.org
	DKClass::DKCreate("TEST_Console");
	
	// [DOM] https://dom.spec.whatwg.org
	DKClass::DKCreate("TEST_Event");
	DKClass::DKCreate("TEST_CustomEvent");
	DKClass::DKCreate("TEST_EventTarget");
	
	// [UIEvents] https://w3c.github.io/uievents
	DKClass::DKCreate("TEST_UIEvent");
	DKClass::DKCreate("TEST_FocusEvent");
	DKClass::DKCreate("TEST_MouseEvent");
	DKClass::DKCreate("TEST_WheelEvent");
	DKClass::DKCreate("TEST_InputEvent");
	DKClass::DKCreate("TEST_KeyboardEvent");
	DKClass::DKCreate("TEST_CompositionEvent");
	
	// [DragEvent] https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface
	DKClass::DKCreate("TEST_DragEvent");
	
	// [Window] https://html.spec.whatwg.org/
	DKClass::DKCreate("TEST_Window");

	// [Screen] https://w3c.github.io/csswg-drafts/cssom-view/#the-screen-interface
	DKClass::DKCreate("TEST_Screen");

	// [Navigator] https://html.spec.whatwg.org/multipage/system-state.html#the-navigator-object
	DKClass::DKCreate("TEST_Navigator");
	
	// [Location] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
	DKClass::DKCreate("TEST_Location");

	// [Node] https://dom.spec.whatwg.org/#interface-node
	DKClass::DKCreate("TEST_Node");

	// [Document] https://dom.spec.whatwg.org/#interface-document
	DKClass::DKCreate("TEST_Document");
	
	// [Element] https://dom.spec.whatwg.org/#interface-element
	DKClass::DKCreate("TEST_Element");
	
	// [HTMLElement] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
	DKClass::DKCreate("TEST_HTMLElement");
	
	
	////// DigitalKnob //////
	// [DKConsoleWindow]
	DKClass::DKCreate("TEST_DKConsoleWindow");

	// [DKSdlWindow]
	DKClass::DKCreate("TEST_DKSdlWindow");
	
	// [DKRmlDocument]
	DKClass::DKCreate("TEST_DKRmlDocument");
	
	// [DKRmlLocation]
	DKClass::DKCreate("TEST_DKRmlLocation");
	
	return true;
}

bool App::End(){
	DKDEBUGFUNC();
	return true;
}
