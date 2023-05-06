// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/CompositionEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-compositionevents
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
		DKINFO("DKCompositionEvent("+_type+", "+_eventInitDict+") \n");
		
		interfaceNamw = "CompositionEvent";
		interfaceAddress = pointerToAddress(this);
	}
	
	// readonly attribute DOMString data;
	DKString data = ""; // [CompositionEvent.data](Read only) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/data
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface CompositionEvent {
	//		// Originally introduced (and deprecated) in this specification
	//		undefined initCompositionEvent(DOMString typeArg,
	//		optional boolean bubblesArg = false,
	//		optional boolean cancelableArg = false,
	//		optional WindowProxy? viewArg = null,
	//		optional DOMString dataArg = "");
			void initCompositionEvent() { // [CompositionEvent.initCompositionEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/initCompositionEvent
				DKTODO();
			}
	// };
};


#endif //DKCompositionEvent_H