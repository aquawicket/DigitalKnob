// ConsoleWindow.js

////////////////////////////////////////////////
var ConsoleWindow = function ConsoleWindow(data) 
{
	console.log("ConsoleWindow("+data+")");
    this.data = data;
	
	this.pointer = CPP_Duktape_createDKObject("ConsoleWindow")
	
	//// Instance properties ////
	Object.defineProperty(this, "value", {
        get: function value() {
            return CPP_ConsoleWindow_value(this.pointer)
        }
    })
	
	//// Instance methods ////
	ConsoleWindow.prototype.test = function test() {
		console.log("ConsoleWindow.prototype.test()")
		CPP_ConsoleWindow_test(this.pointer)
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
