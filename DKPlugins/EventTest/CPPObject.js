// CPPObject.ja

////////////////////////////////////////
var CPPObject = function CPPObject(data) {
	console.log("CPPObject("+data+")");
    this.data = data;
	
	this.pointer = CPP_Duktape_createDKObject("CPPObject")
	
	//// Instance properties ////
	Object.defineProperty(this, "value", {
        get: function value() {
            return CPP_CPPObject_value(this.pointer)
        }
    })
	
	//// Instance methods ////
	CPPObject.prototype.test = function test() {
		console.log("CPPObject.prototype.test()")
		CPP_CPPObject_test(this.pointer)
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
		this.toString = function(){	return "[object CPPObject]" }
	
	return EventTarget.call(this, this.pointer)
	
}
CPPObject.prototype = EventTarget.prototype;
