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
        get: function detail() {
            return CPP_DKUIEvent_detail(this.address);
        }
    });
	// [UIEvent.sourceCapabilities](Read only)
	Object.defineProperty(this, "sourceCapabilities", {
        get: function sourceCapabilities() {
            return CPP_DKUIEvent_sourceCapabilities(this.address);
        }
    });
	// [UIEvent.view](Read only)
	Object.defineProperty(this, "view", {
        get: function view() {
            return CPP_DKUIEvent_view(this.address);
        }
    });
	// [UIEvent.which](Read only)
	Object.defineProperty(this, "which", {
        get: function which() {
            return CPP_DKUIEvent_which(this.address);
        }
    });
	

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
	
	return Event.call(this, type, options)
};
UIEvent.prototype = Event.prototype;
