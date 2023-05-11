// [IDL] https://w3c.github.io/uievents/#idl-inputevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent
#pragma once
#ifndef DKInputEvent_H
#define DKInputEvent_H

#include "DKUIEvent/DKUIEvent.h"

// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface InputEvent : UIEvent {
class DKInputEvent : public DKUIEvent
{
public:
	// constructor(DOMString type, optional InputEventInit eventInitDict = {});
	DKInputEvent(DKString _type, DKString _eventInitDict) : DKUIEvent(_type, _eventInitDict) {
		DKDEBUGFUNC(_type, _eventInitDict);
		interfaceName = "InputEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKInputEvent("+interfaceAddress+") \n");
	}
	virtual ~DKInputEvent(){}
	
	// readonly attribute DOMString? data;
	DKString data = "";
	
	//readonly attribute boolean isComposing;
	bool isComposing = false;
	
	//readonly attribute DOMString inputType;
	DKString inputType = "";
	
	// Source: Input Events Level 2 (https://www.w3.org/TR/input-events-2/)
	// partial interface InputEvent {
	//    	readonly attribute DataTransfer? dataTransfer;
			DKString dataTransfer = "";
	//		
	//    	sequence<StaticRange> getTargetRanges();
			void getTargetRanges() {
				DKDEBUGFUNC();
				DKTODO();
			}
	// };
};


#endif //DKInputEvent_H