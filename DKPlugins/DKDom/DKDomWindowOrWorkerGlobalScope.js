//https://udn.realityripple.com/docs/Web/API/WindowOrWorkerGlobalScope
//https://html.spec.whatwg.org/multipage/webappapis.html#windoworworkerglobalscope-mixin
//https://javascript.info/mixins
//
// The WindowOrWorkerGlobalScope mixin is for use of APIs that are to be exposed on Window and WorkerGlobalScope objects.


var WindowOrWorkerGlobalScope = function(pointer) {
    this.pointer = pointer;

	// Properties
    Object.defineProperty(this, "caches", {
        get: function() {
            return CPP_DKWindowOrWorkerGlobalScope_caches(pointer)
        }
    })
	Object.defineProperty(this, "crossOriginIsolated", {
        get: function() {
            return CPP_DKWindowOrWorkerGlobalScope_crossOriginIsolated(pointer)
        }
    })
	Object.defineProperty(this, "indexedDB", {
        get: function() {
            return CPP_DKWindowOrWorkerGlobalScope_indexedDB(pointer)
        }
    })
	Object.defineProperty(this, "isSecureContext", {
        get: function() {
            return CPP_DKWindowOrWorkerGlobalScope_isSecureContext(pointer)
        }
    })
	Object.defineProperty(this, "origin", {
        get: function() {
            return CPP_DKWindowOrWorkerGlobalScope_origin(pointer)
        }
    })
	
	// Methods
	WindowOrWorkerGlobalScope.prototype.atob = function() {
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.btoa = function() {
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.clearInterval = function() {
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.clearTimeout = function() {
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.createImageBitmap = function() {
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.queueMicrotask = function() {
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.setInterval = function() {
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.setTimeout = function() {
		//TODO
    }
	
    return this;
}

