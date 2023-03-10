// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Event
// [INTERFACE] https://dom.spec.whatwg.org/#interface-event

//event_instances = [];

// [Event()] https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
var Event = function Event(_type, _options, _pointer) {
	
	/*
    this._type = _type;
	this._options = _options;
	this._pointer = _pointer;
	*/

    ////// Instance properties //////
	// [Event.bubbles](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/bubbles
    Object.defineProperty(this, "bubbles", {
        get: function bubbles() {
            return CPP_DKEvent_bubbles(_pointer);
        }
    });
	// [Event.cancelable](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelable
    Object.defineProperty(this, "cancelable", {
        get: function cancelable() {
            return CPP_DKEvent_cancelable(_pointer);
        }
    });
    // [Event.composed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/composed
    Object.defineProperty(this, "composed", {
        get: function composed() {
            return CPP_DKEvent_composed(_pointer);
        }
    });
    // [Event.currentTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/currentTarget
    Object.defineProperty(this, "currentTarget", {
        get: function currentTarget() {
			return window;
			/*
            var elementPointer = CPP_DKEvent_currentTarget(_pointer);
            if (!elementPointer) {
                return;
            }
            return new HTMLElement(elementPointer);
			*/
        }
    });
	// [Event.defaultPrevented](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/defaultPrevented
	Object.defineProperty(this, "defaultPrevented", {
        get: function defaultPrevented() {
            return CPP_DKEvent_defaultPrevented(_pointer);
        }
    });
	// [Event.eventPhase](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/eventPhase
	Object.defineProperty(this, "eventPhase", {
        get: function eventPhase() {
            return CPP_DKEvent_eventPhase(_pointer);
        }
    });
	// [Event.isTrusted](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/isTrusted
	Object.defineProperty(this, "isTrusted", {
        get: function isTrusted() {
            return CPP_DKEvent_isTrusted(_pointer);
        }
    });
	// [Event.target](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/target
	/*
    Object.defineProperty(this, "target", {
        //Read Only
        get: function target() {
            var elementPointer = CPP_DKEvent_target(_pointer);
            if (!elementPointer) {
                return;
            }
            return new HTMLElement(elementPointer);
        }
    });
	*/
	// [Event.timeStamp](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/timeStamp
	Object.defineProperty(this, "timeStamp", {
        get: function timeStamp() {
            return CPP_DKEvent_timeStamp(_pointer);
        }
    });
	// [Event.type](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/type
	Object.defineProperty(this, "type", {
        get: function type() {
            return this._type//CPP_DKEvent_type(_pointer);
        }
    });
    
    ////// Legacy and non-standard properties //////
	// [Event.cancelBubble](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelBubble
    Object.defineProperty(this, "cancelBubble", {
        set: function cancelBubble(flag) {
            return CPP_DKEvent_cancelBubble(_pointer, flag);
        }
    });
	// [Event.explicitOriginalTarget](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Event/explicitOriginalTarget
	Object.defineProperty(this, "explicitOriginalTarget", {
        get: function explicitOriginalTarget() {
            return CPP_DKEvent_explicitOriginalTarget(_pointer);
        }
    });
	// [Event.originalTarget](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Event/originalTarget
	Object.defineProperty(this, "originalTarget", {
        get: function originalTarget() {
            return CPP_DKEvent_originalTarget(_pointer);
        }
    });
	// [Event.originalTarget](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/returnValue
	Object.defineProperty(this, "returnValue", {
        get: function returnValue() {
            return CPP_DKEvent_returnValue(_pointer);
        }
    });
	// [Event.scoped](Read only)(Deprecated)
	Object.defineProperty(this, "scoped", {
        get: function scoped() {
            return CPP_DKEvent_scoped(_pointer);
        }
    });
	
	////// Obsolete properties //////
	/*
	Object.defineProperty(this, "deepPath", {
        get: function deepPath(){
            return CPP_DKEvent_deepPath(_pointer);
        }
    });
    Object.defineProperty(this, "srcElement", {
        get: function srcElement() {
            var elementPointer = CPP_DKEvent_srcElement(_pointer);
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
        //TODO
    }
	// [Event.preventDefault()] https://developer.mozilla.org/en-US/docs/Web/API/Event/preventDefault
	Event.prototype.preventDefault = function preventDefault() {
        CPP_DKEvent_preventDefault(_pointer);
    }
	// [Event.stopImmediatePropagation()] https://developer.mozilla.org/en-US/docs/Web/API/Event/stopImmediatePropagation
	Event.prototype.stopImmediatePropagation = function stopImmediatePropagation() {
        CPP_DKEvent_stopImmediatePropagation(_pointer);
    }
	// [Event.stopPropagation()] https://developer.mozilla.org/en-US/docs/Web/API/Event/stopPropagation
	Event.prototype.stopPropagation = function stopPropagation() {
        CPP_DKEvent_stopPropagation(_pointer);
    }
	
	////// Deprecated methods //////
	// [Event.initEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/initEvent
	Event.prototype.initEvent = function initEvent() {
        CPP_DKEvent_initEvent(_pointer);
    }
	
	////// Obsolete methods //////
	/*
    Event.prototype.createEvent = function createEvent() {
        CPP_DKEvent_createEvent(_pointer);
    }
    Event.prototype.composedPath = function composedPath() {
        CPP_DKEvent_composedPath(_pointer);
    }
    Event.prototype.getPreventDefault = function getPreventDefault() {
        CPP_DKEvent_getPreventDefault(_pointer);
    }
    Event.prototype.preventBubble = function preventBubble() {
        CPP_DKEvent_preventBubble(_pointer);
    }
    Event.prototype.preventCapture = function preventCapture() {
        CPP_DKEvent_preventCapture(_pointer);
    }
	*/

	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object Event]"
		}
	}
	
    //console.log("dispatching event");
    //this.currentTarget.dispatchEvent(this);
    //return this;
}

// Called from C++ to send events
///////////////////////////////
function DispatchEvent(_pointer) {
    var event = new Event(_pointer);
    //console.log("DispatchEvent("+pointer+"): event.type = "+event.type);

    if (event.type === "mousemove" || event.type === "mouseover" || event.type === "mousedown" || event.type === "mouseup" || event.type === "click" || event.type === "dblclick" || event.type === "contextmenu") {
        var mouseEvent = new MouseEvent(_type, _options, _pointer);
        mouseEvent.currentTarget.dispatchEvent(mouseEvent);
    } else if (event.type === "keydown" || event.type === "keyup" || event.type === "keypress") {
        var keyboardEvent = new KeyboardEvent(pointer);
        keyboardEvent.currentTarget.dispatchEvent(keyboardEvent);
    } else {
        event.currentTarget.dispatchEvent(event);
    }
}

/////////////////////////////////////////////
function doEvent(_type, _options, _pointer) {
	const event = new Event(_type, _options, _pointer)
	event.target = new EventTarget(_pointer)
	event.target.dispatchEvent(event)
}
