// [INTERFACE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location


var Location = function Location(address) {
	//console.log("Location("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKLocationDUK();

	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Location]" }
	
	
	return this
}
