// [IDL] https://w3c.github.io/uievents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent
#pragma once
#ifndef DKUIEvent_H
#define DKUIEvent_H

#include "DKEvent/DKEvent.h"


class DKUIEvent : public DKEvent
{
public:
	////// Constructor //////
	// [UIEvent()] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/UIEvent
	DKUIEvent(DKString _type, DKString _options) : DKEvent(_type, _options) {
		DKINFO("DKUIEvent("+_type+", "+_options+") \n");
		
		eventClass = "UIEvent";
		eventAddress = pointerToAddress(this);
		
		////// Instance properties //////
		detail = 0;
		sourceCapabilities = "";
		view = "";
		which = 0;
	}
	
	
	////// Instance properties //////
	// [UIEvent.detail](Read only) https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail
	unsigned int detail;
	// [UIEvent.sourceCapabilities](Experimental)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/sourceCapabilities
	DKString sourceCapabilities;
	// [UIEvent.view](Read only) https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/view
	DKString view;
	// [UIEvent.which](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/which
	unsigned int which;
	
	
	////// Instance methods //////
	// [UIEvent.initUIEvent()](Deprecated)
	void initUIEvent(){
		DKDEPRECATED();
	}
	
	
	////// Events //////
	// [abort] https://w3c.github.io/uievents/#event-type-abort
	// [error] https://w3c.github.io/uievents/#event-type-error
	// [load] https://w3c.github.io/uievents/#event-type-load
	// [select] https://w3c.github.io/uievents/#event-type-select
	// [unload] https://w3c.github.io/uievents/#event-type-unload
};


#endif //DKUIEvent_H