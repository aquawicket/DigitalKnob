// [IDL] https://w3c.github.io/uievents/#events-wheelevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent


// [Exposed=Window]
// interface WheelEvent : MouseEvent {
// constructor(DOMString type, optional WheelEventInit eventInitDict = {});
var WheelEvent = function WheelEvent(type, eventInitDict, address) {
	//console.log("WheelEvent("+type+","+eventInitDict+","+address+")")
	
	if(address)
		this.address = address
	if(!this.address)
		this.address = CPP_DKWheelEventDUK(type, eventInitDict)
	
	
	// DeltaModeCode
	// const unsigned long DOM_DELTA_PIXEL = 0x00;
	Object.defineProperty(this, "DOM_DELTA_PIXEL", {
        get: function DOM_DELTA_PIXEL() 	{ return CPP_DKWheelEventDUK_DOM_DELTA_PIXEL(this.address) },
		//set: function DOM_DELTA_PIXEL(num) { return CPP_DKWheelEventDUK_DOM_DELTA_PIXEL(this.address, num) },
		//configurable: true,
    })
		
	// const unsigned long DOM_DELTA_LINE  = 0x01;
	Object.defineProperty(this, "DOM_DELTA_LINE", {
        get: function DOM_DELTA_LINE() 		{ return CPP_DKWheelEventDUK_DOM_DELTA_LINE(this.address) },
		//set: function DOM_DELTA_LINE(num) { return CPP_DKWheelEventDUK_DOM_DELTA_LINE(this.address, num) },
		//configurable: true,
    })
		
	// const unsigned long DOM_DELTA_PAGE  = 0x02;
	Object.defineProperty(this, "DOM_DELTA_PAGE", {
        get: function DOM_DELTA_PAGE() 		{ return CPP_DKWheelEventDUK_DOM_DELTA_PAGE(this.address) },
		//set: function DOM_DELTA_PAGE(num) { return CPP_DKWheelEventDUK_DOM_DELTA_PAGE(this.address, num) },
		//configurable: true,
    })
		
	// readonly attribute double deltaX;
	Object.defineProperty(this, "deltaX", {
        get: function deltaX() 		{ return CPP_DKWheelEventDUK_deltaX(this.address) },
		set: function deltaX(num) 	{ return CPP_DKWheelEventDUK_deltaX(this.address, num) },
		configurable: true,
    })
	
	// readonly attribute double deltaY;
	Object.defineProperty(this, "deltaY", {
        get: function deltaY()		{ return CPP_DKWheelEventDUK_deltaY(this.address) },
		set: function deltaY(num) 	{ return CPP_DKWheelEventDUK_deltaY(this.address, num) },
		configurable: true,
    })
	
	// readonly attribute double deltaZ;
	Object.defineProperty(this, "deltaZ", {
        get: function deltaZ() 	{ return CPP_DKWheelEventDUK_deltaZ(this.address) },
		set: function deltaZ(z) { return CPP_DKWheelEventDUK_deltaZ(this.address, z) },
		configurable: true,
    })
	
	// readonly attribute unsigned long deltaMode;
	Object.defineProperty(this, "deltaMode", {
        get: function deltaMode()	{ return CPP_DKWheelEventDUK_deltaMode(this.address) },
		set: function deltaMode(num){ return CPP_DKWheelEventDUK_deltaMode(this.address, num) },
		configurable: true,
    })
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object WheelEvent]" }
		
	
	var event = MouseEvent.call(this, type, eventInitDict)
	
	// Make properties (Read Only) after assignment
	Object.defineProperty(this, "deltaX", 	 { set: undefined })
	Object.defineProperty(this, "deltaY", 	 { set: undefined })
	Object.defineProperty(this, "deltaZ", 	 { set: undefined })
	Object.defineProperty(this, "deltaMode", { set: undefined })
	
	return event
};
WheelEvent.prototype = MouseEvent.prototype;
