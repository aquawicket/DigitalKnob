#include "DKRmlEventListener/DKRmlEventListener.h"
#include "DKRmlElement/DKRmlElement.h"
#include "DKMouseEvent/DKMouseEvent.h"

// Rml::EventListener::ProcessEvent override
void DKRmlEventListener::ProcessEvent(Rml::Event& rmlEvent) {
	DKINFO("DKRmlEventListener::ProcessEvent() \n");
	
	DKString type = rmlEvent.GetType();
	Rml::Element* currentElement = rmlEvent.GetCurrentElement();
		
	if (same(type, "click")) {
		DKMouseEvent click_event("click", "");
		DKRmlElement* dkRmlElement = DKRmlElement::instance(this, currentElement);
		dkRmlElement->dispatchEvent(click_event);
	}
}