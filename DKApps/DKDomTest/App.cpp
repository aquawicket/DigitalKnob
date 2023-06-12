#include "DK/stdafx.h"
#include "App.h"


///////////////////////////////////////
bool App::Init() {
	DKDEBUGFUNC();
	
	// [INTERFACE]
	//DKClass::DKCreate("TEST_INTERFACE");																		// DKObjectT
	//TEST_INTERFACE* test_interfqce = new TEST_INTERFACE();													// pointer
	//std::shared_ptr<TEST_INTERFACE> test_interfqce = std::make_shared<TEST_INTERFACE>();						// smart pointer (shared)
	//std::unique_ptr<TEST_INTERFACE> test_interfqce = std::make_unique<TEST_INTERFACE>();						// smart pointer (unique)
	
	// [Console]
	//DKClass::DKCreate("TEST_Console");																		// DKObjectT
	//TEST_Console* test_console = new TEST_Console();															// pointer
	//std::shared_ptr<TEST_Console> test_Console = std::make_shared<TEST_Console>();							// smart pointer (shared)
	std::unique_ptr<TEST_Console> test_Console = std::make_unique<TEST_Console>();								// smart pointer (unique)
	
	
	// [Event]
	//DKClass::DKCreate("TEST_Event");																			// DKObjectT
	//TEST_Event* test_event = new TEST_Event();																// pointer
	std::unique_ptr<TEST_Event> test_Event = std::make_unique<TEST_Event>();									// smart pointer (unique)
	
	// [EventTarget]
	//DKClass::DKCreate("TEST_EventTarget");																	// DKObjectT
	//TEST_EventTarget* test_EventTarget = new TEST_EventTarget();												// pointer
	std::unique_ptr<TEST_EventTarget> test_EventTarget = std::make_unique<TEST_EventTarget>();					// smart pointer (unique)
	
	// [CustomEvent]
	//DKClass::DKCreate("TEST_CustomEvent");																	// DKObjectT
	//TEST_CustomEvent* test_CustomEvent = new TEST_CustomEvent();												// pointer
	std::unique_ptr<TEST_CustomEvent> test_CustomEvent = std::make_unique<TEST_CustomEvent>();					// smart pointer (unique)
	
	
	// [UIEvent]
	//DKClass::DKCreate("TEST_UIEvent");																		// DKObjectT
	//TEST_UIEvent* test_UIEvent = new TEST_UIEvent();															// pointer
	std::unique_ptr<TEST_UIEvent> test_UIEvent = std::make_unique<TEST_UIEvent>();								// smart pointer (unique)
	
	// [FocusEvent]
	//DKClass::DKCreate("TEST_FocusEvent");																		// DKObjectT
	//TEST_FocusEvent* test_FocusEvent = new TEST_FocusEvent();													// pointer
	std::unique_ptr<TEST_FocusEvent> test_FocusEvent = std::make_unique<TEST_FocusEvent>();						// smart pointer (unique)
	
	// [MouseEvent]
	//DKClass::DKCreate("TEST_MouseEvent");																		// DKObjectT
	//TEST_MouseEvent* test_MouseEvent = new TEST_MouseEvent();													// pointer
	std::unique_ptr<TEST_MouseEvent> test_MouseEvent = std::make_unique<TEST_MouseEvent>();						// smart pointer (unique)
	
	// [WheelEvent]
	//DKClass::DKCreate("TEST_WheelEvent");																		// DKObjectT
	//TEST_WheelEvent* test_WheelEvent = new TEST_WheelEvent();													// pointer
	std::unique_ptr<TEST_WheelEvent> test_WheelEvent = std::make_unique<TEST_WheelEvent>();						// smart pointer (unique)
	
	// [InputEvent]
	//DKClass::DKCreate("TEST_InputEvent");																		// DKObjectT
	//TEST_InputEvent* test_InputEvent = new TEST_InputEvent();													// pointer
	std::unique_ptr<TEST_InputEvent> test_InputEvent = std::make_unique<TEST_InputEvent>();						// smart pointer (unique)
	
	// [KeyboardEvent]
	//DKClass::DKCreate("TEST_KeyboardEvent");																	// DKObjectT
	//TEST_KeyboardEvent* test_KeyboardEvent = new TEST_KeyboardEvent();										// pointer
	std::unique_ptr<TEST_KeyboardEvent> test_KeyboardEvent = std::make_unique<TEST_KeyboardEvent>();			// smart pointer (unique)
	
	// [CompositionEvent]
	//DKClass::DKCreate("TEST_CompositionEvent");																// DKObjectT
	//TEST_CompositionEvent* test_CompositionEvent = new TEST_CompositionEvent();								// pointer
	std::unique_ptr<TEST_CompositionEvent> test_CompositionEvent = std::make_unique<TEST_CompositionEvent>();	// smart pointer (unique)
	
	
	// [DragEvent]
	//DKClass::DKCreate("TEST_DragEvent");																		// DKObjectT
	//TEST_DragEvent* test_DragEvent = new TEST_DragEvent();													// pointer
	std::unique_ptr<TEST_DragEvent> test_DragEvent = std::make_unique<TEST_DragEvent>();						// smart pointer (unique)

	// [Screen]
	//DKClass::DKCreate("TEST_Screen");																			// DKObjectT
	//TEST_Screen* test_Screen = new TEST_Screen();																// pointer
	std::unique_ptr<TEST_Screen> test_Screen = std::make_unique<TEST_Screen>();									// smart pointer (unique)

	// [Window]
	//DKClass::DKCreate("TEST_Window");																			// DKObjectT
	//TEST_Window* test_Window = new TEST_Window();																// pointer
	std::unique_ptr<TEST_Window> test_Window = std::make_unique<TEST_Window>();									// smart pointer (unique)

	// [Navigator]
	//DKClass::DKCreate("TEST_Navigator");																		// DKObjectT
	//TEST_Navigator* test_Navigator = new TEST_Navigator();													// pointer
	std::unique_ptr<TEST_Navigator> test_Navigator = std::make_unique<TEST_Navigator>();						// smart pointer (unique)

	// [URL]
	//DKClass::DKCreate("TEST_URL");																			// DKObjectT
	//TEST_URL* test_URL = new TEST_URL();																		// pointer
	std::unique_ptr<TEST_URL> test_URL = std::make_unique<TEST_URL>();											// smart pointer (unique)
	
	// [Location]
	//DKClass::DKCreate("TEST_Location");																		// DKObjectT
	//TEST_Location* test_Location = new TEST_Location();														// pointer
	std::unique_ptr<TEST_Location> test_Location = std::make_unique<TEST_Location>();							// smart pointer (unique)
	
	// [CSSStyleDeclaration]
	//DKClass::DKCreate("TEST_CSSStyleDeclaration");															// DKObjectT
	//TEST_CSSStyleDeclaration* test_CSSStyleDeclaration = new TEST_CSSStyleDeclaration();						// pointer
	std::unique_ptr<TEST_CSSStyleDeclaration> test_CSSStyleDeclaration = std::make_unique<TEST_CSSStyleDeclaration>();		// smart pointer (unique)

	// [Node]
	//DKClass::DKCreate("TEST_Node");																			// DKObjectT
	//TEST_Node* test_Node = new TEST_Node();																	// pointer
	std::unique_ptr<TEST_Node> test_Node = std::make_unique<TEST_Node>();										// smart pointer (unique)

	// [Document]
	//DKClass::DKCreate("TEST_Document");																		// DKObjectT
	//TEST_Document* test_Document = new TEST_Document();														// pointer
	std::unique_ptr<TEST_Document> test_Document = std::make_unique<TEST_Document>();							// smart pointer (unique)
	
	// [Element]
	//DKClass::DKCreate("TEST_Element");																		// DKObjectT
	//TEST_Element* test_Element = new TEST_Element();															// pointer
	std::unique_ptr<TEST_Element> test_Element = std::make_unique<TEST_Element>();								// smart pointer (unique)

	// [HTMLCollection]
	//DKClass::DKCreate("TEST_HTMLCollection");																	// DKObjectT
	//TEST_HTMLCollection* test_HTMLCollection = new TEST_HTMLCollection();										// pointer
	std::unique_ptr<TEST_HTMLCollection> test_HTMLCollection = std::make_unique<TEST_HTMLCollection>();			// smart pointer (unique)
	
	// [HTMLElement]
	//DKClass::DKCreate("TEST_HTMLElement");																	// DKObjectT
	//TEST_HTMLElement* test_HTMLElement = new TEST_HTMLElement();												// pointer
	std::unique_ptr<TEST_HTMLElement> test_HTMLElement = std::make_unique<TEST_HTMLElement>();					// smart pointer (unique)
	
	// [HTMLBodyElement]
	//DKClass::DKCreate("TEST_HTMLBodyElement");																// DKObjectT
	//TEST_HTMLBodyElement* test_HTMLBodyElement = new TEST_HTMLBodyElement();									// pointer
	std::unique_ptr<TEST_HTMLBodyElement> test_HTMLBodyElement = std::make_unique<TEST_HTMLBodyElement>();		// smart pointer (unique)
	
	// [HTMLImageElement]
	//DKClass::DKCreate("TEST_HTMLImageElement");																// DKObjectT
	//TEST_HTMLImageElement* test_HTMLImageElement = new TEST_HTMLImageElement();								// pointer
	std::unique_ptr<TEST_HTMLImageElement> test_HTMLImageElement = std::make_unique<TEST_HTMLImageElement>();	// smart pointer (unique)


	////// DigitalKnob //////
	// [DKConsoleWindow]
	/*
	//DKClass::DKCreate("TEST_DKConsoleWindow");																// DKObjectT						// WORKS
	//TEST_DKConsoleWindow* test_DKConsoleWindow = new TEST_DKConsoleWindow();									// pointer							// WORKS		 (dangling pointer)
	//std::unique_ptr<TEST_DKConsoleWindow> test_DKConsoleWindow = std::make_unique<TEST_DKConsoleWindow>();	// smart pointer					// DOES NOT WORK (goes out of scope)
	test_DKConsoleWindow = std::make_unique<TEST_DKConsoleWindow>();											// smart pointer member variable	// WORKS
	//test_DKConsoleWindow = std::make_shared<TEST_DKConsoleWindow>();											// smart pointer member variable	// WORKS
	//std::make_unique<TEST_DKConsoleWindow>();																	// smart pointer without variable	// DOES NOT WORK (goes out of scope)
	//std::make_shared<TEST_DKConsoleWindow>();
	*/
	
	
	// [DKSdlWindow]
	//DKClass::DKCreate("TEST_DKSdlWindow");																	// DKObjectT						// WORKS
	//TEST_DKSdlWindow* test_DKSdlWindow = new TEST_DKSdlWindow();												// pointer							// WORKS		 (dangling pointer)
	//std::unique_ptr<TEST_DKSdlWindow> test_DKSdlWindow = std::make_unique<TEST_DKSdlWindow>();				// smart pointer					// DOES NOT WORK (goes out of scope)
	test_DKSdlWindow = std::make_unique<TEST_DKSdlWindow>();													// smart pointer member variable	// WORKS
	//std::make_unique<TEST_DKSdlWindow>();																		// smart pointer without variable	// DOES NOT WORK (goes out of scope)
	
	
	// [DKRmlInterface]
	test_DKRmlInterface = std::make_unique<TEST_DKRmlInterface>();
	
	// [DKRmlEventTarget]
	test_DKRmlEventTarget = std::make_unique<TEST_DKRmlEventTarget>();
	
	// [DKRmlLocation]
	test_DKRmlLocation = std::make_unique<TEST_DKRmlLocation>();
	
	// [DKRmlNode]
	test_DKRmlNode = std::make_unique<TEST_DKRmlNode>();
	
	// [DKRmlDocument]
	test_DKRmlDocument = std::make_unique<TEST_DKRmlDocument>();

	// [DKRmlElement]
	//test_DKRmlElement = std::make_unique<TEST_DKRmlElement>();
	
	return true;
}

bool App::End(){
	DKDEBUGFUNC();
	return true;
}
