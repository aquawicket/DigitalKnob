#pragma once
#ifndef App_H
#define App_H

#include "DK/DK.h"

// FIXME: Get the hierarchy in the right order

////// Standard Interfaces //////
//#include "TEST_Interface.h"					// TODO
#include "TEST_Console.h"
#include "TEST_Event.h"
#include "TEST_EventListener.h"
#include "TEST_EventTarget.h"
#include "TEST_CustomEvent.h"
#include "TEST_Screen.h"
#include "TEST_Window.h"
#include "TEST_UIEvent.h"
#include "TEST_FocusEvent.h"
#include "TEST_MouseEvent.h"
#include "TEST_WheelEvent.h"
#include "TEST_InputEvent.h"
#include "TEST_KeyboardEvent.h"
#include "TEST_CompositionEvent.h"
#include "TEST_DragEvent.h"

#include "TEST_Navigator.h"
#include "TEST_URL.h"
#include "TEST_Location.h"
#include "TEST_CSSStyleDeclaration.h"
#include "TEST_Node.h"
//#include "TEST_NonElementParentNode.h"		// Mixin	// TODO
#include "TEST_Document.h"
#include "TEST_Element.h"
#include "TEST_HTMLCollection.h"
//#include "TEST_ElementCSSInlineStyle.h"		// Mixin	// TODO
#include "TEST_HTMLElement.h"
#include "TEST_HTMLBodyElement.h"
#include "TEST_HTMLImageElement.h"


////// DigitalKnob Interfaces //////
#include "TEST_DKConsoleWindow.h"
#include "TEST_DKSDLWindow.h"

//#include "TEST_DKSdlRmlDocument.h"			// Mixin	// TODO
#include "TEST_DKRmlInterface.h"
#include "TEST_DKRmlEventListener.h"
#include "TEST_DKRmlEventTarget.h"
#include "TEST_DKRmlLocation.h"
#include "TEST_DKRmlCSSStyleDeclaration.h"
#include "TEST_DKRmlNode.h"
//#include "TEST_DKRmlElementCSSInlineStyle.h"	// Mixin	// TODO
#include "TEST_DKRmlElement.h"
#include "TEST_DKRmlDocument.h"
#include "TEST_DKRmlHTMLElement.h"


////// DigitalKnob Tests //////
#include "TEST_Browser.h"
#include "TEST_Multiple.h"


class App : public DKObjectT<App>
{
public:
	bool Init();
	bool End();
	
	////// DigitalKnob Interfaces //////
	/*
	std::unique_ptr<TEST_DKConsoleWindow> 				test_DKConsoleWindow;
	std::unique_ptr<TEST_DKSDLWindow> 					test_DKSDLWindow;
	
	//std::unique_ptr<TEST_DKSdlRmlDocument> 			test_DKSdlRmlDocument;				// Mixin
	std::unique_ptr<TEST_DKRmlInterface>				test_DKRmlInterface;
	std::unique_ptr<TEST_DKRmlEventListener> 			test_DKRmlEventListener;
	std::unique_ptr<TEST_DKRmlEventTarget> 				test_DKRmlEventTarget;
	std::unique_ptr<TEST_DKRmlLocation> 				test_DKRmlLocation;
	std::unique_ptr<TEST_DKRmlCSSStyleDeclaration>		test_DKRmlCSSStyleDeclaration;
	std::unique_ptr<TEST_DKRmlNode> 					test_DKRmlNode;
	//std::unique_ptr<TEST_DKRmlElementCSSInlineStyle>	test_DKRmlElementCSSInlineStyle;	// Mixin
	std::unique_ptr<TEST_DKRmlElement> 					test_DKRmlElement;
	std::unique_ptr<TEST_DKRmlDocument>					test_DKRmlDocument;
	std::unique_ptr<TEST_DKRmlHTMLElement> 				test_DKRmlHTMLElement;
	*/
	
	
	////// DigitalKnob Tests //////
	std::unique_ptr<TEST_Browser> 						test_Browser;
	//std::unique_ptr<TEST_Multiple> 					test_Multiple;
};
REGISTER_OBJECT(App, true);


#endif //App_H