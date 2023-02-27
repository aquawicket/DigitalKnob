// Event test
console.log("\n\n ___Event Test___\n");



/////////// JSObject /////////////////////
console.log("/////////// JSObject /////////////////////")
CPP_DK_Create("EventTest/JSObject.js");
const myJSObject = new JSObject('myJSObject')
//console.log("myJSObject = "+myJSObject)
//console.log("myJSObject.value = "+myJSObject.value)
//console.log("myJSObject.test() = "+myJSObject.test())
//console.log("\n")
function myJSCallback(){
	console.log("myJSCallback()\n")
}
myJSObject.addEventListener('myJSEvent', myJSCallback)
const myJSEvent = new Event('myJSEvent')
myJSObject.dispatchEvent(myJSEvent);
myJSObject.removeEventListener('myJSEvent', myJSCallback)
myJSObject.dispatchEvent(myJSEvent);
console.log("\n")



/////////// CPPObject /////////////////////
console.log("/////////// CPPObject /////////////////////")
CPP_DK_Create("EventTest/CPPObject.js");
const myCPPObject = new CPPObject('myCPPObject')
//console.log("myCPPObject = "+myCPPObject)
//console.log("myCPPObject.value = "+myCPPObject.value)
//console.log("myCPPObject.test() = "+myCPPObject.test())
//console.log("\n")
function myCPPCallback(){
	console.log("myCPPCallback()\n")
}
myCPPObject.addEventListener('myCPPEvent', myCPPCallback)
//const myCPPEvent = new Event('myCPPEvent')
//myCPPObject.dispatchEvent(myCPPEvent);
//myCPPObject.removeEventListener('myCPPEvent', myCPPCallback)
//myCPPObject.dispatchEvent(myCPPEvent);
function myCPPObject_onmessage(){
	console.log("myCPPObject_onmessage()\n")
}
myCPPObject.onmessage = myCPPObject_onmessage;
const myCPPEvent_onmessage = new Event('message')
myCPPObject.dispatchEvent(myCPPEvent_onmessage);

function myCPPObject_ontest(){
	console.log("myCPPObject_ontest()\n")
}
myCPPObject.ontest = myCPPObject_ontest;
const myCPPEvent_ontest = new Event('test')
myCPPObject.dispatchEvent(myCPPEvent_ontest);

myCPPObject.test()
console.log("\n")



/////////// ConsoleInput /////////////////////
CPP_DK_Create("ConsoleInput");
function onKeyDown(){
	console.log("onKeyDown()\n")
}
const myEventTarget = new EventTarget("test")
myEventTarget.addEventListener('keydown', onKeyDown)
const myKeyDownEvent = new Event('keydown')
myEventTarget.dispatchEvent(myKeyDownEvent);
