// Event test
console.log("\n\n ___Event Test___\n");

/////////// JSObject /////////////////////
console.log("/////////// JSObject /////////////////////")
const myJSObject = new JSObject('myJSObject')
//console.log("myJSObject = "+myJSObject)
//console.log("myJSObject.value = "+myJSObject.value)
//console.log("myJSObject.test() = "+myJSObject.test())
//console.log("\n")
function myJSObjectCallback(){
	console.log("myJSObjectCallback()\n")
}
myJSObject.addEventListener('myJSEvent', myJSObjectCallback)
const myJSEvent = new Event('myJSEvent')
myJSObject.dispatchEvent(myJSEvent);
myJSObject.removeEventListener('myJSEvent', myJSObjectCallback)
myJSObject.dispatchEvent(myJSEvent);
console.log("\n")



/////////// MyObjectB /////////////////////
console.log("/////////// MyObjectB /////////////////////")
const myObjectB = new MyObject('myObjectB')
//console.log("myObjectB = "+myObjectB)
//console.log("myObjectB.value = "+myObjectB.value)
//console.log("myObjectB.test() = "+myObjectB.test())
//console.log("\n")
function myCallbackB(){
	console.log("myCallbackB()\n")
}
myObjectB.addEventListener('myEventB', myCallbackB)
//const myEventB = new Event('myEventB')
//myObjectB.dispatchEvent(myEventB);
//myObjectB.removeEventListener('myEventB', myCallbackB)
//myObjectB.dispatchEvent(myEventB);
function myObjectB_onmessage(){
	console.log("myObjectB_onmessage()\n")
}
myObjectB.onmessage = myObjectB_onmessage;
//const myEventB_onmessage = new Event('message')
//myObjectB.dispatchEvent(myEventB_onmessage);
/*
function myObjectB_ontest(){
	console.log("myObjectB_ontest()\n")
}
myObjectB.ontest = myObjectB_ontest;
const myEventB_ontest = new Event('test')
myObjectB.dispatchEvent(myEventB_ontest);
*/
myObjectB.test()
console.log("\n")


/////////// WebSocketServer /////////////////////
console.log("/////////// WebSocketServer /////////////////////")
