// [W3C] https://w3c.github.io/uievents/#events-focusevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent


// [FocusEvent()] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent/FocusEvent
var FocusEvent = function FocusEvent(type, options, address) {
	//console.log("FocusEvent("+type+","+options+","+address+")")
	
	options = JSON.stringify(options)
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKFocusEvent(type, options);
	

	////// Instance properties //////
	// [FocusEvent.relatedTarget](Read only)
	Object.defineProperty(this, "relatedTarget", {
        get: function relatedTarget() {
            return CPP_DKFocusEvent_relatedTarget(this.address);
        }
    });
	

	////// Events //////
	// [blur] https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event
	// [focus] https://developer.mozilla.org/en-US/docs/Web/API/Element/focus_event
	// [focusin] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusin_event
	// [focusout] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusout_event
	
	
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object FocusEvent]"
		}
	}
	
	return UIEvent.call(this, type, options)
};
FocusEvent.prototype = UIEvent.prototype;
