// [IDL] https://dom.spec.whatwg.org/#interface-htmlcollection
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection


// [Exposed=Window, LegacyUnenumerableNamedProperties]
// interface HTMLCollection {
var HTMLCollection = function HTMLCollection(address) {
	//console.log("HTMLCollection("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKHTMLCollectionDUK();
	
	// readonly attribute unsigned long length;
	Object.defineProperty(this, "length", {
        get: function length()			{ return CPP_DKHTMLCollectionDUK_length(this.address) },
		set: function length(data)		{ return CPP_DKHTMLCollectionDUK_length(this.address, data) },
    })
	
	// getter Element? item(unsigned long index);
	// TODO
	
	// getter Element? namedItem(DOMString name);
	// TODO
	
//};
		
		
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object HTMLCollection]" }
	
	return this
}
