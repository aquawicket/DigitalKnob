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
	std::unique_ptr<TEST_Console> test_Console = std::make_unique<TEST_Console>();
	
	// [Event]
	std::unique_ptr<TEST_Event> test_Event = std::make_unique<TEST_Event>();
	
	// [EventTarget]
	std::unique_ptr<TEST_EventTarget> test_EventTarget = std::make_unique<TEST_EventTarget>();
	
	// [CustomEvent]
	std::unique_ptr<TEST_CustomEvent> test_CustomEvent = std::make_unique<TEST_CustomEvent>();
	
	// [Screen]
	std::unique_ptr<TEST_Screen> test_Screen = std::make_unique<TEST_Screen>();
	
	// [Window]
	std::unique_ptr<TEST_Window> test_Window = std::make_unique<TEST_Window>();
	
	// [UIEvent]
	std::unique_ptr<TEST_UIEvent> test_UIEvent = std::make_unique<TEST_UIEvent>();

	// [FocusEvent]
	std::unique_ptr<TEST_FocusEvent> test_FocusEvent = std::make_unique<TEST_FocusEvent>();

	// [MouseEvent]
	std::unique_ptr<TEST_MouseEvent> test_MouseEvent = std::make_unique<TEST_MouseEvent>();

	// [WheelEvent]
	std::unique_ptr<TEST_WheelEvent> test_WheelEvent = std::make_unique<TEST_WheelEvent>();
	
	// [InputEvent]
	std::unique_ptr<TEST_InputEvent> test_InputEvent = std::make_unique<TEST_InputEvent>();

	// [KeyboardEvent]
	std::unique_ptr<TEST_KeyboardEvent> test_KeyboardEvent = std::make_unique<TEST_KeyboardEvent>();

	// [CompositionEvent]
	std::unique_ptr<TEST_CompositionEvent> test_CompositionEvent = std::make_unique<TEST_CompositionEvent>();
	
	// [DragEvent]
	std::unique_ptr<TEST_DragEvent> test_DragEvent = std::make_unique<TEST_DragEvent>();

	// [Navigator]
	std::unique_ptr<TEST_Navigator> test_Navigator = std::make_unique<TEST_Navigator>();

	// [URL]
	std::unique_ptr<TEST_URL> test_URL = std::make_unique<TEST_URL>();
	
	// [Location]
	std::unique_ptr<TEST_Location> test_Location = std::make_unique<TEST_Location>();
	
	// [CSSStyleDeclaration]
	std::unique_ptr<TEST_CSSStyleDeclaration> test_CSSStyleDeclaration = std::make_unique<TEST_CSSStyleDeclaration>();

	// [Node]
	std::unique_ptr<TEST_Node> test_Node = std::make_unique<TEST_Node>();
	
	// [NonElementParentNode]
	//std::unique_ptr<TEST_NonElementParentNode> test_NonElementParentNode = std::make_unique<TEST_NonElementParentNode>();		// Mixin
	
	// [Document]
	std::unique_ptr<TEST_Document> test_Document = std::make_unique<TEST_Document>();
	
	// [Element]
	std::unique_ptr<TEST_Element> test_Element = std::make_unique<TEST_Element>();

	// [HTMLCollection]
	std::unique_ptr<TEST_HTMLCollection> test_HTMLCollection = std::make_unique<TEST_HTMLCollection>();
	
	// [HTMLElement]
	//std::unique_ptr<TEST_ElementCSSInlineStyle> test_ElementCSSInlineStyle = std::make_unique<TEST_ElementCSSInlineStyle>();	// Mixin
	
	// [HTMLElement]
	std::unique_ptr<TEST_HTMLElement> test_HTMLElement = std::make_unique<TEST_HTMLElement>();
	
	// [HTMLBodyElement]
	std::unique_ptr<TEST_HTMLBodyElement> test_HTMLBodyElement = std::make_unique<TEST_HTMLBodyElement>();
	
	// [HTMLImageElement]
	std::unique_ptr<TEST_HTMLImageElement> test_HTMLImageElement = std::make_unique<TEST_HTMLImageElement>();


	////// DigitalKnob //////
	// [DKConsoleWindow]
	test_DKConsoleWindow = std::make_unique<TEST_DKConsoleWindow>();										
	
	// [DKSdlWindow]
	test_DKSdlWindow = std::make_unique<TEST_DKSdlWindow>();

	// [DKSdlRmlDocument]
	//test_DKSdlRmlDocument = std::make_unique<TEST_DKSdlRmlDocument>();														// Mixin
	
	// [DKRmlInterface]
	test_DKRmlInterface = std::make_unique<TEST_DKRmlInterface>();
	
	// [DKRmlEventTarget]
	test_DKRmlEventTarget = std::make_unique<TEST_DKRmlEventTarget>();
	
	// [DKRmlLocation]
	test_DKRmlLocation = std::make_unique<TEST_DKRmlLocation>();
	
	// [DKRmlNode]
	//test_DKRmlNode = std::make_unique<TEST_DKRmlNode>();
	
	// [DKRmlDocument]
	//test_DKRmlDocument = std::make_unique<TEST_DKRmlDocument>();

	// [DKRmlElement]
	//test_DKRmlElement = std::make_unique<TEST_DKRmlElement>();
	
	return true;
}

bool App::End(){
	DKDEBUGFUNC();
	return true;
}
