// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLBodyElement


var HTMLBodyElement = function HTMLBodyElement(address) {
	//console.log("HTMLBodyElement("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKHTMLBodyElementDUK();
	
	
	// TODO
		
		
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object HTMLBodyElement]" }
	
	
	return HTMLElement.call(this)
}
HTMLBodyElement.prototype = HTMLElement.prototype
