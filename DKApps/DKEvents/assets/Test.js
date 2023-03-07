// Event test
console.log("\n\n ___Event Test___\n");


///////////////////// JSObject ////////////////////////
console.log("/////////// JSObject /////////////////////")
CPP_DK_Create("EventTest/JSObject.js");
const myJSObject = new JSObject('myJSObject')

function myJSCallback(){
	console.log("myJSCallback()\n")
}
myJSObject.addEventListener('myJSEvent', myJSCallback)
const myJSEvent = new Event('myJSEvent')
myJSObject.dispatchEvent(myJSEvent);
myJSObject.removeEventListener('myJSEvent', myJSCallback)
myJSObject.dispatchEvent(myJSEvent);
console.log("\n")



///////////////////// CPPObject ////////////////////////
console.log("/////////// CPPObject /////////////////////")
CPP_DK_Create("EventTest/CPPObject.js");
const myCPPObject = new CPPObject('myCPPObject')

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



/////////////////// ConsoleInput //////////////////////////
console.log("/////////// ConsoleInput /////////////////////")
CPP_DK_Create("EventTest/ConsoleInput.js");
const myConsoleInput = new ConsoleInput('myConsoleInput')

// Keyboard events
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

// Mouse events
function onClick(){
	console.log("onClick()\n")
}
myConsoleInput.addEventListener('click', onClick)
function onContextMenu(){
	console.log("onContextMenu()\n")
}
myConsoleInput.addEventListener('contextmenu', onContextMenu)
function onDblclick(){
	console.log("onDblclick()\n")
}
myConsoleInput.addEventListener('dblclick', onDblclick)
function onMouseDown(){
	console.log("onMouseDown()\n")
}
myConsoleInput.addEventListener('mousedown', onMouseDown)
function onMouseEnter(){
	console.log("onMouseEnter()\n")
}
myConsoleInput.addEventListener('mouseenter', onMouseEnter)
function onMouseLeave(){
	console.log("onMouseLeave()\n")
}
myConsoleInput.addEventListener('mouseleave', onMouseLeave)
function onMouseMove(){
	console.log("onMouseMove()\n")
}
myConsoleInput.addEventListener('mousemove', onMouseMove)
function onMouseOut(){
	console.log("onMouseOut()\n")
}
myConsoleInput.addEventListener('mouseout', onMouseOut)
function onMouseOver(){
	console.log("onMouseOver()\n")
}
myConsoleInput.addEventListener('mouseover', onMouseOver)
function onMouseUp(){
	console.log("onMouseUp()\n")
}
myConsoleInput.addEventListener('mouseup', onMouseUp)

// Resize events
function onResize(){
	console.log("onResize()\n")
}
myConsoleInput.addEventListener('resize', onResize)


///////////////////// NcursesInput ////////////////////////
console.log("/////////// NcursesInput /////////////////////")
CPP_DK_Create("EventTest/NcursesInput.js");
const myNcursesInput = new NcursesInput('myNcursesInput')

// Keyboard events
function onKeyDown(){
	console.log("onKeyDown()\n")
}
myNcursesInput.addEventListener('keydown', onKeyDown)
function onKeyUp(){
	console.log("onKeyUp()\n")
}
myNcursesInput.addEventListener('keyup', onKeyUp)
function onKeyPress(){
	console.log("onKeyPress()\n")
}
myNcursesInput.addEventListener('keypress', onKeyPress)

// Mouse events
function onClick(){
	console.log("onClick()\n")
}
myNcursesInput.addEventListener('click', onClick)
function onContextMenu(){
	console.log("onContextMenu()\n")
}
myNcursesInput.addEventListener('contextmenu', onContextMenu)
function onDblclick(){
	console.log("onDblclick()\n")
}
myNcursesInput.addEventListener('dblclick', onDblclick)
function onMouseDown(){
	console.log("onMouseDown()\n")
}
myNcursesInput.addEventListener('mousedown', onMouseDown)
function onMouseEnter(){
	console.log("onMouseEnter()\n")
}
myNcursesInput.addEventListener('mouseenter', onMouseEnter)
function onMouseLeave(){
	console.log("onMouseLeave()\n")
}
myNcursesInput.addEventListener('mouseleave', onMouseLeave)
function onMouseMove(){
	console.log("onMouseMove()\n")
}
myNcursesInput.addEventListener('mousemove', onMouseMove)
function onMouseOut(){
	console.log("onMouseOut()\n")
}
myNcursesInput.addEventListener('mouseout', onMouseOut)
function onMouseOver(){
	console.log("onMouseOver()\n")
}
myNcursesInput.addEventListener('mouseover', onMouseOver)
function onMouseUp(){
	console.log("onMouseUp()\n")
}
myNcursesInput.addEventListener('mouseup', onMouseUp)

// Resize events
function onResize(){
	console.log("onResize()\n")
}
myNcursesInput.addEventListener('resize', onResize)
