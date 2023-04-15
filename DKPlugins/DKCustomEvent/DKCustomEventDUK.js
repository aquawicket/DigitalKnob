// [INTERFACE] https://dom.spec.whatwg.org/#interface-customevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent


// [CustomEvent()] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent/CustomEvent
var CustomEvent = function CustomEvent(type, options, address) {
	//console.log("CustomEvent("+type+","+options+","+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKCustomEventDUK(type, options);

	
	////// Instance properties //////
	// [CustomEvent.detail](Read only)
	Object.defineProperty(this, "detail", {
        get: function detail()		{ return JSON.parse(CPP_DKCustomEventDUK_detail(this.address)) },
		set: function detail(str)	{ return JSON.parse(CPP_DKCustomEventDUK_detail(this.address, JSON.stringify(str))) },
		configurable: true,
    })
	

    ////// Instance methods //////
	// [CustomEvent.initCustomEvent()](Deprecated)
	CustomEvent.prototype.initCustomEvent = function initCustomEvent() {
		CPP_DKCustomEventDUK_initCustomEvent(this.address);
    }
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object CustomEvent]" }
	
	
	var event = Event.call(this, type, options)
	
	// Make properties (Read Only) after assignment
	Object.defineProperty(this, "detail", 		{ set: undefined })
	
	return event
};
CustomEvent.prototype = Event.prototype;
