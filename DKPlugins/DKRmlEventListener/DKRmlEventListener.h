// [IDL] https://dom.spec.whatwg.org/#callbackdef-eventlistener
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventListener
#pragma once
#ifndef DKRmlEventListener_H
#define DKRmlEventListener_H

#include "DKEventListener/DKEventListener.h"
#include "DKRmlInterface/DKRmlInterface.h"


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
	
	// undefined handleEvent(Event event);
	const void handleEvent(DKEvent& event) override {
		DKDEBUGFUNC(event);
		DKTODO();
	}
	
	// Rml::EventListener::ProcessEvent override
	void ProcessEvent(Rml::Event& rmlEvent) override;
};


#endif //DKRmlEventListener_H