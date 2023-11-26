// https://developer.mozilla.org/en-US/docs/Web/API/HTMLScriptElement
// https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script

// https://html.spec.whatwg.org/multipage/scripting.html#the-script-element
var HTMLScriptElement = function HTMLScriptElement(pointer) {
    // Properties
	Object.defineProperty(this, "async", {
        get: function async() {
            return CPP_DKDomHTMLScriptElement_async(pointer);
        }
    });
	Object.defineProperty(this, "charset", {
        get: function charset() {
            return CPP_DKDomHTMLScriptElement_charset(pointer);
        }
    });
	Object.defineProperty(this, "crossOrigin", {
        get: function crossOrigin() {
            return CPP_DKDomHTMLScriptElement_crossOrigin(pointer);
        }
    });
	Object.defineProperty(this, "defer", {
        get: function defer() {
            return CPP_DKDomHTMLScriptElement_defer(pointer);
        }
    });
	Object.defineProperty(this, "event", {
        get: function event() {
            return CPP_DKDomHTMLScriptElement_event(pointer);
        }
    });
	Object.defineProperty(this, "integrity", {
        get: function integrity() {
            return CPP_DKDomHTMLScriptElement_integrity(pointer);
        }
    });
	Object.defineProperty(this, "noModule", {
		configurable: true,
        get: function noModule() {
            return CPP_DKDomHTMLScriptElement_noModule(pointer);
        }
    });
	Object.defineProperty(this, "nonce", {
		configurable: true,
        get: function nonce() {
            return CPP_DKDomHTMLScriptElement_nonce(pointer);
        }
    });
	Object.defineProperty(this, "language", {
        get: function language() {
            return CPP_DKDomHTMLScriptElement_language(pointer);
        }
    });
	Object.defineProperty(this, "referrerPolicy", {
        get: function referrerPolicy() {
            return CPP_DKDomHTMLScriptElement_referrerPolicy(pointer);
        }
    });
	Object.defineProperty(this, "src", {
        get: function src() {
			return CPP_DKDomElement_getAttribute(pointer, "src")
        },
		set: function src(val) {
			return CPP_DKDomElement_setAttribute(pointer, "src", val)
		}
    });
	Object.defineProperty(this, "text", {
        get: function text() {
            return CPP_DKDomHTMLScriptElement_text(pointer);
        }
    });
	Object.defineProperty(this, "type", {
        get: function type() {
            return CPP_DKDomHTMLScriptElement_type(pointer);
        }
    });
    return HTMLElement.call(this, pointer);
}

https://html.spec.whatwg.org/multipage/scripting.html#the-script-element
HTMLScriptElement.prototype = HTMLElement.prototype;
