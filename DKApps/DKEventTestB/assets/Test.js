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


////// FocusEvent ///////
function printFocusEventProperties(focusevent){
	////// Instance properties //////
	console.log("focusevent.relatedTarget = "	+focusevent.relatedTarget)
}
// [blur] https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event
function onblur(event){
	console.log("onblur("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printFocusEventProperties(event)
}
myConsoleWindow.addEventListener('blur', onblur)
// [focus] https://developer.mozilla.org/en-US/docs/Web/API/Element/focus_event
function onfocus(event){
	console.log("onfocus("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printFocusEventProperties(event)
}
myConsoleWindow.addEventListener('focus', onfocus)
// [focusin] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusin_event
function onfocusin(event){
	console.log("onfocusin("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printFocusEventProperties(event)
}
myConsoleWindow.addEventListener('focusin', onfocusin)
// [focusout] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusout_event
function onfocusout(event){
	console.log("onfocusout("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printFocusEventProperties(event)
}
myConsoleWindow.addEventListener('focusout', onfocusout)