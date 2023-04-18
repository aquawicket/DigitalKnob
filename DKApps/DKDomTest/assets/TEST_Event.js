console.log("////// TEST_Event.js //////")

// create EventTarget
const eventTarget = new EventTarget();


////// Event ///////
function printEventProperties(event){
	////// Instance properties //////
	console.log("event.bubbles = "					+event.bubbles)					// [Event.bubbles](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/bubbles
	console.log("event.cancelable = "				+event.cancelable)				// [Event.cancelable](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelable
	console.log("event.composed = "					+event.composed)				// [Event.composed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/composed
	console.log("event.currentTarget = "			+event.currentTarget)			// [Event.currentTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/currentTarget
	console.log("event.defaultPrevented = "			+event.defaultPrevented)		// [Event.defaultPrevented](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/defaultPrevented
	console.log("event.eventPhase = "				+event.eventPhase)				// [Event.eventPhase](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/eventPhase	
	console.log("event.isTrusted = "				+event.isTrusted)				// [Event.isTrusted](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/isTrusted	
	console.log("event.target = "					+event.target)					// [Event.target](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/target
	console.log("event.timeStamp = "				+event.timeStamp)				// [Event.timeStamp](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/timeStamp
	console.log("event.type = "						+event.type)					// [Event.type](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/type
	////// Legacy and non-standard properties //////
	console.log("event.cancelBubble = "				+event.cancelBubble)			// [Event.cancelBubble](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelBubble
	console.log("event.explicitOriginalTarget = "	+event.explicitOriginalTarget)	// [Event.explicitOriginalTarget](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/explicitOriginalTarget
	console.log("event.originalTarget = "			+event.originalTarget)			// [Event.originalTarget](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/originalTarget
	console.log("event.returnValue = "				+event.returnValue)				// [Event.returnValue](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/returnValue
	console.log("event.scoped = "					+event.scoped)					// [Event.scoped](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/scoped
}

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
