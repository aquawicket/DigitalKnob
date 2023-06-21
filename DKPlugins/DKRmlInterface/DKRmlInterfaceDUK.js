
var DKRmlInterface = function DKRmlInterface(window) {
	console.log("DKRmlInterface("+window+")");

	//if(address)
	//	this.address = address;
	if(!this.address)
		this.address = CPP_DKRmlInterfaceDUK_constructor(window.address);
	
	
	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object DKRmlInterface]" }
	
	return this;
}
