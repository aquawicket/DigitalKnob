// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Screen
// [INTERFACE] https://w3c.github.io/csswg-drafts/cssom-view/#the-screen-interface

var Screen = function Screen(pointer) {
	
	////// Instance properties //////
	// [Screen.availTop](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/availTop
	Object.defineProperty(this, "availTop", {
        configurable: true,
        get: function availTop() {
            return CPP_DKScreen_availTop(this.pointer);
        }
    })
	// [Screen.availLef](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/availLeft
	Object.defineProperty(this, "availLeft", {
        configurable: true,
        get: function availLeft() {
            return CPP_DKScreen_availLeft(this.pointer);
        }
    })
	// [Screen.availHeight] https://developer.mozilla.org/en-US/docs/Web/API/Screen/availHeight
	Object.defineProperty(this, "availHeight", {
        configurable: true,
        get: function availHeight() {
            return CPP_DKScreen_availHeight(this.pointer);
        }
    })
	// [Screen.availWidth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/availWidth
	Object.defineProperty(this, "availWidth", {
        configurable: true,
        get: function availWidth() {
            return CPP_DKScreen_availWidth(this.pointer);
        }
    })
	// [Screen.colorDepth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/colorDepth
	Object.defineProperty(this, "colorDepth", {
        configurable: true,
        get: function colorDepth() {
            return CPP_DKScreen_colorDepth(this.pointer);
        }
    })
	// [Screen.height] https://developer.mozilla.org/en-US/docs/Web/API/Screen/height
	Object.defineProperty(this, "height", {
        configurable: true,
        get: function height() {
            return CPP_DKScreen_height(this.pointer);
        }
    })
	// [Screen.left](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/left
	Object.defineProperty(this, "left", {
        configurable: true,
        get: function left() {
            return CPP_DKScreen_left(this.pointer);
        }
    })
	// [Screen.orientation] https://developer.mozilla.org/en-US/docs/Web/API/Screen/orientation
	Object.defineProperty(this, "orientation", {
        configurable: true,
        get: function orientation() {
            return CPP_DKScreen_orientation(this.pointer);
        }
    })
	// [Screen.pixelDepth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/pixelDepth
	Object.defineProperty(this, "pixelDepth", {
        configurable: true,
        get: function pixelDepth() {
            return CPP_DKScreen_pixelDepth(this.pointer);
        }
    })
	// [Screen.top])Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/top
	Object.defineProperty(this, "top", {
        configurable: true,
        get: function top() {
            return CPP_DKScreen_top(this.pointer);
        }
    })
	// [Screen.width] https://developer.mozilla.org/en-US/docs/Web/API/Screen/width
	Object.defineProperty(this, "width", {
        configurable: true,
        get: function width() {
            return CPP_DKScreen_width(this.pointer);
        }
    })
	// [Screen.mozEnabled](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/mozEnabled
	Object.defineProperty(this, "mozEnabled", {
        configurable: true,
        get: function mozEnabled() {
            return CPP_DKScreen_mozEnabled(this.pointer);
        }
    })
	// [Screen.mozBrightness](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/mozBrightness
    Object.defineProperty(this, "mozBrightness", {
        configurable: true,
        get: function mozBrightness() {
            return CPP_DKScreen_mozBrightness(this.pointer);
        }
    })

	////// Instance methods //////
	// [Screen.lockOrientation](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/lockOrientation
    Screen.prototype.lockOrientation = function lockOrientation(orientation) {
        return CPP_DKScreen_lockOrientation(orientation);
    }
	// [Screen.unlockOrientation](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/unlockOrientation
    Screen.prototype.unlockOrientation = function unlockOrientation() {
        return CPP_DKScreen_unlockOrientation();
    }

	////// Events //////
	// [orientationchange](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/orientationchange_event
	
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object Screen]"
		}
	}
	
    return EventTarget.call(this, pointer);
}
Screen.prototype = EventTarget.prototype;

var screen = new Screen("screen");
//window.screen = screen;
