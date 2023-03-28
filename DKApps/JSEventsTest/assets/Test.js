// Event test
console.log("\n\n ___Event Test___\n");


/////////////////// ConsoleWindow //////////////////////////
console.log("/////////// ConsoleWindow /////////////////////")
CPP_DK_Create("JSEventsTest/ConsoleWindow.js");
const myConsoleWindow = new ConsoleWindow('myConsoleWindow')


// KeyboardEvents
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
myConsoleWindow.addEventListener('keydown', onKeyDown)
function onKeyUp(event){
	console.log("\n onKeyUp()")
	printKeyboardEventProperties(event)
}
myConsoleWindow.addEventListener('keyup', onKeyUp)
function onKeyPress(event){
	console.log("\n onKeyPress()")
	printKeyboardEventProperties(event)
}
myConsoleWindow.addEventListener('keypress', onKeyPress)

/*
// MouseEvents
function printMouseEventProperties(event){
	console.log("event.altKey="+event.altKey)
	console.log("event.button="+event.button)
	console.log("event.buttons="+event.buttons)
	console.log("event.clientX="+event.clientX)
	console.log("event.clientY="+event.clientY)
	console.log("event.ctrlKey="+event.ctrlKey)
	console.log("event.layerX="+event.layerX)
	console.log("event.layerY="+event.layerY)
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
	console.log("event.x="+event.x)
	console.log("event.y="+event.y)
}
function onClick(event){
	console.log("\n onClick()")
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('click', onClick)
function onContextMenu(event){
	console.log("\n onContextMenu()")
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('contextmenu', onContextMenu)
function onDblclick(event){
	console.log("\n onDblclick()")
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('dblclick', onDblclick)
function onMouseDown(event){
	console.log("\n onMouseDown()")
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('mousedown', onMouseDown)
function onMouseEnter(event){
	console.log("\n onMouseEnter()")
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('mouseenter', onMouseEnter)
function onMouseLeave(event){
	console.log("\n onMouseLeave()")
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('mouseleave', onMouseLeave)
function onMouseMove(event){
	console.log("\n onMouseMove()")
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('mousemove', onMouseMove)
function onMouseOut(event){
	console.log("\n onMouseOut()")
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('mouseout', onMouseOut)
function onMouseOver(event){
	console.log("\n onMouseOver()")
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('mouseover', onMouseOver)
function onMouseUp(event){
	console.log("\n onMouseUp()")
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('mouseup', onMouseUp)


// WheelEvents
function printWheelEventProperties(event){
	console.log("event.deltaX="+event.deltaX)
	console.log("event.deltaY="+event.deltaY)
	console.log("event.deltaZ="+event.deltaZ)
	console.log("event.deltaMode="+event.deltaMode)
}
function onWheel(event){
	console.log("\n onWheel()")
	printWheelEventProperties(event)
}
myConsoleWindow.addEventListener('wheel', onWheel)


// FocusEvents
// https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent/relatedTarget
//1. blur: sent after element A loses focus.
function onBlur(event){ 
	console.log("\n onBlur()")
	//printFocusEventProperties(event)
}
myConsoleWindow.addEventListener('blur', onBlur)
//2. focusout: sent after the blur event.
function onFocusOut(event){
	console.log("\n onFocusOut()")
	//printFocusEventProperties(event)
}
myConsoleWindow.addEventListener('focusout', onFocusOut)
//3. focus: sent after element B receives focus.
function onFocus(event){
	console.log("\n onFocus()")
	//printFocusEventProperties(event)
}
myConsoleWindow.addEventListener('focus', onFocus)
//4. focusin: sent after the focus event.
function onFocusIn(event){
	console.log("\n onFocusIn()")
	//printFocusEventProperties(event)
}
myConsoleWindow.addEventListener('focusin', onFocusIn)


// Resize events
function onResize(event){
	console.log("\n onResize()")
	console.log("myConsoleWindow.columns="+myConsoleWindow.columns)
	console.log("myConsoleWindow.innerHeight="+myConsoleWindow.innerHeight)
	console.log("myConsoleWindow.innerWidth="+myConsoleWindow.innerWidth)
	console.log("myConsoleWindow.outerHeight="+myConsoleWindow.outerHeight)
	console.log("myConsoleWindow.outerWidth="+myConsoleWindow.outerWidth)
	console.log("myConsoleWindow.rows="+myConsoleWindow.rows)
	console.log("myConsoleWindow.screenX="+myConsoleWindow.screenX)
	console.log("myConsoleWindow.screenY="+myConsoleWindow.screenY)
	console.log("myConsoleWindow.screenLeft="+myConsoleWindow.screenLeft)
	console.log("myConsoleWindow.screenTop="+myConsoleWindow.screenTop)
}
myConsoleWindow.addEventListener('resize', onResize)

//console.log("myConsoleWindow.name="+myConsoleWindow.name)
//myConsoleWindow.name = "Test 123"
//console.log("myConsoleWindow.name="+myConsoleWindow.name)
//myConsoleWindow.fullScreen = true;
//myConsoleWindow.fullScreen = false;
//myConsoleWindow.blur()
//myConsoleWindow.close()
//myConsoleWindow.focus()

*/