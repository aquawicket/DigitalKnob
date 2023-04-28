// [IDL] https://dom.spec.whatwg.org/#interface-customevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent
console.log("////// TEST_CustomEvent.js //////")


function printCustomEventProperties(customevent){
	////// Instance properties //////
	console.log("customevent.detail = "	+customevent.detail)	// [CustomEvent.detail](Read only) https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent/detail
}