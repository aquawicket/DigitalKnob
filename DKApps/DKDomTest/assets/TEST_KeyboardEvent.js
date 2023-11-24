// [IDL] https://w3c.github.io/uievents/#events-keyboardevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
console.log("\n////// TEST_KeyboardEvent.js //////");


function printKeyboardEventProperties(keyboardevent){
	
	// constructor(DOMString type, optional KeyboardEventInit eventInitDict = {});
	console.log("keyboardevent = "							+keyboardevent);
		
	// KeyLocationCode
	// const unsigned long DOM_KEY_LOCATION_STANDARD = 0x00;
	console.log("keyboardevent.DOM_KEY_LOCATION_STANDARD = "+keyboardevent.DOM_KEY_LOCATION_STANDARD);
		
	// const unsigned long DOM_KEY_LOCATION_LEFT = 0x01;
	console.log("keyboardevent.DOM_KEY_LOCATION_LEFT = "	+keyboardevent.DOM_KEY_LOCATION_LEFT);
	
	// const unsigned long DOM_KEY_LOCATION_RIGHT = 0x02;
	console.log("keyboardevent.DOM_KEY_LOCATION_RIGHT = "	+keyboardevent.DOM_KEY_LOCATION_RIGHT);
	
	// const unsigned long DOM_KEY_LOCATION_NUMPAD = 0x03;
	console.log("keyboardevent.DOM_KEY_LOCATION_NUMPAD = "	+keyboardevent.DOM_KEY_LOCATION_NUMPAD);
	
	// readonly attribute DOMString key;
	console.log("keyboardevent.key = "						+keyboardevent.key);
	
	// readonly attribute DOMString code;
	console.log("keyboardevent.code = "						+keyboardevent.code);
	
	// readonly attribute unsigned long location;
	console.log("keyboardevent.location = "					+keyboardevent.location);
	
	// readonly attribute boolean ctrlKey;
	console.log("keyboardevent.ctrlKey = "					+keyboardevent.ctrlKey);
	
	// readonly attribute boolean shiftKey;
	console.log("keyboardevent.shiftKey = "					+keyboardevent.shiftKey);
	
	// readonly attribute boolean altKey;
	console.log("keyboardevent.altKey = "					+keyboardevent.altKey);
				
	// readonly attribute boolean metaKey;
	console.log("keyboardevent.metaKey = "					+keyboardevent.metaKey);
	
	// readonly attribute boolean repeat;
	console.log("keyboardevent.repeat = "					+keyboardevent.repeat);
	
	// readonly attribute boolean isComposing;
	console.log("keyboardevent.isComposing = "				+keyboardevent.isComposing);
	
	// boolean getModifierState(DOMString keyArg);
	console.log("keyboardevent.getModifierState = "			+keyboardevent.getModifierState);
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface KeyboardEvent {
	//		// Originally introduced (and deprecated) in this specification
	//		undefined initKeyboardEvent(DOMString typeArg,
	// 		optional boolean bubblesArg = false,
	// 		optional boolean cancelableArg = false,
	//		optional Window? viewArg = null,
	//		optional DOMString keyArg = "",
	//		optional unsigned long locationArg = 0,
	//		optional boolean ctrlKey = false,
	//		optional boolean altKey = false,
	//		optional boolean shiftKey = false,
	//		optional boolean metaKey = false);
			console.log("keyboardevent.initKeyboardEvent = "	+keyboardevent.initKeyboardEvent);
	// };
		
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface KeyboardEvent {
	//		// The following support legacy user agents
	//		readonly attribute unsigned long charCode;
			console.log("keyboardevent.charCode = "				+keyboardevent.charCode);
	//
	//		readonly attribute unsigned long keyCode;
			console.log("keyboardevent.keyCode = "				+keyboardevent.keyCode);
	// };
	
	
	printUIEventProperties(keyboardevent);
}

function onKeyboardEvent(event){
	console.log("onKeyboardEvent() \n");
	printKeyboardEventProperties(event);
}


var keyboardEventTarget = new EventTarget();
keyboardEventTarget.addEventListener("keyboardEvent", onKeyboardEvent);
var keyboardEvent = new KeyboardEvent("keyboardEvent", "");
keyboardEventTarget.dispatchEvent(keyboardEvent);