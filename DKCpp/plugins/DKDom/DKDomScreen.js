//https://developer.mozilla.org/en-US/docs/Web/API/Screen

<<<<<<< HEAD:DKPlugins/DKDom/DKDomScreen.js
var Screen = function Screen(pointer) {
    Object.defineProperty(this, "availTop", {
        get: function availTop() {
=======
var Screen = function Screen(pointer){
    Object.defineProperty(this, "availTop", {
        get: function availTop(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomScreen.js
            return CPP_DKDomScreen_availTop(this.pointer);
        }
    });
    Object.defineProperty(this, "availLeft", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomScreen.js
        get: function availLeft() {
=======
        get: function availLeft(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomScreen.js
            return CPP_DKDomScreen_availLeft(this.pointer);
        }
    });
    Object.defineProperty(this, "availHeight", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomScreen.js
        get: function availHeight() {
=======
        get: function availHeight(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomScreen.js
            return CPP_DKDomScreen_availHeight(this.pointer);
        }
    });
    Object.defineProperty(this, "availWidth", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomScreen.js
        get: function availWidth() {
=======
        get: function availWidth(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomScreen.js
            return CPP_DKDomScreen_availWidth(this.pointer);
        }
    });
    Object.defineProperty(this, "colorDepth", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomScreen.js
        get: function colorDepth() {
=======
        get: function colorDepth(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomScreen.js
            return CPP_DKDomScreen_colorDepth(this.pointer);
        }
    });
    Object.defineProperty(this, "height", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomScreen.js
        get: function height() {
=======
        get: function height(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomScreen.js
            return CPP_DKDomScreen_height(this.pointer);
        }
    });
    Object.defineProperty(this, "left", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomScreen.js
        get: function left() {
=======
        get: function left(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomScreen.js
            return CPP_DKDomScreen_left(this.pointer);
        }
    });
    Object.defineProperty(this, "orientation", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomScreen.js
        get: function orientation() {
=======
        get: function orientation(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomScreen.js
            return CPP_DKDomScreen_orientation(this.pointer);
        }
    });
    Object.defineProperty(this, "pixelDepth", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomScreen.js
        get: function pixelDepth() {
=======
        get: function pixelDepth(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomScreen.js
            return CPP_DKDomScreen_pixelDepth(this.pointer);
        }
    });
    Object.defineProperty(this, "top", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomScreen.js
        get: function top() {
=======
        get: function top(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomScreen.js
            return CPP_DKDomScreen_top(this.pointer);
        }
    });
    Object.defineProperty(this, "width", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomScreen.js
        get: function width() {
=======
        get: function width(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomScreen.js
            return CPP_DKDomScreen_width(this.pointer);
        }
    });
    Object.defineProperty(this, "mozEnabled", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomScreen.js
        get: function mozEnabled() {
=======
        get: function mozEnabled(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomScreen.js
            return CPP_DKDomScreen_mozEnabled(this.pointer);
        }
    });
    Object.defineProperty(this, "mozBrightness", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomScreen.js
        get: function mozBrightness() {
=======
        get: function mozBrightness(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomScreen.js
            return CPP_DKDomScreen_mozBrightness(this.pointer);
        }
    });

<<<<<<< HEAD:DKPlugins/DKDom/DKDomScreen.js
    Screen.prototype.lockOrientation = function lockOrientation(orientation) {
=======
    Screen.prototype.lockOrientation = function lockOrientation(orientation){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomScreen.js
        return CPP_DKDomScreen_lockOrientation(orientation);
    }
	/*
	Screen.prototype.toString = function toString(){
		return "[object Screen]"
	}
	*/
<<<<<<< HEAD:DKPlugins/DKDom/DKDomScreen.js
    Screen.prototype.unlockOrientation = function unlockOrientation() {
=======
    Screen.prototype.unlockOrientation = function unlockOrientation(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomScreen.js
        return CPP_DKDomScreen_unlockOrientation();
    }

    return EventTarget.call(this, pointer);
}

Screen.prototype = EventTarget.prototype;
var screen = new Screen("screen");
window.screen = screen;
