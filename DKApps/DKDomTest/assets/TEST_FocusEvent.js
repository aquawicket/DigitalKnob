// [IDL] https://w3c.github.io/uievents/#events-focusevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/FocusEvent
console.log("\n////// TEST_FocusEvent.js //////")


function printFocusEventProperties(focusevent){
	
	// constructor(DOMString type, optional FocusEventInit eventInitDict = {});
	// function
		
	// readonly attribute EventTarget? relatedTarget;
	console.log("focusevent.relatedTarget = "	+focusevent.relatedTarget)
}
