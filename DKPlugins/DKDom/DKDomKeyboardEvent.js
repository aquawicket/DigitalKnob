// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
// https://w3c.github.io/uievents/#interface-keyboardevent

var KeyboardEvent = function KeyboardEvent(pointer) {
    // Properties
    Object.defineProperty(this, "altKey", {
        get: function altKey() {
            return CPP_DKDomKeyboardEvent_altKey(pointer)
        }
    })
    Object.defineProperty(this, "code", {
        get: function code() {
            return CPP_DKDomKeyboardEvent_code(pointer)
        }
    })
    Object.defineProperty(this, "ctrlKey", {
        get: function ctrlKey() {
            return CPP_DKDomKeyboardEvent_ctrlKey(pointer)
        }
    })
    Object.defineProperty(this, "isComposing", {
        get: function isComposing() {
            return CPP_DKDomKeyboardEvent_isComposing(pointer)
        }
    })
    Object.defineProperty(this, "key", {
        get: function key() {
            return CPP_DKDomKeyboardEvent_key(pointer)
        }
    })
    Object.defineProperty(this, "locale", {
        get: function locale() {
            return CPP_DKDomKeyboardEvent_locale(pointer)
        }
    })
    Object.defineProperty(this, "location", {
        get: function location() {
            return CPP_DKDomKeyboardEvent_location(pointer)
        }
    })
    Object.defineProperty(this, "metaKey", {
        get: function metaKey() {
            return CPP_DKDomKeyboardEvent_metaKey(pointer)
        }
    })
    Object.defineProperty(this, "repeat", {
        get: function repeat() {
            return CPP_DKDomKeyboardEvent_repeat(pointer)
        }
    })
    Object.defineProperty(this, "shiftKey", {
        get: function shiftKey() {
            return CPP_DKDomKeyboardEvent_shiftKey(pointer)
        }
    })

    // Methods
    KeyboardEvent.prototype.getModifierState = function getModifierState() {
        CPP_DKDomKeyboardEvent_getModifierState(pointer)
    }
    

    // Obsolete methods
    KeyboardEvent.prototype.initKeyEvent = function initKeyEvent() {
        CPP_DKDomKeyboardEvent_initKeyEvent(pointer)
    }
    
    KeyboardEvent.prototype.initKeyboardEvent = function initKeyboardEvent() {
        CPP_DKDomKeyboardEvent_initKeyboardEvent(pointer)
    }
    

    //Obsolete properties
    Object.defineProperty(this, "char", {
        get: function char() {
            return CPP_DKDomKeyboardEvent_char(pointer)
        }
    })
    Object.defineProperty(this, "charCode", {
        get: function charCode() {
            return CPP_DKDomKeyboardEvent_charCode(pointer)
        }
    })
    Object.defineProperty(this, "keyCode", {
        get: function keyCode() {
            return CPP_DKDomKeyboardEvent_keyCode(pointer)
        }
    })
    Object.defineProperty(this, "keyIdentifier", {
        get: function keyIdentifier() {
            return CPP_DKDomKeyboardEvent_keyIdentifier(pointer)
        }
    })
    Object.defineProperty(this, "keyLocation", {
        get: function keyLocation() {
            return CPP_DKDomKeyboardEvent_keyLocation(pointer)
        }
    })
    Object.defineProperty(this, "which", {
        get: function which() {
            return CPP_DKDomKeyboardEvent_which(pointer)
        }
    })

	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object KeyboardEvent]"
		}
	}
	
    return UIEvent.call(this, pointer)
}
KeyboardEvent.prototype = UIEvent.prototype
