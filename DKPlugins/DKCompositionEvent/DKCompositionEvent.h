// [IDL] https://w3c.github.io/uievents/#idl-compositionevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent
#pragma once
#ifndef DKCompositionEvent_H
#define DKCompositionEvent_H

#include "DKUIEvent/DKUIEvent.h"

// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface CompositionEvent : UIEvent {
class DKCompositionEvent : public DKUIEvent
{
public:
	// constructor(DOMString type, optional CompositionEventInit eventInitDict = {});
	DKCompositionEvent(DKString _type, DKString _eventInitDict) : DKUIEvent(_type, _eventInitDict) { // [CompositionEvent()] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/CompositionEvent
		DKDEBUGFUNC(_type, _eventInitDict);
		interfaceName = "CompositionEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKCompositionEvent("+interfaceAddress+") \n");
	}
	virtual ~DKCompositionEvent(){}
	
	// readonly attribute DOMString data;
	DKString data = "";
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface CompositionEvent {
	//		// Originally introduced (and deprecated) in this specification
	//		undefined initCompositionEvent(DOMString typeArg,
	//		optional boolean bubblesArg = false,
	//		optional boolean cancelableArg = false,
	//		optional WindowProxy? viewArg = null,
	//		optional DOMString dataArg = "");
			void initCompositionEvent(DKString& _typeArg, bool& _bubblesArg, bool& _cancelableArg, DKString& _viewArg, DKString& _dataArg) {
				DKDEBUGFUNC(_typeArg, _bubblesArg, _cancelableArg, _viewArg, _dataArg);
				DKTODO();
			}
	// };
};


#endif //DKCompositionEvent_H