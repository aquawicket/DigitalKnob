//https://developer.mozilla.org/en-US/docs/Web/API/Event

//event_instances = [];
var Event = function(pointer) //https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
{
    this.pointer = pointer;

    //Properties
    Object.defineProperty(this, "bubbles", {
        //Read Only
        get: function bubbles() {
            return CPP_DKDomEvent_bubbles(pointer)
        }
    })
    Object.defineProperty(this, "cancelBubble", {
        set: function cancelBubble(flag) {
            return CPP_DKDomEvent_cancelBubble(pointer, flag)
        }
    })
    Object.defineProperty(this, "cancelable", {
        get: function cancelable() {
            return CPP_DKDomEvent_cancelable(pointer)
        }
    })
    //Read Only
    Object.defineProperty(this, "composed", {
        get: function composed() {
            return CPP_DKDomEvent_composed(pointer)
        }
    })
    //Read Only
    Object.defineProperty(this, "currentTarget", {
        get: function currentTarget() {
            var elementPointer = CPP_DKDomEvent_currentTarget(pointer)
            if (!elementPointer) {
                return;
            }
            return new HTMLElement(elementPointer)
        }
    })
    //Read Only
    Object.defineProperty(this, "deepPath", {
        get: function deepPath() {
            return CPP_DKDomEvent_deepPath(pointer)
        }
    })
    //Not standardized
    Object.defineProperty(this, "defaultPrevented", {
        get: function defaultPrevented() {
            return CPP_DKDomEvent_defaultPrevented(pointer)
        }
    })
    //Read Only
    Object.defineProperty(this, "eventPhase", {
        get: function eventPhase() {
            return CPP_DKDomEvent_eventPhase(pointer)
        }
    })
    //Read Only
    Object.defineProperty(this, "explicitOriginalTarget", {
        get: function explicitOriginalTarget() {
            return CPP_DKDomEvent_explicitOriginalTarget(pointer)
        }
    })
    //Not standardized, Read Only
    Object.defineProperty(this, "originalTarget", {
        get: function originalTarget() {
            return CPP_DKDomEvent_originalTarget(pointer)
        }
    })
    //Not standardized, Read only
    Object.defineProperty(this, "returnValue", {
        get: function returnValue() {
            return CPP_DKDomEvent_returnValue(pointer)
        }
    })
    Object.defineProperty(this, "srcElement", {
        //Not standardized
        get: function srcElement() {
            var elementPointer = CPP_DKDomEvent_srcElement(pointer)
            if (!elementPointer)
                return;
            return new HTMLElement(elementPointer)
        }
    })
    //Read Only
    Object.defineProperty(this, "target", {
        //Read Only
        get: function target() {
            var elementPointer = CPP_DKDomEvent_target(pointer)
            if (!elementPointer) {
                return;
            }
            return new HTMLElement(elementPointer)
        }
    })
    //Read Only
    Object.defineProperty(this, "timeStamp", {
        get: function timeStamp() {
            return CPP_DKDomEvent_timeStamp(pointer)
        }
    })
    //Read Only
    Object.defineProperty(this, "type", {
        get: function type() {
            return CPP_DKDomEvent_type(pointer)
        },
    })
    //Read Only
    Object.defineProperty(this, "isTrusted", {
        get: function isTrusted() {
            return CPP_DKDomEvent_isTrusted(pointer)
        }
    })
    //Read Only

    //Obsolete properties
    Object.defineProperty(this, "scoped", {
        get: function scoped() {
            return CPP_DKDomEvent_scoped(pointer)
        }
    })
    //Read Only, Obsolete

    //Methods
    Event.prototype.createEvent = function createEvent() {
        //Deprecated
        CPP_DKDomEvent_createEvent(pointer)
    }
    Event.prototype.composedPath = function composedPath() {
        CPP_DKDomEvent_composedPath(pointer)
    }
    Event.prototype.initEvent = function initEvent() {
        //Deprecated
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
        //Not standardized
        CPP_DKDomEvent_getPreventDefault(pointer)
    }
    Event.prototype.preventBubble = function preventBubble() {
        //Not standardized, Obsolete
        CPP_DKDomEvent_preventBubble(pointer)
    }
    Event.prototype.preventCapture = function preventCapture() {
        //Not standardized, Obsolete
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
        //Not standardized, Obsolete
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
