// NcursesInput.js

//////////////////////////////////////////////
var NcursesInput = function NcursesInput(data) 
{
	console.log("NcursesInput("+data+")");
    this.data = data;
	
	this.pointer = CPP_Duktape_createDKObject("NcursesInput")
	
	//// Instance properties ////
	Object.defineProperty(this, "value", {
        get: function value() {
            return CPP_NcursesInput_value(this.pointer)
        }
    })
	
	//// Instance methods ////
	NcursesInput.prototype.test = function test() {
		console.log("NcursesInput.prototype.test()")
		CPP_NcursesInput_test(this.pointer)
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
		this.toString = function(){	return "[object NcursesInput]" }
	
	return EventTarget.call(this, this.pointer)
	
}
NcursesInput.prototype = EventTarget.prototype;
