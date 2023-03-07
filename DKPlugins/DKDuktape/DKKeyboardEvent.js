// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
// https://w3c.github.io/uievents/#interface-keyboardevent

var KeyboardEvent = function KeyboardEvent(_type, _options, _pointer) {
	//console.log("KeyboardEvent("+_type+","+_options+","+_pointer+")")
	
	/*
	this._type = _type;
	this._options = _options;
	this._pointer = _pointer;
	*/
	
    // Properties
    Object.defineProperty(this, "altKey", {
        get: function altKey() {
            return CPP_DKKeyboardEvent_altKey(_pointer);
        }
    });
    Object.defineProperty(this, "code", {
        get: function code() {
            return CPP_DKKeyboardEvent_code(_pointer);
        }
    });
    Object.defineProperty(this, "ctrlKey", {
        get: function ctrlKey() {
            return CPP_DKKeyboardEvent_ctrlKey(_pointer);
        }
    });
    Object.defineProperty(this, "isComposing", {
        get: function isComposing() {
            return CPP_DKKeyboardEvent_isComposing(_pointer);
        }
    });
    Object.defineProperty(this, "key", {
        get: function key() {
            return CPP_DKKeyboardEvent_key(_pointer);
        }
    });
    Object.defineProperty(this, "locale", {
        get: function locale() {
            return CPP_DKKeyboardEvent_locale(_pointer);
        }
    });
    Object.defineProperty(this, "location", {
        get: function location() {
            return CPP_DKKeyboardEvent_location(_pointer);
        }
    });
    Object.defineProperty(this, "metaKey", {
        get: function metaKey() {
            return CPP_DKKeyboardEvent_metaKey(_pointer);
        }
    });
    Object.defineProperty(this, "repeat", {
        get: function repeat() {
            return CPP_DKKeyboardEvent_repeat(_pointer);
        }
    });
    Object.defineProperty(this, "shiftKey", {
        get: function shiftKey() {
            return CPP_DKKeyboardEvent_shiftKey(_pointer);
        }
    });

    // Methods
    KeyboardEvent.prototype.getModifierState = function getModifierState() {
        CPP_DKKeyboardEvent_getModifierState(_pointer);
    }
    ;

    // Obsolete methods
    KeyboardEvent.prototype.initKeyEvent = function initKeyEvent() {
        CPP_DKKeyboardEvent_initKeyEvent(_pointer);
    }
    ;
    KeyboardEvent.prototype.initKeyboardEvent = function initKeyboardEvent() {
        CPP_DKKeyboardEvent_initKeyboardEvent(_pointer);
    }
    ;

    //Obsolete properties
    Object.defineProperty(this, "char", {
        get: function char() {
            return CPP_DKKeyboardEvent_char(_pointer);
        }
    });
    Object.defineProperty(this, "charCode", {
        get: function charCode() {
            return CPP_DKKeyboardEvent_charCode(_pointer);
        }
    });
    Object.defineProperty(this, "keyCode", {
        get: function keyCode() {
            return CPP_DKKeyboardEvent_keyCode(_pointer);
        }
    });
    Object.defineProperty(this, "keyIdentifier", {
        get: function keyIdentifier() {
            return CPP_DKKeyboardEvent_keyIdentifier(_pointer);
        }
    });
    Object.defineProperty(this, "keyLocation", {
        get: function keyLocation() {
            return CPP_DKKeyboardEvent_keyLocation(_pointer);
        }
    });
    Object.defineProperty(this, "which", {
        get: function which() {
            return CPP_DKKeyboardEvent_which(_pointer);
        }
    });


	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object KeyboardEvent]"
		}
	}
	
	return UIEvent.call(this, _type, _options, _pointer)
};
KeyboardEvent.prototype = UIEvent.prototype;


////////////////////////////////////////////////////
function doKeyboardEvent(_type, _options, _pointer){
	//console.log("doKeyboardEvent("+_type+","+_options+","+_pointer+")")
	const event = new KeyboardEvent(_type, _options, _pointer)
	event.target = new EventTarget(_pointer)
	event.target.dispatchEvent(event)
}
