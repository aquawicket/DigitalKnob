//https://developer.mozilla.org/en-US/docs/Web/API/Screen

var Screen = function(pointer) {
    Object.defineProperty(this, "availTop", {
        configurable: true,
        get: function() {
            return CPP_DKScreen_availTop(this.pointer);
        }
    });
    Object.defineProperty(this, "availLeft", {
        configurable: true,
        get: function() {
            return CPP_DKScreen_availLeft(this.pointer);
        }
    });
    Object.defineProperty(this, "availHeight", {
        configurable: true,
        get: function() {
            return CPP_DKScreen_availHeight(this.pointer);
        }
    });
    Object.defineProperty(this, "availWidth", {
        configurable: true,
        get: function() {
            return CPP_DKScreen_availWidth(this.pointer);
        }
    });
    Object.defineProperty(this, "colorDepth", {
        configurable: true,
        get: function() {
            return CPP_DKScreen_colorDepth(this.pointer);
        }
    });
    Object.defineProperty(this, "height", {
        configurable: true,
        get: function() {
            return CPP_DKScreen_height(this.pointer);
        }
    });
    Object.defineProperty(this, "left", {
        configurable: true,
        get: function() {
            return CPP_DKScreen_left(this.pointer);
        }
    });
    Object.defineProperty(this, "orientation", {
        configurable: true,
        get: function() {
            return CPP_DKScreen_orientation(this.pointer);
        }
    });
    Object.defineProperty(this, "pixelDepth", {
        configurable: true,
        get: function() {
            return CPP_DKScreen_pixelDepth(this.pointer);
        }
    });
    Object.defineProperty(this, "top", {
        configurable: true,
        get: function() {
            return CPP_DKScreen_top(this.pointer);
        }
    });
    Object.defineProperty(this, "width", {
        configurable: true,
        get: function() {
            return CPP_DKScreen_width(this.pointer);
        }
    });
    Object.defineProperty(this, "mozEnabled", {
        configurable: true,
        get: function() {
            return CPP_DKScreen_mozEnabled(this.pointer);
        }
    });
    Object.defineProperty(this, "mozBrightness", {
        configurable: true,
        get: function() {
            return CPP_DKScreen_mozBrightness(this.pointer);
        }
    });

    Screen.prototype.lockOrientation = function(orientation) {
        return CPP_DKScreen_lockOrientation(orientation);
    }
    Screen.prototype.unlockOrientation = function() {
        return CPP_DKScreen_unlockOrientation();
    }

    return EventTarget.call(this, pointer);
}
Screen.prototype = EventTarget.prototype;

var screen = new Screen("screen");
