// DKConsoleWindow.js

//////////////////////////////////////////////////////
var DKConsoleWindow = function DKConsoleWindow(data) {
	console.log("DKConsoleWindow("+data+")");
    this.data = data;
	this.address = CPP_Duktape_createDKObject("DKConsoleWindow")
	console.log("JS ConsoleWindow address = "+this.address)
	
	
	//// Instance properties ////
	Object.defineProperty(this, "closed", { //Read only
        get: function closed() {
            return CPP_DKConsoleWindow_closed()
        }
    })
	Object.defineProperty(this, "columns", { //Read only
        get: function columns() {
            return CPP_DKConsoleWindow_columns()
        }
    })
	Object.defineProperty(this, "fullScreen", {
        get: function fullScreen() {
            return CPP_DKConsoleWindow_fullScreen()
        },
		set: function fullScreen(truefalse) {
			CPP_DKConsoleWindow_fullScreen(truefalse)
		}
    })
	Object.defineProperty(this, "innerHeight", { //Read only
        get: function innerHeight() {
            return CPP_DKConsoleWindow_innerHeight()
        }
    })
	Object.defineProperty(this, "innerWidth", { //Read only
        get: function innerWidth() {
            return CPP_DKConsoleWindow_innerWidth()
        }
    })
	Object.defineProperty(this, "name", {
        get: function name() {
            return CPP_DKConsoleWindow_name()
        },
		set: function name(str) {
			CPP_DKConsoleWindow_name(str)
		}
    })
	Object.defineProperty(this, "outerHeight", { //Read only
        get: function outerHeight() {
            return CPP_DKConsoleWindow_outerHeight()
        }
    })
	Object.defineProperty(this, "outerWidth", { //Read only
        get: function outerWidth() {
            return CPP_DKConsoleWindow_outerWidth()
        }
    })
	Object.defineProperty(this, "rows", { //Read only
        get: function rows() {
            return CPP_DKConsoleWindow_rows()
        }
    })
	Object.defineProperty(this, "screenX", { //Read only
        get: function screenX() {
            return CPP_DKConsoleWindow_screenX()
        }
    })
	Object.defineProperty(this, "screenLeft", { //Read only
        get: function screenLeft() {
            return CPP_DKConsoleWindow_screenLeft()
        }
    })
	Object.defineProperty(this, "screenY", { //Read only
        get: function screenY() {
            return CPP_DKConsoleWindow_screenY()
        }
    })
	Object.defineProperty(this, "screenTop", { //Read only
        get: function screenTop() {
            return CPP_DKConsoleWindow_screenTop()
        }
    })

	
	//// Instance methods ////
	DKConsoleWindow.prototype.blur = function blur() {
		CPP_DKConsoleWindow_blur()
    }
	DKConsoleWindow.prototype.close = function close() {
		CPP_DKConsoleWindow_close()
    }
	DKConsoleWindow.prototype.focus = function focus() {
		CPP_DKConsoleWindow_focus()
    }
	DKConsoleWindow.prototype.moveBy = function moveBy(deltaX, deltaY) {
		CPP_DKConsoleWindow_moveBy(deltaX, deltaY)
    }
	DKConsoleWindow.prototype.moveTo = function moveTo(x, y) {
		CPP_DKConsoleWindow_moveTo(x, y)
    }
	DKConsoleWindow.prototype.resizeBy = function resizeBy(xDelta, yDelta) {
		CPP_DKConsoleWindow_resizeBy(xDelta, yDelta)
    }
	DKConsoleWindow.prototype.resizeTo = function resizeTo(width, height) {
		CPP_DKConsoleWindow_resizeTo(width, height)
    }
	
	
	//// Instance events ////
	this.message_func = null;
    Object.defineProperty(this, "onmessage", {
        get: function onmessage() {
            return this.message_func;
        },
        set: function onmessage(func) {
            func && this.addEventListener("message", func)
			!func && this.removeEventListener("message", this.message_func)
            this.message_func = func
        }
    });
	
	
	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object DKConsoleWindow]" }
	
	return EventTarget.call(this, this.address)
}
DKConsoleWindow.prototype = EventTarget.prototype;
