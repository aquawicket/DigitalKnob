// [INTERFACE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location


var Location = function Location(address) {
	//console.log("Location("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKLocationDUK();


	////// Instance properties //////
	// [Location.ancestorOrigins] https://developer.mozilla.org/en-US/docs/Web/API/Location/ancestorOrigins
	// [Location.href] https://developer.mozilla.org/en-US/docs/Web/API/Location/href
	// [Location.protocol] https://developer.mozilla.org/en-US/docs/Web/API/Location/protocol
	// [Location.host] https://developer.mozilla.org/en-US/docs/Web/API/Location/host
	// [Location.hostname] https://developer.mozilla.org/en-US/docs/Web/API/Location/hostname
	// [Location.port] https://developer.mozilla.org/en-US/docs/Web/API/Location/port
	// [Location.pathname] https://developer.mozilla.org/en-US/docs/Web/API/Location/pathname
	// [Location.search] https://developer.mozilla.org/en-US/docs/Web/API/Location/search
	// [Location.hash] https://developer.mozilla.org/en-US/docs/Web/API/Location/hash
	// [Location.origin](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Location/origin
		
		
	////// Instance methods //////
	// [Location.assign()] https://developer.mozilla.org/en-US/docs/Web/API/Location/assign
	// [Location.reload()] https://developer.mozilla.org/en-US/docs/Web/API/Location/reload
	// [Location.replace()] https://developer.mozilla.org/en-US/docs/Web/API/Location/replace
	// [Location.toString()] https://developer.mozilla.org/en-US/docs/Web/API/Location/toString
		
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Location]" }
	
	
	return this
}
