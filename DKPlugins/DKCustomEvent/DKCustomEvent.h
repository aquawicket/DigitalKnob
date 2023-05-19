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
	DKCustomEvent(DOMString type, CustomEventInit eventInitDict) : DKEvent(type, eventInitDict) { // https://dom.spec.whatwg.org/#dom-customevent-customevent
		DKDEBUGFUNC(type, eventInitDict);
		interfaceName = "CustomEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKCustomEvent("+interfaceAddress+") \n");
	}
	virtual ~DKCustomEvent(){}
	
	// readonly attribute any detail;
	DKString _detail = "{}";	// https://dom.spec.whatwg.org/#dom-customevent-detail
	virtual DKString	detail()						{ return _detail; }		// getter
	virtual void 		detail(const DKString& detail) 	{ _detail = detail; }	// setter

	// undefined initCustomEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false, optional any detail = null); // legacy
	void initCustomEvent(DOMString& type, bool& bubbles, bool& cancelable, DKString& detail){	// https://dom.spec.whatwg.org/#dom-customevent-initcustomevent
		DKDEBUGFUNC(type, bubbles, cancelable, detail);
		DKTODO();
	}
};


#endif //DKCustomEvent_H