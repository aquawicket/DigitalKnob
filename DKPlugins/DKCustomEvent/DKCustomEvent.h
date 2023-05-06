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
	DKCustomEvent(DKString _type, DKString _eventInitDict) : DKEvent(_type, _eventInitDict) {
		DKDEBUGFUNC(_type, _eventInitDict);
		interfaceName = "CustomEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKCustomEvent("+interfaceAddress+") \n");
	}
	virtual ~DKCustomEvent(){}
	
	// readonly attribute any detail;
	DKString detail = "{}";	// https://dom.spec.whatwg.org/#dom-customevent-detail

	// undefined initCustomEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false, optional any detail = null); // legacy
	void initCustomEvent(){	// https://dom.spec.whatwg.org/#dom-customevent-initcustomevent
		DKDEPRECATED();
	}
};


#endif //DKCustomEvent_H