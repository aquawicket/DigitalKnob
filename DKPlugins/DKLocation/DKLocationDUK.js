// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/Location.idl
// [SOURCE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-location-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Location


// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Exposed=Window]
// interface Location { // but see also additional creation steps and overridden internal methods
var rmlLocation = function RmlLocation(address) {
	console.log("RmlLocation("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKRmlLocationDUK();

	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object RmlLocation]" }
	
	return this
}
