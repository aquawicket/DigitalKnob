#pragma once
#ifndef DKPointerEvent_H
#define DKPointerEvent_H

#include "DKEventTest/DKMouseEvent.h"


// [W3C] https://w3c.github.io/pointerevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent
class DKPointerEvent : public DKMouseEvent
{
public:
	////// Constructor //////
	// [PointerEvent()] https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/PointerEvent
	DKPointerEvent(DKString _type, DKString _options) : DKMouseEvent(_type, _options) {
		DKINFO("DKPointerEvent("+_type+", "+_options+") \n");
		
		eventClass = "PointerEvent";
		
		////// Instance properties //////
		pointerId = 0;

	}
	
	
	////// Instance properties //////
	// [PointerEvent.pointerId](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pointerId
	unsigned int pointerId;
	// [PointerEvent.width](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/width
	// [PointerEvent.height](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/height
	// [PointerEvent.pressure](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pressure
	// [PointerEvent.tangentialPressure) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tangentialPressure
	// [PointerEvent.tiltX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tiltX
	// [PointerEvent.tiltY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tiltY
	// [PointerEvent.twist](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/twist
	// [PointerEvent.pointerType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pointerType
	// [PointerEvent.isPrimary](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/isPrimary


	////// Instance methods //////
	// [PointerEvent.getCoalescedEvents()] https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/getCoalescedEvents
	// [PointerEvent.getPredictedEvents()] https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent
	
	
	////// Events //////
	// [pointerover] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerover_event
	// [pointerenter] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerenter_event
	// [pointerdown] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerdown_event
	// [pointermove] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointermove_event
	// [pointerrawupdate](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerrawupdate_event
	// [pointerup] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerup_event
	// [pointercancel] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointercancel_event
	// [pointerout] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerout_event
	// [pointerleave] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerleave_event
	// [gotpointercapture] https://developer.mozilla.org/en-US/docs/Web/API/Element/gotpointercapture_event
	// [lostpointercapture] https://developer.mozilla.org/en-US/docs/Web/API/Element/lostpointercapture_event

};


#endif //DKPointerEvent_H