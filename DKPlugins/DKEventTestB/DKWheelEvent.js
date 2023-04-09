// [W3C] https://w3c.github.io/uievents/#events-wheelevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent


// [WheelEvent()] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/WheelEvent
var WheelEvent = function WheelEvent(type, options, address) {
	//console.log("WheelEvent("+type+","+options+","+address+")")
	
	if(address)
		this.address = address
	if(!this.address)
		this.address = CPP_DKWheelEvent(type, options)
	
	
	////// Instance properties //////
	// [WheelEvent.deltaX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaX
	Object.defineProperty(this, "deltaX", {
        get: function deltaX() { return CPP_DKWheelEvent_deltaX(this.address) }
    })
	// [WheelEvent.deltaY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaY
	Object.defineProperty(this, "deltaY", {
        get: function deltaY() { return CPP_DKWheelEvent_deltaY(this.address) }
    })
	// [WheelEvent.deltaZ](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaZ
	Object.defineProperty(this, "deltaZ", {
        get: function deltaZ() { return CPP_DKWheelEvent_deltaZ(this.address) }
    })
	// [WheelEvent.deltaMode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaMode
	Object.defineProperty(this, "deltaMode", {
        get: function deltaMode() { return CPP_DKWheelEvent_deltaMode(this.address) }
    })
	// [WheelEvent.wheelDelta](Read only)(Deprecated)(Non-standard)
	Object.defineProperty(this, "wheelDelta", {
        get: function wheelDelta() { return CPP_DKWheelEvent_wheelDelta(this.address) }
    })
	// [WheelEvent.wheelDeltaX](Read only)(Deprecated)(Non-standard)
	Object.defineProperty(this, "wheelDeltaX", {
        get: function wheelDeltaX() { return CPP_DKWheelEvent_wheelDeltaX(this.address) }
    })
	// [WheelEvent.wheelDeltaY](Read only)(Deprecated)(Non-standard)
	Object.defineProperty(this, "wheelDeltaY", {
        get: function wheelDeltaY() { return CPP_DKWheelEvent_wheelDeltaY(this.address) }
    })
	

	////// Events //////
	// [mousewheel](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/mousewheel_event
	// [wheel] https://developer.mozilla.org/en-US/docs/Web/API/Element/wheel_event
	
	
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object WheelEvent]"
		}
	}
	
	return MouseEvent.call(this, type, options)
};
WheelEvent.prototype = MouseEvent.prototype;
