//https://developer.mozilla.org/en-US/docs/Web/API/Screen

var Screen = function Screen(pointer) {
    Object.defineProperty(this, "availTop", {
        configurable: true,
        get: function availTop() {
            return CPP_DKScreen_availTop(this.pointer);
        }
    });
    Object.defineProperty(this, "availLeft", {
        configurable: true,
        get: function availLeft() {
            return CPP_DKScreen_availLeft(this.pointer);
        }
    });
    Object.defineProperty(this, "availHeight", {
        configurable: true,
        get: function availHeight() {
            return CPP_DKScreen_availHeight(this.pointer);
        }
    });
    Object.defineProperty(this, "availWidth", {
        configurable: true,
        get: function availWidth() {
            return CPP_DKScreen_availWidth(this.pointer);
        }
    });
    Object.defineProperty(this, "colorDepth", {
        configurable: true,
        get: function colorDepth() {
            return CPP_DKScreen_colorDepth(this.pointer);
        }
    });
    Object.defineProperty(this, "height", {
        configurable: true,
        get: function height() {
            return CPP_DKScreen_height(this.pointer);
        }
    });
    Object.defineProperty(this, "left", {
        configurable: true,
        get: function left() {
            return CPP_DKScreen_left(this.pointer);
        }
    });
    Object.defineProperty(this, "orientation", {
        configurable: true,
        get: function orientation() {
            return CPP_DKScreen_orientation(this.pointer);
        }
    });
    Object.defineProperty(this, "pixelDepth", {
        configurable: true,
        get: function pixelDepth() {
            return CPP_DKScreen_pixelDepth(this.pointer);
        }
    });
    Object.defineProperty(this, "top", {
        configurable: true,
        get: function top() {
            return CPP_DKScreen_top(this.pointer);
        }
    });
    Object.defineProperty(this, "width", {
        configurable: true,
        get: function width() {
            return CPP_DKScreen_width(this.pointer);
        }
    });
    Object.defineProperty(this, "mozEnabled", {
        configurable: true,
        get: function mozEnabled() {
            return CPP_DKScreen_mozEnabled(this.pointer);
        }
    });
    Object.defineProperty(this, "mozBrightness", {
        configurable: true,
        get: function mozBrightness() {
            return CPP_DKScreen_mozBrightness(this.pointer);
        }
    });

    Screen.prototype.lockOrientation = function lockOrientation(orientation) {
        return CPP_DKScreen_lockOrientation(orientation);
    }
    Screen.prototype.unlockOrientation = function unlockOrientation() {
        return CPP_DKScreen_unlockOrientation();
    }

    return EventTarget.call(this, pointer);
}
Screen.prototype = EventTarget.prototype;

var screen = new Screen("screen");
window.screen = screen;
