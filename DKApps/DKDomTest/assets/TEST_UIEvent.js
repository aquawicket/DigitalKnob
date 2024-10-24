// [IDL] https://w3c.github.io/uievents/#idl-uievent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent
console.log("\n////// TEST_UIEvent.js //////")


function printUIEventProperties(uievent){
	
	// constructor(DOMString type, optional UIEventInit eventInitDict = {});
	console.log("uievent = "					+uievent);
		
	// readonly attribute Window? view;
	console.log("uievent.view = "				+uievent.view);
	
	// readonly attribute long detail;
	console.log("uievent.detail = "				+uievent.detail);
	
	// Source: Input Device Capabilities (https://wicg.github.io/input-device-capabilities/)
	// partial interface UIEvent {
	// 		readonly attribute InputDeviceCapabilities? sourceCapabilities;
			console.log("uievent.sourceCapabilities = "	+uievent.sourceCapabilities);
	// };
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface UIEvent {
	// 		Deprecated in this specification
	//		undefined initUIEvent(DOMString typeArg, optional boolean bubblesArg = false, optional boolean cancelableArg = false, optional Window? viewArg = null, optional long detailArg = 0);
			console.log("uievent.initUIEvent = "		+uievent.initUIEvent);
	//	};

	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface UIEvent {
	//		The following support legacy user agents
	//		readonly attribute unsigned long which;
			console.log("uievent.which = "				+uievent.which);
	// };
	
	printEventProperties(uievent);
}

function onuievent(event){
	console.log("onuievent() \n");
	printUIEventProperties(event);
}
	

var uiEventTarget = new EventTarget();
uiEventTarget.addEventListener("uievent", onuievent);
var uievent = new UIEvent("uievent", "");
uiEventTarget.dispatchEvent(uievent);