// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/InputEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-inputevents
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
	DKInputEvent(DKString _type, DKString _eventInitDict) : DKUIEvent(_type, _eventInitDict) { // [InputEvent()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/InputEvent
		DKDEBUGFUNC(_type, _eventInitDict);
		interfaceName = "InputEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKInputEvent("+interfaceAddress+") \n");
	}
	virtual ~DKInputEvent(){}
	
	// readonly attribute DOMString? data;
	DKString data = ""; // [InputEvent.data](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/data
	
	//readonly attribute boolean isComposing;
	bool isComposing = false; // [InputEvent.isComposing](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/isComposing
	
	//readonly attribute DOMString inputType;
	DKString inputType = ""; // [InputEvent.inputType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/inputType
	
	// Source: Input Events Level 2 (https://www.w3.org/TR/input-events-2/)
	// partial interface InputEvent {
	//    	readonly attribute DataTransfer? dataTransfer;
			DKString dataTransfer = ""; // [InputEvent.dataTransfer](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/dataTransfer
	//    	sequence<StaticRange> getTargetRanges();
			void getTargetRanges() { // [InputEvent.getTargetRanges()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/getTargetRanges
				DKTODO();
			}
	// };
};


#endif //DKInputEvent_H