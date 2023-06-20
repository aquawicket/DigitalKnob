// [IDL] https://w3c.github.io/uievents/#idl-focusevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent
#pragma once
#ifndef DKFocusEvent_H
#define DKFocusEvent_H

#include "DKUIEvent/DKUIEvent.h"

////// FocusEventInit //////
typedef std::string FocusEventInit;


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface FocusEvent : UIEvent {
class DKFocusEvent : public DKUIEvent
{
public:
	// constructor(DOMString type, optional FocusEventInit eventInitDict = {});
	DKFocusEvent(const DOMString& type, const FocusEventInit& eventInitDict = "{}") : DKUIEvent(type, eventInitDict) { // https://w3c.github.io/uievents/#dom-focusevent-focusevent
		DKDEBUGFUNC(type, eventInitDict);
		interfaceName = "FocusEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKFocusEvent("+interfaceAddress+") \n");
	}
	virtual ~DKFocusEvent(){}
	
	// readonly attribute EventTarget? relatedTarget;
	DKEventTarget* _relatedTarget = NULL;
	virtual DKEventTarget& 	relatedTarget()									{ return _relatedTarget ? *_relatedTarget : *new DKNullEventTarget(); }	// getter
	virtual void 			relatedTarget(DKEventTarget& relatedTarget) 	{ _relatedTarget = &relatedTarget; } 									// setter
	
	
	////// toString //////
	operator std::string() const { return "[object FocusEvent]"; }
};


#endif //DKFocusEvent_H