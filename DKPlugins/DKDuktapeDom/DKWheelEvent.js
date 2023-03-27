// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent
// [INTERFACE] https://w3c.github.io/uievents/#interface-wheelevent


// [WheelEvent()] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/WheelEvent
var WheelEvent = function(_type, _options, _pointer) {
	
    ////// Instance properties //////
	// [WheelEvent.deltaX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaX
    Object.defineProperty(this, "deltaX", {
        get: function deltaX() {
            return CPP_DKWheelEvent_deltaX(_pointer)
        }
    })
	// [WheelEvent.deltaY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaY
    Object.defineProperty(this, "deltaY", {
        get: function deltaY() {
            return CPP_DKWheelEvent_deltaY(_pointer)
        }
    })
	// [WheelEvent.deltaZ](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaZ
    Object.defineProperty(this, "deltaZ", {
        get: function deltaZ() {
            return CPP_DKWheelEvent_deltaZ(_pointer)
        }
    })
	// [WheelEvent.deltaMode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/deltaMode
    Object.defineProperty(this, "deltaMode", {
        get: function deltaMode() {
            return CPP_DKWheelEvent_deltaMode(_pointer)
        }
    })
	// [WheelEvent.wheelDelta](Read only)(Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/wheelDelta
    Object.defineProperty(this, "wheelDelta", {
        get: function wheelDelta() {
            return CPP_DKWheelEvent_wheelDelta(_pointer)
        }
    })
	// [WheelEvent.wheelDeltaX](Read only)(Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/wheelDeltaX
    Object.defineProperty(this, "wheelDeltaX", {
        get: function wheelDeltaX() {
            return CPP_DKWheelEvent_wheelDeltaX(_pointer)
        }
    })
	// [WheelEvent.wheelDeltaY](Read only)(Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent/wheelDeltaY
    Object.defineProperty(this, "wheelDeltaY", {
        get: function wheelDeltaY() {
            return CPP_DKWheelEvent_wheelDeltaY(_pointer)
        }
    })
    
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object WheelEvent]"
		}
	}
	
    return MouseEvent.call(this, _type, _options, _pointer)
}
WheelEvent.prototype = MouseEvent.prototype


// Called from C++ to dispatch Mouse events
////////////////////////////////////////////////////////
function dispatchWheelEvent(_type, _options, _pointer) {
	const event = new WheelEvent(_type, _options, _pointer)
	event.target = new EventTarget(_pointer)
	event.target.dispatchEvent(event)
}
