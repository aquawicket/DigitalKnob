// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#htmldocument
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLDocument


////// Constructor //////
// [HTMLDocument()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLDocument/HTMLDocument
var HTMLDocument = function HTMLDocument(address) {
	//console.log("HTMLDocument("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKHTMLDocumentDUK();
	
	////// Instance properties //////
		
		
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object HTMLDocument]" }
	
	
	return Document.call(this)
}
HTMLDocument.prototype = Document.prototype
