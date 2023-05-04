// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/CustomEvent.idl
// [SOURCE] https://dom.spec.whatwg.org/#interface-customevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent
#pragma once
#ifndef DKCustomEvent_H
#define DKCustomEvent_H

#include "DKEvent/DKEvent.h"

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface CustomEvent : Event {
class DKCustomEvent : public DKEvent
{
public:
	// constructor(DOMString type, optional CustomEventInit eventInitDict = {});
	DKCustomEvent(DKString _type, DKString _options) : DKEvent(_type, _options) { // [CustomEvent()] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent/CustomEvent
		DKINFO("DKCustomEvent("+_type+", "+_options+") \n");
		
		eventClass = "CustomEvent";
		eventAddress = pointerToAddress(this);
	}
	
	// readonly attribute any detail;
	DKString detail = "{}";	// [CustomEvent.detail](Read only) https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent/detail

	// undefined initCustomEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false, optional any detail = null); // legacy
	void initCustomEvent(){	// [CustomEvent.initCustomEvent()](Deprecated)
		DKDEPRECATED();
	}
};


#endif //DKCustomEvent_H