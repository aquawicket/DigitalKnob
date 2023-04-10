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
	Object.defineProperty(this, "pointerId", {
        get: function pointerId() 	{ return CPP_DKPointerEvent_pointerId(this.address) }
    })
	// [PointerEvent.width](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/width
	Object.defineProperty(this, "width", {
        get: function width() 	{ return CPP_DKPointerEvent_width(this.address) }
    })
	// [PointerEvent.height](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/height
	Object.defineProperty(this, "height", {
        get: function height() 	{ return CPP_DKPointerEvent_height(this.address) }
    })
	// [PointerEvent.pressure](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pressure
	Object.defineProperty(this, "pressure", {
        get: function pressure() 	{ return CPP_DKPointerEvent_pressure(this.address) }
    })
	// [PointerEvent.tangentialPressure) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tangentialPressure
	Object.defineProperty(this, "tangentialPressure", {
        get: function tangentialPressure() 	{ return CPP_DKPointerEvent_tangentialPressure(this.address) }
    })
	// [PointerEvent.tiltX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tiltX
	Object.defineProperty(this, "tiltX", {
        get: function tiltX() 	{ return CPP_DKPointerEvent_tiltX(this.address) }
    })
	// [PointerEvent.tiltY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/tiltY
	Object.defineProperty(this, "tiltY", {
        get: function tiltY() 	{ return CPP_DKPointerEvent_tiltY(this.address) }
    })
	// [PointerEvent.twist](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/twist
	Object.defineProperty(this, "twist", {
        get: function twist() 	{ return CPP_DKPointerEvent_twist(this.address) }
    })
	// [PointerEvent.pointerType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/pointerType
	Object.defineProperty(this, "pointerType", {
        get: function pointerType() 	{ return CPP_DKPointerEvent_pointerType(this.address) }
    })
	// [PointerEvent.isPrimary](Read only) https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/isPrimary
	Object.defineProperty(this, "isPrimary", {
        get: function isPrimary() 	{ return CPP_DKPointerEvent_isPrimary(this.address) }
    })


	////// Instance methods //////
	// [PointerEvent.getCoalescedEvents()] https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent/getCoalescedEvents
	PointerEvent.prototype.getCoalescedEvents = function getCoalescedEvents() {
        CPP_PointerEvent_getCoalescedEvents(this.address);
    }
	// [PointerEvent.getPredictedEvents()] https://developer.mozilla.org/en-US/docs/Web/API/PointerEvent
	PointerEvent.prototype.getPredictedEvents = function getPredictedEvents() {
        CPP_PointerEvent_getPredictedEvents(this.address);
    }
	
	
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
