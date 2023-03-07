// https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent

var MouseEvent = function(_type, _options, _pointer) {
	//console.log("MouseEvent("+_type+","+_options+","+_pointer+")")
	
	/*
	this._type = _type;
	this._options = _options;
	this._pointer = _pointer;
	*/
	
    //// Properties ////
    Object.defineProperty(this, "altKey", {
        //Read only
        get: function altKey() {
            return CPP_DKMouseEvent_altKey(_pointer)
        }
    })
    Object.defineProperty(this, "button", {
        //Read only
        get: function button() {
            return CPP_DKMouseEvent_button(_pointer)
        }
    })
    Object.defineProperty(this, "buttons", {
        //Read only
        get: function buttons() {
            return CPP_DKMouseEvent_buttons(_pointer)
        }
    })
    Object.defineProperty(this, "clientX", {
        //Read only
        get: function clientX() {
            return CPP_DKMouseEvent_clientX(_pointer)
        }
    })
    Object.defineProperty(this, "clientY", {
        //Read only
        get: function clientY() {
            return CPP_DKMouseEvent_clientY(_pointer)
        }
    })
    Object.defineProperty(this, "ctrlKey", {
        //Read only
        get: function ctrlKey() {
            return CPP_DKMouseEvent_ctrlKey(_pointer)
        }
    })
    Object.defineProperty(this, "metaKey", {
        //Read only
        get: function metaKey() {
            return CPP_DKMouseEvent_metaKey(_pointer)
        }
    })
    Object.defineProperty(this, "movementX", {
        //Read only
        get: function movementX() {
            return CPP_DKMouseEvent_movementX(_pointer)
        }
    })
    Object.defineProperty(this, "movementY", {
        //Read only
        get: function movementY() {
            return CPP_DKMouseEvent_movementY(_pointer)
        }
    })
    Object.defineProperty(this, "offsetX", {
        //Read only
        get: function offsetX() {
            return CPP_DKMouseEvent_offsetX(_pointer)
        }
    })
    Object.defineProperty(this, "offsetY", {
        //Read only
        get: function offsetY() {
            return CPP_DKMouseEvent_offsetY(_pointer)
        }
    })
    Object.defineProperty(this, "pageX", {
        //Read only
        get: function pageX() {
            return CPP_DKMouseEvent_pageX(_pointer)
        }
    })
    Object.defineProperty(this, "pageY", {
        //Read only
        get: function pageY() {
            return CPP_DKMouseEvent_pageY(_pointer)
        }
    })
    Object.defineProperty(this, "region", {
        //Read only
        get: function region() {
            return CPP_DKMouseEvent_pageX(_pointer)
        }
    })
    Object.defineProperty(this, "relatedTarget", {
        //Read only
        get: function relatedTarget() {
            return CPP_DKMouseEvent_relatedTarget(_pointer)
        }
    })
    Object.defineProperty(this, "screenX", {
        //Read only
        get: function screenX() {
            return CPP_DKMouseEvent_screenX(_pointer)
        }
    })
    Object.defineProperty(this, "screenY", {
        //Read only
        get: function screenY() {
            return CPP_DKMouseEvent_screenY(_pointer)
        }
    })
    Object.defineProperty(this, "shiftKey", {
        //Read only
        get: function shiftKey() {
            return CPP_DKMouseEvent_shiftKey(_pointer)
        }
    })
    Object.defineProperty(this, "which", {
        //Read only
        get: function which() {
            return CPP_DKMouseEvent_which(_pointer)
        }
    })
    Object.defineProperty(this, "moxPressure", {
        //Read only,
        get: function moxPressure() {
            return CPP_DKMouseEvent_pageX(_pointer)
        }
    })
    Object.defineProperty(this, "mozInputSource", {
        //Read only
        get: function mozInputSource() {
            return CPP_DKMouseEvent_mozInputSource(_pointer)
        }
    })
    Object.defineProperty(this, "webkitForce", {
        //Read only
        get: function webkitForce() {
            return CPP_DKMouseEvent_webkitForce(_pointer)
        }
    })
    Object.defineProperty(this, "x", {
        //Read only
        get: function x() {
            return CPP_DKMouseEvent_x(_pointer)
        }
    })
    Object.defineProperty(this, "y", {
        //Read only
        get: function y() {
            return CPP_DKMouseEvent_y(_pointer)
        }
    })

    // Methods
    MouseEvent.prototype.getModifierState = function getModifierState() {
        CPP_DKMouseEvent_getModifierState(_pointer)
    }
    
    MouseEvent.prototype.initMouseEvent = function initMouseEvent() {
        CPP_DKMouseEvent_initMouseEvent(_pointer)
    }
    
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object MouseEvent]"
		}
	}
	
    return UIEvent.call(this, _type, _options, _pointer)
}
MouseEvent.prototype = UIEvent.prototype


/////////////////////////////////////////////////
function doMouseEvent(_type, _options, _pointer){
	console.log("doMouseEvent("+_type+","+_options+","+_pointer+")")
	const event = new MouseEvent(_type, _options, _pointer)
	event.target = new EventTarget(_pointer)
	event.target.dispatchEvent(event)
}
