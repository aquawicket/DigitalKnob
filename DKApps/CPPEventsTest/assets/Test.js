// Event test
console.log("\n\n ___JS Event Test___\n");


//////////////// GENERIC EVENT //////////////////////////////
function printEventProperties(event){
	console.log("event.bubbles="+event.bubbles)
	console.log("event.cancelable="+event.cancelable)
	console.log("event.composed="+event.composed)
	console.log("event.currentTarget="+event.currentTarget)
	console.log("event.defaultPrevented="+event.defaultPrevented)
	console.log("event.eventPhase="+event.eventPhase)			
	console.log("event.isTrusted="+event.isTrusted)		
	console.log("event.target="+event.target)			
	console.log("event.timeStamp="+event.timeStamp)
	console.log("event.type="+event.type)
}
function onGeneric(event){
	console.log("onGeneric()")
	//printEventProperties(event)
}
const pointer = "123"
const event = new Event('generic', '')
//event.bubbles = true;
const target = new EventTarget(pointer)
target.addEventListener('generic', onGeneric)
target.dispatchEvent(event)



/////////////////// ConsoleWindow //////////////////////////
console.log("/////////// ConsoleWindow /////////////////////")
CPP_DK_Create("CPPEventsTest/DKConsoleWindow.js");
const myConsoleWindow = new DKConsoleWindow('myConsoleWindow')





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
	console.log("onKeyUp("+event+")")
	const ev = new Event(event, '');
	console.log("ev = "+ev);
	
	printEventProperties(ev)
}
myConsoleWindow.addEventListener('keyup', onKeyUp)

/*
function onKeyPress(event){
	console.log("\n onKeyPress()")
	printKeyboardEventProperties(event)
}
myConsoleWindow.addEventListener('keypress', onKeyPress)
*/