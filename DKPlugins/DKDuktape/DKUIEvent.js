// https://developer.mozilla.org/en-US/docs/Web/API/UIEvent

var UIEvent = function UIEvent(_type, _options, _pointer) {
	//console.log("UIEvent("+_type+","+_options+","+_pointer+")")
	
	/*
	this._type = _type;
	this._options = _options;
	this._pointer = _pointer;
	*/
	
    //// Properties ////
    Object.defineProperty(this, "detail", {
        //Read only
        get: function detail() {
            return CPP_DKUIEvent_detail(_pointer);
        }
    })
    Object.defineProperty(this, "sourceCapabilities", {
        //Read only
        get: function sourceCapabilities () {
            return CPP_DKUIEvent_sourceCapabilities(_pointer);
        }
    })
	Object.defineProperty(this, "view", {
        //Read only
        get: function view() {
            return CPP_DKUIEvent_view(_pointer);
        }
    })
	Object.defineProperty(this, "which", {
        //Read only
        get: function which() {
            return CPP_DKUIEvent_which(_pointer);
        }
    })

    //// Methods ////
    UIEvent.prototype.initUIEvent = function initUIEvent() {
        //Deprecated
        CPP_DKUIEvent_initUIEvent(this._pointer);
    }

	//// toString ////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object UIEvent]"
		}
	}
	
    return Event.call(this, _type, _options, _pointer);
};
UIEvent.prototype = Event.prototype;
