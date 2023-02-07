
var WebSocketServer = function WebSocketServer(url) {
    this.url = url;

	//// Instance properties ////
	Object.defineProperty(this, "isConnected", {
        get: function isConnected() {
            return CPP_DKDomWebSocketServer_isConnected(url)
        }
    })
	
	//// Instance methods ////
	WebSocket.prototype.disconnect = function disconnect() {
		//TODO
    }
	WebSocket.prototype.send = function send() {
		//TODO
    }	
	WebSocket.prototype.start = function start() {
		//TODO
    }	
	
	//// Events ////
	this.close_func = null;
    Object.defineProperty(this, "onclose", {
        get: function onclose() {
            return this.close_func;
        },
        set: function onclose(func) {
            func && this.addEventListener("close", func)
			!func && this.removeEventListener("close", this.close_func)
            this.close_func = func
        }
    });
	
	this.message_func = null;
    Object.defineProperty(this, "onmessage", {
        get: function onmessage() {
            return this.message_func;
        },
        set: function onmessage(func) {
            func && this.addEventListener("message", func)
			!func && this.removeEventListener("message", this.message_func)
            this.message_func = func
        }
    });
	
	this.open_func = null;
    Object.defineProperty(this, "onopen", {
        get: function onopen() {
            return this.open_func;
        },
        set: function onopen(func) {
            func && this.addEventListener("open", func)
			!func && this.removeEventListener("open", this.open_func)
            this.open_func = func
        }
    });
	
	
	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object WebSocketServer]" }
	
    return this;
}

WebSocketServer.prototype = EventTarget.prototype;
