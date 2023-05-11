// [IDL] https://w3c.github.io/uievents/#idl-wheelevent
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
	DKWheelEvent(DKString _type, DKString _eventInitDict) : DKMouseEvent(_type, _eventInitDict) {
		DKDEBUGFUNC(_type, _eventInitDict);
		interfaceName = "WheelEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKWheelEvent("+interfaceAddress+") \n");
	}
	virtual ~DKWheelEvent(){}
	
	// DeltaModeCode
	
	// const unsigned long DOM_DELTA_PIXEL = 0x00;
	const unsigned int DOM_DELTA_PIXEL = 0x00;
	
	// const unsigned long DOM_DELTA_LINE  = 0x01;
	const unsigned int DOM_DELTA_LINE  = 0x01;
	
	// const unsigned long DOM_DELTA_PAGE  = 0x02;
	const unsigned int DOM_DELTA_PAGE  = 0x02;
	
	// readonly attribute double deltaX;
	double deltaX = 0.0; 
	
	// readonly attribute double deltaY;
	double deltaY = 0.0;
	
	// readonly attribute double deltaZ;
	double deltaZ = 0.0;
	
	// readonly attribute unsigned long deltaMode;
	unsigned int deltaMode = 0;
};


#endif //DKWheelEvent_H