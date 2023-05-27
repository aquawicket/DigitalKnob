// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/CustomEvent.idl
// [SOURCE] https://dom.spec.whatwg.org/#interface-customevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface CustomEvent : Event {
// constructor(DOMString type, optional CustomEventInit eventInitDict = {});
var CustomEvent = function CustomEvent(type, eventInitDict, address) {
	//console.log("CustomEvent("+type+","+eventInitDict+","+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKCustomEventDUK(type, eventInitDict);

	// readonly attribute any detail;
	Object.defineProperty(this, "detail", {
        get: function detail()		{ return JSON.parse(CPP_DKCustomEventDUK_detail(this.address)) },
		set: function detail(str)	{ return JSON.parse(CPP_DKCustomEventDUK_detail(this.address, JSON.stringify(str))) },
		configurable: true,
    })
	
	// undefined initCustomEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false, optional any detail = null); // legacy
	CustomEvent.prototype.initCustomEvent = function initCustomEvent() {
		CPP_DKCustomEventDUK_initCustomEvent(this.address);
    }
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object CustomEvent]" }
	
	// assign eventInitDict
	var event = Event.call(this, type, eventInitDict)
	
	// Make properties (Read Only) after assignment
	//Object.defineProperty(this, "detail", 		{ set: undefined })
	
	return event
};
CustomEvent.prototype = Event.prototype;
