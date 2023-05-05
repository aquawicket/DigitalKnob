// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/WheelEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-wheelevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent


// Source: UI Events (https://www.w3.org/TR/uievents/)
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
		
	// const unsigned long DOM_DELTA_LINE  = 0x01;
		
	// const unsigned long DOM_DELTA_PAGE  = 0x02;
		
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
