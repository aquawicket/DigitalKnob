// [IDL] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement


////// Constructor //////
// [HTMLElement()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/HTMLElement
var HTMLElement = function HTMLElement(address) {
	//console.log("HTMLElement("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKHTMLElementDUK();
	
	////// Instance properties //////
		
		
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object HTMLElement]" }
	
	
	return Element.call(this)
}
HTMLElement.prototype = Element.prototype
