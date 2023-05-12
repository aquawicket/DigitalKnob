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
		
		DKEventTarget myEventTarget;
		myEventTarget.addEventListener("uievent", &TEST_UIEvent::onuievent);
		DKUIEvent uievent("uievent", "");
		myEventTarget.dispatchEvent(uievent);
		return true;
	}
	
	static void printUIEventProperties(DKUIEvent& uievent){
		DKDEBUGFUNC(uievent);
		DKINFO("uievent.detail = "				+toString(uievent.detail)				+"\n");
		DKINFO("uievent.sourceCapabilities = "	+toString(uievent.sourceCapabilities)	+"\n");
		DKINFO("uievent.view = "				+toString(uievent.view)					+"\n");
		DKINFO("uievent.which = "				+toString(uievent.which)				+"\n");
	}
	
	static bool onuievent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_UIEvent::onuievent() \n");
		printUIEventProperties(dynamic_cast<DKUIEvent&>(event));		//TODO: try to remove the need for dynamic_cast
		TEST_Event::printEventProperties(event);
		return true;
	}
};
REGISTER_OBJECT(TEST_UIEvent, true);


#endif //TEST_UIEvent_H