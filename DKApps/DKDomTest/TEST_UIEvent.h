// [IDL] https://w3c.github.io/uievents/#idl-uievent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent
#pragma once
#ifndef TEST_UIEvent_H
#define TEST_UIEvent_H

#include "DKUIEvent/DKUIEvent.h"


class TEST_UIEvent //: public DKObjectT<TEST_UIEvent>
{
public:
	TEST_UIEvent(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_UIEvent.h //////");
		
		DKEventTarget eventTarget;
		eventTarget.addEventListener("uievent", &TEST_UIEvent::onuievent);
		DKUIEvent uievent("uievent", "");
		eventTarget.dispatchEvent(uievent);
	}
	
	static void printUIEventProperties(DKUIEvent& uievent){
		DKDEBUGFUNC(uievent);
		
		// constructor(DOMString type, optional UIEventInit eventInitDict = {});
		// function
		
		// readonly attribute Window? view;
		console.log("uievent.view() = "							+toString(uievent.view()));
		
		// readonly attribute long detail;
		console.log("uievent.detail() = "						+toString(uievent.detail()));
		
		// Source: Input Device Capabilities (https://wicg.github.io/input-device-capabilities/)
		// partial interface UIEvent {
		// 		readonly attribute InputDeviceCapabilities? sourceCapabilities;
				console.log("uievent.sourceCapabilities() = "	+toString(uievent.sourceCapabilities()));
		// };
		
		// Source: UI Events (https://www.w3.org/TR/uievents/)
		// partial interface UIEvent {
		// 		Deprecated in this specification
		//		undefined initUIEvent(DOMString typeArg, optional boolean bubblesArg = false, optional boolean cancelableArg = false, optional Window? viewArg = null, optional long detailArg = 0);
				// function
		//	};
	
		// Source: UI Events (https://www.w3.org/TR/uievents/)
		// partial interface UIEvent {
		//		The following support legacy user agents
		//		readonly attribute unsigned long which;
				console.log("uievent.which() = "					+toString(uievent.which()));
		// };
		
		TEST_Event::printEventProperties(dynamic_cast<DKEvent&>(uievent));	//TODO: try to remove the need for dynamic_cast
	}
	
	static bool onuievent(DKEvent& event){
		DKDEBUGFUNC(event);
		console.log("\nTEST_UIEvent::onuievent()");
		printUIEventProperties(dynamic_cast<DKUIEvent&>(event));			//TODO: try to remove the need for dynamic_cast
		return true;
	}
};
//REGISTER_OBJECT(TEST_UIEvent, true);


#endif //TEST_UIEvent_H