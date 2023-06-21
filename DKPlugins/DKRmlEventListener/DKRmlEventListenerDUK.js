
var DKRmlEventListener = function DKRmlEventListener(dkRmlInterface, dkRmlEventListener) {
	console.log("DKRmlEventListener("+dkRmlInterface+","+dkRmlEventListener+")");

	//if(address)
	//	this.address = address;
	if(!this.address)
		this.address = CPP_DKRmlEventListenerDUK_constructor(dkRmlInterface.address, dkRmlEventListener.address);	
	
	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object DKRmlEventListener]" }
	
	return EventListener.call(this, this.address)
}
DKRmlEventListener.prototype = EventListener.prototype;
