// Event test

////////////////////////////////////////
var MyObject = function MyObject(data) {
	console.log("MyObject("+data+")");
    this.data = data;
	
	var pointer = CPP_Duktape_createDKObject("MyObject")
	this.pointer = pointer;
	
	//// Instance properties ////
	Object.defineProperty(this, "value", {
        get: function value() {
            return CPP_MyObject_value(pointer)
        }
    })
	
	//// Instance methods ////
	MyObject.prototype.test = function test() {
		console.log("MyObject.prototype.test()")
		CPP_MyObject_test(pointer)
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
		this.toString = function(){	return "[object MyObject]" }
	
	return EventTarget.call(this, data)
	
}
MyObject.prototype = EventTarget.prototype;
