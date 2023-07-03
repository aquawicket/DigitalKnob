// [INTERFACE] https://html.spec.whatwg.org/multipage/system-state.html#the-navigator-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Navigator


var Navigator = function Navigator(address) {
	console.log("Navigator("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKNavigatorDUK_constructor();

	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Navigator]" }
	
	
	return this;
}
