// [W3C] https://w3c.github.io/uievents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent


// [UIEvent()] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/UIEvent
var UIEvent = function UIEvent(type, options, address) {
	//console.log("UIEvent("+type+","+options+","+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKUIEvent(type, options);
	
	
	////// Instance properties //////
	// [UIEvent.detail](Read only)
	Object.defineProperty(this, "detail", {
        get: function detail() 		{ return CPP_DKUIEvent_detail(this.address) },
		set: function detail(num)	{ return CPP_DKUIEvent_detail(this.address, num) },
		configurable: true
    })
	// [UIEvent.sourceCapabilities](Read only)
	Object.defineProperty(this, "sourceCapabilities", {
        get: function sourceCapabilities()	{ return CPP_DKUIEvent_sourceCapabilities(this.address) },
		set: function sourceCapabilities(v)	{ return CPP_DKUIEvent_sourceCapabilities(this.address, v) },
		configurable: true
    })
	// [UIEvent.view](Read only)
	Object.defineProperty(this, "view", {
        get: function view() { return CPP_DKUIEvent_view(this.address) },
		set: function view(num)	{ return CPP_DKUIEvent_view(this.address, num) },
		configurable: true
    })
	// [UIEvent.which](Read only)
	Object.defineProperty(this, "which", {
        get: function which() { return CPP_DKUIEvent_which(this.address) }
    })
	

    ////// Instance methods //////
	// [UIEvent.initUIEvent()](Deprecated)
	UIEvent.prototype.initUIEvent = function initUIEvent() {
		CPP_DKUIEvent_initUIEvent(this.address);
    }
	
	
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object UIEvent]"
		}
	}
	
	
	var event = Event.call(this, type, options)
	
	// Make properties (Read Only) after assignment
	Object.defineProperty(this, "detail", 				{ set: undefined })
	Object.defineProperty(this, "sourceCapabilities", 	{ set: undefined })
	Object.defineProperty(this, "view", 				{ set: undefined })
	
	return event
};
UIEvent.prototype = Event.prototype;
