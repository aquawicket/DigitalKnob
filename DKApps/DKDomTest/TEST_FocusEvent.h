// [IDL] https://w3c.github.io/uievents/#events-focusevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent
#pragma once
#ifndef TEST_FocusEvent_H
#define TEST_FocusEvent_H

#include "DK/DK.h"
#include "DKFocusEvent/DKFocusEvent.h"


class TEST_FocusEvent : public DKObjectT<TEST_FocusEvent>
{
public:
	bool Init(){
		DKINFO("////// TEST_FocusEvent.h ////// \n");
		
		////// Constructor //////
		// [FocusEvent()] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent/FocusEvent
		
		
		////// Instance properties //////
		// [FocusEvent.relatedTarget] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent/relatedTarget
	
	
		////// Events //////
		// [blur] https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event
		// [focus] https://developer.mozilla.org/en-US/docs/Web/API/Element/focus_event
		// [focusin] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusin_event
		// [focusout] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusout_event
	
		return DKTODO();
	}
	
	static void printFocusEventProperties(DKFocusEvent& focusevent){
		DKDEBUGFUNC(focusevent);
		DKTODO();
	}
	
	static bool onfocusevent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_FocusEvent::onfocusevent() \n");
		printFocusEventProperties(dynamic_cast<DKFocusEvent&>(event));			//TODO: try to remove the need for dynamic_cast
		TEST_UIEvent::printUIEventProperties(dynamic_cast<DKUIEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		TEST_Event::printEventProperties(event);
		return true;
	}
};
REGISTER_OBJECT(TEST_FocusEvent, true);


#endif //TEST_FocusEvent_H