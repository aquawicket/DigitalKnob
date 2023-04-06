#pragma once
#ifndef DKWheelEvent_H
#define DKWheelEvent_H

#include "DKEventTest/DKMouseEvent.h"


// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent
// [INTERFACE] https://w3c.github.io/uievents/#interface-wheelevent
class DKWheelEvent : public DKMouseEvent
{
public:
	////// Constructor //////
	// [WheelEvent()] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/WheelEvent
	DKWheelEvent(DKString _type, DKString _options) : DKMouseEvent(_type, _options) {
		DKINFO("DKWheelEvent("+_type+", "+_options+") \n");
		
		////// Instance properties //////
		deltaX = 0.0;
		deltaY = 0.0;
		deltaZ = 0.0;
		deltaMode = 0;
		wheelDelta = 0;
		wheelDeltaX = 0;
		wheelDeltaY = 0;
	}
	
	
	////// Instance properties //////
	// [WheelEvent.deltaX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaX
	double deltaX;
	// [WheelEvent.deltaY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaY
	double deltaY;
	// [WheelEvent.deltaZ](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaZ
	double deltaZ;
	// [WheelEvent.deltaMode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaMode
	unsigned int deltaMode;
	// [WheelEvent.wheelDelta](Read only)(Deprecated)(Non-standard)
	int wheelDelta;
	// [WheelEvent.wheelDeltaX](Read only)(Deprecated)(Non-standard)
	int wheelDeltaX;
	// [WheelEvent.wheelDeltaY](Read only)(Deprecated)(Non-standard)
	int wheelDeltaY;

	
	////// Events //////
	// [mousewheel](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/mousewheel_event
	// [wheel] https://developer.mozilla.org/en-US/docs/Web/API/Element/wheel_event
};


#endif //DKWheelEvent_H