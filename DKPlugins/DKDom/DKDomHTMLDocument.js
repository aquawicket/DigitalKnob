// https://html.spec.whatwg.org/multipage/window-object.html#htmldocument
// HTMLDocument

var HTMLDocument = function HTMLDocument(pointer) {
	
	this.pointer = pointer
	
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object HTMLDocument]" }
	
    Document.call(this, pointer)
	return this;
}

HTMLDocument.prototype = Document.prototype;

//Object.assign(HTMLDocument.prototype, HTMLElement)