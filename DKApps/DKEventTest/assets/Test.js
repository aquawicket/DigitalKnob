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
CPP_DK_Create("DKEventTest/DKConsoleWindow.js");
const myConsoleWindow = new DKConsoleWindow('myConsoleWindow')


// KeyboardEvents
function printKeyboardEventProperties(keyevent){
	console.log("keyevent.altKey="+keyevent.altKey)
	console.log("keyevent.code="+keyevent.code)			
	console.log("keyevent.ctrlKey="+keyevent.ctrlKey)
	console.log("keyevent.isComposing="+keyevent.isComposing)
	console.log("keyevent.key="+keyevent.key)
	console.log("keyevent.locale="+keyevent.locale)
	console.log("keyevent.location="+keyevent.location)
	console.log("keyevent.metaKey="+keyevent.metaKey)
	console.log("keyevent.repeat="+keyevent.repeat)
	console.log("keyevent.shiftKey="+keyevent.shiftKey)
}

/*
function onKeyDown(event){
	console.log("\n onKeyDown()")
	printKeyboardEventProperties(event)
}
myConsoleWindow.addEventListener('keydown', onKeyDown)
*/
function onKeyUp(eventAddress){
	console.log("onKeyUp("+eventAddress+")")
	const event = new KeyboardEvent('', '', eventAddress);
	printEventProperties(event)
	printKeyboardEventProperties(event)
}
myConsoleWindow.addEventListener('keyup', onKeyUp)

/*
function onKeyPress(event){
	console.log("\n onKeyPress()")
	printKeyboardEventProperties(event)
}
myConsoleWindow.addEventListener('keypress', onKeyPress)
*/