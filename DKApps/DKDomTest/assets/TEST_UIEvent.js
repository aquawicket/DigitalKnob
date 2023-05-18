// [IDL] https://w3c.github.io/uievents/#idl-uievent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent
console.log("\n////// TEST_UIEvent.js //////")


function printUIEventProperties(uievent){
	
	// constructor(DOMString type, optional UIEventInit eventInitDict = {});
	// function
		
	// readonly attribute Window? view;
	console.log("uievent.view = "				+uievent.view)
	
	// readonly attribute long detail;
	console.log("uievent.detail = "				+uievent.detail)
	
	// Source: Input Device Capabilities (https://wicg.github.io/input-device-capabilities/)
	// partial interface UIEvent {
	// 		readonly attribute InputDeviceCapabilities? sourceCapabilities;
			console.log("uievent.sourceCapabilities = "	+uievent.sourceCapabilities)
	// };
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface UIEvent {
	// 		Deprecated in this specification
	//		undefined initUIEvent(DOMString typeArg, optional boolean bubblesArg = false, optional boolean cancelableArg = false, optional Window? viewArg = null, optional long detailArg = 0);
			// function
	//	};

	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface UIEvent {
	//		The following support legacy user agents
	//		readonly attribute unsigned long which;
			console.log("uievent.which = "				+uievent.which)
	// };	
}

const uievent = new UIEvent('myUiEvent', '', '')
printUIEventProperties(uievent)