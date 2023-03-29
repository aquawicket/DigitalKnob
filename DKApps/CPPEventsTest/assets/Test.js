// Event test
console.log("\n\n ___JS Event Test___\n");






/////////////////// ConsoleWindow //////////////////////////
console.log("/////////// ConsoleWindow /////////////////////")
CPP_DK_Create("CPPEventsTest/DKConsoleWindow.js");
const myConsoleWindow = new DKConsoleWindow('myConsoleWindow')


//////////////// GENERIC EVENT //////////////////////////////
function onGeneric(event){
	console.log("\n onGeneric()")
	//printEventProperties(event)
}
myConsoleWindow.addEventListener('generic', onGeneric)

const event = new Event('generic', '', myConsoleWindow)
event.target = new EventTarget(myConsoleWindow)
event.target.dispatchEvent(event)


/*
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
*/
function onKeyUp(event){
	console.log("\n onKeyUp()")
	//printKeyboardEventProperties(event)
}
myConsoleWindow.addEventListener('keyup', onKeyUp)

/*
function onKeyPress(event){
	console.log("\n onKeyPress()")
	printKeyboardEventProperties(event)
}
myConsoleWindow.addEventListener('keypress', onKeyPress)
*/