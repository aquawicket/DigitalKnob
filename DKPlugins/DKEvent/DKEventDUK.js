// [INTERFACE] https://dom.spec.whatwg.org/#interface-event
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Event


// [Event()] https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
var Event = function Event(type, options, address) {
	//console.log("Event("+type+","+options+","+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKEventDUK(type, options);
	
	
    ////// Instance properties //////
	// [Event.bubbles](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/bubbles
    Object.defineProperty(this, "bubbles", {
        get: function bubbles()			{ return CPP_DKEventDUK_bubbles(this.address) },
		set: function bubbles(flag)		{ return CPP_DKEventDUK_bubbles(this.address, flag) },
		configurable: true,
    })
	// [Event.cancelable](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelable
    Object.defineProperty(this, "cancelable", {
        get: function cancelable()		{ return CPP_DKEventDUK_cancelable(this.address) },
		set: function cancelable(flag)	{ return CPP_DKEventDUK_cancelable(this.address, flag) },
		configurable: true,
    })
    // [Event.composed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/composed
    Object.defineProperty(this, "composed", {
        get: function composed() 		{ return CPP_DKEventDUK_composed(this.address) },
		set: function composed(flag)	{ return CPP_DKEventDUK_composed(this.address, flag) },
		configurable: true,
    })
    // [Event.currentTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/currentTarget
    Object.defineProperty(this, "currentTarget", {
        get: function currentTarget() {
            var targetAddress = CPP_DKEventDUK_currentTarget(this.address);
            if(!targetAddress)
                return;
            //return new HTMLElement(targetAddress);
			return new EventTarget(targetAddress);
        },
    });
	// [Event.defaultPrevented](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/defaultPrevented
	Object.defineProperty(this, "defaultPrevented", {
        get: function defaultPrevented() {	return CPP_DKEventDUK_defaultPrevented(this.address) },
    })
	// [Event.eventPhase](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/eventPhase
	Object.defineProperty(this, "eventPhase", {
        get: function eventPhase() { return CPP_DKEventDUK_eventPhase(this.address) },
    })
	// [Event.isTrusted](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/isTrusted
	Object.defineProperty(this, "isTrusted", {
        get: function isTrusted() { return CPP_DKEventDUK_isTrusted(this.address) },
    })
	// [Event.target](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/target
    Object.defineProperty(this, "target", {
        get: function target() {
            var targetAddress = CPP_DKEventDUK_target(this.address);
            if (!targetAddress)
                return;
            //return new HTMLElement(targetAddress);
			return new EventTarget(targetAddress);
        },
    })
	// [Event.timeStamp](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/timeStamp
	Object.defineProperty(this, "timeStamp", {
        get: function timeStamp() { return CPP_DKEventDUK_timeStamp(this.address) },
    })
	// [Event.type](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/type
	Object.defineProperty(this, "type", {
        get: function type() { return CPP_DKEventDUK_type(this.address) },
    })
    
	
    ////// Legacy and non-standard properties //////
	// [Event.cancelBubble] https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelBubble
    Object.defineProperty(this, "cancelBubble", {
        get: function cancelBubble()	{ return CPP_DKEventDUK_cancelBubble(this.address) },
		set: function cancelBubble(flag){ return CPP_DKEventDUK_cancelBubble(this.address, flag) },
    })
	// [Event.explicitOriginalTarget](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Event/explicitOriginalTarget
	Object.defineProperty(this, "explicitOriginalTarget", {
        get: function explicitOriginalTarget() { return CPP_DKEventDUK_explicitOriginalTarget(this.address) },
    })
	// [Event.originalTarget](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Event/originalTarget
	Object.defineProperty(this, "originalTarget", {
        get: function originalTarget() { return CPP_DKEventDUK_originalTarget(this.address) },
    })
	// [Event.returnValue](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/returnValue
	Object.defineProperty(this, "returnValue", {
        get: function returnValue()		{ return CPP_DKEventDUK_returnValue(this.address) },
		set: function returnValue(flag) { return CPP_DKEventDUK_returnValue(this.address, flag) },
    })
	// [Event.scoped](Read only)(Deprecated)
	Object.defineProperty(this, "scoped", {
        get: function scoped() { return CPP_DKEventDUK_scoped(this.address) },
    })
	
	
	////// Obsolete properties //////
	/*
	Object.defineProperty(this, "deepPath", {
        get: function deepPath(){ return CPP_DKEventDUK_deepPath(this.address) },
    })
    Object.defineProperty(this, "srcElement", {
        get: function srcElement() {
            var elementPointer = CPP_DKEventDUK_srcElement(this.address);
            if (!elementPointer)
                return;
            return new HTMLElement(elementPointer);
        },
    });
	*/


    ////// Instance methods //////
	// [Event.composedPath()] https://developer.mozilla.org/en-US/docs/Web/API/Event/composedPath
	Event.prototype.composedPath = function composedPath() {
        // TODO
		CPP_DKEventDUK_composedPath(this.address);
		// Return value
		// An array of EventTarget objects representing the objects on which an event listener will be invoked.
    }
	// [Event.preventDefault()] https://developer.mozilla.org/en-US/docs/Web/API/Event/preventDefault
	Event.prototype.preventDefault = function preventDefault() {
        CPP_DKEventDUK_preventDefault(this.address);
    }
	// [Event.stopImmediatePropagation()] https://developer.mozilla.org/en-US/docs/Web/API/Event/stopImmediatePropagation
	Event.prototype.stopImmediatePropagation = function stopImmediatePropagation() {
        CPP_DKEventDUK_stopImmediatePropagation(this.address);
    }
	// [Event.stopPropagation()] https://developer.mozilla.org/en-US/docs/Web/API/Event/stopPropagation
	Event.prototype.stopPropagation = function stopPropagation() {
        CPP_DKEventDUK_stopPropagation(this.address);
    }
	
	
	////// Deprecated methods //////
	// [Event.initEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/initEvent
	Event.prototype.initEvent = function initEvent(type, bubbles, cancelable) {
        CPP_DKEventDUK_initEvent(this.address, type, bubbles, cancelable);
    }
	
	
	////// Obsolete methods //////
	/*
    Event.prototype.createEvent = function createEvent() {
        CPP_DKEventDUK_createEvent(this.address);
    }
    Event.prototype.getPreventDefault = function getPreventDefault() {
        CPP_DKEventDUK_getPreventDefault(this.address);
    }
    Event.prototype.preventBubble = function preventBubble() {
        CPP_DKEventDUK_preventBubble(this.address);
    }
    Event.prototype.preventCapture = function preventCapture() {
        CPP_DKEventDUK_preventCapture(this.address);
    }
	*/


	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object Event]" }

	
	// assign options
	Object.assign(this, options);
	
	// Make properties (Read Only) after assignment
	Object.defineProperty(this, "bubbles", 		{ set: undefined })
	Object.defineProperty(this, "cancelable", 	{ set: undefined })
	Object.defineProperty(this, "composed", 	{ set: undefined })
}
