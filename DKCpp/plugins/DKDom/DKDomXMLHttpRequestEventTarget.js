// https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequestEventTarget
// https://docs.w3cub.com/dom/xmlhttprequesteventtarget/onload

<<<<<<< HEAD:DKPlugins/DKDom/DKDomXMLHttpRequestEventTarget.js
var XMLHttpRequestEventTarget = function XMLHttpRequestEventTarget(pointer) {
=======
var XMLHttpRequestEventTarget = function XMLHttpRequestEventTarget(pointer){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomXMLHttpRequestEventTarget.js
 
	// Properties
	this.abort_func = null;
    Object.defineProperty(this, "onabort", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomXMLHttpRequestEventTarget.js
        get: function onabort() {
            return this.abort_func;
        },
        set: function onabort(func) {
=======
        get: function onabort(){
            return this.abort_func;
        },
        set: function onabort(func){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomXMLHttpRequestEventTarget.js
            this.addEventListener("abort", func);
            this.abort_func = func
        }
    });
	
	this.error_func = null;
    Object.defineProperty(this, "onerror", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomXMLHttpRequestEventTarget.js
        get: function onerror() {
            return this.error_func;
        },
        set: function onerror(func) {
=======
        get: function onerror(){
            return this.error_func;
        },
        set: function onerror(func){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomXMLHttpRequestEventTarget.js
            this.addEventListener("error", func);
            this.error_func = func
        }
    });
	
	this.error_func = null;
    Object.defineProperty(this, "onerror", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomXMLHttpRequestEventTarget.js
        get: function onerror() {
            return this.error_func;
        },
        set: function onerror(func) {
=======
        get: function onerror(){
            return this.error_func;
        },
        set: function onerror(func){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomXMLHttpRequestEventTarget.js
            this.addEventListener("error", func);
            this.error_func = func
        }
    });
	
	this.loadstart_func = null;
    Object.defineProperty(this, "onloadstart", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomXMLHttpRequestEventTarget.js
        get: function onloadstart() {
            return this.loadstart_func;
        },
        set: function onloadstart(func) {
=======
        get: function onloadstart(){
            return this.loadstart_func;
        },
        set: function onloadstart(func){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomXMLHttpRequestEventTarget.js
            this.addEventListener("loadstart", func);
            this.loadstart_func = func
        }
    });
	
	this.progress_func = null;
    Object.defineProperty(this, "onprogress", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomXMLHttpRequestEventTarget.js
        get: function onprogress() {
            return this.progress_func;
        },
        set: function onprogress(func) {
=======
        get: function onprogress(){
            return this.progress_func;
        },
        set: function onprogress(func){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomXMLHttpRequestEventTarget.js
            this.addEventListener("progress", func);
            this.progress_func = func
        }
    });
	
	this.timeout_func = null;
    Object.defineProperty(this, "ontimeout", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomXMLHttpRequestEventTarget.js
        get: function ontimeout() {
            return this.timeout_func;
        },
        set: function ontimeout(func) {
=======
        get: function ontimeout(){
            return this.timeout_func;
        },
        set: function ontimeout(func){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomXMLHttpRequestEventTarget.js
            this.addEventListener("timeout", func);
            this.timeout_func = func
        }
    });

	this.loadend_func = null;
    Object.defineProperty(this, "onloadend", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomXMLHttpRequestEventTarget.js
        get: function onloadend() {
            return this.loadend_func;
        },
        set: function onloadend(func) {
=======
        get: function onloadend(){
            return this.loadend_func;
        },
        set: function onloadend(func){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomXMLHttpRequestEventTarget.js
            this.addEventListener("loadend", func);
            this.loadend_func = func
        }
    });

    return EventTarget.call(this, pointer);
}

//IDL:: interface XMLHttpRequestEventTarget : EventTarget
XMLHttpRequestEventTarget.prototype = EventTarget.prototype;