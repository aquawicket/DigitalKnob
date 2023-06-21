
var DKRmlDocument = function DKRmlDocument(dkRmlInterface, dkRmlEventListener) {
	console.log("DKRmlLocation("+dkRmlInterface+","+dkRmlEventListener+")");
	console.log("DKRmlLocation("+dkRmlInterface.address+","+dkRmlEventListener.address+")");

	//if(address)
	//	this.address = address;
	if(!this.address)
		this.address = CPP_DKRmlDocumentDUK_constructor(dkRmlInterface.address, dkRmlEventListener.address);
	
	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object DKRmlDocument]" }
	
	return Document.call(this, this.address);
}
DKRmlDocument.prototype = Document.prototype;
