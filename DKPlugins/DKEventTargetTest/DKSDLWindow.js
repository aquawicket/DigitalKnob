
var DKSDLWindow = function DKSDLWindow(address) {
	console.log("DKSDLWindow("+address+")");

	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKSDLWindow();
	
	
	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object DKSDLWindow]" }
	
	
	return Window.call(this, this.address)
}
DKSDLWindow.prototype = Window.prototype;
