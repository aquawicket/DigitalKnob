// [IDL] https://dom.spec.whatwg.org/#interface-nonelementparentnode

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// interface mixin NonElementParentNode {
var NonElementParentNode = function NonElementParentNode(address) {
	console.log("NonElementParentNode("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_NonElementParentNodeDUK_constructor();
		
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object NonElementParentNode]" }
	
	return this;
}

