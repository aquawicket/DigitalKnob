// [IDL] https://dom.spec.whatwg.org/#interface-eventtarget
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
#pragma once
#ifndef DKRmlEventTarget_H
#define DKRmlEventTarget_H

#include "DKEventTarget/DKEventTarget.h"

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface EventTarget {
class DKRmlEventTarget : public DKEventTarget
{
public:

	// constructor();
	DKRmlEventTarget() : DKEventTarget() {
		DKDEBUGFUNC();
		interfaceName = "DKRmlEventTarget";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKRmlEventTarget("+interfaceAddress+") \n");
	}
	virtual ~DKRmlEventTarget(){}

	// undefined addEventListener(DOMString type, EventListener? callback, optional (AddEventListenerOptions or boolean) options = {});
	virtual void addEventListener(const DOMString& type, DKEventListener callback) override {
		DKDEBUGFUNC(type, callback);
		DKTODO();
	}
	
	// undefined removeEventListener(DOMString type, EventListener? callback, optional (EventListenerOptions or boolean) options = {});
	virtual void removeEventListener(const DOMString& type, DKEventListener callback) override {
		DKDEBUGFUNC(type, callback);
		DKTODO();
	}
	
	// boolean dispatchEvent(Event event);
	virtual bool dispatchEvent(DKEvent& event) override {
		DKDEBUGFUNC(event);
		DKTODO();
		return false;
	}
};


#endif //DKEventTarget_H