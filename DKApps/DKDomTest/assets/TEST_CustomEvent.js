// [IDL] https://dom.spec.whatwg.org/#interface-customevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent
console.log("\n////// TEST_CustomEvent.js //////")


function printCustomEventProperties(customevent){
	
	// constructor(DOMString type, optional CustomEventInit eventInitDict = {});
	console.log("customevent = "				+customevent)
	
	// readonly attribute any detail;
	console.log("customevent.detail = "			+customevent.detail)
	
	// undefined initCustomEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false, optional any detail = null); // legacy
	console.log("customevent.initCustomEvent = "+customevent.initCustomEvent)
	
	printEventProperties(customEvent);
}

function onCustomEvent(event) {
		console.log("onCustomEvent() \n");
		printCustomEventProperties(event);
		return true;
}
	
var customEventTarget = new EventTarget();
customEventTarget.addEventListener("customEvent", onCustomEvent);
var customEvent = new CustomEvent("customEvent", "");
customEvent.detail = "{name : 'myCustomEvent'}";
customEventTarget.dispatchEvent(customEvent);
