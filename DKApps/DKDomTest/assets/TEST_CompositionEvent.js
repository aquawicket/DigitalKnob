// [IDL] https://w3c.github.io/uievents/#events-compositionevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent
console.log("////// TEST_CompositionEvent.js //////")


function printCompositionEventProperties(compositionevent){
	////// Instance properties //////
	console.log("compositionevent.data = "		+compositionevent.data)
	console.log("compositionevent.locale = "	+compositionevent.locale)
}