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


// KeyboardEvents
function printKeyboardEventProperties(keyevent){
	console.log("keyevent.altKey="+keyevent.altKey)
	console.log("keyevent.code="+keyevent.code)				//TODO
	console.log("keyevent.ctrlKey="+keyevent.ctrlKey)
	console.log("keyevent.isComposing="+keyevent.isComposing)	//TODO
	console.log("keyevent.key="+keyevent.key)
	console.log("keyevent.locale="+keyevent.locale)			//TODO
	console.log("keyevent.location="+keyevent.location)		//TODO
	console.log("keyevent.metaKey="+keyevent.metaKey)			//TODO
	console.log("keyevent.repeat="+keyevent.repeat)
	console.log("keyevent.shiftKey="+keyevent.shiftKey)
	
	//// Obsolete ////
	//console.log("event.char="+event.char)
	//console.log("event.charCode="+event.charCode)
	//console.log("event.keyCode="+event.keyCode)
	//console.log("event.keyIdentifier="+event.keyIdentifier)
	//console.log("event.which="+event.which)
}

/*
function onKeyDown(event){
	console.log("\n onKeyDown()")
	printKeyboardEventProperties(event)
}
myConsoleWindow.addEventListener('keydown', onKeyDown)
*/
function onKeyUp(event){
	console.log("onKeyUp("+event+")")
	//const ev = new Event(event, '');
	const ev = new KeyboardEvent(event, '');
	console.log("ev = "+ev);
	
	printEventProperties(ev)
	printKeyboardEventProperties(ev)
}
myConsoleWindow.addEventListener('keyup', onKeyUp)

/*
function onKeyPress(event){
	console.log("\n onKeyPress()")
	printKeyboardEventProperties(event)
}
myConsoleWindow.addEventListener('keypress', onKeyPress)
*/