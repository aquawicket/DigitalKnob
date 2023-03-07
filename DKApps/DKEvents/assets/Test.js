// Event test
console.log("\n\n ___Event Test___\n");


///////////////////// JSObject ////////////////////////
console.log("/////////// JSObject /////////////////////")
CPP_DK_Create("EventTest/JSObject.js");
const myJSObject = new JSObject('myJSObject')

function myJSCallback(event){
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

function myCPPCallback(event){
	console.log("myCPPCallback()\n")
}
myCPPObject.addEventListener('myCPPEvent', myCPPCallback)
//const myCPPEvent = new Event('myCPPEvent')
//myCPPObject.dispatchEvent(myCPPEvent);
//myCPPObject.removeEventListener('myCPPEvent', myCPPCallback)
//myCPPObject.dispatchEvent(myCPPEvent);
function myCPPObject_onmessage(event){
	console.log("myCPPObject_onmessage()\n")
}
myCPPObject.onmessage = myCPPObject_onmessage;
const myCPPEvent_onmessage = new Event('message')
myCPPObject.dispatchEvent(myCPPEvent_onmessage);

function myCPPObject_ontest(event){
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
function onKeyDown(event){
	console.log("onKeyDown() event.altKey="+event.altKey)
	console.log("onKeyDown() event.code="+event.code)				//TODO
	console.log("onKeyDown() event.ctrlKey="+event.ctrlKey)
	console.log("onKeyDown() event.isComposing="+event.isComposing)	//TODO
	console.log("onKeyDown() event.key="+event.key)
	console.log("onKeyDown() event.locale="+event.locale)			//TODO
	console.log("onKeyDown() event.location="+event.location)		//TODO
	console.log("onKeyDown() event.metaKey="+event.metaKey)			//TODO
	console.log("onKeyDown() event.repeat="+event.repeat)
	console.log("onKeyDown() event.shiftKey="+event.shiftKey)
}
myConsoleInput.addEventListener('keydown', onKeyDown)
function onKeyUp(event){
	console.log("onKeyUp() event.key="+event.key)
}
myConsoleInput.addEventListener('keyup', onKeyUp)
function onKeyPress(event){
	console.log("onKeyPress() event.key="+event.key)
}
myConsoleInput.addEventListener('keypress', onKeyPress)

// Mouse events
function onClick(event){
	console.log("onClick() event.button="+event.button)
}
myConsoleInput.addEventListener('click', onClick)
function onContextMenu(event){
	console.log("onContextMenu() event.button="+event.button)
}
myConsoleInput.addEventListener('contextmenu', onContextMenu)
function onDblclick(event){
	console.log("onDblclick() event.button="+event.button)
}
myConsoleInput.addEventListener('dblclick', onDblclick)
function onMouseDown(event){
	console.log("onMouseDown() event.button="+event.button)
}
myConsoleInput.addEventListener('mousedown', onMouseDown)
function onMouseEnter(event){
	console.log("onMouseEnter() event.button="+event.button)
}
myConsoleInput.addEventListener('mouseenter', onMouseEnter)
function onMouseLeave(event){
	console.log("onMouseLeave() event.button="+event.button)
}
myConsoleInput.addEventListener('mouseleave', onMouseLeave)
function onMouseMove(event){
	console.log("onMouseMove() event.button="+event.button)
}
myConsoleInput.addEventListener('mousemove', onMouseMove)
function onMouseOut(event){
	console.log("onMouseOut() event.button="+event.button)
}
myConsoleInput.addEventListener('mouseout', onMouseOut)
function onMouseOver(event){
	console.log("onMouseOver() event.button="+event.button)
}
myConsoleInput.addEventListener('mouseover', onMouseOver)
function onMouseUp(event){
	console.log("onMouseUp() event.button="+event.button)
}
myConsoleInput.addEventListener('mouseup', onMouseUp)

// Resize events
function onResize(event){
	console.log("onResize() event.x="+event.x)
}
myConsoleInput.addEventListener('resize', onResize)


/*
///////////////////// NcursesInput ////////////////////////
console.log("/////////// NcursesInput /////////////////////")
CPP_DK_Create("EventTest/NcursesInput.js");
const myNcursesInput = new NcursesInput('myNcursesInput')

// Keyboard events
function onKeyDown(event){
	console.log("onKeyDown() event.key="+event.key)
}
myNcursesInput.addEventListener('keydown', onKeyDown)
function onKeyUp(event){
	console.log("onKeyUp() event.key="+event.key)
}
myNcursesInput.addEventListener('keyup', onKeyUp)
function onKeyPress(event){
	console.log("onKeyPress() event.key="+event.key)
}
myNcursesInput.addEventListener('keypress', onKeyPress)

// Mouse events
function onClick(event){
	console.log("onClick() event.button="+event.button)
}
myNcursesInput.addEventListener('click', onClick)
function onContextMenu(event){
	console.log("onContextMenu() event.button="+event.button)
}
myNcursesInput.addEventListener('contextmenu', onContextMenu)
function onDblclick(event){
	console.log("onDblclick() event.button="+event.button)
}
myNcursesInput.addEventListener('dblclick', onDblclick)
function onMouseDown(event){
	console.log("onMouseDown() event.button="+event.button)
}
myNcursesInput.addEventListener('mousedown', onMouseDown)
function onMouseEnter(event){
	console.log("onMouseEnter() event.button="+event.button)
}
myNcursesInput.addEventListener('mouseenter', onMouseEnter)
function onMouseLeave(event){
	console.log("onMouseLeave() event.button="+event.button)
}
myNcursesInput.addEventListener('mouseleave', onMouseLeave)
function onMouseMove(event){
	console.log("onMouseMove() event.button="+event.button)
}
myNcursesInput.addEventListener('mousemove', onMouseMove)
function onMouseOut(event){
	console.log("onMouseOut() event.button="+event.button)
}
myNcursesInput.addEventListener('mouseout', onMouseOut)
function onMouseOver(event){
	console.log("onMouseOver() event.button="+event.button)
}
myNcursesInput.addEventListener('mouseover', onMouseOver)
function onMouseUp(event){
	console.log("onMouseUp() event.button="+event.button)
}
myNcursesInput.addEventListener('mouseup', onMouseUp)

// Resize events
function onResize(event){
	console.log("onResize() event.x="+event.x)
}
myNcursesInput.addEventListener('resize', onResize)
*/
