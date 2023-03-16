// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent
// [INTERFACE] https://w3c.github.io/uievents/#interface-mouseevent


// [MouseEvent()] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/MouseEvent
var MouseEvent = function(_type, _options, _pointer) {
	console.log("MouseEvent("+_type+", "+_options+", "+_pointer+")")
	
    ////// Instance properties //////
	// [MouseEvent.altKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/altKey
    Object.defineProperty(this, "altKey", {
        get: function altKey() {
            return CPP_DKDomMouseEvent_altKey(_pointer)
        }
    })
	// [MouseEvent.button](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/button
	//0. LeftButton
	//1. MiddleButton
	//2. RightButton
    Object.defineProperty(this, "button", {
        get: function button() {
            return CPP_DKDomMouseEvent_button(_pointer)
        }
    })
	// [MouseEvent.buttons](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/buttons
	//0. (No Buttons)
	//1. LeftButton
	//2. RightButton
	//3. LeftButton + RightButton
	//4. MiddleButton
	//5. LeftButton + MiddleButton
	//6. MiddleButton + RightButton
	//7. LeftButton + MiddleButton + RightButton
    Object.defineProperty(this, "buttons", {
        get: function buttons() {
            return CPP_DKDomMouseEvent_buttons(_pointer)
        }
    })
	// [MouseEvent.clientX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientX
    Object.defineProperty(this, "clientX", {
        get: function clientX() {
            return CPP_DKDomMouseEvent_clientX(_pointer)
        }
    })
	// [MouseEvent.clientY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientY
    Object.defineProperty(this, "clientY", {
        get: function clientY() {
            return CPP_DKDomMouseEvent_clientY(_pointer)
        }
    })
	// [MouseEvent.ctrlKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/ctrlKey
    Object.defineProperty(this, "ctrlKey", {
        get: function ctrlKey() {
            return CPP_DKDomMouseEvent_ctrlKey(_pointer)
        }
    })
	// [MouseEvent.layerX](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/layerX
	Object.defineProperty(this, "layerX", {
        get: function layerX() {
            return CPP_DKDomMouseEvent_layerX(_pointer)
        }
    })
	// [MouseEvent.layerY](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/layerY
	Object.defineProperty(this, "layerY", {
        get: function layerY() {
            return CPP_DKDomMouseEvent_layerY(_pointer)
        }
    })
	// [MouseEvent.metaKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/metaKey
    Object.defineProperty(this, "metaKey", {
        get: function metaKey() {
            return CPP_DKDomMouseEvent_metaKey(_pointer)
        }
    })
	// [MouseEvent.movementX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementX
    Object.defineProperty(this, "movementX", {
        get: function movementX() {
            return CPP_DKDomMouseEvent_movementX(_pointer)
        }
    })
	// [MouseEvent.movementY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementY
    Object.defineProperty(this, "movementY", {
        get: function movementY() {
            return CPP_DKDomMouseEvent_movementY(_pointer)
        }
    })
	// [MouseEvent.offsetX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetX
    Object.defineProperty(this, "offsetX", {
        get: function offsetX() {
            return CPP_DKDomMouseEvent_offsetX(_pointer)
        }
    })
	// [MouseEvent.offsetY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetY
    Object.defineProperty(this, "offsetY", {
        get: function offsetY() {
            return CPP_DKDomMouseEvent_offsetY(_pointer)
        }
    })
	// [MouseEvent.pageX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageX
    Object.defineProperty(this, "pageX", {
        get: function pageX() {
            return CPP_DKDomMouseEvent_pageX(_pointer)
        }
    })
	// [MouseEvent.pageY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageY
    Object.defineProperty(this, "pageY", {
        get: function pageY() {
            return CPP_DKDomMouseEvent_pageY(_pointer)
        }
    })
	// [MouseEvent.relatedTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/relatedTarget
    Object.defineProperty(this, "relatedTarget", {
        get: function relatedTarget() {
            return CPP_DKDomMouseEvent_relatedTarget(_pointer)
        }
    })
	// [MouseEvent.screenX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/screenX
    Object.defineProperty(this, "screenX", {
        get: function screenX() {
            return CPP_DKDomMouseEvent_screenX(_pointer)
        }
    })
	// [MouseEvent.screenY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/screenY
    Object.defineProperty(this, "screenY", {
        get: function screenY() {
            return CPP_DKDomMouseEvent_screenY(_pointer)
        }
    })
	// [MouseEvent.shiftKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/shiftKey
    Object.defineProperty(this, "shiftKey", {
        get: function shiftKey() {
            return CPP_DKDomMouseEvent_shiftKey(_pointer)
        }
    })
	// [MouseEvent.mozPressure](Read only)(Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent
    Object.defineProperty(this, "mozPressure", {
        get: function mozPressure() {
            return CPP_DKDomMouseEvent_mozPressure(_pointer)
        }
    })
	// [MouseEvent.mozInputSource](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/mozInputSource
    Object.defineProperty(this, "mozInputSource", {
        get: function mozInputSource() {
            return CPP_DKDomMouseEvent_mozInputSource(_pointer)
        }
    })
	// [MouseEvent.webkitForce](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/webkitForce
    Object.defineProperty(this, "webkitForce", {
        get: function webkitForce() {
            return CPP_DKDomMouseEvent_webkitForce(_pointer)
        }
    })
	// [MouseEvent.x](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/x
    Object.defineProperty(this, "x", {
        get: function x() {
            return CPP_DKDomMouseEvent_x(_pointer)
        }
    })
	// [MouseEvent.y](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/y
    Object.defineProperty(this, "y", {
        get: function y() {
            return CPP_DKDomMouseEvent_y(_pointer)
        }
    })

    ////// Methods //////
	// [MouseEvent.getModifierState()] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/getModifierState
    MouseEvent.prototype.getModifierState = function getModifierState() {
        CPP_DKDomMouseEvent_getModifierState(_pointer)
    }
    // [MouseEvent.initMouseEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/initMouseEvent
    MouseEvent.prototype.initMouseEvent = function initMouseEvent() {
        CPP_DKDomMouseEvent_initMouseEvent(_pointer)
    }
    
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object MouseEvent]"
		}
	}
	
    return UIEvent.call(this, _type, _options, _pointer)
}
MouseEvent.prototype = UIEvent.prototype


// Called from C++ to dispatch Mouse events
////////////////////////////////////////////////////////
function dispatchMouseEvent(_type, _options, _pointer) {
	console.log("dispatchMouseEvent("+_type+","+_options+","+_pointer+")")
	const event = new MouseEvent(_type, _options, _pointer)
	event.target = new EventTarget(_pointer)
	console.log("event.target = "+event.target)
	event.target.dispatchEvent(event)
}
