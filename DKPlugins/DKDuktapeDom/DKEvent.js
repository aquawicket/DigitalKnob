//https://developer.mozilla.org/en-US/docs/Web/API/Event

//event_instances = [];
var Event = function(pointer) //https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
{
    this.pointer = pointer;

    //Properties
    Object.defineProperty(this, "bubbles", {
        //Read Only
        get: function() {
            return CPP_DKEvent_bubbles(pointer);
        }
    });
    Object.defineProperty(this, "cancelBubble", {
        set: function(flag) {
            return CPP_DKEvent_cancelBubble(pointer, flag);
        }
    });
    Object.defineProperty(this, "cancelable", {
        get: function() {
            return CPP_DKEvent_cancelable(pointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "composed", {
        get: function() {
            return CPP_DKEvent_composed(pointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "currentTarget", {
        get: function() {
			return window;
			/*
            var elementPointer = CPP_DKEvent_currentTarget(pointer);
            if (!elementPointer) {
                return;
            }
            return new HTMLElement(elementPointer);
			*/
        }
    });
    //Read Only
    Object.defineProperty(this, "deepPath", {
        get: function() {
            return CPP_DKEvent_deepPath(pointer);
        }
    });
    //Not standardized
    Object.defineProperty(this, "defaultPrevented", {
        get: function() {
            return CPP_DKEvent_defaultPrevented(pointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "eventPhase", {
        get: function() {
            return CPP_DKEvent_eventPhase(pointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "explicitOriginalTarget", {
        get: function() {
            return CPP_DKEvent_explicitOriginalTarget(pointer);
        }
    });
    //Not standardized, Read Only
    Object.defineProperty(this, "originalTarget", {
        get: function() {
            return CPP_DKEvent_originalTarget(pointer);
        }
    });
    //Not standardized, Read only
    Object.defineProperty(this, "returnValue", {
        get: function() {
            return CPP_DKEvent_returnValue(pointer);
        }
    });
    Object.defineProperty(this, "srcElement", {
        //Not standardized
        get: function() {
            var elementPointer = CPP_DKEvent_srcElement(pointer);
            if (!elementPointer) {
                return;
            }
            return new HTMLElement(elementPointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "target", {
        //Read Only
        get: function() {
            var elementPointer = CPP_DKEvent_target(pointer);
            if (!elementPointer) {
                return;
            }
            return new HTMLElement(elementPointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "timeStamp", {
        get: function() {
            return CPP_DKEvent_timeStamp(pointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "type", {
        get: function() {
            return CPP_DKEvent_type(pointer);
        },
    });
    //Read Only
    Object.defineProperty(this, "isTrusted", {
        get: function() {
            return CPP_DKEvent_isTrusted(pointer);
        }
    });
    //Read Only

    //Obsolete properties
    Object.defineProperty(this, "scoped", {
        get: function() {
            return CPP_DKEvent_scoped(pointer);
        }
    });
    //Read Only, Obsolete

    //Methods
    Event.prototype.createEvent = function() {
        //Deprecated
        CPP_DKEvent_createEvent(pointer);
    }
    ;
    Event.prototype.composedPath = function() {
        CPP_DKEvent_composedPath(pointer);
    }
    ;
    Event.prototype.initEvent = function() {
        //Deprecated
        CPP_DKEvent_initEvent(pointer);
    }
    ;
    Event.prototype.preventDefault = function() {
        CPP_DKEvent_preventDefault(pointer);
    }
    ;
    Event.prototype.stopImmediatePropagation = function() {
        CPP_DKEvent_stopImmediatePropagation(pointer);
    }
    ;
    Event.prototype.stopPropagation = function() {
        CPP_DKEvent_stopPropagation(pointer);
    }
    ;

    //Obsolete methods
    Event.prototype.getPreventDefault = function() {
        //Not standardized
        CPP_DKEvent_getPreventDefault(pointer);
    }
    ;
    Event.prototype.preventBubble = function() {
        //Not standardized, Obsolete
        CPP_DKEvent_preventBubble(pointer);
    }
    ;
    Event.prototype.preventCapture = function() {
        //Not standardized, Obsolete
        CPP_DKEvent_preventCapture(pointer);
    }
    ;

    //console.log("dispatching event");
    //this.currentTarget.dispatchEvent(this);
    //return this;
};

// Called from C++ to send events
///////////////////////////////
function DispatchEvent(pointer) {
    var event = new Event(pointer);
    //console.log("DispatchEvent("+pointer+"): event.type = "+event.type);

    if (event.type === "mousemove" || event.type === "mouseover" || event.type === "mousedown" || event.type === "mouseup" || event.type === "click" || event.type === "dblclick" || event.type === "contextmenu") {
        var mouseEvent = new MouseEvent(pointer);
        mouseEvent.currentTarget.dispatchEvent(mouseEvent);
    } else if (event.type === "keydown" || event.type === "keyup" || event.type === "keypress") {
        var keyboardEvent = new KeyboardEvent(pointer);
        keyboardEvent.currentTarget.dispatchEvent(keyboardEvent);
    } else {
        event.currentTarget.dispatchEvent(event);
    }
}
