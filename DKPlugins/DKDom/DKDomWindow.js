//https://developer.mozilla.org/en-US/docs/Web/API/Window

var Window = function(pointer) {
    // Properties
    Object.defineProperty(this, "closed", {
        get: function() {/* return CPP_DKDomWindow_closed(pointer); */
        }
    });
    Object.defineProperty(this, "console", {
        get: function() {
            return console;
        }
    });
    Object.defineProperty(this, "controllers", {
        get: function() {/* return CPP_DKDomWindow_controllers(pointer); */
        }
    });
    Object.defineProperty(this, "customElements", {
        get: function() {/* return CPP_DKDomWindow_customElements(pointer); */
        }
    });
    Object.defineProperty(this, "crypto", {
        get: function() {/* return CPP_DKDomWindow_crypto(pointer); */
        }
    });
    Object.defineProperty(this, "devicePixelRatio", {
        get: function() {
            return CPP_DKDomWindow_devicePixelRatio(pointer);
        },
        set: function(val) {
            return CPP_DKDomWindow_devicePixelRatio(pointer, val);
        }
    });
    Object.defineProperty(this, "dialogArguments", {
        get: function() {/* return CPP_DKDomWindow_dialogArguments(pointer); */
        }
    });
    Object.defineProperty(this, "document", {
        get: function() {
            return document;
        }
    });
    Object.defineProperty(this, "event", {
        get: function() {/* return CPP_DKDomWindow_event(pointer); */
        }
    });
    Object.defineProperty(this, "frameElement", {
        get: function() {/* return CPP_DKDomWindow_frameElement(pointer); */
        }
    });
    Object.defineProperty(this, "frames", {
        get: function() {/* return CPP_DKDomWindow_frames(pointer); */
        }
    });
    Object.defineProperty(this, "fullScreen", {
        get: function() {/* return CPP_DKDomWindow_fullScreen(pointer); */
        },
        set: function(val) {/* return CPP_DKDomWindow_fullScreen(pointer, val); */
        }
    });
    Object.defineProperty(this, "history", {
        get: function() {/* return CPP_DKDomWindow_history(pointer); */
        }
    });
    Object.defineProperty(this, "innerHeight", {
        get: function() {
            return CPP_DKDomWindow_innerHeight();
        }
    });
    Object.defineProperty(this, "innerWidth", {
        get: function() {
            return CPP_DKDomWindow_innerWidth();
        }
    });
    Object.defineProperty(this, "isSecureContext", {
        get: function() {/* return CPP_DKDomWindow_isSecureContext(); */
        }
    });
    Object.defineProperty(this, "length", {
        get: function() {/* return CPP_DKDomWindow_length(); */
        }
    });
    Object.defineProperty(this, "location", {
        get: function() {
            return location;
        }
    });
    Object.defineProperty(this, "locationbar", {
        get: function() {/* return CPP_DKDomWindow_locationbar(); */
        }
    });
    Object.defineProperty(this, "localStorage", {
        get: function() {/* return CPP_DKDomWindow_localStorage(); */
        }
    });
    Object.defineProperty(this, "menubar", {
        get: function() {/* return CPP_DKDomWindow_menubar(); */
        }
    });
    Object.defineProperty(this, "messageManager", {
        get: function() {/* return CPP_DKDomWindow_messageManager(); */
        }
    });
    Object.defineProperty(this, "mozAnimationStartTime", {
        get: function() {/* return CPP_DKDomWindow_mozAnimationStartTime(); */
        }
    });
    Object.defineProperty(this, "mozInnerScreenX", {
        get: function() {/* return CPP_DKDomWindow_mozInnerScreenX(); */
        }
    });
    Object.defineProperty(this, "mozInnerScreenY", {
        get: function() {/* return CPP_DKDomWindow_mozInnerScreenX(); */
        }
    });
    Object.defineProperty(this, "mozPaintCount", {
        get: function() {/* return CPP_DKDomWindow_mozPaintCount(); */
        }
    });
    Object.defineProperty(this, "name", {
        get: function() {
            return CPP_DKDomWindow_name();
        },
        set: function(val) {
            return CPP_DKDomWindow_name(val);
        }
    });
    Object.defineProperty(this, "navigator", {
        get: function() {
            return navigator;
        }
    });
    Object.defineProperty(this, "opener", {
        get: function() {/* return CPP_DKDomWindow_opener(); */
        }
    });
    Object.defineProperty(this, "orientation", {
        get: function() {/* return CPP_DKDomWindow_orientation(); */
        }
    });
    Object.defineProperty(this, "outerHeight", {
        get: function() {/* return CPP_DKDomWindow_outerHeight(); */
        }
    });
    Object.defineProperty(this, "outerWidth", {
        get: function() {/* return CPP_DKDomWindow_outerWidth(); */
        }
    });
    Object.defineProperty(this, "pageXOffset", {
        get: function() {/* return CPP_DKDomWindow_pageXOffset(); */
        }
    });
    Object.defineProperty(this, "pageYOffset", {
        get: function() {/* return CPP_DKDomWindow_pageYOffset(); */
        }
    });
    Object.defineProperty(this, "parent", {
        get: function() {/* return CPP_DKDomWindow_parent(); */
        }
    });
    Object.defineProperty(this, "performance", {
        get: function() {/* return CPP_DKDomWindow_performance(); */
        }
    });
    Object.defineProperty(this, "personalbar", {
        get: function() {/* return CPP_DKDomWindow_personalbar(); */
        }
    });
    Object.defineProperty(this, "returnValue", {
        get: function() {/* return CPP_DKDomWindow_returnValue(); */
        }
    });
    Object.defineProperty(this, "screen", {
        get: function() {
            return screen;
        }
    });
    Object.defineProperty(this, "screenX", {
        get: function() {/* return CPP_DKDomWindow_screenX(); */
        }
    });
    Object.defineProperty(this, "screenY", {
        get: function() {/* return CPP_DKDomWindow_screenY(); */
        }
    });
    Object.defineProperty(this, "scrollbars", {
        get: function() {/* return CPP_DKDomWindow_scrollbars(); */
        }
    });
    Object.defineProperty(this, "scrollMaxX", {
        get: function() {/* return CPP_DKDomWindow_scrollMaxX(); */
        }
    });
    Object.defineProperty(this, "scrollMaxY", {
        get: function() {/* return CPP_DKDomWindow_scrollMaxY(); */
        }
    });
    Object.defineProperty(this, "scrollX", {
        get: function() {/* return CPP_DKDomWindow_scrollX(); */
        }
    });
    Object.defineProperty(this, "scrollY", {
        get: function() {/* return CPP_DKDomWindow_scrollY(); */
        }
    });
    Object.defineProperty(this, "self", {
        get: function() {/* return CPP_DKDomWindow_self(); */
        }
    });
    Object.defineProperty(this, "sessionStorage", {
        get: function() {/* return CPP_DKDomWindow_sessionStorage(); */
        }
    });
    Object.defineProperty(this, "sidebar", {
        get: function() {/* return CPP_DKDomWindow_sidebar(); */
        }
    });
    Object.defineProperty(this, "speechSynthesis", {
        get: function() {/* return CPP_DKDomWindow_speechSynthesis(); */
        }
    });
    Object.defineProperty(this, "status", {
        get: function() {/* return CPP_DKDomWindow_status(); */
        },
        set: function(val) {/* return CPP_DKDomWindow_setStatus(); */
        }
    });
    Object.defineProperty(this, "statusbar", {
        get: function() {/* return CPP_DKDomWindow_statusbar(); */
        }
    });
    Object.defineProperty(this, "toolbar", {
        get: function() {/* return CPP_DKDomWindow_toolbar(); */
        }
    });
    Object.defineProperty(this, "top", {
        get: function() {
            return this;
        }
    });
    Object.defineProperty(this, "visualViewport", {
        get: function() {/* return CPP_DKDomWindow_visualViewport(); */
        }
    });
    Object.defineProperty(this, "window", {
        get: function() {/* return CPP_DKDomWindow_window(); */
        }
    });

    // Methods
    Window.prototype.alert = function(msg) {
        console.warn("alert: " + msg);
    }
    Window.prototype.blur = function() {}
    Window.prototype.cancelAnimationFrame = function() {}
    Window.prototype.cancelIdleCallback = function() {}
    Window.prototype.captureEvents = function() {}
    Window.prototype.clearImmediate = function() {}
    Window.prototype.close = function() {}
    Window.prototype.confirm = function() {}
    Window.prototype.dispatchEvent = function() {}
    Window.prototype.dump = function() {}
    Window.prototype.find = function() {}
    Window.prototype.focus = function() {}
    Window.prototype.getAttentionWithCycleCount = function() {}
    Window.prototype.getComputedStyle = function(element) {
        return new CSSStyleDeclaration(element.pointer);
        //var style = CPP_DKDomWindow_getComputedStyle(element.pointer); //TODO
    }
    Window.prototype.getDefaultComputedStyle = function() {}
    Window.prototype.getSelection = function() {}
    Window.prototype.matchMedia = function() {}
    Window.prototype.maximize = function() {}
    Window.prototype.minimize = function() {}
    Window.prototype.moveBy = function() {}
    Window.prototype.moveTo = function(x, y) {
        CPP_DKWindow_moveTo(x, y);
    }
    Window.prototype.open = function() {}
    Window.prototype.postMessage = function() {}
    Window.prototype.print = function() {}
    Window.prototype.prompt = function() {}
    Window.prototype.releaseEvents = function() {}
    Window.prototype.requestAnimationFrame = function() {}
    Window.prototype.requestIdleCallback = function() {}
    Window.prototype.resizeBy = function() {}
    Window.prototype.resizeTo = function(width, height) {
        CPP_DKWindow_resizeTo(width, height);
    }
    Window.prototype.scroll = function() {}
    Window.prototype.scrollBy = function() {}
    Window.prototype.scrollByLines = function() {}
    Window.prototype.scrollByPages = function() {}
    Window.prototype.scrollTo = function() {}
    Window.prototype.setCursor = function() {}
    Window.prototype.setImmediate = function() {}
    Window.prototype.setResizable = function() {}
    Window.prototype.sizeToContent = function() {}
    Window.prototype.stop = function() {}
    Window.prototype.updateCommands = function() {}

    //GlobalEventHandlers.call(this, pointer); //FIXME: should be a mixin
    return EventTarget.call(this, pointer);
}
Window.prototype = EventTarget.prototype;
Object.assign(Window.prototype, GlobalEventHandlers);
//mixin
var window = new Window("window");
//Create the global window object
var dk = new Object;
window.dk = dk;
dk.duktape = true;
const duktape = true;
