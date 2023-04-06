// [INTERFACE] https://dom.spec.whatwg.org/#interface-event
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Event


// [Event()] https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
var Event = function Event(type, options, address) {
	//console.log("Event("+type+","+options+","+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKEvent(type, options);
	
	
    ////// Instance properties //////
	// [Event.bubbles](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/bubbles
    Object.defineProperty(this, "bubbles", {
        get: function bubbles() {
            return CPP_DKEvent_bubbles(this.address);
        },
		set: function bubbles(flag) {
            return CPP_DKEvent_bubbles(this.address, flag);
        }
    });
	// [Event.cancelable](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelable
    Object.defineProperty(this, "cancelable", {
        get: function cancelable() {
            return CPP_DKEvent_cancelable(this.address);
        }
    });
    // [Event.composed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/composed
    Object.defineProperty(this, "composed", {
        get: function composed() {
            return CPP_DKEvent_composed(this.address);
        }
    });
    // [Event.currentTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/currentTarget
    Object.defineProperty(this, "currentTarget", {
        get: function currentTarget() {
            var targetAddress = CPP_DKEvent_currentTarget(this.address);
            if (!targetAddress) {
                return;
            }
            //return new HTMLElement(targetAddress);
			return new EventTarget(targetAddress);
        }
    });
	// [Event.defaultPrevented](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/defaultPrevented
	Object.defineProperty(this, "defaultPrevented", {
        get: function defaultPrevented() {
            return CPP_DKEvent_defaultPrevented(this.address);
        }
    });
	// [Event.eventPhase](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/eventPhase
	Object.defineProperty(this, "eventPhase", {
        get: function eventPhase() {
            return CPP_DKEvent_eventPhase(this.address);
        }
    });
	// [Event.isTrusted](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/isTrusted
	Object.defineProperty(this, "isTrusted", {
        get: function isTrusted() {
            return CPP_DKEvent_isTrusted(this.address);
        }
    });
	// [Event.target](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/target
    Object.defineProperty(this, "target", {
        get: function target() {
            var targetAddress = CPP_DKEvent_target(this.address);
            if (!targetAddress) {
                return;
            }
            //return new HTMLElement(targetAddress);
			return new EventTarget(targetAddress);
        }
    });
	// [Event.timeStamp](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/timeStamp
	Object.defineProperty(this, "timeStamp", {
        get: function timeStamp() {
            return CPP_DKEvent_timeStamp(this.address);
        }
    });
	// [Event.type](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/type
	Object.defineProperty(this, "type", {
        get: function type() {
            //return this._type
			return CPP_DKEvent_type(this.address);
        }
    });
    
	
    ////// Legacy and non-standard properties //////
	// [Event.cancelBubble] https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelBubble
    Object.defineProperty(this, "cancelBubble", {
        get: function cancelBubble() {
            return CPP_DKEvent_cancelBubble(this.address);
        },
		set: function cancelBubble(flag) {
            return CPP_DKEvent_cancelBubble(this.address, flag);
        }
    });
	// [Event.explicitOriginalTarget](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Event/explicitOriginalTarget
	Object.defineProperty(this, "explicitOriginalTarget", {
        get: function explicitOriginalTarget() {
            return CPP_DKEvent_explicitOriginalTarget(this.address);
        }
    });
	// [Event.originalTarget](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Event/originalTarget
	Object.defineProperty(this, "originalTarget", {
        get: function originalTarget() {
            return CPP_DKEvent_originalTarget(this.address);
        }
    });
	// [Event.returnValue](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/returnValue
	Object.defineProperty(this, "returnValue", {
        get: function returnValue() {
            return CPP_DKEvent_returnValue(this.address);
        },
		set: function returnValue(flag) {
            return CPP_DKEvent_returnValue(this.address, flag);
        }
    });
	// [Event.scoped](Read only)(Deprecated)
	Object.defineProperty(this, "scoped", {
        get: function scoped() {
            return CPP_DKEvent_scoped(this.address);
        }
    });
	
	////// Obsolete properties //////
	/*
	Object.defineProperty(this, "deepPath", {
        get: function deepPath(){
            return CPP_DKEvent_deepPath(this.address);
        }
    });
    Object.defineProperty(this, "srcElement", {
        get: function srcElement() {
            var elementPointer = CPP_DKEvent_srcElement(this.address);
            if (!elementPointer) {
                return;
            }
            return new HTMLElement(elementPointer);
        }
    });
	*/

    ////// Instance methods //////
	// [Event.composedPath()] https://developer.mozilla.org/en-US/docs/Web/API/Event/composedPath
	Event.prototype.composedPath = function composedPath() {
        // TODO
		CPP_DKEvent_composedPath(this.address);
		// Return value
		// An array of EventTarget objects representing the objects on which an event listener will be invoked.
    }
	// [Event.preventDefault()] https://developer.mozilla.org/en-US/docs/Web/API/Event/preventDefault
	Event.prototype.preventDefault = function preventDefault() {
        CPP_DKEvent_preventDefault(this.address);
    }
	// [Event.stopImmediatePropagation()] https://developer.mozilla.org/en-US/docs/Web/API/Event/stopImmediatePropagation
	Event.prototype.stopImmediatePropagation = function stopImmediatePropagation() {
        CPP_DKEvent_stopImmediatePropagation(this.address);
    }
	// [Event.stopPropagation()] https://developer.mozilla.org/en-US/docs/Web/API/Event/stopPropagation
	Event.prototype.stopPropagation = function stopPropagation() {
        CPP_DKEvent_stopPropagation(this.address);
    }
	
	////// Deprecated methods //////
	// [Event.initEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/initEvent
	Event.prototype.initEvent = function initEvent(type, bubbles, cancelable) {
        CPP_DKEvent_initEvent(this.address, type, bubbles, cancelable);
    }
	
	////// Obsolete methods //////
	/*
    Event.prototype.createEvent = function createEvent() {
        CPP_DKEvent_createEvent(this.address);
    }
    Event.prototype.getPreventDefault = function getPreventDefault() {
        CPP_DKEvent_getPreventDefault(this.address);
    }
    Event.prototype.preventBubble = function preventBubble() {
        CPP_DKEvent_preventBubble(this.address);
    }
    Event.prototype.preventCapture = function preventCapture() {
        CPP_DKEvent_preventCapture(this.address);
    }
	*/

	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object Event]"
		}
	}
}
