
var WebSocketServer = function WebSocketServer(url) {
	console.log("WebSocketServer("+url+")");
    this.url = url;
	
	var pointer = CPP_DKDomDocument_createElement("websocketserver");
	this.pointer = pointer;
	
	CPP_DK_Create("DKWebSocketsServer,"+pointer);

	//// Instance properties ////
	Object.defineProperty(this, "isConnected", {
        get: function isConnected() {
            return CPP_DKDomWebSocketServer_isConnected(url)
        }
    })
	
	//// Instance methods ////
	WebSocketServer.prototype.disconnect = function disconnect() {
		console.log("WebSocket.prototype.disconnect()")
		CPP_DKDomWebSocketServer_disconnect()
    }
	WebSocketServer.prototype.send = function send(message) {
		console.log("WebSocket.prototype.send("+message+")")
		CPP_DKDomWebSocketServer_send(message)
    }	
	WebSocketServer.prototype.start = function start(address, port) {
		console.log("WebSocket.prototype.start("+address+","+port+")")
		CPP_DKDomWebSocketServer_start(address, port);
    }	
	
	//// Events ////
	// NOTE: already included from DKDomGlobalEventHandlers.js
	/*
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
	*/
	
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
	
	return EventTarget.call(this, pointer)
}

WebSocketServer.prototype = EventTarget.prototype;
