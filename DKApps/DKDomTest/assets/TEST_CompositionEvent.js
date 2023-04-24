console.log("////// TEST_CompositionEvent.js //////")

// create EventTarget
const eventTarget = new EventTarget();


///// CompositionEvent //////
function printCompositionEventProperties(compositionevent){
	////// Instance properties //////
	console.log("compositionevent.data = "		+compositionevent.data)
	console.log("compositionevent.locale = "	+compositionevent.locale)
}