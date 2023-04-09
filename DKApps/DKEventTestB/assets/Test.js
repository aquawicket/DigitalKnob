// create EventTarget
const obj = new EventTarget();

////// Event ///////
function printEventProperties(event){
	////// Instance properties //////
	console.log("event.bubbles = "					+event.bubbles)
	console.log("event.cancelable = "				+event.cancelable)
	console.log("event.composed = "					+event.composed)
	console.log("event.currentTarget = "			+event.currentTarget)
	console.log("event.defaultPrevented = "			+event.defaultPrevented)
	console.log("event.eventPhase = "				+event.eventPhase)			
	console.log("event.isTrusted = "				+event.isTrusted)		
	console.log("event.target = "					+event.target)			
	console.log("event.timeStamp = "				+event.timeStamp)
	console.log("event.type = "						+event.type)
	////// Legacy and non-standard properties //////
	console.log("event.cancelBubble = "				+event.cancelBubble)
	console.log("event.explicitOriginalTarget = "	+event.explicitOriginalTarget)
	console.log("event.originalTarget = "			+event.originalTarget)
	console.log("event.returnValue = "				+event.returnValue)
	console.log("event.scoped = "					+event.scoped)
}

console.log('\n');
const myEventA = new Event('myeventA');
obj.addEventListener('myeventA', function(event){
	console.log('onmyeventA')
	printEventProperties(event)
})
obj.dispatchEvent(myEventA);

console.log('\n');
obj.addEventListener('myeventB', function(event){
	console.log('onmyeventB')
	printEventProperties(event)
})
obj.dispatchEvent(new Event('myeventB'));



////// CustomEvent //////
function printCustomEventProperties(customevent){
	////// Instance properties //////
	console.log("customevent.detail = "	+customevent.detail)
}

console.log('\n');
const myCustomEvent = new CustomEvent('customevent');
obj.addEventListener('customevent', function(event){
	console.log('oncustomevent')
	printEventProperties(event)
	printCustomEventProperties(event)
})
obj.dispatchEvent(myCustomEvent);


/////////////////// ConsoleWindow //////////////////////////
console.log("/////////// ConsoleWindow /////////////////////")
CPP_DK_Create("DKEventTestB/DKConsoleWindow.js");
const myConsoleWindow = new DKConsoleWindow('myConsoleWindow')


////// UIEvent //////
function printUIEventProperties(uievent){
	////// Instance properties //////
	console.log("uievent.detail = "				+uievent.detail)
	console.log("uievent.sourceCapabilities = "	+uievent.sourceCapabilities)			
	console.log("uievent.view = "				+uievent.view)
	console.log("uievent.which = "				+uievent.which)
}
console.log('\n');
const myUIEvent = new UIEvent('uievent');
obj.addEventListener('uievent', function(event){
	console.log('onuievent')
	printEventProperties(event)
	printUIEventProperties(event)
})
obj.dispatchEvent(myUIEvent);