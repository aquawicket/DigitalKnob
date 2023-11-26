// [IDL] https://dom.spec.whatwg.org/#interface-event
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Event


// [Exposed=*]
// interface Event {
// constructor(DOMString type, optional EventInit eventInitDict = {});
var Event = function Event(type, eventInitDict, address) {
	//console.log("Event("+type+","+eventInitDict+","+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKEventDUK_constructor(type, eventInitDict);
	
	// readonly attribute DOMString type;
	Object.defineProperty(this, "type", {
        get: function type()					{ return CPP_DKEventDUK_type(this.address) },
		//set: function type(data) 				{ return CPP_DKEventDUK_type(this.address, data) },
		//configurable: true,
    })
	
	// readonly attribute EventTarget? target;
	Object.defineProperty(this, "target", {
        get: function target() 					{ return new EventTarget( CPP_DKEventDUK_target(this.address) )	},
		//set: function target(data)			{ return new EventTarget( CPP_DKEventDUK_target(this.address, data) ) },
		//configurable: true,
    })
	
	// readonly attribute EventTarget? srcElement; // legacy
	Object.defineProperty(this, "srcElement", {
        get: function srcElement() 				{ return new EventTarget( CPP_DKEventDUK_srcElement(this.address) )	},
		//set: function srcElement(data)		{ return new EventTarget( CPP_DKEventDUK_srcElement(this.address, data) ) },
		//configurable: true,
    })
	
	// readonly attribute EventTarget? currentTarget;
	Object.defineProperty(this, "currentTarget", {
        get: function currentTarget()			{ return new EventTarget( CPP_DKEventDUK_currentTarget(this.address) )	},
		//set: function currentTarget(data)		{ return new EventTarget( CPP_DKEventDUK_currentTarget(this.address, data) ) },
		//configurable: true,
    });
	
	// sequence<EventTarget> composedPath();
	Event.prototype.composedPath = function composedPath() {
		return CPP_DKEventDUK_composedPath(this.address);
    }
	
	// const unsigned short NONE = 0;
	Object.defineProperty(this, "NONE", {
        get: function NONE() 					{ return CPP_DKEventDUK_NONE(this.address) },
		//set: function NONE(data)				{ return CPP_DKEventDUK_NONE(this.address, data) },
		//configurable: true,
    })
	
	// const unsigned short CAPTURING_PHASE = 1;
	Object.defineProperty(this, "CAPTURING_PHASE", {
        get: function CAPTURING_PHASE() 		{ return CPP_DKEventDUK_CAPTURING_PHASE(this.address) },
		//set: function CAPTURING_PHASE(data)	{ return CPP_DKEventDUK_CAPTURING_PHASE(this.address, data) },
		//configurable: true,
    })
	
	// const unsigned short AT_TARGET = 2;
	Object.defineProperty(this, "AT_TARGET", {
        get: function AT_TARGET() 				{ return CPP_DKEventDUK_AT_TARGET(this.address) },
		//set: function AT_TARGET(data)			{ return CPP_DKEventDUK_AT_TARGET(this.address, data) },
		//configurable: true,
    })
	
	// const unsigned short BUBBLING_PHASE = 3;
	Object.defineProperty(this, "BUBBLING_PHASE", {
        get: function BUBBLING_PHASE()			{ return CPP_DKEventDUK_BUBBLING_PHASE(this.address) },
		//set: function BUBBLING_PHASE(data)	{ return CPP_DKEventDUK_BUBBLING_PHASE(this.address, data) },
		//configurable: true,
    })
	
	// readonly attribute unsigned short eventPhase;
	Object.defineProperty(this, "eventPhase", {
        get: function eventPhase()				{ return CPP_DKEventDUK_eventPhase(this.address) },
		//set: function eventPhase(data)		{ return CPP_DKEventDUK_eventPhase(this.address, data) },
		//configurable: true,
    })
	
	// undefined stopPropagation();
	Event.prototype.stopPropagation = function stopPropagation() {
        CPP_DKEventDUK_stopPropagation(this.address);
    }
	
	// attribute boolean cancelBubble; // legacy alias of .stopPropagation()
	Object.defineProperty(this, "cancelBubble", {
        get: function cancelBubble()			{ return CPP_DKEventDUK_cancelBubble(this.address) },
		set: function cancelBubble(data)		{ return CPP_DKEventDUK_cancelBubble(this.address, data) },
		//configurable: true,
    })
	
	// undefined stopImmediatePropagation();
	Event.prototype.stopImmediatePropagation = function stopImmediatePropagation() {
        CPP_DKEventDUK_stopImmediatePropagation(this.address);
    }
	
	// readonly attribute boolean bubbles;
	Object.defineProperty(this, "bubbles", {
        get: function bubbles()					{ return CPP_DKEventDUK_bubbles(this.address) },
		set: function bubbles(data)				{ return CPP_DKEventDUK_bubbles(this.address, data) },
		configurable: true,
    })
	
	// readonly attribute boolean cancelable;
	Object.defineProperty(this, "cancelable", {
        get: function cancelable()				{ return CPP_DKEventDUK_cancelable(this.address) },
		set: function cancelable(data)			{ return CPP_DKEventDUK_cancelable(this.address, data) },
		configurable: true,
    })
	
	// attribute boolean returnValue;  // legacy
	Object.defineProperty(this, "returnValue", {
        get: function returnValue()				{ return CPP_DKEventDUK_returnValue(this.address) },
		set: function returnValue(data) 		{ return CPP_DKEventDUK_returnValue(this.address, data) },
		//configurable: true,
    })
	
	// undefined preventDefault();
	Event.prototype.preventDefault = function preventDefault() {
        CPP_DKEventDUK_preventDefault(this.address);
    }
	
	// readonly attribute boolean defaultPrevented;
	Object.defineProperty(this, "defaultPrevented", {
        get: function defaultPrevented()		{ return CPP_DKEventDUK_defaultPrevented(this.address) },
		//set: function defaultPrevented(data)	{ return CPP_DKEventDUK_defaultPrevented(this.address, data) },
		//configurable: true,
    })
	
	// readonly attribute boolean composed;
	Object.defineProperty(this, "composed", {
        get: function composed() 				{ return CPP_DKEventDUK_composed(this.address) },
		set: function composed(data)			{ return CPP_DKEventDUK_composed(this.address, data) },
		configurable: true,
    })
	
	// [LegacyUnforgeable] readonly attribute boolean isTrusted;
	Object.defineProperty(this, "isTrusted", {
        get: function isTrusted() 				{ return CPP_DKEventDUK_isTrusted(this.address) },
		//set: function isTrusted(data)			{ return CPP_DKEventDUK_isTrusted(this.address, data) },
		//configurable: true,
    })
	
	// readonly attribute DOMHighResTimeStamp timeStamp;
	Object.defineProperty(this, "timeStamp", {
        get: function timeStamp() 				{ return CPP_DKEventDUK_timeStamp(this.address) },
		//set: function timeStamp(data)			{ return CPP_DKEventDUK_timeStamp(this.address, data) },
		//configurable: true,
    })
	
	// undefined initEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false); // legacy
	Event.prototype.initEvent = function initEvent(type, bubbles, cancelable) {
        CPP_DKEventDUK_initEvent(this.address, type, bubbles, cancelable);
    }


	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object Event]" }

	
	// assign eventInitDict
	Object.assign(this, eventInitDict);
	
	// Make properties (Read Only) after assignment
	Object.defineProperty(this, "bubbles", 		{ set: undefined })
	Object.defineProperty(this, "cancelable", 	{ set: undefined })
	Object.defineProperty(this, "composed", 	{ set: undefined })
}
