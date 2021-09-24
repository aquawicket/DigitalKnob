//https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement

// https://html.spec.whatwg.org/multipage/dom.html#htmlelement
var HTMLElement = function(pointer) {
    // Properties
    Object.defineProperty(this, "accessKey", {
        get: function() {
            return CPP_DKDomHTMLElement_accessKey(pointer);
        }
    });
    Object.defineProperty(this, "accessKeyLabel", {
        get: function() {
            return CPP_DKDomHTMLElement_accessKeyLabel(pointer);
        }
    });
    Object.defineProperty(this, "contentEditable", {
        get: function() {
            return CPP_DKDomHTMLElement_contentEditable(pointer);
        },
        set: function(val) {
            return CPP_DKDomHTMLElement_setContentEditable(pointer, val);
        }
    });
    Object.defineProperty(this, "isContentEditable", {
        get: function() {
            return CPP_DKDomHTMLElement_isContentEditable(pointer);
        }
    });
    Object.defineProperty(this, "contextMenu", {
        get: function() {
            return CPP_DKDomHTMLElement_contextMenu(pointer);
        }
    });
    Object.defineProperty(this, "dataset", {
        get: function() {
            return CPP_DKDomHTMLElement_dataset(pointer);
        }
    });
    Object.defineProperty(this, "dir", {
        get: function() {
            return CPP_DKDomHTMLElement_dir(pointer);
        },
        set: function(val) {
            return CPP_DKDomHTMLElement_dir(pointer, val);
        }
    });
    Object.defineProperty(this, "draggable", {
        get: function() {
            return CPP_DKDomHTMLElement_draggable(pointer);
        }
    });
    Object.defineProperty(this, "dropzone", {
        get: function() {
            return CPP_DKDomHTMLElement_dropzone(pointer);
        }
    });
    Object.defineProperty(this, "hidden", {
        get: function() {
            return CPP_DKDomHTMLElement_hidden(pointer);
        },
        set: function(val) {
            return CPP_DKDomHTMLElement_hidden(pointer, val);
        }
    });
    Object.defineProperty(this, "inert", {
        get: function() {
            return CPP_DKDomHTMLElement_inert(pointer);
        }
    });
	Object.defineProperty(this, "innerText", {
        get: function() {
            return CPP_DKDomElement_innerText(pointer)
        },
        set: function(val) {
            return CPP_DKDomElement_innerText(pointer, val)
        }
    })
    Object.defineProperty(this, "itemScope", {
        get: function() {
            return CPP_DKDomHTMLElement_itemScope(pointer);
        }
    });
    Object.defineProperty(this, "itemType", {
        get: function() {
            return CPP_DKDomHTMLElement_itemType(pointer);
        }
    });
    Object.defineProperty(this, "itemId", {
        get: function() {
            return CPP_DKDomHTMLElement_itemId(pointer);
        }
    });
    Object.defineProperty(this, "itemRef", {
        get: function() {
            return CPP_DKDomHTMLElement_itemRef(pointer);
        }
    });
    Object.defineProperty(this, "itemProp", {
        get: function() {
            return CPP_DKDomHTMLElement_itemProp(pointer);
        }
    });
    Object.defineProperty(this, "itemValue", {
        get: function() {
            return CPP_DKDomHTMLElement_itemValue(pointer);
        }
    });
    Object.defineProperty(this, "lang", {
        get: function() {
            return CPP_DKDomHTMLElement_lang(pointer);
        },
        set: function(val) {
            return CPP_DKDomHTMLElement_lang(pointer, val);
        }
    });
    Object.defineProperty(this, "noModule", {
        get: function() {
            return CPP_DKDomHTMLElement_noModule(pointer);
        }
    });
    Object.defineProperty(this, "nonce", {
        get: function() {
            return CPP_DKDomHTMLElement_nonce(pointer);
        },
        set: function(val) {
            return CPP_DKDomHTMLElement_nonce(pointer, val);
        }
    });
    Object.defineProperty(this, "offsetHeight", {
        get: function() {
            return CPP_DKDomHTMLElement_offsetHeight(pointer);
        }
    });
    Object.defineProperty(this, "offsetLeft", {
        get: function() {
            return CPP_DKDomHTMLElement_offsetLeft(pointer);
        }
    });
    Object.defineProperty(this, "offsetParent", {
        get: function() {
            return CPP_DKDomHTMLElement_offsetParent(pointer);
        }
    });
    Object.defineProperty(this, "offsetTop", {
        get: function() {
            return CPP_DKDomHTMLElement_offsetTop(pointer);
        }
    });
    Object.defineProperty(this, "offsetWidth", {
        get: function() {
            return CPP_DKDomHTMLElement_offsetWidth(pointer);
        }
    });
    Object.defineProperty(this, "properties", {
        get: function() {
            return CPP_DKDomHTMLElement_properties(pointer);
        }
    });
    Object.defineProperty(this, "spellcheck", {
        get: function() {
            return CPP_DKDomHTMLElement_spellcheck(pointer);
        }
    });
    Object.defineProperty(this, "style", {
        get: function() {
            return new CSSStyleDeclaration(pointer);
        }
    });
    Object.defineProperty(this, "tabIndex", {
        get: function() {
            return CPP_DKDomHTMLElement_tabIndex(pointer);
        },
        set: function(val) {
            return CPP_DKDomHTMLElement_tabIndex(pointer, val);
        }
    });
    Object.defineProperty(this, "title", {
        get: function() {
            return CPP_DKDomHTMLElement_title(pointer);
        },
        set: function(val) {
            return CPP_DKDomHTMLElement_title(pointer, val);
        }
    });
    Object.defineProperty(this, "translate", {
        get: function() {
            return CPP_DKDomHTMLElement_translate(pointer);
        }
    });
    Object.defineProperty(this, "oncopy", {
        get: function() {
            return this.copy;
        },
        set: function(func) {
            this.addEventListener("copy", func);
            this.copy = func
        }
    });
    Object.defineProperty(this, "oncut", {
        get: function() {
            return this.cut;
        },
        set: function(func) {
            this.addEventListener("cut", func);
            this.cut = func
        }
    });
    Object.defineProperty(this, "onpaste", {
        get: function() {
            return this.paste;
        },
        set: function(func) {
            this.addEventListener("paste", func);
            this.paste = func
        }
    });

    // Methods
    HTMLElement.prototype.blur = function() {
        console.log("HTMLElement.blur(): TODO");
    }
    HTMLElement.prototype.click = function() {
        console.log("HTMLElement.click(): TODO");
    }
    HTMLElement.prototype.focus = function() {
        //console.log("HTMLElement.focus()");
        CPP_DKDomHTMLElement_focus(this.pointer);
    }
    HTMLElement.prototype.forceSpellCheck = function() {
        console.log("HTMLElement.forceSpellCheck(): TODO");
    }

    return Element.call(this, pointer);
}

// interface HTMLElement : Element
HTMLElement.prototype = Element.prototype;
//Window includes GlobalEventHandlers
Object.assign(HTMLElement.prototype, GlobalEventHandlers)
//HTMLElement includes DocumentAndElementEventHandlers;
//HTMLElement includes ElementContentEditable;
//HTMLElement includes HTMLOrSVGElement;
