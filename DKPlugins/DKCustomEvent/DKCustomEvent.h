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
	DKCustomEvent(const DOMString& type, const CustomEventInit& eventInitDict = "{}") : DKEvent(type, eventInitDict) {
		DKDEBUGFUNC(type, eventInitDict);
		interfaceName = "CustomEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKCustomEvent("+interfaceAddress+") \n");
	}
	virtual ~DKCustomEvent(){}
	
	// readonly attribute any detail;
	DKString _detail = "{}";
	virtual const DKString&		detail()						{ return _detail; }		// getter
	virtual void 				detail(const DKString& detail) 	{ _detail = detail; }	// setter

	// undefined initCustomEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false, optional any detail = null); // legacy
	virtual void initCustomEvent(const DOMString& type, const bool& bubbles, const bool& cancelable, const DKString& detail){
		DKDEBUGFUNC(type, bubbles, cancelable, detail);
		DKTODO();
	}
	
	////// toString //////
	operator std::string() const { return "[object CustomEvent]"; }	
};


#endif //DKCustomEvent_H