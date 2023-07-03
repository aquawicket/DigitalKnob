// [IDL] https://dom.spec.whatwg.org/#callbackdef-eventlistener
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventListener
#pragma once
#ifndef DKEventListener_H
#define DKEventListener_H

#include "DKEvent/DKEvent.h"


typedef std::function<void(DKEvent*)> DKCallback;


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// callback interface EventListener {
class DKEventListener : virtual public DKInterface
{
public:
	DKEventListener() : DKInterface() {
		DKDEBUGFUNC();
		interfaceName = "EventListener";
		address[interfaceName] = pointerToAddress(this);
		DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
	}
	//virtual ~DKEventListener(){}
	
	// undefined handleEvent(Event event);
	virtual const void handleEvent(DKEvent& event) {
		DKDEBUGFUNC(event);
		DKTODO();
	}
	
// };

	////// DK properties //////
	//DKString interfaceAddress;
	DKEventTarget* dkEventTarget;
	DOMString type;
	DKCallback callback;
	
	////// toString //////
	virtual operator std::string() const { return "[object EventListener]"; }
};



#endif //DKEventListener_H