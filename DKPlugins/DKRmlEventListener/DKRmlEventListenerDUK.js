
var DKRmlEventListener = function DKRmlEventListener() {
	console.log("DKRmlEventListener()");

	//if(address)
	//	this.address = address;
	if(!this.address)
		this.address = CPP_DKRmlEventListenerDUK_constructor();
	
	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object DKRmlEventListener]" }
	
	return EventListener.call(this, this.address)
}
DKRmlEventListener.prototype = EventListener.prototype;
