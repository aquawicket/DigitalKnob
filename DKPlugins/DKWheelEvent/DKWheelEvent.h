// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/WheelEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-wheelevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent
#pragma once
#ifndef DKWheelEvent_H
#define DKWheelEvent_H

#include "DKMouseEvent/DKMouseEvent.h"

// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface WheelEvent : MouseEvent {
class DKWheelEvent : public DKMouseEvent
{
public:
	// constructor(DOMString type, optional WheelEventInit eventInitDict = {});
	DKWheelEvent(DKString _type, DKString _eventInitDict) : DKMouseEvent(_type, _eventInitDict) { // [WheelEvent()] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/WheelEvent
		DKDEBUGFUNC(_type, _eventInitDict);
		interfaceName = "WheelEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKWheelEvent("+interfaceAddress+") \n");
	}
	virtual ~DKWheelEvent(){}
	
	// DeltaModeCode
	// const unsigned long DOM_DELTA_PIXEL = 0x00;
	
	// const unsigned long DOM_DELTA_LINE  = 0x01;
	
	// const unsigned long DOM_DELTA_PAGE  = 0x02;
	
	// readonly attribute double deltaX;
	double deltaX = 0.0; // [WheelEvent.deltaX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaX
	// readonly attribute double deltaY;
	double deltaY = 0.0; // [WheelEvent.deltaY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaY
	// readonly attribute double deltaZ;
	double deltaZ = 0.0; // [WheelEvent.deltaZ](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaZ
	// readonly attribute unsigned long deltaMode;
	unsigned int deltaMode = 0; // [WheelEvent.deltaMode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaMode
};


#endif //DKWheelEvent_H