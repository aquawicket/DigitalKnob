// [IDL] https://w3c.github.io/uievents/#events-mouseevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent
console.log("\n////// TEST_MouseEvent.js //////")


function printMouseEventProperties(mouseevent){
	
	// constructor(DOMString type, optional MouseEventInit eventInitDict = {});
	// function
		
	// readonly attribute long screenX;
	console.log("mouseevent.screenX = "			+mouseevent.screenX);
	
	// readonly attribute long screenY;
	console.log("mouseevent.screenY = "			+mouseevent.screenY);
	
	// readonly attribute long clientX;
	console.log("mouseevent.clientX = "			+mouseevent.clientX);
	
	// readonly attribute long clientY;
	console.log("mouseevent.clientY = "			+mouseevent.clientY);
	
	// readonly attribute boolean ctrlKey;
	console.log("mouseevent.ctrlKey = "			+mouseevent.ctrlKey);
	
	// readonly attribute boolean shiftKey;
	console.log("mouseevent.shiftKey = "		+mouseevent.shiftKey);
	
	// readonly attribute boolean altKey;	
	console.log("mouseevent.altKey = "			+mouseevent.altKey);
	
	// readonly attribute boolean metaKey;
	console.log("mouseevent.metaKey = "			+mouseevent.metaKey);
	
	// readonly attribute short button;
	console.log("mouseevent.button = "			+mouseevent.button);
	
	// readonly attribute unsigned short buttons;	
	console.log("mouseevent.buttons = "			+mouseevent.buttons);
	
	// readonly attribute EventTarget? relatedTarget;
	console.log("mouseevent.relatedTarget = "	+mouseevent.relatedTarget);
	
	// boolean getModifierState(DOMString keyArg);
	// function
	
	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface MouseEvent {
	//  	readonly attribute double pageX;
			console.log("mouseevent.pageX = "			+mouseevent.pageX);
	//  	readonly attribute double pageY;
			console.log("mouseevent.pageY = "			+mouseevent.pageY);
	//  	readonly attribute double x;
			console.log("mouseevent.x = "				+mouseevent.x);
	//  	readonly attribute double y;
			console.log("mouseevent.y = "				+mouseevent.y);
	//  	readonly attribute double offsetX; 
			console.log("mouseevent.offsetX = "			+mouseevent.offsetX);
	//  	readonly attribute double offsetY;
			console.log("mouseevent.offsetY = "			+mouseevent.offsetY);
	// };
	
	// Source: Pointer Lock 2.0 (https://www.w3.org/TR/pointerlock-2/)
	// partial interface MouseEvent {
	//   	readonly attribute double movementX;
			console.log("mouseevent.movementX = "		+mouseevent.movementX);
	//   	readonly attribute double movementY;
			console.log("mouseevent.movementY = "		+mouseevent.movementY);
	// };
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface MouseEvent {
	//		Deprecated in this specification
	//	  	undefined initMouseEvent(DOMString typeArg,
	//		optional boolean bubblesArg = false,
	//		optional boolean cancelableArg = false,
	//		optional Window? viewArg = null,
	//		optional long detailArg = 0,
	//		optional long screenXArg = 0,
	//		optional long screenYArg = 0,
	//		optional long clientXArg = 0,
	//		optional long clientYArg = 0,
	//		optional boolean ctrlKeyArg = false,
	//		optional boolean altKeyArg = false,
	//		optional boolean shiftKeyArg = false,
	//		optional boolean metaKeyArg = false,
	//		optional short buttonArg = 0,
	//		optional EventTarget? relatedTargetArg = null);
			// function
	// };
	
	printUIEventProperties(mouseEvent);
}

function onMouseEvent(DKEvent& event){
	DKDEBUGFUNC(event);
	console.log("onMouseEvent() \n");
	printMouseEventProperties(event);
}

var mouseEventTarget = new EventTarget();
mouseEventTarget.addEventListener("mouseEvent", onMouseEvent);
var mouseEvent = new MouseEvent("mouseEvent", "");
mouseEventTarget.dispatchEvent(mouseEvent);
