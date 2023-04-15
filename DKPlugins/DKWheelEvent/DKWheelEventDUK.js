// [W3C] https://w3c.github.io/uievents/#events-wheelevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent


// [WheelEvent()] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/WheelEvent
var WheelEvent = function WheelEvent(type, options, address) {
	//console.log("WheelEvent("+type+","+options+","+address+")")
	
	if(address)
		this.address = address
	if(!this.address)
		this.address = CPP_DKWheelEventDUK(type, options)
	
	
	////// Instance properties //////
	// [WheelEvent.deltaX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaX
	Object.defineProperty(this, "deltaX", {
        get: function deltaX() 		{ return CPP_DKWheelEventDUK_deltaX(this.address) },
		set: function deltaX(num) 	{ return CPP_DKWheelEventDUK_deltaX(this.address, num) },
		configurable: true,
    })
	// [WheelEvent.deltaY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaY
	Object.defineProperty(this, "deltaY", {
        get: function deltaY()		{ return CPP_DKWheelEventDUK_deltaY(this.address) },
		set: function deltaY(num) 	{ return CPP_DKWheelEventDUK_deltaY(this.address, num) },
		configurable: true,
    })
	// [WheelEvent.deltaZ](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaZ
	Object.defineProperty(this, "deltaZ", {
        get: function deltaZ() 	{ return CPP_DKWheelEventDUK_deltaZ(this.address) },
		set: function deltaZ(z) { return CPP_DKWheelEventDUK_deltaZ(this.address, z) },
		configurable: true,
    })
	// [WheelEvent.deltaMode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaMode
	Object.defineProperty(this, "deltaMode", {
        get: function deltaMode()	{ return CPP_DKWheelEventDUK_deltaMode(this.address) },
		set: function deltaMode(num){ return CPP_DKWheelEventDUK_deltaMode(this.address, num) },
		configurable: true,
    })
	// [WheelEvent.wheelDelta](Read only)(Deprecated)(Non-standard)
	Object.defineProperty(this, "wheelDelta", {
        get: function wheelDelta() { return CPP_DKWheelEventDUK_wheelDelta(this.address) },
    })
	// [WheelEvent.wheelDeltaX](Read only)(Deprecated)(Non-standard)
	Object.defineProperty(this, "wheelDeltaX", {
        get: function wheelDeltaX() { return CPP_DKWheelEventDUK_wheelDeltaX(this.address) },
    })
	// [WheelEvent.wheelDeltaY](Read only)(Deprecated)(Non-standard)
	Object.defineProperty(this, "wheelDeltaY", {
        get: function wheelDeltaY() { return CPP_DKWheelEventDUK_wheelDeltaY(this.address) },
    })
	

	////// Events //////
	// [mousewheel](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/mousewheel_event
	// [wheel] https://developer.mozilla.org/en-US/docs/Web/API/Element/wheel_event
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object WheelEvent]" }
		
	
	var event = MouseEvent.call(this, type, options)
	
	// Make properties (Read Only) after assignment
	Object.defineProperty(this, "deltaX", 	 { set: undefined })
	Object.defineProperty(this, "deltaY", 	 { set: undefined })
	Object.defineProperty(this, "deltaZ", 	 { set: undefined })
	Object.defineProperty(this, "deltaMode", { set: undefined })
	
	return event
};
WheelEvent.prototype = MouseEvent.prototype;
