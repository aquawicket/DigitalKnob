// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
// https://w3c.github.io/uievents/#interface-keyboardevent

<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
var KeyboardEvent = function KeyboardEvent(pointer) {
    // Properties
    Object.defineProperty(this, "altKey", {
        get: function altKey() {
=======
var KeyboardEvent = function KeyboardEvent(pointer){
    // Properties
    Object.defineProperty(this, "altKey", {
        get: function altKey(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
            return CPP_DKKeyboardEvent_altKey(pointer);
        }
    });
    Object.defineProperty(this, "code", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
        get: function code() {
=======
        get: function code(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
            return CPP_DKKeyboardEvent_code(pointer);
        }
    });
    Object.defineProperty(this, "ctrlKey", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
        get: function ctrlKey() {
=======
        get: function ctrlKey(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
            return CPP_DKKeyboardEvent_ctrlKey(pointer);
        }
    });
    Object.defineProperty(this, "isComposing", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
        get: function isComposing() {
=======
        get: function isComposing(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
            return CPP_DKKeyboardEvent_isComposing(pointer);
        }
    });
    Object.defineProperty(this, "key", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
        get: function key() {
=======
        get: function key(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
            return CPP_DKKeyboardEvent_key(pointer);
        }
    });
    Object.defineProperty(this, "locale", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
        get: function locale() {
=======
        get: function locale(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
            return CPP_DKKeyboardEvent_locale(pointer);
        }
    });
    Object.defineProperty(this, "location", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
        get: function location() {
=======
        get: function location(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
            return CPP_DKKeyboardEvent_location(pointer);
        }
    });
    Object.defineProperty(this, "metaKey", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
        get: function metaKey() {
=======
        get: function metaKey(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
            return CPP_DKKeyboardEvent_metaKey(pointer);
        }
    });
    Object.defineProperty(this, "repeat", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
        get: function repeat() {
=======
        get: function repeat(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
            return CPP_DKKeyboardEvent_repeat(pointer);
        }
    });
    Object.defineProperty(this, "shiftKey", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
        get: function shiftKey() {
=======
        get: function shiftKey(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
            return CPP_DKKeyboardEvent_shiftKey(pointer);
        }
    });

    // Methods
<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
    KeyboardEvent.prototype.getModifierState = function getModifierState() {
=======
    KeyboardEvent.prototype.getModifierState = function getModifierState(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
        CPP_DKKeyboardEvent_getModifierState(pointer);
    }
    ;

    // Obsolete methods
<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
    KeyboardEvent.prototype.initKeyEvent = function initKeyEvent() {
        CPP_DKKeyboardEvent_initKeyEvent(pointer);
    }
    ;
    KeyboardEvent.prototype.initKeyboardEvent = function initKeyboardEvent() {
=======
    KeyboardEvent.prototype.initKeyEvent = function initKeyEvent(){
        CPP_DKKeyboardEvent_initKeyEvent(pointer);
    }
    ;
    KeyboardEvent.prototype.initKeyboardEvent = function initKeyboardEvent(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
        CPP_DKKeyboardEvent_initKeyboardEvent(pointer);
    }
    ;

    //Obsolete properties
    Object.defineProperty(this, "char", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
        get: function char() {
=======
        get: function char(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
            return CPP_DKKeyboardEvent_char(pointer);
        }
    });
    Object.defineProperty(this, "charCode", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
        get: function charCode() {
=======
        get: function charCode(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
            return CPP_DKKeyboardEvent_charCode(pointer);
        }
    });
    Object.defineProperty(this, "keyCode", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
        get: function keyCode() {
=======
        get: function keyCode(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
            return CPP_DKKeyboardEvent_keyCode(pointer);
        }
    });
    Object.defineProperty(this, "keyIdentifier", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
        get: function keyIdentifier() {
=======
        get: function keyIdentifier(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
            return CPP_DKKeyboardEvent_keyIdentifier(pointer);
        }
    });
    Object.defineProperty(this, "keyLocation", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
        get: function keyLocation() {
=======
        get: function keyLocation(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
            return CPP_DKKeyboardEvent_keyLocation(pointer);
        }
    });
    Object.defineProperty(this, "which", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKKeyboardEvent.js
        get: function which() {
=======
        get: function which(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKKeyboardEvent.js
            return CPP_DKKeyboardEvent_which(pointer);
        }
    });

    return UIEvent.call(this, pointer);
};
KeyboardEvent.prototype = UIEvent.prototype;
