// [W3C] https://w3c.github.io/uievents/#events-compositionevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent


// [CompositionEvent()] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/CompositionEvent
var CompositionEvent = function CompositionEvent(type, options, address) {
	//console.log("CompositionEvent("+type+","+options+","+address+")")
	
	if(address)
		this.address = address
	if(!this.address)
		this.address = CPP_DKCompositionEventDUK(type, options)
	

	////// Instance properties //////
	// [CompositionEvent.data](Read only) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/data
	Object.defineProperty(this, "data", {
        get: function data()		{ return CPP_DKCompositionEventDUK_data(this.address) },
		set: function data(data) 	{ return CPP_DKCompositionEventDUK_data(this.address, data) },
		configurable: true,
    })
	// [CompositionEvent.locale](Read only) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/locale
	Object.defineProperty(this, "locale", {
        get: function locale() 		{ return CPP_DKCompositionEventDUK_locale(this.address) },
		//set: function locale(data) 	{ return CPP_DKCompositionEventDUK_locale(this.address, data) },
    })
	

    ////// Instance methods //////
	// [CompositionEvent.initCompositionEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/initCompositionEvent
	CompositionEvent.prototype.initCompositionEvent = function initCompositionEvent() {
		CPP_DKCompositionEventDUK_initCompositionEvent(this.address)
    }
	
	
	////// Events //////
	// [compositionstart] https://w3c.github.io/uievents/#event-type-compositionstart
	// [compositionupdate] https://w3c.github.io/uievents/#event-type-compositionupdate
	// [compositionend] https://w3c.github.io/uievents/#event-type-compositionend
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object CompositionEvent]" }
	
	
	var event = UIEvent.call(this, type, options)
	
	// Make properties (Read Only) after assignment
	Object.defineProperty(this, "data", { set: undefined })
	
	return event
};
CompositionEvent.prototype = UIEvent.prototype;
