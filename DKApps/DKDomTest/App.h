#pragma once
#ifndef App_H
#define App_H

#include "DK/DK.h"

#include "TEST_Console.h"
#include "TEST_Event.h"
#include "TEST_EventTarget.h"
#include "TEST_CustomEvent.h"
#include "TEST_UIEvent.h"
#include "TEST_FocusEvent.h"
#include "TEST_MouseEvent.h"
#include "TEST_WheelEvent.h"
#include "TEST_InputEvent.h"
#include "TEST_KeyboardEvent.h"
#include "TEST_CompositionEvent.h"
#include "TEST_DragEvent.h"
#include "TEST_Screen.h"
#include "TEST_Window.h"
#include "TEST_Navigator.h"
#include "TEST_Location.h"
#include "TEST_Node.h"
#include "TEST_Document.h"
#include "TEST_Element.h"
#include "TEST_HTMLCollection.h"
#include "TEST_HTMLElement.h"
#include "TEST_HTMLBodyElement.h"
#include "TEST_HTMLImageElement.h"

////// DigitalKnob //////
#include "TEST_DKConsoleWindow.h"
#include "TEST_DKSdlWindow.h"

#include "TEST_DKRmlDocument.h"
//#include "TEST_DKRmlNode.h"


class App : public DKObjectT<App>
{
public:
	bool Init();
	bool End();

	std::unique_ptr<TEST_DKConsoleWindow> 	test_DKConsoleWindow;
	//std::shared_ptr<TEST_DKConsoleWindow> test_DKConsoleWindow;
	
	std::unique_ptr<TEST_DKSdlWindow> 		test_DKSdlWindow;
	std::unique_ptr<TEST_DKRmlDocument>		test_DKRmlDocument;
	std::unique_ptr<TEST_DKRmlLocation> 	test_DKRmlLocation;
};
REGISTER_OBJECT(App, true);


#endif //App_H