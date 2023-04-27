// [IDL] https://w3c.github.io/uievents/#events-focusevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent
#pragma once
#ifndef DKFocusEvent_H
#define DKFocusEvent_H

#include "DKUIEvent/DKUIEvent.h"


class DKFocusEvent : public DKUIEvent
{
public:
	////// Constructor //////
	// [FocusEvent()] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent/FocusEvent
	DKFocusEvent(DKString _type, DKString _options) : DKUIEvent(_type, _options) {
		DKINFO("DKFocusEvent("+_type+", "+_options+") \n");
		
		eventClass = "FocusEvent";
		eventAddress = pointerToAddress(this);
		
		////// Instance properties //////
		relatedTarget = "";
	}
	
	
	////// Instance properties //////
	// [FocusEvent.relatedTarget] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent/relatedTarget
	DKString relatedTarget;

	
	////// Events //////
	// [blur] https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event
	// [focus] https://developer.mozilla.org/en-US/docs/Web/API/Element/focus_event
	// [focusin] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusin_event
	// [focusout] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusout_event
};


#endif //DKFocusEvent_H