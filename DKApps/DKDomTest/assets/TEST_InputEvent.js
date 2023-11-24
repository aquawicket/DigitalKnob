// [IDL] https://w3c.github.io/uievents/#events-inputevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent
console.log("\n////// TEST_InputEvent.js //////");


function printInputEventProperties(inputevent){
	
	// constructor(DOMString type, optional InputEventInit eventInitDict = {});
	console.log("inputevent = "						+inputevent);
		
	// readonly attribute DOMString? data;	
	console.log("inputevent.data = "				+inputevent.data);
	
	//readonly attribute boolean isComposing;
	console.log("inputevent.isComposing = "			+inputevent.isComposing);
	
	//readonly attribute DOMString inputType;
	console.log("inputevent.inputType = "			+inputevent.inputType);
	
	// Source: Input Events Level 2 (https://www.w3.org/TR/input-events-2/)
	// partial interface InputEvent {
	//    	readonly attribute DataTransfer? dataTransfer;
			console.log("inputevent.dataTransfer = "	+inputevent.dataTransfer);
	//		
	//    	sequence<StaticRange> getTargetRanges();
			console.log("inputevent.getTargetRanges = "	+inputevent.getTargetRanges);
	// };


	printUIEventProperties(inputEvent);
}

function onInputEvent(event){
	console.log("onInputEvent() \n");
	printInputEventProperties(event);
}


var inputEventTarget = new EventTarget();
inputEventTarget.addEventListener("inputEvent", onInputEvent);
var inputEvent = new InputEvent("inputEvent", "");
inputEventTarget.dispatchEvent(inputEvent);