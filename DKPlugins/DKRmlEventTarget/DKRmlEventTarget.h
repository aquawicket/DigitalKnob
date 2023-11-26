// [IDL] https://dom.spec.whatwg.org/#interface-eventtarget
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
#pragma once
#ifndef DKRmlEventTarget_H
#define DKRmlEventTarget_H

#include "DKEventTarget/DKEventTarget.h"
#include "DKRmlEventListener/DKRmlEventListener.h"

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface EventTarget {
class DKRmlEventTarget : virtual public DKEventTarget
{
public:
	DKRmlEventListener* _dkRmlEventListener;
	Rml::Element* _rmlElement;
	
	// constructor();
	DKRmlEventTarget(DKRmlEventListener* dkRmlEventListener, Rml::Element* rmlElement) : DKEventTarget() {
		DKDEBUGFUNC(dkRmlEventListener, rmlElement);
		DKASSERT(dkRmlEventListener);
		DKASSERT(rmlElement);
		
		interfaceName = "RmlEventTarget";
		address[interfaceName] = pointerToAddress(this);
		DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
		
		_dkRmlEventListener = dkRmlEventListener;
		_rmlElement = rmlElement;
	}

	// undefined addEventListener(DOMString type, EventListener? callback, optional (AddEventListenerOptions or boolean) options = {});
	void addEventListener(const DOMString& type, DKCallback callback) override {
		DKDEBUGFUNC(type, callback);
		_rmlElement->AddEventListener(type, _dkRmlEventListener, false);
		DKEventTarget::addEventListener(type, callback);
	}
	
	// undefined removeEventListener(DOMString type, EventListener? callback, optional (EventListenerOptions or boolean) options = {});
	void removeEventListener(const DOMString& type, DKCallback callback) override {
		DKDEBUGFUNC(type, callback);
		_rmlElement->RemoveEventListener(type, _dkRmlEventListener, false);
		DKEventTarget::removeEventListener(type, callback);
	}
	
	// boolean dispatchEvent(Event event);
	bool dispatchEvent(DKEvent* event) override {
		DKDEBUGFUNC(event);
		DKASSERT(event);
		
		//_rmlElement->DispatchEvent(event->type(), Rml::Dictionary());
		DKEventTarget::dispatchEvent(event);
		return false;
	}
	
	/*
	bool onEvent() {
		
	}
	*/
};


#endif //DKEventTarget_H