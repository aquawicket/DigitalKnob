// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/FocusEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-focusevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface FocusEvent : UIEvent {
// constructor(DOMString type, optional FocusEventInit eventInitDict = {});
var FocusEvent = function FocusEvent(type, eventInitDict, address) {
	//console.log("FocusEvent("+type+","+eventInitDict+","+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKFocusEventDUK_constructor(type, eventInitDict);
	
	
	// readonly attribute EventTarget? relatedTarget;
	Object.defineProperty(this, "relatedTarget", {
        get: function relatedTarget() { return CPP_DKFocusEventDUK_relatedTarget(this.address) },
		set: function relatedTarget(v) { return CPP_DKFocusEventDUK_relatedTarget(this.address, v) },
		configurable: true,
    })


	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object FocusEvent]" }
	
	var event = UIEvent.call(this, type, eventInitDict)
	
	// Make properties (Read Only) after assignment
	Object.defineProperty(this, "relatedTarget",  { set: undefined })
	
	return event
};
FocusEvent.prototype = UIEvent.prototype;
