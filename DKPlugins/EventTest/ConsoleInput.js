// ConsoleInput.js

//////////////////////////////////////////////
var ConsoleInput = function ConsoleInput(data) 
{
	console.log("ConsoleInput("+data+")");
    this.data = data;
	
	this.pointer = CPP_Duktape_createDKObject("ConsoleInput")
	
	//// Instance properties ////
	Object.defineProperty(this, "value", {
        get: function value() {
            return CPP_ConsoleInput_value(this.pointer)
        }
    })
	
	//// Instance methods ////
	ConsoleInput.prototype.test = function test() {
		console.log("ConsoleInput.prototype.test()")
		CPP_ConsoleInput_test(this.pointer)
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
		this.toString = function(){	return "[object ConsoleInput]" }
	
	return EventTarget.call(this, this.pointer)
	
}
ConsoleInput.prototype = EventTarget.prototype;
