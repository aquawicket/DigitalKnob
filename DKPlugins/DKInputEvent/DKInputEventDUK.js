// [W3C] https://w3c.github.io/uievents/#events-inputevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent


// [InputEvent()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/InputEvent
var InputEvent = function InputEvent(type, options, address) {
	//console.log("InputEvent("+type+","+options+","+address+")")
	
	if(address)
		this.address = address
	if(!this.address)
		this.address = CPP_DKInputEventDUK(type, options)
	

	////// Instance properties //////
	// [InputEvent.data](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/data
	Object.defineProperty(this, "data", {
        get: function data() 	{ return CPP_DKInputEventDUK_data(this.address) },
		set: function data(str) { return CPP_DKInputEventDUK_data(this.address, str) },
		configurable: true,
    })
	// [InputEvent.dataTransfer](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/dataTransfer
	Object.defineProperty(this, "dataTransfer", {
        get: function dataTransfer() { return CPP_DKInputEventDUK_dataTransfer(this.address) },
    })
	// [InputEvent.inputType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/inputType
	Object.defineProperty(this, "inputType", {
        get: function inputType()	{ return CPP_DKInputEventDUK_inputType(this.address) },
		set: function inputType(str){ return CPP_DKInputEventDUK_inputType(this.address, str) },
		configurable: true,
    })
	// [InputEvent.isComposing](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/isComposing
	Object.defineProperty(this, "isComposing", {
        get: function isComposing() 	{ return CPP_DKInputEventDUK_isComposing(this.address) },
		set: function isComposing(flag) { return CPP_DKInputEventDUK_isComposing(this.address, flag) },
		configurable: true,
    })
	

    ////// Instance methods //////
	// [InputEvent.getTargetRanges()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/getTargetRanges
	InputEvent.prototype.getTargetRanges = function getTargetRanges() {
		CPP_DKInputEventDUK_getTargetRanges(this.address)
    }
	
	
	////// Events //////
	// [beforeinput] https://w3c.github.io/uievents/#event-type-beforeinput
	// [input] https://w3c.github.io/uievents/#event-type-input
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object InputEvent]" }
	
	
	var event = UIEvent.call(this, type, options)
	
	// Make properties (Read Only) after assignment
	Object.defineProperty(this, "data", 		{ set: undefined })
	Object.defineProperty(this, "inputType", 	{ set: undefined })
	Object.defineProperty(this, "isComposing", 	{ set: undefined })
	
	return event
};
InputEvent.prototype = UIEvent.prototype;
