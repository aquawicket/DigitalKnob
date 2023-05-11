// [IDL] https://dom.spec.whatwg.org/#interface-customevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent
#pragma once
#ifndef DKCustomEvent_H
#define DKCustomEvent_H

#include "DKEvent/DKEvent.h"

////// CustomEventInit //////
typedef std::string CustomEventInit;


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface CustomEvent : Event {
class DKCustomEvent : public DKEvent
{
public:
	// constructor(DOMString type, optional CustomEventInit eventInitDict = {});
	DKCustomEvent(DOMString _type, CustomEventInit _eventInitDict) : DKEvent(_type, _eventInitDict) { // https://dom.spec.whatwg.org/#dom-customevent-customevent
		DKDEBUGFUNC(_type, _eventInitDict);
		interfaceName = "CustomEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKCustomEvent("+interfaceAddress+") \n");
	}
	virtual ~DKCustomEvent(){}
	
	// readonly attribute any detail;
	DKString detail = "{}";	// https://dom.spec.whatwg.org/#dom-customevent-detail

	// undefined initCustomEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false, optional any detail = null); // legacy
	void initCustomEvent(DOMString& _type, bool& _bubbles, bool& _cancelable, DKString& _detail){	// https://dom.spec.whatwg.org/#dom-customevent-initcustomevent
		DKDEBUGFUNC(_type, _bubbles, _cancelable, _detail);
		DKTODO();
	}
};


#endif //DKCustomEvent_H