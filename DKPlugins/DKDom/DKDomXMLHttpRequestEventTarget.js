// https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequestEventTarget

var XMLHttpRequestEventTarget = function(pointer) {
 
	// Properties
	this.abort_func = null;
    Object.defineProperty(this, "onabort", {
        get: function() {
            return this.abort_func;
        },
        set: function(func) {
            this.addEventListener("abort", func);
            this.abort_func = func
        }
    });
	
	this.error_func = null;
    Object.defineProperty(this, "onerror", {
        get: function() {
            return this.error_func;
        },
        set: function(func) {
            this.addEventListener("error", func);
            this.error_func = func
        }
    });
	
	this.error_func = null;
    Object.defineProperty(this, "onerror", {
        get: function() {
            return this.error_func;
        },
        set: function(func) {
            this.addEventListener("error", func);
            this.error_func = func
        }
    });
	
	this.loadstart_func = null;
    Object.defineProperty(this, "onloadstart", {
        get: function() {
            return this.loadstart_func;
        },
        set: function(func) {
            this.addEventListener("loadstart", func);
            this.loadstart_func = func
        }
    });
	
	this.progress_func = null;
    Object.defineProperty(this, "onprogress", {
        get: function() {
            return this.progress_func;
        },
        set: function(func) {
            this.addEventListener("progress", func);
            this.progress_func = func
        }
    });
	
	this.timeout_func = null;
    Object.defineProperty(this, "ontimeout", {
        get: function() {
            return this.timeout_func;
        },
        set: function(func) {
            this.addEventListener("timeout", func);
            this.timeout_func = func
        }
    });

	this.loadend_func = null;
    Object.defineProperty(this, "onloadend", {
        get: function() {
            return this.loadend_func;
        },
        set: function(func) {
            this.addEventListener("loadend", func);
            this.loadend_func = func
        }
    });

    return EventTarget.call(this, pointer);
}

//interface XMLHttpRequestEventTarget : EventTarget
XMLHttpRequestEventTarget.prototype = EventTarget.prototype;