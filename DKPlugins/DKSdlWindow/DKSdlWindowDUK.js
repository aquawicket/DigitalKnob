
var DKSdlWindow = function DKSdlWindow(address) {
	console.log("DKSdlWindow("+address+")");

	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKSdlWindowDUK();
	
	
	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object DKSdlWindow]" }
	
	
	return Window.call(this, this.address)
}
DKSdlWindow.prototype = Window.prototype;
