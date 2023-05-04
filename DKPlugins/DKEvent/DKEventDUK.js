// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/Event.idl
// [SOURCE] https://dom.spec.whatwg.org/#interface-event
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Event


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface Event {
	
// constructor(DOMString type, optional EventInit eventInitDict = {});
var Event = function Event(type, eventInitDict, address) {
	//console.log("Event("+type+","+eventInitDict+","+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKEventDUK(type, eventInitDict);
	
	// readonly attribute DOMString type;
	Object.defineProperty(this, "type", {
        get: function type() { return CPP_DKEventDUK_type(this.address) },
    })
	
	// readonly attribute EventTarget? target;
	Object.defineProperty(this, "target", {
        get: function target() {
            var targetAddress = CPP_DKEventDUK_target(this.address);
            if (!targetAddress)
                return;
            //return new HTMLElement(targetAddress);
			return new EventTarget(targetAddress);
        },
    })
	
	// readonly attribute EventTarget? srcElement; // legacy
	Object.defineProperty(this, "srcElement", {
        get: function srcElement() {
            var targetAddress = CPP_DKEventDUK_srcElement(this.address);
            if (!targetAddress)
                return;
            //return new HTMLElement(targetAddress);
			return new EventTarget(targetAddress);
        },
    })
	
	// readonly attribute EventTarget? currentTarget;
	Object.defineProperty(this, "currentTarget", {
        get: function currentTarget() {
            var targetAddress = CPP_DKEventDUK_currentTarget(this.address);
            if(!targetAddress)
                return;
            //return new HTMLElement(targetAddress);
			return new EventTarget(targetAddress);
        },
    });
	
	// sequence<EventTarget> composedPath();
	Event.prototype.composedPath = function composedPath() {
        // TODO
		CPP_DKEventDUK_composedPath(this.address);
		// Return value
		// An array of EventTarget objects representing the objects on which an event listener will be invoked.
    }
	
	// const unsigned short NONE = 0;
	
	// const unsigned short CAPTURING_PHASE = 1;
	
	// const unsigned short AT_TARGET = 2;
	
	// const unsigned short BUBBLING_PHASE = 3;
	
	// readonly attribute unsigned short eventPhase;
	Object.defineProperty(this, "eventPhase", {
        get: function eventPhase() { return CPP_DKEventDUK_eventPhase(this.address) },
    })
	
	// undefined stopPropagation();
	Event.prototype.stopPropagation = function stopPropagation() {
        CPP_DKEventDUK_stopPropagation(this.address);
    }
	
	// attribute boolean cancelBubble; // legacy alias of .stopPropagation()
	Object.defineProperty(this, "cancelBubble", {
        get: function cancelBubble()	{ return CPP_DKEventDUK_cancelBubble(this.address) },
		set: function cancelBubble(flag){ return CPP_DKEventDUK_cancelBubble(this.address, flag) },
    })
	
	// undefined stopImmediatePropagation();
	Event.prototype.stopImmediatePropagation = function stopImmediatePropagation() {
        CPP_DKEventDUK_stopImmediatePropagation(this.address);
    }
	
	// readonly attribute boolean bubbles;
	Object.defineProperty(this, "bubbles", {
        get: function bubbles()			{ return CPP_DKEventDUK_bubbles(this.address) },
		set: function bubbles(flag)		{ return CPP_DKEventDUK_bubbles(this.address, flag) },
		configurable: true,
    })
	
	// readonly attribute boolean cancelable;
	Object.defineProperty(this, "cancelable", {
        get: function cancelable()		{ return CPP_DKEventDUK_cancelable(this.address) },
		set: function cancelable(flag)	{ return CPP_DKEventDUK_cancelable(this.address, flag) },
		configurable: true,
    })
	
	// attribute boolean returnValue;  // legacy
	Object.defineProperty(this, "returnValue", {
        get: function returnValue()		{ return CPP_DKEventDUK_returnValue(this.address) },
		set: function returnValue(flag) { return CPP_DKEventDUK_returnValue(this.address, flag) },
    })
	
	// undefined preventDefault();
	Event.prototype.preventDefault = function preventDefault() {
        CPP_DKEventDUK_preventDefault(this.address);
    }
	
	// readonly attribute boolean defaultPrevented;
	Object.defineProperty(this, "defaultPrevented", {
        get: function defaultPrevented() {	return CPP_DKEventDUK_defaultPrevented(this.address) },
    })
	
	// readonly attribute boolean composed;
	Object.defineProperty(this, "composed", {
        get: function composed() 		{ return CPP_DKEventDUK_composed(this.address) },
		set: function composed(flag)	{ return CPP_DKEventDUK_composed(this.address, flag) },
		configurable: true,
    })
	
	// [LegacyUnforgeable] readonly attribute boolean isTrusted;
	Object.defineProperty(this, "isTrusted", {
        get: function isTrusted() { return CPP_DKEventDUK_isTrusted(this.address) },
    })
	
	// readonly attribute DOMHighResTimeStamp timeStamp;
	Object.defineProperty(this, "timeStamp", {
        get: function timeStamp() { return CPP_DKEventDUK_timeStamp(this.address) },
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
