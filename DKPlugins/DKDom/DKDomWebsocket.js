//https://developer.mozilla.org/en-US/docs/Web/API/WebSocket


var WebSocket = function WebSocket(pointer) {
	console.log("WebSocket("+pointer+")");
    this.pointer = pointer;

	//// Instance properties ////
	Object.defineProperty(this, "binaryType", {
        get: function binaryType() {
            return CPP_DKDomWebSocket_binaryType(pointer)
        }
    })
	Object.defineProperty(this, "bufferedAmount", {
        get: function bufferedAmount() {
            return CPP_DKDomWebSocket_bufferedAmount(pointer)
        }
    })
	Object.defineProperty(this, "extensions", {
        get: function extensions() {
            return CPP_DKDomWebSocket_extensions(pointer)
        }
    })
	Object.defineProperty(this, "protocol", {
        get: function protocol() {
            return CPP_DKDomWebSocket_protocol(pointer)
        }
    })
	Object.defineProperty(this, "readyState", {
        get: function readyState() {
            return CPP_DKDomWebSocket_readyState(pointer)
        }
    })
	Object.defineProperty(this, "url", {
        get: function url() {
            return CPP_DKDomWebSocket_url(pointer)
        }
    })
	

	//// Instance methods ////
	WebSocket.prototype.close = function close() {
		//TODO
    }
	WebSocket.prototype.send = function send() {
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
	
    return this;
}

// https://html.spec.whatwg.org/multipage/webappapis.html#eventhandler
WebSocket.prototype = EventTarget.prototype;
