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
function printKeyboardEventProperties(event){
	console.log("event.altKey="+event.altKey)
	console.log("event.code="+event.code)				//TODO
	console.log("event.ctrlKey="+event.ctrlKey)
	console.log("event.isComposing="+event.isComposing)	//TODO
	console.log("event.key="+event.key)
	console.log("event.locale="+event.locale)			//TODO
	console.log("event.location="+event.location)		//TODO
	console.log("event.metaKey="+event.metaKey)			//TODO
	console.log("event.repeat="+event.repeat)
	console.log("event.shiftKey="+event.shiftKey)
	
	//// Obsolete ////
	//console.log("event.char="+event.char)
	//console.log("event.charCode="+event.charCode)
	//console.log("event.keyCode="+event.keyCode)
	//console.log("event.keyIdentifier="+event.keyIdentifier)
	//console.log("event.which="+event.which)
}

function onKeyDown(event){
	console.log("\n onKeyDown()")
	printKeyboardEventProperties(event)
}
myConsoleInput.addEventListener('keydown', onKeyDown)
function onKeyUp(event){
	console.log("\n onKeyUp()")
	printKeyboardEventProperties(event)
}
myConsoleInput.addEventListener('keyup', onKeyUp)
function onKeyPress(event){
	console.log("\n onKeyPress()")
	printKeyboardEventProperties(event)
}
myConsoleInput.addEventListener('keypress', onKeyPress)

// Mouse events
function printMouseEventProperties(event){
	console.log("event.altKey="+event.altKey)
	console.log("event.button="+event.button)
	console.log("event.buttons="+event.buttons)
	console.log("event.clientX="+event.clientX)
	console.log("event.clientY="+event.clientY)
	console.log("event.ctrlKey="+event.ctrlKey)
	console.log("event.layerX="+event.layerX)
	console.log("event.layerY="+event.layerY)
	//console.log("event.detail="+event.detail)
	console.log("event.metaKey="+event.metaKey)
	console.log("event.movementX="+event.movementX)
	console.log("event.movementY="+event.movementY)
	console.log("event.offsetX="+event.offsetX)
	console.log("event.offsetY="+event.offsetY)
	console.log("event.pageX="+event.pageX)
	console.log("event.pageY="+event.pageY)
	console.log("event.relatedTarget="+event.relatedTarget)
	console.log("event.screenX="+event.screenX)
	console.log("event.screenY="+event.screenY)
	console.log("event.shiftKey="+event.shiftKey)
	console.log("event.mozPressure="+event.mozPressure)
	console.log("event.mozInputSource="+event.mozInputSource)
	console.log("event.webkitForce="+event.webkitForce)
	//console.log("event.which="+event.which)
	console.log("event.x="+event.x)
	console.log("event.y="+event.y)
}

function onClick(event){
	console.log("\n onClick()")
	printMouseEventProperties(event)
}
myConsoleInput.addEventListener('click', onClick)
function onContextMenu(event){
	console.log("\n onContextMenu()")
	printMouseEventProperties(event)
}
myConsoleInput.addEventListener('contextmenu', onContextMenu)
function onDblclick(event){
	console.log("\n onDblclick()")
	printMouseEventProperties(event)
}
myConsoleInput.addEventListener('dblclick', onDblclick)
function onMouseDown(event){
	console.log("\n onMouseDown()")
	printMouseEventProperties(event)
}
myConsoleInput.addEventListener('mousedown', onMouseDown)
function onMouseEnter(event){
	console.log("\n onMouseEnter()")
	printMouseEventProperties(event)
}
myConsoleInput.addEventListener('mouseenter', onMouseEnter)
function onMouseLeave(event){
	console.log("\n onMouseLeave()")
	printMouseEventProperties(event)
}
myConsoleInput.addEventListener('mouseleave', onMouseLeave)
function onMouseMove(event){
	console.log("\n onMouseMove()")
	printMouseEventProperties(event)
}
myConsoleInput.addEventListener('mousemove', onMouseMove)
function onMouseOut(event){
	console.log("\n onMouseOut()")
	printMouseEventProperties(event)
}
myConsoleInput.addEventListener('mouseout', onMouseOut)
function onMouseOver(event){
	console.log("\n onMouseOver()")
	printMouseEventProperties(event)
}
myConsoleInput.addEventListener('mouseover', onMouseOver)
function onMouseUp(event){
	console.log("\n onMouseUp()")
	printMouseEventProperties(event)
}
myConsoleInput.addEventListener('mouseup', onMouseUp)

// Resize events
function onResize(event){
	console.log("\n onResize()")
	//printResizeEventProperties(event)
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
