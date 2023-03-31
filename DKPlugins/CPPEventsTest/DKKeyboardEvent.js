// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
// [INTERFACE] https://w3c.github.io/uievents/#interface-keyboardevent

// [KeyboardEvent()] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/KeyboardEvent
var KeyboardEvent = function KeyboardEvent(type, options, address) {
	console.log("KeyboardEvent("+type+","+options+","+address+")")
	
	if(!address){
		if(!this.address)
			this.address = CPP_DKKeyboardEvent(type, options);
	}
	else{
		this.address = address;
	}
	
	////// Constants //////
	// [DOM_KEY_LOCATION_STANDARD]	0x00
	// [DOM_KEY_LOCATION_LEFT]		0x01
	// [DOM_KEY_LOCATION_RIGHT]		0x02
	// [DOM_KEY_LOCATION_NUMPAD]	0x03
	
	
	////// Instance properties //////
	// [KeyboardEvent.altKey](Read only)
	Object.defineProperty(this, "altKey", {
        get: function altKey() {
            return CPP_DKKeyboardEvent_altKey(this.address);
        }
    });
	// [KeyboardEvent.code](Read only)
	Object.defineProperty(this, "code", {
        get: function code() {
            return CPP_DKKeyboardEvent_code(this.address);
        }
    });
	// [KeyboardEvent.ctrlKey](Read only)
	Object.defineProperty(this, "ctrlKey", {
        get: function ctrlKey() {
            return CPP_DKKeyboardEvent_ctrlKey(this.address);
        }
    });
	// [KeyboardEvent.isComposing](Read only)
	Object.defineProperty(this, "isComposing", {
        get: function isComposing() {
            return CPP_DKKeyboardEvent_isComposing(this.address);
        }
    });
	// [KeyboardEvent.key](Read only)
	Object.defineProperty(this, "key", {
        get: function key() {
            return CPP_DKKeyboardEvent_key(this.address);
        }
    });
	// [KeyboardEvent.locale](Read only)
	Object.defineProperty(this, "locale", {
        get: function locale() {
            return CPP_DKKeyboardEvent_locale(this.address);
        }
    });
	// [KeyboardEvent.location](Read only)
	Object.defineProperty(this, "location", {
        get: function location() {
            return CPP_DKKeyboardEvent_location(this.address);
        }
    });
	// [KeyboardEvent.metaKey](Read only)
	Object.defineProperty(this, "metaKey", {
        get: function metaKey() {
            return CPP_DKKeyboardEvent_metaKey(this.address);
        }
    });
	// [KeyboardEvent.repeat](Read only)
	Object.defineProperty(this, "repeat", {
        get: function repeat() {
            return CPP_DKKeyboardEvent_repeat(this.address);
        }
    });
	// [KeyboardEvent.shiftKey](Read only)
	Object.defineProperty(this, "shiftKey", {
        get: function shiftKey() {
            return CPP_DKKeyboardEvent_shiftKey(this.address);
        }
    });
	

    ////// Instance methods //////
	// [KeyboardEvent.getModifierState()] 
	KeyboardEvent.prototype.getModifierState = function getModifierState() {
		CPP_DKKeyboardEvent_getModifierState(this.address);
    }


	/*
	////// Obsolete methods //////
	// [KeyboardEvent.initKeyEvent()](Deprecated)
	KeyboardEvent.prototype.initKeyEvent = function initKeyEvent() {
		CPP_DKKeyboardEvent_initKeyEvent(this.address);
    }
	// [KeyboardEvent.initKeyboardEvent()](Deprecated)
	KeyboardEvent.prototype.initKeyboardEvent = function initKeyboardEvent() {
		CPP_DKKeyboardEvent_initKeyboardEvent(this.address);
    }
	*/
	
	
	////// Obsolete properties //////
	// [KeyboardEvent.char](Non-standard)(Deprecated)(Read only)
	// [KeyboardEvent.charCode](Deprecated)(Read only)
	// [KeyboardEvent.keyCode](Deprecated)(Read only)
	// [KeyboardEvent.keyIdentifier](Non-standard)(Deprecated)(Read only)
	// [KeyboardEvent.keyLocation](Non-standard)(Deprecated)(Read only)
	// [KeyboardEvent.which](Deprecated)(Read only)

	
	////// Events //////
	// [keydown]
	// [keyup]
	
	
	////// Obsolete events //////
	// [keypress](Deprecated)
	
	
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object KeyboardEvent]"
		}
	}
	
	return Event.call(this, type, options)
};
KeyboardEvent.prototype = Event.prototype;
