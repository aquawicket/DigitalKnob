// [W3C] https://w3c.github.io/uievents/#events-compositionevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent


// [CompositionEvent()] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/CompositionEvent
var CompositionEvent = function CompositionEvent(type, options, address) {
	//console.log("CompositionEvent("+type+","+options+","+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKCompositionEvent(type, options);
	

	////// Instance properties //////
	// [CompositionEvent.data](Read only) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/data
	Object.defineProperty(this, "data", {
        get: function data() {
            return CPP_DKCompositionEvent_data(this.address);
        }
    });
	// [CompositionEvent.locale](Read only) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/locale
	Object.defineProperty(this, "locale", {
        get: function locale() {
            return CPP_DKCompositionEvent_locale(this.address);
        }
    });
	

    ////// Instance methods //////
	// [CompositionEvent.initCompositionEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/initCompositionEvent
	CompositionEvent.prototype.initCompositionEvent = function initCompositionEvent() {
		CPP_DKCompositionEvent_initCompositionEvent(this.address);
    }
	
	
	////// Events //////
	// [compositionstart] https://w3c.github.io/uievents/#event-type-compositionstart
	// [compositionupdate] https://w3c.github.io/uievents/#event-type-compositionupdate
	// [compositionend] https://w3c.github.io/uievents/#event-type-compositionend
	
	
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object CompositionEvent]"
		}
	}
	
	return UIEvent.call(this, type, options)
};
CompositionEvent.prototype = UIEvent.prototype;
