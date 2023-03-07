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



/////////// ConsoleInput //////////////////
console.log("/////////// ConsoleInput /////////////////////")
CPP_DK_Create("EventTest/ConsoleInput.js");
const myConsoleInput = new ConsoleInput('myConsoleInput')
//console.log("myConsoleInput = "+myConsoleInput)
//console.log("myConsoleInput.value = "+myConsoleInput.value)
//console.log("myConsoleInput.test() = "+myConsoleInput.test())
//console.log("\n")

function onKeyDown(){
	console.log("onKeyDown()\n")
}
myConsoleInput.addEventListener('keydown', onKeyDown)
function onKeyUp(){
	console.log("onKeyUp()\n")
}
myConsoleInput.addEventListener('keyup', onKeyUp)
function onKeyPress(){
	console.log("onKeyPress()\n")
}
myConsoleInput.addEventListener('keypress', onKeyPress)



/////////// NcursesInput //////////////////
console.log("/////////// NcursesInput /////////////////////")
CPP_DK_Create("EventTest/NcursesInput.js");
const myNcursesInput = new NcursesInput('myNcursesInput')
//console.log("myNcursesInput = "+myNcursesInput)
//console.log("myNcursesInput.value = "+myNcursesInput.value)
//console.log("myNcursesInput.test() = "+myNcursesInput.test())
//console.log("\n")

function onKeyDown(){
	console.log("onKeyDown()\n")
}
myNcursesInput.addEventListener('keydown', onKeyDown)
function onKeyUp(){
	console.log("onKeyUp()\n")
}
myNcursesInput.addEventListener('keyup', onKeyUp)
