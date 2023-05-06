// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/FocusEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-focusevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent
#pragma once
#ifndef DKFocusEvent_H
#define DKFocusEvent_H

#include "DKUIEvent/DKUIEvent.h"

// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface FocusEvent : UIEvent {
class DKFocusEvent : public DKUIEvent
{
public:
	// constructor(DOMString type, optional FocusEventInit eventInitDict = {});
	DKFocusEvent(DKString _type, DKString _eventInitDict) : DKUIEvent(_type, _eventInitDict) { // [FocusEvent()] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent/FocusEvent
		DKDEBUGFUNC(_type, _eventInitDict);
		//DKINFO("DKFocusEvent("+_type+", "+_eventInitDict+") \n");
		interfaceName = "FocusEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKFocusEvent("+interfaceAddress+") \n");
	}
	
	// readonly attribute EventTarget? relatedTarget;
	DKString relatedTarget = ""; // [FocusEvent.relatedTarget] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent/relatedTarget
};


#endif //DKFocusEvent_H