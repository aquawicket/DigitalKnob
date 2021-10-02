// https://developer.mozilla.org/en-US/docs/Web/API/HTMLScriptElement
// https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script

// https://html.spec.whatwg.org/multipage/scripting.html#the-script-element
var HTMLScriptElement = function(pointer) {
    // Properties
	Object.defineProperty(this, "async", {
        get: function() {
            return CPP_DKDomHTMLScriptElement_async(pointer);
        }
    });
	Object.defineProperty(this, "charset", {
        get: function() {
            return CPP_DKDomHTMLScriptElement_charset(pointer);
        }
    });
	Object.defineProperty(this, "crossOrigin", {
        get: function() {
            return CPP_DKDomHTMLScriptElement_crossOrigin(pointer);
        }
    });
	Object.defineProperty(this, "defer", {
        get: function() {
            return CPP_DKDomHTMLScriptElement_defer(pointer);
        }
    });
	Object.defineProperty(this, "event", {
        get: function() {
            return CPP_DKDomHTMLScriptElement_event(pointer);
        }
    });
	Object.defineProperty(this, "integrity", {
        get: function() {
            return CPP_DKDomHTMLScriptElement_integrity(pointer);
        }
    });
	Object.defineProperty(this, "noModule", {
		configurable: true,
        get: function() {
            return CPP_DKDomHTMLScriptElement_noModule(pointer);
        }
    });
	Object.defineProperty(this, "nonce", {
		configurable: true,
        get: function() {
            return CPP_DKDomHTMLScriptElement_nonce(pointer);
        }
    });
	Object.defineProperty(this, "language", {
        get: function() {
            return CPP_DKDomHTMLScriptElement_language(pointer);
        }
    });
	Object.defineProperty(this, "referrerPolicy", {
        get: function() {
            return CPP_DKDomHTMLScriptElement_referrerPolicy(pointer);
        }
    });
	Object.defineProperty(this, "src", {
        get: function() {
			return CPP_DKDomElement_getAttribute(pointer, "src")
        },
		set: function(val) {
			return CPP_DKDomElement_setAttribute(pointer, "src", val)
		}
    });
	Object.defineProperty(this, "text", {
        get: function() {
            return CPP_DKDomHTMLScriptElement_text(pointer);
        }
    });
	Object.defineProperty(this, "type", {
        get: function() {
            return CPP_DKDomHTMLScriptElement_type(pointer);
        }
    });
    return HTMLElement.call(this, pointer);
}

https://html.spec.whatwg.org/multipage/scripting.html#the-script-element
HTMLScriptElement.prototype = HTMLElement.prototype;
