
var DKRmlDocument = function DKRmlDocument(address) {
	console.log("DKRmlDocument("+address+")");

	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKRmlDocumentDUK();
	
	
	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object DKRmlDocument]" }
	
	Location.call(this, this.address)
	return Document.call(this, this.address)
	
}
DKRmlDocument.prototype = Document.prototype = Location.prototype;
