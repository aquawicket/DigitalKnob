// [IDL] https://w3c.github.io/uievents/#events-compositionevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent
#pragma once
#ifndef DKCompositionEvent_H
#define DKCompositionEvent_H

#include "DKUIEvent/DKUIEvent.h"


class DKCompositionEvent : public DKUIEvent
{
public:
	////// Constructor //////
	// [CompositionEvent()] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/CompositionEvent
	DKCompositionEvent(DKString _type, DKString _options) : DKUIEvent(_type, _options) {
		DKINFO("DKCompositionEvent("+_type+", "+_options+") \n");
		
		eventClass = "CompositionEvent";
		eventAddress = pointerToAddress(this);
	}
	

	////// Instance properties //////
	// [CompositionEvent.data](Read only) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/data
	DKString data = "";
	// [CompositionEvent.locale](Read only)(Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/locale
	DKString locale = "";


	
	////// Instance methods //////
	// [CompositionEvent.initCompositionEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/initCompositionEvent
	void initCompositionEvent() {
		DKTODO();
	}

	
	////// Events //////
	// [compositionstart] https://w3c.github.io/uievents/#event-type-compositionstart
	// [compositionupdate] https://w3c.github.io/uievents/#event-type-compositionupdate
	// [compositionend] https://w3c.github.io/uievents/#event-type-compositionend
};


#endif //DKCompositionEvent_H