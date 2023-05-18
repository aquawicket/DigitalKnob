// [IDL] https://dom.spec.whatwg.org/#interface-event
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Event
console.log("\n////// TEST_Event.js //////")


function printEventProperties(event){
	
	// readonly attribute DOMString type;
	console.log("event.type = "				+event.type)
	
	// readonly attribute EventTarget? target;
	console.log("event.target = "			+event.target)
	
	// readonly attribute EventTarget? srcElement; // legacy
	console.log("event.srcElement = "		+event.srcElement)
	
	// readonly attribute EventTarget? currentTarget;
	console.log("event.currentTarget = "	+event.currentTarget)
	
	// sequence<EventTarget> composedPath();
	// function
	
	// const unsigned short NONE = 0;
	console.log("event.NONE = "				+event.NONE)
	
	// const unsigned short CAPTURING_PHASE = 1;
	console.log("event.CAPTURING_PHASE = "	+event.CAPTURING_PHASE)
	
	// const unsigned short AT_TARGET = 2;
	console.log("event.AT_TARGET = "		+event.AT_TARGET)
	
	// const unsigned short BUBBLING_PHASE = 3;
	console.log("event.BUBBLING_PHASE = "	+event.BUBBLING_PHASE)
	
	// readonly attribute unsigned short eventPhase;
	console.log("event.eventPhase = "		+event.eventPhase)
	
	// undefined stopPropagation();
	// function
	
	// attribute boolean cancelBubble; // legacy alias of .stopPropagation()
	console.log("event.cancelBubble = "		+event.cancelBubble)
	
	// undefined stopImmediatePropagation();
	// function
	
	// readonly attribute boolean bubbles;
	console.log("event.bubbles = "			+event.bubbles)
	
	// readonly attribute boolean cancelable;
	console.log("event.cancelable = "		+event.cancelable)
	
	// attribute boolean returnValue;  // legacy
	console.log("event.returnValue = "		+event.returnValue)
	
	// undefined preventDefault();
	// function
		
	// readonly attribute boolean defaultPrevented;
	console.log("event.defaultPrevented = "	+event.defaultPrevented)
	
	// readonly attribute boolean composed;
	console.log("event.composed = "			+event.composed)
	
	// [LegacyUnforgeable] readonly attribute boolean isTrusted;	
	console.log("event.isTrusted = "		+event.isTrusted)
	
	// readonly attribute DOMHighResTimeStamp timeStamp;
	console.log("event.timeStamp = "		+event.timeStamp)
	
	// undefined initEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false); // legacy
	// function 
}

const eventTarget = new EventTarget();

console.log('\n');
const myEventA = new Event('myeventA');
eventTarget.addEventListener('myeventA', function(event){
	console.log('onmyeventA')
	printEventProperties(event)
})
eventTarget.dispatchEvent(myEventA);

console.log('\n');
eventTarget.addEventListener('myeventB', function(event){
	console.log('onmyeventB')
	printEventProperties(event)
})
eventTarget.dispatchEvent(new Event('myeventB'));
