// https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent

var FocusEvent = function(_type, _options, _pointer) {
	//console.log("FocusEvent("+_type+","+_options+","+_pointer+")")
	
    //// Instance properties ////
    Object.defineProperty(this, "relatedTarget", { //Read only
        get: function relatedTarget() {
            return CPP_DKFocusEvent_relatedTarget(_pointer)
        }
    })
    
	//// toString ////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object FocusEvent]"
		}
	}
	
    return UIEvent.call(this, _type, _options, _pointer)
}
FocusEvent.prototype = UIEvent.prototype


/////////////////////////////////////////////////
function doFocusEvent(_type, _options, _pointer){
	//console.log("doFocusEvent("+_type+","+_options+","+_pointer+")")
	const event = new FocusEvent(_type, _options, _pointer)
	event.target = new EventTarget(_pointer)
	event.target.dispatchEvent(event)
}
