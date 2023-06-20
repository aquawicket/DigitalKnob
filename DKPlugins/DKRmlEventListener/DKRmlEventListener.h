// [IDL] https://dom.spec.whatwg.org/#callbackdef-eventlistener
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventListener
#pragma once
#ifndef DKRmlEventListener_H
#define DKRmlEventListener_H

//#include "DKEventListener/DKEventListener.h"

//typedef std::function<void(DKEvent&)> DKCallback;


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// callback interface EventListener {
class DKRmlEventListener : public Rml::EventListener //: virtual public DKEventListener
{
public:
	DKRmlEventListener() {//: DKEventListener() {
		DKDEBUGFUNC();
		/*
		interfaceName = "RmlEventListener";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKRmlEventListener("+interfaceAddress+") \n");
		*/
	}
	virtual ~DKRmlEventListener(){}
	
	// undefined handleEvent(Event event);
	virtual const void handleEvent(DKEvent& event) {
		DKDEBUGFUNC(event);
		DKTODO();
	}
	
// };

	/*
	////// DK properties //////
	DKString interfaceAddress;
	DKEventTarget* dkEventTarget;
	DOMString type;
	DKCallback callback;
	*/
	
	////// toString //////
	//virtual operator std::string() const { return "[object RmlEventListener]"; }
};



#endif //DKRmlEventListener_H