#include "DK/stdafx.h"

#include "App.h"
#include <algorithm>	// smart pointers


// [Console] https://console.spec.whatwg.org
#include "TEST_Console.h"

// [DOM] https://dom.spec.whatwg.org
#include "TEST_Event.h"
#include "TEST_EventTarget.h"
#include "TEST_CustomEvent.h"

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

// [Screen] https://w3c.github.io/csswg-drafts/cssom-view/#the-screen-interface
#include "TEST_Screen.h"

// [Window] https://html.spec.whatwg.org/
#include "TEST_Window.h"

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

// [HTMLCollection] https://dom.spec.whatwg.org/#interface-htmlcollection
#include "TEST_HTMLCollection.h"

// [HTMLElement] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
#include "TEST_HTMLElement.h"

// [HTMLBodyElement] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
#include "TEST_HTMLBodyElement.h"

// [HTMLImageElement] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
#include "TEST_HTMLImageElement.h"


////// DigitalKnob //////
// [DKConsoleWindow]
//#include "TEST_DKConsoleWindow.h"

// [DKSdlWindow]
#include "TEST_DKSdlWindow.h"

// [DKRmlDocument]
#include "TEST_DKRmlDocument.h"

// [DKRmlLocation]
#include "TEST_DKRmlLocation.h"


///////////////////////////////////////
bool App::Init() {
	DKDEBUGFUNC();

	// [Console]
	//DKClass::DKCreate("TEST_Console");																		// DKObjectT
	//TEST_Console* test_console = new TEST_Console();															// pointer
	std::unique_ptr<TEST_Console> test_Console = std::make_unique<TEST_Console>();								// smart pointer
	
	
	// [Event]
	//DKClass::DKCreate("TEST_Event");																			// DKObjectT
	//TEST_Event* test_event = new TEST_Event();																// pointer
	std::unique_ptr<TEST_Event> test_Event = std::make_unique<TEST_Event>();									// smart pointer
	
	// [EventTarget]
	//DKClass::DKCreate("TEST_EventTarget");																	// DKObjectT
	//TEST_EventTarget* test_EventTarget = new TEST_EventTarget();												// pointer
	std::unique_ptr<TEST_EventTarget> test_EventTarget = std::make_unique<TEST_EventTarget>();					// smart pointer
	
	// [CustomEvent]
	//DKClass::DKCreate("TEST_CustomEvent");																	// DKObjectT
	//TEST_CustomEvent* test_CustomEvent = new TEST_CustomEvent();												// pointer
	std::unique_ptr<TEST_CustomEvent> test_CustomEvent = std::make_unique<TEST_CustomEvent>();					// smart pointer
	
	
	// [UIEvent]
	//DKClass::DKCreate("TEST_UIEvent");																		// DKObjectT
	//TEST_UIEvent* test_UIEvent = new TEST_UIEvent();															// pointer
	std::unique_ptr<TEST_UIEvent> test_UIEvent = std::make_unique<TEST_UIEvent>();								// smart pointer
	
	// [FocusEvent]
	//DKClass::DKCreate("TEST_FocusEvent");																		// DKObjectT
	//TEST_FocusEvent* test_FocusEvent = new TEST_FocusEvent();													// pointer
	std::unique_ptr<TEST_FocusEvent> test_FocusEvent = std::make_unique<TEST_FocusEvent>();						// smart pointer
	
	// [MouseEvent]
	//DKClass::DKCreate("TEST_MouseEvent");																		// DKObjectT
	//TEST_MouseEvent* test_MouseEvent = new TEST_MouseEvent();													// pointer
	std::unique_ptr<TEST_MouseEvent> test_MouseEvent = std::make_unique<TEST_MouseEvent>();						// smart pointer
	
	// [WheelEvent]
	//DKClass::DKCreate("TEST_WheelEvent");																		// DKObjectT
	//TEST_WheelEvent* test_WheelEvent = new TEST_WheelEvent();													// pointer
	std::unique_ptr<TEST_WheelEvent> test_WheelEvent = std::make_unique<TEST_WheelEvent>();						// smart pointer
	
	// [InputEvent]
	//DKClass::DKCreate("TEST_InputEvent");																		// DKObjectT
	//TEST_InputEvent* test_InputEvent = new TEST_InputEvent();													// pointer
	std::unique_ptr<TEST_InputEvent> test_InputEvent = std::make_unique<TEST_InputEvent>();						// smart pointer
	
	// [KeyboardEvent]
	//DKClass::DKCreate("TEST_KeyboardEvent");																	// DKObjectT
	//TEST_KeyboardEvent* test_KeyboardEvent = new TEST_KeyboardEvent();										// pointer
	std::unique_ptr<TEST_KeyboardEvent> test_KeyboardEvent = std::make_unique<TEST_KeyboardEvent>();			// smart pointer
	
	// [CompositionEvent]
	//DKClass::DKCreate("TEST_CompositionEvent");																// DKObjectT
	//TEST_CompositionEvent* test_CompositionEvent = new TEST_CompositionEvent();								// pointer
	std::unique_ptr<TEST_CompositionEvent> test_CompositionEvent = std::make_unique<TEST_CompositionEvent>();	// smart pointer
	
	
	/*
	// [DragEvent] https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface
	DKClass::DKCreate("TEST_DragEvent");
	
	// [Screen] https://w3c.github.io/csswg-drafts/cssom-view/#the-screen-interface
	DKClass::DKCreate("TEST_Screen");
	
	// [Window] https://html.spec.whatwg.org/
	DKClass::DKCreate("TEST_Window");

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

	// [HTMLCollection ] https://dom.spec.whatwg.org/#interface-htmlcollection
	DKClass::DKCreate("TEST_HTMLCollection");
	
	// [HTMLElement] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
	DKClass::DKCreate("TEST_HTMLElement");
	
	// [HTMLBodyElement] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
	DKClass::DKCreate("TEST_HTMLBodyElement");
	
	// [HTMLImageElement] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
	DKClass::DKCreate("TEST_HTMLImageElement");
	*/

	/*
	////// DigitalKnob //////
	// [DKConsoleWindow]
	//DKClass::DKCreate("TEST_DKConsoleWindow");
	
	// [DKSdlWindow]
	DKClass::DKCreate("TEST_DKSdlWindow");
	
	// [DKRmlDocument]
	DKClass::DKCreate("TEST_DKRmlDocument");
	
	// [DKRmlLocation]
	DKClass::DKCreate("TEST_DKRmlLocation");
	*/
	
	return true;
}

bool App::End(){
	DKDEBUGFUNC();
	return true;
}
