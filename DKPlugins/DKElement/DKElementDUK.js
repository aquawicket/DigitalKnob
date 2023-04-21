// [IDL] https://dom.spec.whatwg.org/#interface-element
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Element


////// Constructor //////
// [Element()]
var Element = function Element(address) {
	//console.log("Element("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKElementDUK();

	
	////// Instance properties //////
	// TODO


	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Element]" }
	
	
	return Node.call(this)
}
Element.prototype = Node.prototype
