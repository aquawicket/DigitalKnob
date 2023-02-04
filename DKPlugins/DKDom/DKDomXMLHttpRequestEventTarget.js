// https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequestEventTarget
// https://docs.w3cub.com/dom/xmlhttprequesteventtarget/onload

var XMLHttpRequestEventTarget = function XMLHttpRequestEventTarget(pointer) {
 
	// Properties
	this.abort_func = null;
    Object.defineProperty(this, "onabort", {
        get: function onabort() {
            return this.abort_func;
        },
        set: function onabort(func) {
            this.addEventListener("abort", func);
            this.abort_func = func
        }
    });
	
	this.error_func = null;
    Object.defineProperty(this, "onerror", {
        get: function onerror() {
            return this.error_func;
        },
        set: function onerror(func) {
            this.addEventListener("error", func);
            this.error_func = func
        }
    });
	
	this.error_func = null;
    Object.defineProperty(this, "onerror", {
        get: function onerror() {
            return this.error_func;
        },
        set: function onerror(func) {
            this.addEventListener("error", func);
            this.error_func = func
        }
    });
	
	this.loadstart_func = null;
    Object.defineProperty(this, "onloadstart", {
        get: function onloadstart() {
            return this.loadstart_func;
        },
        set: function onloadstart(func) {
            this.addEventListener("loadstart", func);
            this.loadstart_func = func
        }
    });
	
	this.progress_func = null;
    Object.defineProperty(this, "onprogress", {
        get: function onprogress() {
            return this.progress_func;
        },
        set: function onprogress(func) {
            this.addEventListener("progress", func);
            this.progress_func = func
        }
    });
	
	this.timeout_func = null;
    Object.defineProperty(this, "ontimeout", {
        get: function ontimeout() {
            return this.timeout_func;
        },
        set: function ontimeout(func) {
            this.addEventListener("timeout", func);
            this.timeout_func = func
        }
    });

	this.loadend_func = null;
    Object.defineProperty(this, "onloadend", {
        get: function onloadend() {
            return this.loadend_func;
        },
        set: function onloadend(func) {
            this.addEventListener("loadend", func);
            this.loadend_func = func
        }
    });

	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object XMLHttpRequestEventTarget]"
		}
	}
	
    return EventTarget.call(this, pointer);
}

//IDL:: interface XMLHttpRequestEventTarget : EventTarget
XMLHttpRequestEventTarget.prototype = EventTarget.prototype;