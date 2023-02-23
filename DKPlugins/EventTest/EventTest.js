// Event test
console.log("\n\n ___Event Test___");

////////////////////////////////////////
var MyObject = function MyObject(data) {
	console.log("MyObject("+data+")");
    this.data = data;
	
	//var pointer = CPP_EventTest_createNode("eventtest");
	//this.pointer = pointer;
	
	//// Instance properties ////
	Object.defineProperty(this, "value", {
        get: function value() {
            return "myValue"//CPP_EventTest_value(data)
        }
    })
	
	//// Instance methods ////
	MyObject.prototype.test = function test() {
		console.log("MyObject.prototype.test()")
		//CPP_EventTest_test()
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



///////////////////////////////////////////////
function testCallback(){
	console.log("testCallback()")
}
const testObject = new EventTarget('testObject')
testObject.addEventListener('testEvent', testCallback)
const testEvent = new Event('testEvent')
testObject.dispatchEvent(testEvent);
testObject.removeEventListener('testEvent', testCallback)
testObject.dispatchEvent(testEvent);



///////////////////////////////////////////////
function myCallback(){
	console.log("myCallback()")
}
const myObject = new MyObject('myObject')
myObject.addEventListener('myEvent', myCallback)
const myEvent = new Event('myEvent')
myObject.dispatchEvent(myEvent);
myObject.removeEventListener('myEvent', myCallback)
myObject.dispatchEvent(myEvent);
