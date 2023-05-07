
var DKRmlLocation = function DKRmlLocation(address) {
	console.log("DKRmlLocation("+address+")");

	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKRmlLocationDUK();
	
	
	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object DKRmlLocation]" }
	
	return Location.call(this, this.address)
}
DKRmlLocation.prototype = Location.prototype;
