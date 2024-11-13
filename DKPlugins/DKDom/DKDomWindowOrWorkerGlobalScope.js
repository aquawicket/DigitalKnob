//https://udn.realityripple.com/docs/Web/API/WindowOrWorkerGlobalScope
//https://html.spec.whatwg.org/multipage/webappapis.html#windoworworkerglobalscope-mixin
//https://javascript.info/mixins
//
// The WindowOrWorkerGlobalScope mixin is for use of APIs that are to be exposed on Window and WorkerGlobalScope objects.


var WindowOrWorkerGlobalScope = function WindowOrWorkerGlobalScope(pointer) {
    this.pointer = pointer;

	// Properties
    Object.defineProperty(this, "caches", {
        get: function caches() {
            return CPP_DKWindowOrWorkerGlobalScope_caches(pointer)
        }
    })
	Object.defineProperty(this, "crossOriginIsolated", {
        get: function crossOriginIsolated() {
            return CPP_DKWindowOrWorkerGlobalScope_crossOriginIsolated(pointer)
        }
    })
	Object.defineProperty(this, "indexedDB", {
        get: function indexedDB() {
            return CPP_DKWindowOrWorkerGlobalScope_indexedDB(pointer)
        }
    })
	Object.defineProperty(this, "isSecureContext", {
        get: function isSecureContext() {
            return CPP_DKWindowOrWorkerGlobalScope_isSecureContext(pointer)
        }
    })
	Object.defineProperty(this, "origin", {
        get: function origin() {
            return CPP_DKWindowOrWorkerGlobalScope_origin(pointer)
        }
    })
	
	// Methods
	WindowOrWorkerGlobalScope.prototype.atob = function atob() {
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.btoa = function btoa() {
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.clearInterval = function clearInterval() {
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.clearTimeout = function clearTimeout() {
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.createImageBitmap = function createImageBitmap() {
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.queueMicrotask = function queueMicrotask() {
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.setInterval = function setInterval() {
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.setTimeout = function setTimeout() {
		//TODO
    }
	
    return this;
}

