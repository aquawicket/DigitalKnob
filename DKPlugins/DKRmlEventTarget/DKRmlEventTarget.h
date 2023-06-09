// [IDL] https://dom.spec.whatwg.org/#interface-eventtarget
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
#pragma once
#ifndef DKRmlEventTarget_H
#define DKRmlEventTarget_H

#include "DKEventTarget/DKEventTarget.h"

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface EventTarget {
class DKRMLEventTarget : public DKEventTarget
{
public:

	// constructor();
	DKRmlEventTarget() : DKEventTarget() {
		DKDEBUGFUNC();
		interfaceName = "RmlEventTarget";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKRmlEventTarget("+interfaceAddress+") \n");
	}
	virtual ~DKRmlEventTarget(){}

	// undefined addEventListener(DOMString type, EventListener? callback, optional (AddEventListenerOptions or boolean) options = {});
	// TODO
	
	// undefined removeEventListener(DOMString type, EventListener? callback, optional (EventListenerOptions or boolean) options = {});
	// TODO
	
	// boolean dispatchEvent(Event event);
	// TODO
	
	////// DK properties //////	
	//static std::vector<EventObject> events;	// TODO
};


#endif //DKEventTarget_H