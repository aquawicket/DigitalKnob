// [IDL] https://dom.spec.whatwg.org/#callbackdef-eventlistener
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventListener
#pragma once
#ifndef DKRmlEventListener_H
#define DKRmlEventListener_H


#include "DKEventListener/DKEventListener.h"
#include "DKRmlInterface/DKRmlInterface.h"

#include "DKMouseEvent/DKMouseEvent.h"
//#include "DKRmlElement/DKRmlElement.h"


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// callback interface EventListener {
class DKRmlEventListener : virtual public DKEventListener, public Rml::EventListener
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
	
	// Rml::EventListener::ProcessEvent override
	void ProcessEvent(Rml::Event& rmlEvent) override {
		DKINFO("DKRmlEventListener::ProcessEvent() \n");
		
		DKString type = rmlEvent.GetType();
		//Rml::Element* currentElement = rmlEvent.GetCurrentElement();
		
		// TODO
		if (same(type, "click")) {
			DKINFO("click!\n");
			DKMouseEvent click_event("click", "");
			//DKRmlElement* dkRmlElement = DKRmlElement::instance(this, currentElement);
			//dkRmlElement->dispatchEvent(click_event);
		}
	}
};



#endif //DKRmlEventListener_H