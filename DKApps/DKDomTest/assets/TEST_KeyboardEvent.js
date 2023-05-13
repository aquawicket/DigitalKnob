// [IDL] https://w3c.github.io/uievents/#events-keyboardevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
console.log("\n////// TEST_KeyboardEvent.js //////")


function printKeyboardEventProperties(keyboardevent){
	console.log("keyboardevent.altKey = "		+keyboardevent.altKey)
	console.log("keyboardevent.code = "			+keyboardevent.code)			
	console.log("keyboardevent.ctrlKey = "		+keyboardevent.ctrlKey)
	console.log("keyboardevent.isComposing = "	+keyboardevent.isComposing)
	console.log("keyboardevent.key = "			+keyboardevent.key)
	console.log("keyboardevent.locale = "		+keyboardevent.locale)
	console.log("keyboardevent.location = "		+keyboardevent.location)
	console.log("keyboardevent.metaKey = "		+keyboardevent.metaKey)
	console.log("keyboardevent.repeat = "		+keyboardevent.repeat)
	console.log("keyboardevent.shiftKey = "		+keyboardevent.shiftKey)
	console.log("keyboardevent.char = "			+keyboardevent.char)
	console.log("keyboardevent.charCode = "		+keyboardevent.charCode)
	console.log("keyboardevent.keyCode = "		+keyboardevent.keyCode)
	console.log("keyboardevent.keyIdentifier = "+keyboardevent.keyIdentifier)
	console.log("keyboardevent.keyLocation = "	+keyboardevent.keyLocation)
	console.log("keyboardevent.which = "		+keyboardevent.which)
}
