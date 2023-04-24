console.log("////// TEST_InputEvent.js //////")


////// InputEvent //////
function printInputEventProperties(inputevent){
	////// Instance properties //////
	console.log("inputevent.data = "		+inputevent.data)
	console.log("inputevent.dataTransfer = "+inputevent.dataTransfer)
	console.log("inputevent.inputType = "	+inputevent.inputType)
	console.log("inputevent.isComposing = "	+inputevent.isComposing)
}


////// Constructor //////
// [InputEvent()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/InputEvent
	
		
////// Instance properties //////
// [InputEvent.data](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/data
// [InputEvent.dataTransfer](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/dataTransfer
// [InputEvent.inputType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/inputType
// [InputEvent.isComposing](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/isComposing
	
	
////// Instance methods //////
// [InputEvent.getTargetRanges()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/getTargetRanges


////// Events //////
// [beforeinput] https://w3c.github.io/uievents/#event-type-beforeinput
// [input] https://w3c.github.io/uievents/#event-type-input