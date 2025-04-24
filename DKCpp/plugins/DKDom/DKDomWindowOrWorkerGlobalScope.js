//https://udn.realityripple.com/docs/Web/API/WindowOrWorkerGlobalScope
//https://html.spec.whatwg.org/multipage/webappapis.html#windoworworkerglobalscope-mixin
//https://javascript.info/mixins
//
// The WindowOrWorkerGlobalScope mixin is for use of APIs that are to be exposed on Window and WorkerGlobalScope objects.


<<<<<<< HEAD:DKPlugins/DKDom/DKDomWindowOrWorkerGlobalScope.js
var WindowOrWorkerGlobalScope = function WindowOrWorkerGlobalScope(pointer) {
=======
var WindowOrWorkerGlobalScope = function WindowOrWorkerGlobalScope(pointer){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomWindowOrWorkerGlobalScope.js
    this.pointer = pointer;

	// Properties
    Object.defineProperty(this, "caches", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomWindowOrWorkerGlobalScope.js
        get: function caches() {
=======
        get: function caches(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomWindowOrWorkerGlobalScope.js
            return CPP_DKWindowOrWorkerGlobalScope_caches(pointer)
        }
    })
	Object.defineProperty(this, "crossOriginIsolated", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomWindowOrWorkerGlobalScope.js
        get: function crossOriginIsolated() {
=======
        get: function crossOriginIsolated(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomWindowOrWorkerGlobalScope.js
            return CPP_DKWindowOrWorkerGlobalScope_crossOriginIsolated(pointer)
        }
    })
	Object.defineProperty(this, "indexedDB", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomWindowOrWorkerGlobalScope.js
        get: function indexedDB() {
=======
        get: function indexedDB(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomWindowOrWorkerGlobalScope.js
            return CPP_DKWindowOrWorkerGlobalScope_indexedDB(pointer)
        }
    })
	Object.defineProperty(this, "isSecureContext", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomWindowOrWorkerGlobalScope.js
        get: function isSecureContext() {
=======
        get: function isSecureContext(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomWindowOrWorkerGlobalScope.js
            return CPP_DKWindowOrWorkerGlobalScope_isSecureContext(pointer)
        }
    })
	Object.defineProperty(this, "origin", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomWindowOrWorkerGlobalScope.js
        get: function origin() {
=======
        get: function origin(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomWindowOrWorkerGlobalScope.js
            return CPP_DKWindowOrWorkerGlobalScope_origin(pointer)
        }
    })
	
	// Methods
<<<<<<< HEAD:DKPlugins/DKDom/DKDomWindowOrWorkerGlobalScope.js
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
=======
	WindowOrWorkerGlobalScope.prototype.atob = function atob(){
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.btoa = function btoa(){
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.clearInterval = function clearInterval(){
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.clearTimeout = function clearTimeout(){
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.createImageBitmap = function createImageBitmap(){
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.queueMicrotask = function queueMicrotask(){
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.setInterval = function setInterval(){
		//TODO
    }
	WindowOrWorkerGlobalScope.prototype.setTimeout = function setTimeout(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomWindowOrWorkerGlobalScope.js
		//TODO
    }
	
    return this;
}

