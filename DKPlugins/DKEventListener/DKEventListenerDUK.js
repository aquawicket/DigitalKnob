// [IDL] https://dom.spec.whatwg.org/#callbackdef-eventlistener
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventListener

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// callback interface EventListener {
var EventListener = function EventListener(address) {
	console.log("EventListener("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKEventListenerDUK_constructor();

	// TODO
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object EventListener]" }
	
	return this;
}
