// https://html.spec.whatwg.org/
// https://developer.mozilla.org/en-US/docs/Web/API/Window

// https://html.spec.whatwg.org/multipage/window-object.html#the-window-object
var Window = function Window(pointer) 
{
    // Properties
    Object.defineProperty(this, "closed", {
        get: function closed() {
			return CPP_DKDomWindow_closed(pointer)
        }
    })
    Object.defineProperty(this, "console", {
        get: function console() {
            return console
        }
    })
    Object.defineProperty(this, "controllers", {
        get: function controllers() {
			return CPP_DKDomWindow_controllers(pointer)
        }
    })
    Object.defineProperty(this, "customElements", {
        get: function customElements() {
			return CPP_DKDomWindow_customElements(pointer)
        }
    })
    Object.defineProperty(this, "crypto", {
        get: function crypto() {
			return CPP_DKDomWindow_crypto(pointer)
        }
    })
    Object.defineProperty(this, "devicePixelRatio", {
        get: function devicePixelRatio() {
            return CPP_DKDomWindow_devicePixelRatio(pointer)
        },
        set: function devicePixelRatio(val) {
            return CPP_DKDomWindow_devicePixelRatio(pointer, val)
        }
    })
    Object.defineProperty(this, "dialogArguments", {
        get: function dialogArguments() {
			return CPP_DKDomWindow_dialogArguments(pointer)
        }
    })
    Object.defineProperty(this, "document", {
        get: function document() {
            return document
        }
    })
    Object.defineProperty(this, "event", {
        get: function event() {
			return CPP_DKDomWindow_event(pointer)
        }
    })
    Object.defineProperty(this, "frameElement", {
        get: function frameElement() {
			return CPP_DKDomWindow_frameElement(pointer)
        }
    })
    Object.defineProperty(this, "frames", {
        get: function frames() {
			return CPP_DKDomWindow_frames(pointer)
        }
    })
    Object.defineProperty(this, "fullScreen", {
        get: function fullScreen() {
			return CPP_DKDomWindow_fullScreen(pointer)
        },
        set: function fullScreen(val) {
			return CPP_DKDomWindow_fullScreen(pointer, val)
        }
    })
	
	// getComputedStyle: https://developer.mozilla.org/en-US/docs/Web/API/Window/getComputedStyle
	Object.defineProperty(this, "getComputedStyle", {
        get: function getComputedStyle() {
			return CPP_DKDomWindow_getComputedStyle(pointer)
        }
    })
	
    Object.defineProperty(this, "history", {
        get: function history() {
			return CPP_DKDomWindow_history(pointer)
        }
    })
    Object.defineProperty(this, "innerHeight", {
        get: function innerHeight() {
            return CPP_DKDomWindow_innerHeight()
        }
    })
    Object.defineProperty(this, "innerWidth", {
        get: function innerWidth() {
            return CPP_DKDomWindow_innerWidth()
        }
    })
    Object.defineProperty(this, "isSecureContext", {
        get: function isSecureContext() {
			return CPP_DKDomWindow_isSecureContext()
        }
    })
    Object.defineProperty(this, "length", {
        get: function length() {
			return CPP_DKDomWindow_length()
        }
    })
    Object.defineProperty(this, "location", {
        get: function location() {
            return location
        }
    })
    Object.defineProperty(this, "locationbar", {
        get: function locationbar() {
			return CPP_DKDomWindow_locationbar()
        }
    })
    Object.defineProperty(this, "localStorage", {
        get: function localStorage() {
			return CPP_DKDomWindow_localStorage()
        }
    })
    Object.defineProperty(this, "menubar", {
        get: function menubar() {
			return CPP_DKDomWindow_menubar()
        }
    })
    Object.defineProperty(this, "messageManager", {
        get: function messageManager() {
			return CPP_DKDomWindow_messageManager()
        }
    })
    Object.defineProperty(this, "mozAnimationStartTime", {
        get: function mozAnimationStartTime() {
			return CPP_DKDomWindow_mozAnimationStartTime()
        }
    })
    Object.defineProperty(this, "mozInnerScreenX", {
        get: function mozInnerScreenX() {
			return CPP_DKDomWindow_mozInnerScreenX()
        }
    })
    Object.defineProperty(this, "mozInnerScreenY", {
        get: function mozInnerScreenY() {
			return CPP_DKDomWindow_mozInnerScreenX()
        }
    })
    Object.defineProperty(this, "mozPaintCount", {
        get: function mozPaintCount() {
			return CPP_DKDomWindow_mozPaintCount()
        }
    })
    Object.defineProperty(this, "name", {
        get: function name() {
            return CPP_DKDomWindow_name()
        },
        set: function name(val) {
            return CPP_DKDomWindow_name(val)
        }
    })
    Object.defineProperty(this, "navigator", {
        get: function navigator() {
            return navigator
        }
    })
    Object.defineProperty(this, "opener", {
        get: function opener() {
			return CPP_DKDomWindow_opener()
        }
    })
    Object.defineProperty(this, "orientation", {
        get: function orientation() {
			return CPP_DKDomWindow_orientation()
        }
    })
    Object.defineProperty(this, "outerHeight", {
        get: function outerHeight() {
			return CPP_DKDomWindow_outerHeight()
        }
    })
    Object.defineProperty(this, "outerWidth", {
        get: function outerWidth() {
			return CPP_DKDomWindow_outerWidth()
        }
    })
    Object.defineProperty(this, "pageXOffset", {
        get: function pageXOffset() {
			return CPP_DKDomWindow_pageXOffset()
        }
    })
    Object.defineProperty(this, "pageYOffset", {
        get: function pageYOffset() {
			return CPP_DKDomWindow_pageYOffset()
        }
    })
    Object.defineProperty(this, "parent", {
        get: function parent() {
			return CPP_DKDomWindow_parent()
        }
    })
    Object.defineProperty(this, "performance", {
        get: function performance() {
			return CPP_DKDomWindow_performance()
        }
    })
    Object.defineProperty(this, "personalbar", {
        get: function personalbar() {
			return CPP_DKDomWindow_personalbar()
        }
    })
    Object.defineProperty(this, "returnValue", {
        get: function returnValue() {
			return CPP_DKDomWindow_returnValue()
        }
    })
    Object.defineProperty(this, "screen", {
        get: function screen() {
            return screen
        }
    })
    Object.defineProperty(this, "screenX", {
        get: function screenX() {
			return CPP_DKDomWindow_screenX()
        }
    })
    Object.defineProperty(this, "screenY", {
        get: function screenY() {
			return CPP_DKDomWindow_screenY()
        }
    })
    Object.defineProperty(this, "scrollbars", {
        get: function scrollbars() {
			return CPP_DKDomWindow_scrollbars()
        }
    })
    Object.defineProperty(this, "scrollMaxX", {
        get: function scrollMaxX() {
			return CPP_DKDomWindow_scrollMaxX()
        }
    })
    Object.defineProperty(this, "scrollMaxY", {
        get: function scrollMaxY() {
			return CPP_DKDomWindow_scrollMaxY()
        }
    })
    Object.defineProperty(this, "scrollX", {
        get: function scrollX() {
			return CPP_DKDomWindow_scrollX()
        }
    })
    Object.defineProperty(this, "scrollY", {
        get: function scrollY() {
			return CPP_DKDomWindow_scrollY()
        }
    })
    Object.defineProperty(this, "self", {
        get: function self() {
			return CPP_DKDomWindow_self()
        }
    })
    Object.defineProperty(this, "sessionStorage", {
        get: function sessionStorage() {
			return CPP_DKDomWindow_sessionStorage()
        }
    })
    Object.defineProperty(this, "sidebar", {
        get: function sidebar() {
			return CPP_DKDomWindow_sidebar()
        }
    })
    Object.defineProperty(this, "speechSynthesis", {
        get: function speechSynthesis() {
			return CPP_DKDomWindow_speechSynthesis()
        }
    })
    Object.defineProperty(this, "status", {
        get: function status() {
			return CPP_DKDomWindow_status()
        },
        set: function status(val) {
			return CPP_DKDomWindow_setStatus()
        }
    })
    Object.defineProperty(this, "statusbar", {
        get: function statusbar() {
			return CPP_DKDomWindow_statusbar()
        }
    })
    Object.defineProperty(this, "toolbar", {
        get: function toolbar() {
			return CPP_DKDomWindow_toolbar()
        }
    })
    Object.defineProperty(this, "top", {
        get: function top() {
            return this
        }
    })
    Object.defineProperty(this, "visualViewport", {
        get: function visualViewport() {
			return CPP_DKDomWindow_visualViewport()
        }
    })
    Object.defineProperty(this, "window", {
        get: function window() {
			return CPP_DKDomWindow_window()
        }
    })

    // Methods
    Window.prototype.alert = function alert(msg) {
        console.warn("alert: " + msg)
    }
    Window.prototype.blur = function blur() {}
    Window.prototype.cancelAnimationFrame = function cancelAnimationFrame() {}
    Window.prototype.cancelIdleCallback = function cancelIdleCallback() {}
    Window.prototype.captureEvents = function captureEvents() {}
    Window.prototype.clearImmediate = function clearImmediate() {}
    Window.prototype.close = function close() {}
    Window.prototype.confirm = function confirm() {}
    Window.prototype.dispatchEvent = function dispatchEvent() {}
    Window.prototype.dump = function dump() {}
    Window.prototype.find = function find() {}
    Window.prototype.focus = function focus() {}
    Window.prototype.getAttentionWithCycleCount = function getAttentionWithCycleCount() {}
    Window.prototype.getComputedStyle = function getComputedStyle(element) {
        return new CSSStyleDeclaration(element.pointer)
        //var style = CPP_DKDomWindow_getComputedStyle(element.pointer) //TODO
    }
    Window.prototype.getDefaultComputedStyle = function getDefaultComputedStyle() {}
    Window.prototype.getSelection = function getSelection() {}
    Window.prototype.matchMedia = function matchMedia() {}
    Window.prototype.maximize = function maximize() {}
    Window.prototype.minimize = function minimize() {}
    Window.prototype.moveBy = function moveBy() {}
    Window.prototype.moveTo = function moveTo(x, y) {
        CPP_DKWindow_moveTo(x, y)
    }
    Window.prototype.open = function open() {}
    Window.prototype.postMessage = function postMessage() {}
    Window.prototype.print = function print() {}
    Window.prototype.prompt = function prompt() {}
    Window.prototype.releaseEvents = function releaseEvents() {}
    Window.prototype.requestAnimationFrame = function requestAnimationFrame() {}
    Window.prototype.requestIdleCallback = function requestIdleCallback() {}
    Window.prototype.resizeBy = function resizeBy() {}
    Window.prototype.resizeTo = function resizeTo(width, height) {
        CPP_DKWindow_resizeTo(width, height)
    }
    Window.prototype.scroll = function scroll() {}
    Window.prototype.scrollBy = function scrollBy() {}
    Window.prototype.scrollByLines = function scrollByLines() {}
    Window.prototype.scrollByPages = function scrollByPages() {}
    Window.prototype.scrollTo = function scrollTo() {}
    Window.prototype.setCursor = function setCursor() {}
    Window.prototype.setImmediate = function setImmediate() {}
    Window.prototype.setResizable = function setResizable() {}
    Window.prototype.sizeToContent = function sizeToContent() {}
    Window.prototype.stop = function stop() {}
	/*
	Window.prototype.toString = function toString(){
		return "[object Window]"
	}
	*/
    Window.prototype.updateCommands = function updateCommands() {}
    Window.prototype.XMLHttpRequest = function XMLHttpRequest(client) {
        return new XMLHttpRequest(client.pointer)
    }
    return EventTarget.call(this, pointer)
}

// https://html.spec.whatwg.org/multipage/window-object.html#the-window-object
// interface Window : EventTarget
Window.prototype = EventTarget.prototype
Object.assign(Window.prototype, GlobalEventHandlers)
Object.assign(Window.prototype, WindowEventHandlers)

/*
//Create the global window object
var window = new Window("window")
globalThis.window = window

//Duktape miscellaneous
var dk = new Object
window.dk = dk
const DUKTAPE = true
window.DUKTAPE = DUKTAPE
console.log("DUKTAPE = "+DUKTAPE)
*/
