#pragma once
#ifndef DKCustomEvent_H
#define DKCustomEvent_H

#include "DKEvent/DKEvent.h"


// [IDL] https://dom.spec.whatwg.org/#interface-customevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent
class DKCustomEvent : public DKEvent
{
public:
	////// Constructor //////
	// [CustomEvent()] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent/CustomEvent
	DKCustomEvent(DKString _type, DKString _options) : DKEvent(_type, _options) {
		DKINFO("DKCustomEvent("+_type+", "+_options+") \n");
		
		eventClass = "CustomEvent";
		eventAddress = pointerToAddress(this);
		
		////// Instance properties //////
		detail = "{}";
	}
	
	
	////// Instance properties //////
	// [CustomEvent.detail](Read only) https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent/detail
	DKString detail;

	
	////// Instance methods //////
	// [CustomEvent.initCustomEvent()](Deprecated)
	void initCustomEvent(){
		DKDEPRECATED();
	}
};


#endif //DKCustomEvent_H