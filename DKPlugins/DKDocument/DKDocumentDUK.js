// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=Window]
// interface Document : Node {
// constructor();
var Document = function Document(address) {
	//console.log("Document("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKDocumentDUK();

	
	// [SameObject] readonly attribute DOMImplementation implementation;
	Object.defineProperty(this, "implementation", {
        get: function implementation()			{ return CPP_DKDocumentDUK_implementation(this.address) },
		//set: function implementation(data)	{ return CPP_DKDocumentDUK_implementation(this.address, data) },
    })
	
	// readonly attribute USVString URL;
	Object.defineProperty(this, "URL", {
        get: function URL()						{ return CPP_DKDocumentDUK_URL(this.address) },
		//set: function URL(data)				{ return CPP_DKDocumentDUK_URL(this.address, data) },
    })
	
	// readonly attribute USVString documentURI;
	Object.defineProperty(this, "documentURI", {
        get: function documentURI()				{ return CPP_DKDocumentDUK_documentURI(this.address) },
		//set: function documentURI(data)		{ return CPP_DKDocumentDUK_documentURI(this.address, data) },
    })
	
	// readonly attribute DOMString compatMode;
	Object.defineProperty(this, "compatMode", {
        get: function compatMode()				{ return CPP_DKDocumentDUK_compatMode(this.address) },
		//set: function compatMode(data)		{ return CPP_DKDocumentDUK_compatMode(this.address, data) },
    })
	
	// readonly attribute DOMString characterSet;
	Object.defineProperty(this, "characterSet", {
        get: function characterSet()			{ return CPP_DKDocumentDUK_characterSet(this.address) },
		//set: function characterSet(data)		{ return CPP_DKDocumentDUK_characterSet(this.address, data) },
    })
	
	// readonly attribute DOMString charset; // legacy alias of .characterSet
	Object.defineProperty(this, "charset", {
        get: function charset()					{ return CPP_DKDocumentDUK_charset(this.address) },
		//set: function charset(data)			{ return CPP_DKDocumentDUK_charset(this.address, data) },
    })
	
	// readonly attribute DOMString inputEncoding; // legacy alias of .characterSet
	Object.defineProperty(this, "inputEncoding", {
        get: function inputEncoding()			{ return CPP_DKDocumentDUK_inputEncoding(this.address) },
		//set: function inputEncoding(data)		{ return CPP_DKDocumentDUK_inputEncoding(this.address, data) },
    })
	
	// readonly attribute DOMString contentType;
	Object.defineProperty(this, "contentType", {
        get: function contentType()				{ return CPP_DKDocumentDUK_contentType(this.address) },
		//set: function contentType(data)		{ return CPP_DKDocumentDUK_contentType(this.address, data) },
    })
	
	// readonly attribute DocumentType? doctype;
	Object.defineProperty(this, "doctype", {
        get: function doctype()					{ return CPP_DKDocumentDUK_doctype(this.address) },
		//set: function doctype(data)			{ return CPP_DKDocumentDUK_doctype(this.address, data) },
    })
	
	// readonly attribute Element? documentElement;
	Object.defineProperty(this, "documentElement", {
        get: function documentElement()			{ return CPP_DKDocumentDUK_documentElement(this.address) },
		//set: function documentElement(data)	{ return CPP_DKDocumentDUK_documentElement(this.address, data) },
    })
	
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	Document.prototype.getElementsByTagName = function getElementsByTagName(qualifiedName) {
		CPP_DKDocumentDUK_getElementsByTagName(this.address, qualifiedName);
		// TODO
		// Return a HTMLCollection
    }
	
	// TODO
		
		
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Document]" }
	
	return Node.call(this, this.address)
}
Document.prototype = Node.prototype
