// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/InputEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-inputevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface InputEvent : UIEvent {
// constructor(DOMString type, optional InputEventInit eventInitDict = {});
var InputEvent = function InputEvent(type, options, address) {
	//console.log("InputEvent("+type+","+options+","+address+")")
	
	if(address)
		this.address = address
	if(!this.address)
		this.address = CPP_DKInputEventDUK_constructor(type, options)
	
	
	// readonly attribute DOMString? data;
	Object.defineProperty(this, "data", {
        get: function data() 	{ return CPP_DKInputEventDUK_data(this.address) },
		set: function data(str) { return CPP_DKInputEventDUK_data(this.address, str) },
		configurable: true,
    })
	
	// readonly attribute boolean isComposing;
	Object.defineProperty(this, "isComposing", {
        get: function isComposing() 	{ return CPP_DKInputEventDUK_isComposing(this.address) },
		set: function isComposing(flag) { return CPP_DKInputEventDUK_isComposing(this.address, flag) },
		configurable: true,
    })
	
	// readonly attribute DOMString inputType;
	Object.defineProperty(this, "inputType", {
        get: function inputType()	{ return CPP_DKInputEventDUK_inputType(this.address) },
		set: function inputType(str){ return CPP_DKInputEventDUK_inputType(this.address, str) },
		configurable: true,
    })
	
	// Source: Input Events Level 2 (https://www.w3.org/TR/input-events-2/)
	// partial interface InputEvent {
	//    	readonly attribute DataTransfer? dataTransfer;
			Object.defineProperty(this, "dataTransfer", {
				get: function dataTransfer() { return CPP_DKInputEventDUK_dataTransfer(this.address) },
			})
	//    	sequence<StaticRange> getTargetRanges();
			InputEvent.prototype.getTargetRanges = function getTargetRanges() {
				CPP_DKInputEventDUK_getTargetRanges(this.address)
			}
	// };


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
