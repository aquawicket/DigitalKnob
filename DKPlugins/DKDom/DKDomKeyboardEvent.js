// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
// [INTERFACE] https://w3c.github.io/uievents/#interface-keyboardevent

// [KeyboardEvent()] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/KeyboardEvent
var KeyboardEvent = function KeyboardEvent(_type, _options, _pointer) {
	
    ////// Instance properties //////
	// [KeyboardEvent.altKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/altKey
    Object.defineProperty(this, "altKey", {
        get: function altKey() {
            return CPP_DKDomKeyboardEvent_altKey(_pointer);
        }
    })
	// [KeyboardEvent.code](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/code
    Object.defineProperty(this, "code", {
        get: function code() {
            var _code = CPP_DKDomKeyboardEvent_code(_pointer);
			console.log("_code = "+_code)
			return _code
        }
    })
	// [KeyboardEvent.ctrlKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/ctrlKey
    Object.defineProperty(this, "ctrlKey", {
        get: function ctrlKey() {
            return CPP_DKDomKeyboardEvent_ctrlKey(_pointer);
        }
    })
	// [KeyboardEvent.isComposing](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/isComposing
    Object.defineProperty(this, "isComposing", {
        get: function isComposing() {
            return CPP_DKDomKeyboardEvent_isComposing(_pointer);
        }
    })
	// [KeyboardEvent.key](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key
    Object.defineProperty(this, "key", {
        get: function key() {
            return CPP_DKDomKeyboardEvent_key(_pointer);
        }
    })
	// [KeyboardEvent.locale](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
    Object.defineProperty(this, "locale", {
        get: function locale() {
            return CPP_DKDomKeyboardEvent_locale(_pointer);
        }
    })
	// [KeyboardEvent.location](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/location
    Object.defineProperty(this, "location", {
        get: function location() {
            return CPP_DKDomKeyboardEvent_location(_pointer);
        }
    })
	// [KeyboardEvent.metaKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/metaKey
    Object.defineProperty(this, "metaKey", {
        get: function metaKey() {
            return CPP_DKDomKeyboardEvent_metaKey(_pointer);
        }
    })
	// [KeyboardEvent.repeat](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/repeat
    Object.defineProperty(this, "repeat", {
        get: function repeat() {
            return CPP_DKDomKeyboardEvent_repeat(_pointer);
        }
    })
	// [KeyboardEvent.shiftKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/shiftKey
    Object.defineProperty(this, "shiftKey", {
        get: function shiftKey() {
            return CPP_DKDomKeyboardEvent_shiftKey(_pointer);
        }
    })

    ////// Instance methods //////
	// [KeyboardEvent.getModifierState()] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/getModifierState
    KeyboardEvent.prototype.getModifierState = function getModifierState() {
        CPP_DKDomKeyboardEvent_getModifierState(_pointer);
    }

    ////// Obsolete Methods //////
	/*
	// [KeyboardEvent.initKeyEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/initKeyEvent
    KeyboardEvent.prototype.initKeyEvent = function initKeyEvent() {
        CPP_DKDomKeyboardEvent_initKeyEvent(_pointer);
    }
	// [KeyboardEvent.initKeyboardEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/initKeyboardEvent
    KeyboardEvent.prototype.initKeyboardEvent = function initKeyboardEvent() {
        CPP_DKDomKeyboardEvent_initKeyboardEvent(_pointer);
    }
	*/

    ////// Obsolete Properties //////
	/*
	// [Keyboard.char](Read only)(Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
    Object.defineProperty(this, "char", {
        get: function char() {
            return CPP_DKDomKeyboardEvent_char(_pointer);
        }
    });
	// [Keyboard.charCode](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/charCode
    Object.defineProperty(this, "charCode", {
        get: function charCode() {
            return CPP_DKDomKeyboardEvent_charCode(_pointer);
        }
    });
	// [Keyboard.keyCode](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyCode
    Object.defineProperty(this, "keyCode", {
        get: function keyCode() {
            return CPP_DKDomKeyboardEvent_keyCode(_pointer);
        }
    });
	// [Keyboard.keyIdentifier](Read only)(Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyIdentifier
    Object.defineProperty(this, "keyIdentifier", {
        get: function keyIdentifier() {
            return CPP_DKDomKeyboardEvent_keyIdentifier(_pointer);
        }
    });
	// [Keyboard.keyLocation](Read only)(Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
    Object.defineProperty(this, "keyLocation", {
        get: function keyLocation() {
            return CPP_DKDomKeyboardEvent_keyLocation(_pointer);
        }
    });
	// [Keyboard.which](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/which
    Object.defineProperty(this, "which", {
        get: function which() {
            return CPP_DKDomKeyboardEvent_which(_pointer);
        }
    });
	*/

	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object KeyboardEvent]"
		}
	}
	
	return UIEvent.call(this, _type, _options, _pointer)
};
KeyboardEvent.prototype = UIEvent.prototype;


// Called from C++ to dispatch Keyboard events
///////////////////////////////////////////////////////////
function dispatchKeyboardEvent(_type, _options, _pointer) {
	const event = new KeyboardEvent(_type, _options, _pointer)
	event.target = new EventTarget(_pointer)
	event.target.dispatchEvent(event)
}
