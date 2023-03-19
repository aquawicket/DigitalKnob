// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WebSocket
// [INTERFACE] https://websockets.spec.whatwg.org/#the-websocket-interface


// [WebSocket()] https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/WebSocket
var WebSocket = function WebSocket(url) {
	console.log("WebSocket("+url+")");
	this.url = url;
	var pointer = CPP_DKDomDocument_createElement("websocket");
	this.pointer = pointer;
	CPP_DK_Create("DKUWebSocketsClient,"+pointer);
	CPP_DKDomWebSocket_open(url);

	////// Instance properties //////
	// [WebSocket.binaryType] https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/binaryType
	Object.defineProperty(this, "binaryType", {
        get: function binaryType() {
            return CPP_DKDomWebSocket_binaryType(pointer)
        }
    })
	// [WebSocket.bufferedAmount](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/bufferedAmount
	Object.defineProperty(this, "bufferedAmount", {
        get: function bufferedAmount() {
            return CPP_DKDomWebSocket_bufferedAmount(pointer)
        }
    })
	// [WebSocket.extensions](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/extensions
	Object.defineProperty(this, "extensions", {
        get: function extensions() {
            return CPP_DKDomWebSocket_extensions(pointer)
        }
    })
	// [WebSocket.protocol](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/protocol
	Object.defineProperty(this, "protocol", {
        get: function protocol() {
            return CPP_DKDomWebSocket_protocol(pointer)
        }
    })
	// [WebSocket.readyState](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/readyState
	Object.defineProperty(this, "readyState", {
        get: function readyState() {
            return CPP_DKDomWebSocket_readyState(pointer)
        }
    })
	// [WebSocket.url](Read only) https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/url
	Object.defineProperty(this, "url", {
        get: function url() {
            return CPP_DKDomWebSocket_url(pointer)
        }
    })
	

	////// Instance methods //////
	WebSocket.prototype.close = function close() {
		CPP_DKDomWebSocket_close()
    }
	WebSocket.prototype.send = function send(message) {
		CPP_DKDomWebSocket_send(message)
    }
	
	
	//// Events ////
	// [close] https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/close_event
	// [error] https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/error_event
	// [message] https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/message_event
	// [open] https://developer.mozilla.org/en-US/docs/Web/API/WebSocket/open_event



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
	
	// NOTE: already included from DKDomGlobalEventHandlers.js
	/*
	this.error_func = null;
    Object.defineProperty(this, "onerror", {
        get: function onerror() {
            return this.error_func;
        },
        set: function onerror(func) {
            func && this.addEventListener("error", func)
			!func && this.removeEventListener("error", this.error_func)
            this.error_func = func
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
		this.toString = function(){	return "[object WebSocket]" }
	
    return EventTarget.call(this, pointer)
}
WebSocket.prototype = EventTarget.prototype;