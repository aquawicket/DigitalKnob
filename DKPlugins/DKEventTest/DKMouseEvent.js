// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent
// [INTERFACE] https://w3c.github.io/uievents/#interface-keyboardevent


////// Constructor //////
// [MouseEvent()] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/MouseEvent
var MouseEvent = function MouseEvent(type, options, address) {
	console.log("MouseEvent("+type+","+options+","+address+")")
	
	if(!address){
		if(!this.address)
			this.address = CPP_DKMouseEvent(type, options);
	}
	else{
		this.address = address;
	}
	
	
	////// Static properties //////
	// [MouseEvent.WEBKIT_FORCE_AT_MOUSE_DOWN](Non-standard)(Read only) 
	// [MouseEvent.WEBKIT_FORCE_AT_FORCE_MOUSE_DOWN](Non-standard)(Read only)
	
	
	////// Instance properties //////
	// [MouseEvent.altKey](Read only)
	Object.defineProperty(this, "altKey", {
        get: function altKey() {
            return CPP_DKMouseEvent_altKey(this.address);
        }
    });
	// [MouseEvent.code](Read only)
	Object.defineProperty(this, "code", {
        get: function code() {
            return CPP_DKMouseEvent_code(this.address);
        }
    });
	// [MouseEvent.ctrlKey](Read only)
	Object.defineProperty(this, "ctrlKey", {
        get: function ctrlKey() {
            return CPP_DKMouseEvent_ctrlKey(this.address);
        }
    });
	// [MouseEvent.isComposing](Read only)
	Object.defineProperty(this, "isComposing", {
        get: function isComposing() {
            return CPP_DKMouseEvent_isComposing(this.address);
        }
    });
	// [MouseEvent.key](Read only)
	Object.defineProperty(this, "key", {
        get: function key() {
            return CPP_DKMouseEvent_key(this.address);
        }
    });
	// [MouseEvent.locale](Read only)
	Object.defineProperty(this, "locale", {
        get: function locale() {
            return CPP_DKMouseEvent_locale(this.address);
        }
    });
	// [MouseEvent.location](Read only)
	Object.defineProperty(this, "location", {
        get: function location() {
            return CPP_DKMouseEvent_location(this.address);
        }
    });
	// [MouseEvent.metaKey](Read only)
	Object.defineProperty(this, "metaKey", {
        get: function metaKey() {
            return CPP_DKMouseEvent_metaKey(this.address);
        }
    });
	// [MouseEvent.repeat](Read only)
	Object.defineProperty(this, "repeat", {
        get: function repeat() {
            return CPP_DKMouseEvent_repeat(this.address);
        }
    });
	// [MouseEvent.shiftKey](Read only)
	Object.defineProperty(this, "shiftKey", {
        get: function shiftKey() {
            return CPP_DKMouseEvent_shiftKey(this.address);
        }
    });
	

    ////// Instance methods //////
	// [MouseEvent.getModifierState()] 
	MouseEvent.prototype.getModifierState = function getModifierState() {
		CPP_DKMouseEvent_getModifierState(this.address);
    }


	/*
	////// Obsolete methods //////
	// [MouseEvent.initKeyEvent()](Deprecated)
	MouseEvent.prototype.initKeyEvent = function initKeyEvent() {
		CPP_DKMouseEvent_initKeyEvent(this.address);
    }
	// [MouseEvent.initMouseEvent()](Deprecated)
	MouseEvent.prototype.initMouseEvent = function initMouseEvent() {
		CPP_DKMouseEvent_initMouseEvent(this.address);
    }
	*/
	
	
	////// Obsolete properties //////
	// [MouseEvent.char](Non-standard)(Deprecated)(Read only)
	// [MouseEvent.charCode](Deprecated)(Read only)
	// [MouseEvent.keyCode](Deprecated)(Read only)
	// [MouseEvent.keyIdentifier](Non-standard)(Deprecated)(Read only)
	// [MouseEvent.keyLocation](Non-standard)(Deprecated)(Read only)
	// [MouseEvent.which](Deprecated)(Read only)

	
	////// Events //////
	// [keydown]
	// [keyup]
	
	
	////// Obsolete events //////
	// [keypress](Deprecated)
	
	
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object MouseEvent]"
		}
	}
	
	return UIEvent.call(this, type, options)
};
MouseEvent.prototype = UIEvent.prototype;
