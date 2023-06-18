// [IDL] https://dom.spec.whatwg.org/#interface-eventtarget
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
#pragma once
#ifndef DKRmlEventTarget_H
#define DKRmlEventTarget_H

#include "DKEventTarget/DKEventTarget.h"
#include "DKRmlInterface/DKRmlInterface.h"

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface EventTarget {
class DKRmlEventTarget : virtual public DKEventTarget
{
public:
	DKRmlInterface* _dkRmlInterface;
	Rml::Element* _rmlElement;
	
	// constructor();
	DKRmlEventTarget(DKRmlInterface* dkRmlInterface, Rml::Element* rmlElement) : DKEventTarget() {
		DKDEBUGFUNC();
		interfaceName = "DKRmlEventTarget";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKRmlEventTarget("+interfaceAddress+") \n");
		_dkRmlInterface = dkRmlInterface;
		_rmlElement = rmlElement;
		
		if(!_rmlElement)
			DKERROR("_rmlElement invalid! \n");
	}
	~DKRmlEventTarget(){}

	// undefined addEventListener(DOMString type, EventListener? callback, optional (AddEventListenerOptions or boolean) options = {});
	const void addEventListener(const DOMString& type, DKCallback callback) override {
		DKDEBUGFUNC(type, callback);
		DKTODO();
		_rmlElement->AddEventListener(type, _dkRmlInterface, false);
		DKEventTarget::addEventListener(type, callback);
		DKTODO();
	}
	
	// undefined removeEventListener(DOMString type, EventListener? callback, optional (EventListenerOptions or boolean) options = {});
	void removeEventListener(const DOMString& type, DKCallback callback) override {
		DKDEBUGFUNC(type, callback);
		DKTODO();
		_rmlElement->RemoveEventListener(type, _dkRmlInterface, false);
		DKEventTarget::removeEventListener(type, callback);
		DKTODO();
	}
	
	// boolean dispatchEvent(Event event);
	bool dispatchEvent(DKEvent& event) override {
		DKDEBUGFUNC(event);
		DKTODO();
		//_rmlElement->DispatchEvent(event.type(), Rml::Dictionary());
		DKEventTarget::dispatchEvent(event);
		return false;
	}
	
	bool onEvent() {

	}

	////// toString //////
	operator std::string() const { return "[object DKRmlEventTarget]"; }
};


#endif //DKEventTarget_H