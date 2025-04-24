//https://developer.mozilla.org/en-US/docs/Web/API/Screen

<<<<<<< HEAD:DKPlugins/DKDuktape/DKScreen.js
var Screen = function Screen(pointer) {
    Object.defineProperty(this, "availTop", {
        configurable: true,
        get: function availTop() {
=======
var Screen = function Screen(pointer){
    Object.defineProperty(this, "availTop", {
        configurable: true,
        get: function availTop(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKScreen.js
            return CPP_DKScreen_availTop(this.pointer);
        }
    });
    Object.defineProperty(this, "availLeft", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKScreen.js
        get: function availLeft() {
=======
        get: function availLeft(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKScreen.js
            return CPP_DKScreen_availLeft(this.pointer);
        }
    });
    Object.defineProperty(this, "availHeight", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKScreen.js
        get: function availHeight() {
=======
        get: function availHeight(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKScreen.js
            return CPP_DKScreen_availHeight(this.pointer);
        }
    });
    Object.defineProperty(this, "availWidth", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKScreen.js
        get: function availWidth() {
=======
        get: function availWidth(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKScreen.js
            return CPP_DKScreen_availWidth(this.pointer);
        }
    });
    Object.defineProperty(this, "colorDepth", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKScreen.js
        get: function colorDepth() {
=======
        get: function colorDepth(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKScreen.js
            return CPP_DKScreen_colorDepth(this.pointer);
        }
    });
    Object.defineProperty(this, "height", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKScreen.js
        get: function height() {
=======
        get: function height(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKScreen.js
            return CPP_DKScreen_height(this.pointer);
        }
    });
    Object.defineProperty(this, "left", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKScreen.js
        get: function left() {
=======
        get: function left(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKScreen.js
            return CPP_DKScreen_left(this.pointer);
        }
    });
    Object.defineProperty(this, "orientation", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKScreen.js
        get: function orientation() {
=======
        get: function orientation(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKScreen.js
            return CPP_DKScreen_orientation(this.pointer);
        }
    });
    Object.defineProperty(this, "pixelDepth", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKScreen.js
        get: function pixelDepth() {
=======
        get: function pixelDepth(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKScreen.js
            return CPP_DKScreen_pixelDepth(this.pointer);
        }
    });
    Object.defineProperty(this, "top", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKScreen.js
        get: function top() {
=======
        get: function top(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKScreen.js
            return CPP_DKScreen_top(this.pointer);
        }
    });
    Object.defineProperty(this, "width", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKScreen.js
        get: function width() {
=======
        get: function width(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKScreen.js
            return CPP_DKScreen_width(this.pointer);
        }
    });
    Object.defineProperty(this, "mozEnabled", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKScreen.js
        get: function mozEnabled() {
=======
        get: function mozEnabled(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKScreen.js
            return CPP_DKScreen_mozEnabled(this.pointer);
        }
    });
    Object.defineProperty(this, "mozBrightness", {
        configurable: true,
<<<<<<< HEAD:DKPlugins/DKDuktape/DKScreen.js
        get: function mozBrightness() {
=======
        get: function mozBrightness(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKScreen.js
            return CPP_DKScreen_mozBrightness(this.pointer);
        }
    });

<<<<<<< HEAD:DKPlugins/DKDuktape/DKScreen.js
    Screen.prototype.lockOrientation = function lockOrientation(orientation) {
        return CPP_DKScreen_lockOrientation(orientation);
    }
    Screen.prototype.unlockOrientation = function unlockOrientation() {
=======
    Screen.prototype.lockOrientation = function lockOrientation(orientation){
        return CPP_DKScreen_lockOrientation(orientation);
    }
    Screen.prototype.unlockOrientation = function unlockOrientation(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKScreen.js
        return CPP_DKScreen_unlockOrientation();
    }

    return EventTarget.call(this, pointer);
}
Screen.prototype = EventTarget.prototype;

var screen = new Screen("screen");
window.screen = screen;
