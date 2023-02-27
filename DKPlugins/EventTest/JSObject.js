// JSObject

////////////////////////////////////////
var JSObject = function JSObject(value) {
	console.log("JSObject("+value+")");
    this.value = value;
	this.pointer = "";
	
	//// Instance properties ////
	Object.defineProperty(this, "value", {
        get: function value() {
            return this.value
        }
    })
	
	//// Instance methods ////
	JSObject.prototype.test = function JSObject_test() {
		console.log("JSObject.prototype.test()")
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
		this.toString = function(){	return "[object JSObject]" }
	
	return EventTarget.call(this, this.pointer)
	
}
JSObject.prototype = EventTarget.prototype;
