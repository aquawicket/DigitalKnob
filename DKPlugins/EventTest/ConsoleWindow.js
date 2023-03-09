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
		CPP_ConsoleWindow_blur(this.pointer)
    }
	ConsoleWindow.prototype.close = function close() {
		console.log("ConsoleWindow.prototype.close()")
		CPP_ConsoleWindow_close(this.pointer)
    }
	ConsoleWindow.prototype.focus = function focus() {
		console.log("ConsoleWindow.prototype.focus()")
		CPP_ConsoleWindow_focus(this.pointer)
    }
	ConsoleWindow.prototype.moveBy = function moveBy() {
		console.log("ConsoleWindow.prototype.moveBy()")
		CPP_ConsoleWindow_moveBy(this.pointer)
    }
	ConsoleWindow.prototype.moveTo = function moveTo() {
		console.log("ConsoleWindow.prototype.moveTo()")
		CPP_ConsoleWindow_moveTo(this.pointer)
    }
	ConsoleWindow.prototype.resizeBy = function resizeBy() {
		console.log("ConsoleWindow.prototype.resizeBy()")
		CPP_ConsoleWindow_resizeBy(this.pointer)
    }
	ConsoleWindow.prototype.resizeTo = function resizeTo() {
		console.log("ConsoleWindow.prototype.resizeTo()")
		CPP_ConsoleWindow_resizeTo(this.pointer)
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
