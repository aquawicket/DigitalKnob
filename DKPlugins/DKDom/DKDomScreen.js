//https://developer.mozilla.org/en-US/docs/Web/API/Screen

var Screen = function Screen(pointer) {
    Object.defineProperty(this, "availTop", {
        get: function availTop() {
            return CPP_DKDomScreen_availTop(this.pointer);
        }
    });
    Object.defineProperty(this, "availLeft", {
        get: function availLeft() {
            return CPP_DKDomScreen_availLeft(this.pointer);
        }
    });
    Object.defineProperty(this, "availHeight", {
        get: function availHeight() {
            return CPP_DKDomScreen_availHeight(this.pointer);
        }
    });
    Object.defineProperty(this, "availWidth", {
        get: function availWidth() {
            return CPP_DKDomScreen_availWidth(this.pointer);
        }
    });
    Object.defineProperty(this, "colorDepth", {
        get: function colorDepth() {
            return CPP_DKDomScreen_colorDepth(this.pointer);
        }
    });
    Object.defineProperty(this, "height", {
        get: function height() {
            return CPP_DKDomScreen_height(this.pointer);
        }
    });
    Object.defineProperty(this, "left", {
        get: function left() {
            return CPP_DKDomScreen_left(this.pointer);
        }
    });
    Object.defineProperty(this, "orientation", {
        get: function orientation() {
            return CPP_DKDomScreen_orientation(this.pointer);
        }
    });
    Object.defineProperty(this, "pixelDepth", {
        get: function pixelDepth() {
            return CPP_DKDomScreen_pixelDepth(this.pointer);
        }
    });
    Object.defineProperty(this, "top", {
        get: function top() {
            return CPP_DKDomScreen_top(this.pointer);
        }
    });
    Object.defineProperty(this, "width", {
        get: function width() {
            return CPP_DKDomScreen_width(this.pointer);
        }
    });
    Object.defineProperty(this, "mozEnabled", {
        get: function mozEnabled() {
            return CPP_DKDomScreen_mozEnabled(this.pointer);
        }
    });
    Object.defineProperty(this, "mozBrightness", {
        get: function mozBrightness() {
            return CPP_DKDomScreen_mozBrightness(this.pointer);
        }
    });

    Screen.prototype.lockOrientation = function lockOrientation(orientation) {
        return CPP_DKDomScreen_lockOrientation(orientation);
    }
	
    Screen.prototype.unlockOrientation = function unlockOrientation() {
        return CPP_DKDomScreen_unlockOrientation();
    }
	
	
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
