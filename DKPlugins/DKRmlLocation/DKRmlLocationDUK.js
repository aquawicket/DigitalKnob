
var DKRmlLocation = function DKRmlLocation(dkRmlInterface, dkRmlEventListener) {
	console.log("RmlLocation("+dkRmlInterface+","+dkRmlEventListener+")");
	console.log("RmlLocation("+dkRmlInterface.address+","+dkRmlEventListener.address+")");

	//if(address)
	//	this.address = address;
	if(!this.address)
		this.address = CPP_DKRmlLocationDUK_constructor(dkRmlInterface.address, dkRmlEventListener.address);
	
	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object DKRmlLocation]" }
	
	return Location.call(this, this.address);
}
DKRmlLocation.prototype = Location.prototype;