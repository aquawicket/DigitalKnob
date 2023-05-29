// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlimageelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement


var HTMLImageElement = function HTMLImageElement(address) {
	//console.log("HTMLImageElement("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKHTMLImageElementDUK();
	
	
	// TODO


	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object HTMLImageElement]" }
	
	
	return HTMLElement.call(this)
}
HTMLImageElement.prototype = HTMLElement.prototype
