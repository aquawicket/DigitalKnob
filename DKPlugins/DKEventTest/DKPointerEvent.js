// [W3C] https://w3c.github.io/uievents/#events-wheelevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent


// [PointerEvent()] https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/PointerEvent
var PointerEvent = function PointerEvent(type, options, address) {
	//console.log("PointerEvent("+type+","+options+","+address+")")
	
	if(address)
		this.address = address
	if(!this.address)
		this.address = CPP_DKPointerEvent(type, options)
	
	
	////// Instance properties //////
	// [PointerEvent.pointerId](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pointerId
	// [PointerEvent.width](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/width
	// [PointerEvent.height](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/height
	// [PointerEvent.pressure](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pressure
	// [PointerEvent.tangentialPressure) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tangentialPressure
	// [PointerEvent.tiltX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tiltX
	// [PointerEvent.tiltY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tiltY
	// [PointerEvent.twist](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/twist
	// [PointerEvent.pointerType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pointerType
	// [PointerEvent.isPrimary](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/isPrimary
	/*
	Object.defineProperty(this, "???", {
        get: function ???() 	{ return CPP_DKPointerEvent_???(this.address) },
		set: function ???(??) 	{ return CPP_DKPointerEvent_???(this.address, ??) },
		configurable: true
    })
	*/

	
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

	
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object PointerEvent]"
		}
	}
	
	var event = MouseEvent.call(this, type, options)
	
	// Make properties (Read Only) after assignment
	//Object.defineProperty(this, "???", 	 { set: undefined })
	
	return event
};
PointerEvent.prototype = MouseEvent.prototype;
