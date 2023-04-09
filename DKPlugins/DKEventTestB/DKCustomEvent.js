// [INTERFACE] https://dom.spec.whatwg.org/#interface-customevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent


// [CustomEvent()] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent/CustomEvent
var CustomEvent = function CustomEvent(type, options, address) {
	//console.log("CustomEvent("+type+","+options+","+address+")")
	
	
	//options = JSON.stringify(options);
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKCustomEvent(type, options);

	
	////// Instance properties //////
	// [CustomEvent.detail](Read only)
	Object.defineProperty(this, "detail", {
        get: function detail() {
            return CPP_DKCustomEvent_detail(this.address);
        }
    });
	

    ////// Instance methods //////
	// [CustomEvent.initCustomEvent()](Deprecated)
	CustomEvent.prototype.initCustomEvent = function initCustomEvent() {
		CPP_DKCustomEvent_initCustomEvent(this.address);
    }
	
	
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object CustomEvent]"
		}
	}
	
	return Event.call(this, type, options)
};
CustomEvent.prototype = Event.prototype;
