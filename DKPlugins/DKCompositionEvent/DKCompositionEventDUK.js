// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/CompositionEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-compositionevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface CompositionEvent : UIEvent {
// constructor(DOMString type, optional CompositionEventInit eventInitDict = {});
var CompositionEvent = function CompositionEvent(type, options, address) {
	console.log("CompositionEvent("+type+","+options+","+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKCompositionEventDUK_constructor(type, options);
	

	// readonly attribute DOMString data;
	Object.defineProperty(this, "data", {
        get: function data()		{ return CPP_DKCompositionEventDUK_data(this.address) },
		set: function data(data) 	{ return CPP_DKCompositionEventDUK_data(this.address, data) },
		configurable: true,
    })
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface CompositionEvent {
	// // Originally introduced (and deprecated) in this specification
	//		undefined initCompositionEvent(DOMString typeArg,
	//		optional boolean bubblesArg = false,
	//		optional boolean cancelableArg = false,
	//		optional WindowProxy? viewArg = null,
	//		optional DOMString dataArg = "");
	CompositionEvent.prototype.initCompositionEvent = function initCompositionEvent() {
		CPP_DKCompositionEventDUK_initCompositionEvent(this.address)
	}
	
	// };
		

	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object CompositionEvent]" }
	
	
	var event = UIEvent.call(this, type, options);
	
	// Make properties (Read Only) after assignment
	Object.defineProperty(this, "data", { set: undefined });
	
	return event;
};
CompositionEvent.prototype = UIEvent.prototype;
