
var DKRmlInterface = function DKRmlInterface(address) {
	console.log("DKRmlInterface("+address+")");

	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKRmlInterfaceDUK_constructor();
	
	
	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object DKRmlInterface]" }
	
	return Document.call(this, this.address)
	
}
DKRmlInterface.prototype = Document.prototype;
