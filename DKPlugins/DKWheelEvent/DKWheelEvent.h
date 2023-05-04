// [IDL] https://w3c.github.io/uievents/#events-wheelevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent
#pragma once
#ifndef DKWheelEvent_H
#define DKWheelEvent_H

#include "DKMouseEvent/DKMouseEvent.h"


class DKWheelEvent : public DKMouseEvent
{
public:
	////// Constructor //////
	// [WheelEvent()] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/WheelEvent
	DKWheelEvent(DKString _type, DKString _options) : DKMouseEvent(_type, _options) {
		DKINFO("DKWheelEvent("+_type+", "+_options+") \n");
		
		eventClass = "WheelEvent";
		eventAddress = pointerToAddress(this);
	}
	
	
	////// Instance properties //////
	// [WheelEvent.deltaX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaX
	double deltaX = 0.0;
	// [WheelEvent.deltaY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaY
	double deltaY = 0.0;
	// [WheelEvent.deltaZ](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaZ
	double deltaZ = 0.0;
	// [WheelEvent.deltaMode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaMode
	unsigned int deltaMode = 0;
	// [WheelEvent.wheelDelta](Read only)(Deprecated)(Non-standard)
	int wheelDelta = 0;
	// [WheelEvent.wheelDeltaX](Read only)(Deprecated)(Non-standard)
	int wheelDeltaX = 0;
	// [WheelEvent.wheelDeltaY](Read only)(Deprecated)(Non-standard)
	int wheelDeltaY = 0;

	
	////// Events //////
	// [mousewheel](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/mousewheel_event
	// [wheel] https://developer.mozilla.org/en-US/docs/Web/API/Element/wheel_event
};


#endif //DKWheelEvent_H