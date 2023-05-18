// [IDL] https://dom.spec.whatwg.org/#interface-customevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent
console.log("\n////// TEST_CustomEvent.js //////")


function printCustomEventProperties(customevent){
	
	// constructor(DOMString type, optional CustomEventInit eventInitDict = {});
	// function
	
	// readonly attribute any detail;
	console.log("customevent.detail = "	+customevent.detail)
	
	// undefined initCustomEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false, optional any detail = null); // legacy
	// function
}
