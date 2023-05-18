// [IDL] https://w3c.github.io/uievents/#idl-compositionevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent
console.log("\n////// TEST_CompositionEvent.js //////")


function printCompositionEventProperties(compositionevent){
	
	// constructor(DOMString type, optional CompositionEventInit eventInitDict = {});
	// function
		
	// readonly attribute DOMString data;
	console.log("compositionevent.data = "		+compositionevent.data)
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface CompositionEvent {
	//		// Originally introduced (and deprecated) in this specification
	//		undefined initCompositionEvent(DOMString typeArg,
	//		optional boolean bubblesArg = false,
	//		optional boolean cancelableArg = false,
	//		optional WindowProxy? viewArg = null,
	//		optional DOMString dataArg = "");
			// function
	// };
}

