// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent
// [INTERFACE] https://w3c.github.io/uievents/#interface-focusevent

// [FocusEvent()] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent/FocusEvent
var FocusEvent = function(_type, _options, _pointer) {
	
    ////// Instance properties //////
	// [FocusEvent.relatedTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent/relatedTarget
    Object.defineProperty(this, "relatedTarget", {
        get: function relatedTarget() {
            return CPP_DKFocusEvent_relatedTarget(_pointer)
        }
    })
    
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object FocusEvent]"
		}
	}
	
    return UIEvent.call(this, _type, _options, _pointer)
}
FocusEvent.prototype = UIEvent.prototype


// Called from C++ to dispatch Focus events
////////////////////////////////////////////////////////
function dispatchFocusEvent(_type, _options, _pointer) {
	const event = new FocusEvent(_type, _options, _pointer)
	event.target = new EventTarget(_pointer)
	event.target.dispatchEvent(event)
}
