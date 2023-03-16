// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Event
// [INTERFACE] https://dom.spec.whatwg.org/#interface-event

//event_instances = [];

// [Event()] https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
var Event = function(pointer) {
	
    this.pointer = pointer;

    ////// Instance properties //////
	// [Event.bubbles](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/bubbles
    Object.defineProperty(this, "bubbles", {
        get: function bubbles() {
            return CPP_DKDomEvent_bubbles(pointer)
        }
    })
    Object.defineProperty(this, "cancelBubble", {
        set: function cancelBubble(flag) {
            return CPP_DKDomEvent_cancelBubble(pointer, flag)
        }
    })
	// [Event.cancelable](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelable
    Object.defineProperty(this, "cancelable", {
        get: function cancelable() {
            return CPP_DKDomEvent_cancelable(pointer)
        }
    })
    // [Event.composed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/composed
    Object.defineProperty(this, "composed", {
        get: function composed() {
            return CPP_DKDomEvent_composed(pointer)
        }
    })
    // [Event.currentTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/currentTarget
    Object.defineProperty(this, "currentTarget", {
        get: function currentTarget() {
            var elementPointer = CPP_DKDomEvent_currentTarget(pointer)
            if (!elementPointer) {
                return;
            }
            return new HTMLElement(elementPointer)
        }
    })
    Object.defineProperty(this, "deepPath", {
        get: function deepPath() {
            return CPP_DKDomEvent_deepPath(pointer)
        }
    })
    // [Event.defaultPrevented](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/defaultPrevented
    Object.defineProperty(this, "defaultPrevented", {
        get: function defaultPrevented() {
            return CPP_DKDomEvent_defaultPrevented(pointer)
        }
    })
    // [Event.eventPhase](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/eventPhase
    Object.defineProperty(this, "eventPhase", {
        get: function eventPhase() {
            return CPP_DKDomEvent_eventPhase(pointer)
        }
    })
    Object.defineProperty(this, "explicitOriginalTarget", {
        get: function explicitOriginalTarget() {
            return CPP_DKDomEvent_explicitOriginalTarget(pointer)
        }
    })
    Object.defineProperty(this, "originalTarget", {
        get: function originalTarget() {
            return CPP_DKDomEvent_originalTarget(pointer)
        }
    })
    Object.defineProperty(this, "returnValue", {
        get: function returnValue() {
            return CPP_DKDomEvent_returnValue(pointer)
        }
    })
    Object.defineProperty(this, "srcElement", {
        get: function srcElement() {
            var elementPointer = CPP_DKDomEvent_srcElement(pointer)
            if (!elementPointer)
                return;
            return new HTMLElement(elementPointer)
        }
    })
    Object.defineProperty(this, "target", {
        get: function target() {
            var elementPointer = CPP_DKDomEvent_target(pointer)
            if (!elementPointer) {
                return;
            }
            return new HTMLElement(elementPointer)
        }
    })
    Object.defineProperty(this, "timeStamp", {
        get: function timeStamp() {
            return CPP_DKDomEvent_timeStamp(pointer)
        }
    })
    Object.defineProperty(this, "type", {
        get: function type() {
            return CPP_DKDomEvent_type(pointer)
        },
    })
    Object.defineProperty(this, "isTrusted", {
        get: function isTrusted() {
            return CPP_DKDomEvent_isTrusted(pointer)
        }
    })
    Object.defineProperty(this, "scoped", {
        get: function scoped() {
            return CPP_DKDomEvent_scoped(pointer)
        }
    })
	
	// Custom added by DigitalKnob
	Object.defineProperty(this, "value", {
        get: function value() {
            return CPP_DKDomEvent_value(pointer)
        }
    })

    //Methods
    Event.prototype.createEvent = function createEvent() {
        CPP_DKDomEvent_createEvent(pointer)
    }
    Event.prototype.composedPath = function composedPath() {
        CPP_DKDomEvent_composedPath(pointer)
    }
    Event.prototype.initEvent = function initEvent() {
        CPP_DKDomEvent_initEvent(pointer)
    }
    Event.prototype.preventDefault = function preventDefault() {
        CPP_DKDomEvent_preventDefault(pointer)
    }
    Event.prototype.stopImmediatePropagation = function stopImmediatePropagation() {
        CPP_DKDomEvent_stopImmediatePropagation(pointer)
    }
    Event.prototype.stopPropagation = function stopPropagation() {
        CPP_DKDomEvent_stopPropagation(pointer)
    }

    //Obsolete methods
    Event.prototype.getPreventDefault = function getPreventDefault() {
        CPP_DKDomEvent_getPreventDefault(pointer)
    }
    Event.prototype.preventBubble = function preventBubble() {
        CPP_DKDomEvent_preventBubble(pointer)
    }
    Event.prototype.preventCapture = function preventCapture() {
        CPP_DKDomEvent_preventCapture(pointer)
    }

	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object Event]"
		}
	}
	
	// Extra
	///////////////////////////////////////////////
	Event.prototype.getParameters = function getParameters() {
        CPP_DKDomEvent_getParameters(pointer)
    }
	
    //console.log("dispatching event")
    //this.currentTarget.dispatchEvent(this)
    //return this;
};

// Called from C++ RmlUI to send events
///////////////////////////////
function DispatchEvent(pointer) {
    var event = new Event(pointer)
	globalThis.event = event;
    //console.log("DispatchEvent("+pointer+"): event.type = "+event.type)
	//DKDEBUGFUNC(pointer, event.type);
    if (event.type === "mousemove" || event.type === "mouseover" || event.type === "mousedown" || event.type === "mouseup" || event.type === "click" || event.type === "dblclick" || event.type === "contextmenu") {
        var mouseEvent = new MouseEvent(pointer)
        mouseEvent.currentTarget.dispatchEvent(mouseEvent)
    } 
	else if (event.type === "keydown" || event.type === "keyup" || event.type === "keypress") {
        var keyboardEvent = new KeyboardEvent(pointer)
        keyboardEvent.currentTarget.dispatchEvent(keyboardEvent)
    } 
	else {
        event.currentTarget.dispatchEvent(event)
    }
}
