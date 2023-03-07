//https://developer.mozilla.org/en-US/docs/Web/API/Event

//event_instances = [];
var Event = function Event(_type, _options, _pointer) { //https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
	//console.log("Event("+_type+","+_options+","+_pointer+")")
    this._type = _type;
	this._options = _options;
	this._pointer = _pointer;

    //Properties
    Object.defineProperty(this, "bubbles", {
        //Read Only
        get: function bubbles() {
            return CPP_DKEvent_bubbles(_pointer);
        }
    });
    Object.defineProperty(this, "cancelBubble", {
        set: function cancelBubble(flag) {
            return CPP_DKEvent_cancelBubble(_pointer, flag);
        }
    });
    Object.defineProperty(this, "cancelable", {
        get: function cancelable() {
            return CPP_DKEvent_cancelable(_pointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "composed", {
        get: function composed() {
            return CPP_DKEvent_composed(_pointer);
        }
    });
    //Read Only
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
    //Read Only
    Object.defineProperty(this, "deepPath", {
        get: function deepPath(){
            return CPP_DKEvent_deepPath(_pointer);
        }
    });
    //Not standardized
    Object.defineProperty(this, "defaultPrevented", {
        get: function defaultPrevented() {
            return CPP_DKEvent_defaultPrevented(_pointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "eventPhase", {
        get: function eventPhase() {
            return CPP_DKEvent_eventPhase(_pointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "explicitOriginalTarget", {
        get: function explicitOriginalTarget() {
            return CPP_DKEvent_explicitOriginalTarget(_pointer);
        }
    });
    //Not standardized, Read Only
    Object.defineProperty(this, "originalTarget", {
        get: function originalTarget() {
            return CPP_DKEvent_originalTarget(_pointer);
        }
    });
    //Not standardized, Read only
    Object.defineProperty(this, "returnValue", {
        get: function returnValue() {
            return CPP_DKEvent_returnValue(_pointer);
        }
    });
    Object.defineProperty(this, "srcElement", {
        //Not standardized
        get: function srcElement() {
            var elementPointer = CPP_DKEvent_srcElement(_pointer);
            if (!elementPointer) {
                return;
            }
            return new HTMLElement(elementPointer);
        }
    });
	/*
    //Read Only
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
    //Read Only
    Object.defineProperty(this, "timeStamp", {
        get: function timeStamp() {
            return CPP_DKEvent_timeStamp(_pointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "type", {
        get: function type() {
            return this._type//CPP_DKEvent_type(_pointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "isTrusted", {
        get: function isTrusted() {
            return CPP_DKEvent_isTrusted(_pointer);
        }
    });
    //Read Only

    //Obsolete properties
    Object.defineProperty(this, "scoped", {
        get: function scoped() {
            return CPP_DKEvent_scoped(_pointer);
        }
    });
    //Read Only, Obsolete

    //Methods
    Event.prototype.createEvent = function createEvent() {
        //Deprecated
        CPP_DKEvent_createEvent(_pointer);
    }
    ;
    Event.prototype.composedPath = function composedPath() {
        CPP_DKEvent_composedPath(_pointer);
    }
    ;
    Event.prototype.initEvent = function initEvent() {
        //Deprecated
        CPP_DKEvent_initEvent(_pointer);
    }
    ;
    Event.prototype.preventDefault = function preventDefault() {
        CPP_DKEvent_preventDefault(_pointer);
    }
    ;
    Event.prototype.stopImmediatePropagation = function stopImmediatePropagation() {
        CPP_DKEvent_stopImmediatePropagation(_pointer);
    }
    ;
    Event.prototype.stopPropagation = function stopPropagation() {
        CPP_DKEvent_stopPropagation(_pointer);
    }
    ;

    //Obsolete methods
    Event.prototype.getPreventDefault = function getPreventDefault() {
        //Not standardized
        CPP_DKEvent_getPreventDefault(_pointer);
    }
    ;
    Event.prototype.preventBubble = function preventBubble() {
        //Not standardized, Obsolete
        CPP_DKEvent_preventBubble(_pointer);
    }
    ;
    Event.prototype.preventCapture = function preventCapture() {
        //Not standardized, Obsolete
        CPP_DKEvent_preventCapture(_pointer);
    }
    ;

	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object Event]"
		}
	}
	
    //console.log("dispatching event");
    //this.currentTarget.dispatchEvent(this);
    //return this;
};

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

////////////////////////////////
function doEvent(address, type){
	console.log("doEvent("+address+","+type+")")
	const event = new Event(type)
	event.target = new EventTarget(address)
	event.target.dispatchEvent(event)
}
