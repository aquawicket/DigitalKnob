
var WebSocketServer = function WebSocketServer(pointer) {
    this.pointer = pointer;

	//TODO
	
	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object WebSocketServer]" }
	
    return this;
}

WebSocketServer.prototype = EventTarget.prototype;
