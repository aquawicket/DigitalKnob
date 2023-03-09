// ConsoleWindow.js

//////////////////////////////////////////////////
var ConsoleWindow = function ConsoleWindow(data) {
	console.log("ConsoleWindow("+data+")");
    this.data = data;
	this.pointer = CPP_Duktape_createDKObject("ConsoleWindow")
	
	
	//// Instance properties ////
	Object.defineProperty(this, "innerHeight", {
        get: function innerHeight() {
            return CPP_ConsoleWindow_innerHeight(this.pointer)
        }
    })
	Object.defineProperty(this, "innerWidth", {
        get: function innerWidth() {
            return CPP_ConsoleWindow_innerWidth(this.pointer)
        }
    })
	Object.defineProperty(this, "outerHeight", {
        get: function outerHeight() {
            return CPP_ConsoleWindow_outerHeight(this.pointer)
        }
    })
	Object.defineProperty(this, "outerWidth", {
        get: function outerWidth() {
            return CPP_ConsoleWindow_outerWidth(this.pointer)
        }
    })
	Object.defineProperty(this, "screenX", {
        get: function screenX() {
            return CPP_ConsoleWindow_screenX(this.pointer)
        }
    })
	Object.defineProperty(this, "screenLeft", {
        get: function screenLeft() {
            return CPP_ConsoleWindow_screenLeft(this.pointer)
        }
    })
	Object.defineProperty(this, "screenY", {
        get: function screenY() {
            return CPP_ConsoleWindow_screenY(this.pointer)
        }
    })
	Object.defineProperty(this, "screenTop", {
        get: function screenTop() {
            return CPP_ConsoleWindow_screenTop(this.pointer)
        }
    })

	
	//// Instance methods ////
	ConsoleWindow.prototype.blur = function blur() {
		console.log("ConsoleWindow.prototype.blur()")
		CPP_ConsoleWindow_blur()
    }
	ConsoleWindow.prototype.close = function close() {
		console.log("ConsoleWindow.prototype.close()")
		CPP_ConsoleWindow_close()
    }
	ConsoleWindow.prototype.focus = function focus() {
		console.log("ConsoleWindow.prototype.focus()")
		CPP_ConsoleWindow_focus()
    }
	ConsoleWindow.prototype.moveBy = function moveBy(deltaX, deltaY) {
		console.log("ConsoleWindow.prototype.moveBy("+deltaX+", "+deltaY+")")
		CPP_ConsoleWindow_moveBy(deltaX, deltaY)
    }
	ConsoleWindow.prototype.moveTo = function moveTo(x, y) {
		console.log("ConsoleWindow.prototype.moveTo("+x+", "+y+")")
		CPP_ConsoleWindow_moveTo(x, y)
    }
	ConsoleWindow.prototype.resizeBy = function resizeBy(xDelta, yDelta) {
		console.log("ConsoleWindow.prototype.resizeBy("+xDelta+", "+yDelta+")")
		CPP_ConsoleWindow_resizeBy(xDelta, yDelta)
    }
	ConsoleWindow.prototype.resizeTo = function resizeTo(width, height) {
		console.log("ConsoleWindow.prototype.resizeTo("+width+", "+height+")")
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
