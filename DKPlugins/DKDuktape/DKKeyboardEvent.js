// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
// https://w3c.github.io/uievents/#interface-keyboardevent

var KeyboardEvent = function(pointer) {
    // Properties
    Object.defineProperty(this, "altKey", {
        get: function() {
            return CPP_DKKeyboardEvent_altKey(pointer);
        }
    });
    Object.defineProperty(this, "code", {
        get: function() {
            return CPP_DKKeyboardEvent_code(pointer);
        }
    });
    Object.defineProperty(this, "ctrlKey", {
        get: function() {
            return CPP_DKKeyboardEvent_ctrlKey(pointer);
        }
    });
    Object.defineProperty(this, "isComposing", {
        get: function() {
            return CPP_DKKeyboardEvent_isComposing(pointer);
        }
    });
    Object.defineProperty(this, "key", {
        get: function() {
            return CPP_DKKeyboardEvent_key(pointer);
        }
    });
    Object.defineProperty(this, "locale", {
        get: function() {
            return CPP_DKKeyboardEvent_locale(pointer);
        }
    });
    Object.defineProperty(this, "location", {
        get: function() {
            return CPP_DKKeyboardEvent_location(pointer);
        }
    });
    Object.defineProperty(this, "metaKey", {
        get: function() {
            return CPP_DKKeyboardEvent_metaKey(pointer);
        }
    });
    Object.defineProperty(this, "repeat", {
        get: function() {
            return CPP_DKKeyboardEvent_repeat(pointer);
        }
    });
    Object.defineProperty(this, "shiftKey", {
        get: function() {
            return CPP_DKKeyboardEvent_shiftKey(pointer);
        }
    });

    // Methods
    KeyboardEvent.prototype.getModifierState = function() {
        CPP_DKKeyboardEvent_getModifierState(pointer);
    }
    ;

    // Obsolete methods
    KeyboardEvent.prototype.initKeyEvent = function() {
        CPP_DKKeyboardEvent_initKeyEvent(pointer);
    }
    ;
    KeyboardEvent.prototype.initKeyboardEvent = function() {
        CPP_DKKeyboardEvent_initKeyboardEvent(pointer);
    }
    ;

    //Obsolete properties
    Object.defineProperty(this, "char", {
        get: function() {
            return CPP_DKKeyboardEvent_char(pointer);
        }
    });
    Object.defineProperty(this, "charCode", {
        get: function() {
            return CPP_DKKeyboardEvent_charCode(pointer);
        }
    });
    Object.defineProperty(this, "keyCode", {
        get: function() {
            return CPP_DKKeyboardEvent_keyCode(pointer);
        }
    });
    Object.defineProperty(this, "keyIdentifier", {
        get: function() {
            return CPP_DKKeyboardEvent_keyIdentifier(pointer);
        }
    });
    Object.defineProperty(this, "keyLocation", {
        get: function() {
            return CPP_DKKeyboardEvent_keyLocation(pointer);
        }
    });
    Object.defineProperty(this, "which", {
        get: function() {
            return CPP_DKKeyboardEvent_which(pointer);
        }
    });

    return UIEvent.call(this, pointer);
};
KeyboardEvent.prototype = UIEvent.prototype;
