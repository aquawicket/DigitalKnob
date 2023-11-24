// [IDL] https://dom.spec.whatwg.org/#callbackdef-eventlistener
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventListener
console.log("\n////// TEST_EventListener.js //////")


function printEventListenerProperties(eventListener) {

	console.log("eventListener = "		+eventListener);
}


var eventListener = new EventListener();
printEventListenerProperties(eventListener);