// [IDL] https://w3c.github.io/uievents/#idl-uievent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent
#pragma once
#ifndef TEST_UIEvent_H
#define TEST_UIEvent_H

#include "DKUIEvent/DKUIEvent.h"


class TEST_UIEvent : public DKObjectT<TEST_UIEvent>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_UIEvent.h ////// \n");
		
		DKEventTarget eventTarget;
		eventTarget.addEventListener("uievent", &TEST_UIEvent::onuievent);
		DKUIEvent uievent("uievent", "");
		eventTarget.dispatchEvent(uievent);
		return true;
	}
	
	static void printUIEventProperties(DKUIEvent& uievent){
		DKDEBUGFUNC(uievent);
		
		// constructor(DOMString type, optional UIEventInit eventInitDict = {});
		// function
		
		// readonly attribute Window? view;
		DKINFO("uievent.view() = "							+toString(uievent.view())				+"\n");
		
		// readonly attribute long detail;
		DKINFO("uievent.detail() = "						+toString(uievent.detail())				+"\n");
		
		// Source: Input Device Capabilities (https://wicg.github.io/input-device-capabilities/)
		// partial interface UIEvent {
		// 		readonly attribute InputDeviceCapabilities? sourceCapabilities;
				DKINFO("uievent.sourceCapabilities() = "	+toString(uievent.sourceCapabilities())	+"\n");
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
				DKINFO("uievent.which() = "					+toString(uievent.which())				+"\n");
		// };
		
		TEST_Event::printEventProperties(dynamic_cast<DKEvent&>(uievent));	//TODO: try to remove the need for dynamic_cast
	}
	
	static bool onuievent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_UIEvent::onuievent() \n");
		printUIEventProperties(dynamic_cast<DKUIEvent&>(event));			//TODO: try to remove the need for dynamic_cast
		return true;
	}
};
REGISTER_OBJECT(TEST_UIEvent, true);


#endif //TEST_UIEvent_H