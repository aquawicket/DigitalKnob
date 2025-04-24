// https://developer.mozilla.org/en-US/docs/Web/API/HTMLScriptElement
// https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script

// https://html.spec.whatwg.org/multipage/scripting.html#the-script-element
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLScriptElement.js
var HTMLScriptElement = function HTMLScriptElement(pointer) {
    // Properties
	Object.defineProperty(this, "async", {
        get: function async() {
=======
var HTMLScriptElement = function HTMLScriptElement(pointer){
    // Properties
	Object.defineProperty(this, "async", {
        get: function async(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLScriptElement.js
            return CPP_DKDomHTMLScriptElement_async(pointer);
        }
    });
	Object.defineProperty(this, "charset", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLScriptElement.js
        get: function charset() {
=======
        get: function charset(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLScriptElement.js
            return CPP_DKDomHTMLScriptElement_charset(pointer);
        }
    });
	Object.defineProperty(this, "crossOrigin", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLScriptElement.js
        get: function crossOrigin() {
=======
        get: function crossOrigin(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLScriptElement.js
            return CPP_DKDomHTMLScriptElement_crossOrigin(pointer);
        }
    });
	Object.defineProperty(this, "defer", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLScriptElement.js
        get: function defer() {
=======
        get: function defer(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLScriptElement.js
            return CPP_DKDomHTMLScriptElement_defer(pointer);
        }
    });
	Object.defineProperty(this, "event", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLScriptElement.js
        get: function event() {
=======
        get: function event(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLScriptElement.js
            return CPP_DKDomHTMLScriptElement_event(pointer);
        }
    });
	Object.defineProperty(this, "integrity", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLScriptElement.js
        get: function integrity() {
=======
        get: function integrity(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLScriptElement.js
            return CPP_DKDomHTMLScriptElement_integrity(pointer);
        }
    });
	Object.defineProperty(this, "noModule", {
		configurable: true,
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLScriptElement.js
        get: function noModule() {
=======
        get: function noModule(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLScriptElement.js
            return CPP_DKDomHTMLScriptElement_noModule(pointer);
        }
    });
	Object.defineProperty(this, "nonce", {
		configurable: true,
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLScriptElement.js
        get: function nonce() {
=======
        get: function nonce(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLScriptElement.js
            return CPP_DKDomHTMLScriptElement_nonce(pointer);
        }
    });
	Object.defineProperty(this, "language", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLScriptElement.js
        get: function language() {
=======
        get: function language(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLScriptElement.js
            return CPP_DKDomHTMLScriptElement_language(pointer);
        }
    });
	Object.defineProperty(this, "referrerPolicy", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLScriptElement.js
        get: function referrerPolicy() {
=======
        get: function referrerPolicy(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLScriptElement.js
            return CPP_DKDomHTMLScriptElement_referrerPolicy(pointer);
        }
    });
	Object.defineProperty(this, "src", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLScriptElement.js
        get: function src() {
			return CPP_DKDomElement_getAttribute(pointer, "src")
        },
		set: function src(val) {
=======
        get: function src(){
			return CPP_DKDomElement_getAttribute(pointer, "src")
        },
		set: function src(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLScriptElement.js
			return CPP_DKDomElement_setAttribute(pointer, "src", val)
		}
    });
	Object.defineProperty(this, "text", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLScriptElement.js
        get: function text() {
=======
        get: function text(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLScriptElement.js
            return CPP_DKDomHTMLScriptElement_text(pointer);
        }
    });
	Object.defineProperty(this, "type", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLScriptElement.js
        get: function type() {
=======
        get: function type(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLScriptElement.js
            return CPP_DKDomHTMLScriptElement_type(pointer);
        }
    });
    return HTMLElement.call(this, pointer);
}

https://html.spec.whatwg.org/multipage/scripting.html#the-script-element
HTMLScriptElement.prototype = HTMLElement.prototype;
