var Tray = function Tray() {
	console.log("Tray()");
	
	var pointer = CPP_DKDomDocument_createElement("tray");
	this.pointer = pointer;
	
	CPP_DK_Create("DKTray,"+pointer);
	
	CPP_DKDomTray_open(url);

	//// Instance properties ////
	Object.defineProperty(this, "binaryType", {
        get: function binaryType() {
            return CPP_DKDomTray_binaryType(pointer)
        }
    })
	Object.defineProperty(this, "bufferedAmount", {
        get: function bufferedAmount() {
            return CPP_DKDomTray_bufferedAmount(pointer)
        }
    })
	Object.defineProperty(this, "extensions", {
        get: function extensions() {
            return CPP_DKDomTray_extensions(pointer)
        }
    })
	Object.defineProperty(this, "protocol", {
        get: function protocol() {
            return CPP_DKDomTray_protocol(pointer)
        }
    })
	Object.defineProperty(this, "readyState", {
        get: function readyState() {
            return CPP_DKDomTray_readyState(pointer)
        }
    })
	Object.defineProperty(this, "url", {
        get: function url() {
            return CPP_DKDomTray_url(pointer)
        }
    })
	

	//// Instance methods ////
	Tray.prototype.close = function close() {
		CPP_DKDomTray_close()
    }
	Tray.prototype.send = function send(message) {
		CPP_DKDomTray_send(message)
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
		this.toString = function(){	return "[object Tray]" }
	
    return EventTarget.call(this, pointer)
}

// https://html.spec.whatwg.org/multipage/webappapis.html#eventhandler
Tray.prototype = EventTarget.prototype;
