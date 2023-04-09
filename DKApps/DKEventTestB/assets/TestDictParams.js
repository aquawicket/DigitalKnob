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

////// CustomEvent //////
function printCustomEventProperties(customevent){
	////// Instance properties //////
	console.log("customevent.detail = "	+customevent.detail)
}

console.log('\n');
function oncustomevent(event){
	console.log('oncustomevent')
	printEventProperties(event)
	printCustomEventProperties(event)
}

const myCustomEvent = new CustomEvent('customevent', {
	bubbles: true,
	cancelable: true,
	composed: true
});
obj.addEventListener('customevent', oncustomevent)
obj.dispatchEvent(myCustomEvent);

