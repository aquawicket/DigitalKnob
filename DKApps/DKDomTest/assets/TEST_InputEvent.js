// [IDL] https://w3c.github.io/uievents/#events-inputevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent
console.log("\n////// TEST_InputEvent.js //////")


function printInputEventProperties(inputevent){
	console.log("inputevent.data = "		+inputevent.data)
	console.log("inputevent.dataTransfer = "+inputevent.dataTransfer)
	console.log("inputevent.inputType = "	+inputevent.inputType)
	console.log("inputevent.isComposing = "	+inputevent.isComposing)
}
