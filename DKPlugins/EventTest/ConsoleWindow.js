// ConsoleWindow.js

//////////////////////////////////////////////////
var ConsoleWindow = function ConsoleWindow(data) {
	console.log("ConsoleWindow("+data+")");
    this.data = data;
	this.pointer = CPP_Duktape_createDKObject("ConsoleWindow")
	
	
	//// Instance properties ////
	Object.defineProperty(this, "closed", { //Read only
        get: function closed() {
            return CPP_ConsoleWindow_closed()
        }
    })
	Object.defineProperty(this, "fullScreen", {
        get: function fullScreen() {
            return CPP_ConsoleWindow_fullScreen()
        }
    })
	Object.defineProperty(this, "innerHeight", { //Read only
        get: function innerHeight() {
            return CPP_ConsoleWindow_innerHeight()
        }
    })
	Object.defineProperty(this, "innerWidth", { //Read only
        get: function innerWidth() {
            return CPP_ConsoleWindow_innerWidth()
        }
    })
	Object.defineProperty(this, "name", {
        get: function name() {
            return CPP_ConsoleWindow_name()
        }
    })
	Object.defineProperty(this, "outerHeight", { //Read only
        get: function outerHeight() {
            return CPP_ConsoleWindow_outerHeight()
        }
    })
	Object.defineProperty(this, "outerWidth", { //Read only
        get: function outerWidth() {
            return CPP_ConsoleWindow_outerWidth()
        }
    })
	Object.defineProperty(this, "screenX", { //Read only
        get: function screenX() {
            return CPP_ConsoleWindow_screenX()
        }
    })
	Object.defineProperty(this, "screenLeft", { //Read only
        get: function screenLeft() {
            return CPP_ConsoleWindow_screenLeft()
        }
    })
	Object.defineProperty(this, "screenY", { //Read only
        get: function screenY() {
            return CPP_ConsoleWindow_screenY()
        }
    })
	Object.defineProperty(this, "screenTop", { //Read only
        get: function screenTop() {
            return CPP_ConsoleWindow_screenTop()
        }
    })

	
	//// Instance methods ////
	ConsoleWindow.prototype.blur = function blur() {
		CPP_ConsoleWindow_blur()
    }
	ConsoleWindow.prototype.close = function close() {
		CPP_ConsoleWindow_close()
    }
	ConsoleWindow.prototype.focus = function focus() {
		CPP_ConsoleWindow_focus()
    }
	ConsoleWindow.prototype.moveBy = function moveBy(deltaX, deltaY) {
		CPP_ConsoleWindow_moveBy(deltaX, deltaY)
    }
	ConsoleWindow.prototype.moveTo = function moveTo(x, y) {
		CPP_ConsoleWindow_moveTo(x, y)
    }
	ConsoleWindow.prototype.resizeBy = function resizeBy(xDelta, yDelta) {
		CPP_ConsoleWindow_resizeBy(xDelta, yDelta)
    }
	ConsoleWindow.prototype.resizeTo = function resizeTo(width, height) {
		CPP_ConsoleWindow_resizeTo(width, height)
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
		this.toString = function(){	return "[object ConsoleWindow]" }
	
	return EventTarget.call(this, this.pointer)
}
ConsoleWindow.prototype = EventTarget.prototype;
