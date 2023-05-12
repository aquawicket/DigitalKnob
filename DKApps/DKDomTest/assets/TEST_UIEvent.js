// [IDL] https://w3c.github.io/uievents/#idl-uievent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent
console.log("////// TEST_UIEvent.js //////")


function printUIEventProperties(uievent){
	console.log("uievent.detail = "				+uievent.detail)
	console.log("uievent.sourceCapabilities = "	+uievent.sourceCapabilities)			
	console.log("uievent.view = "				+uievent.view)
	console.log("uievent.which = "				+uievent.which)
}

const uievent = new UIEvent()
printUIEventProperties(uievent)