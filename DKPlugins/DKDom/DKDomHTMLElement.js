//https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement

// https://html.spec.whatwg.org/multipage/dom.html#htmlelement
var HTMLElement = function HTMLElement(pointer) {
    // Properties
    Object.defineProperty(this, "accessKey", {
		configurable: true,
        get: function accessKey() {
            return CPP_DKDomHTMLElement_accessKey(pointer);
        }
    });
    Object.defineProperty(this, "accessKeyLabel", {
        get: function accessKeyLabel() {
            return CPP_DKDomHTMLElement_accessKeyLabel(pointer);
        }
    });
    Object.defineProperty(this, "contentEditable", {
        get: function contentEditable() {
            return CPP_DKDomHTMLElement_contentEditable(pointer);
        },
        set: function contentEditable(val) {
            return CPP_DKDomHTMLElement_setContentEditable(pointer, val);
        }
    });
    Object.defineProperty(this, "isContentEditable", {
        get: function isContentEditable() {
            return CPP_DKDomHTMLElement_isContentEditable(pointer);
        }
    });
    Object.defineProperty(this, "contextMenu", {
        get: function contextMenu() {
            return CPP_DKDomHTMLElement_contextMenu(pointer);
        }
    });
    Object.defineProperty(this, "dataset", {
        get: function dataset() {
            return CPP_DKDomHTMLElement_dataset(pointer);
        }
    });
    Object.defineProperty(this, "dir", {
        get: function dir() {
            return CPP_DKDomHTMLElement_dir(pointer);
        },
        set: function dir(val) {
            return CPP_DKDomHTMLElement_dir(pointer, val);
        }
    });
    Object.defineProperty(this, "draggable", {
        get: function draggable() {
            return CPP_DKDomHTMLElement_draggable(pointer);
        }
    });
    Object.defineProperty(this, "dropzone", {
        get: function dropzone() {
            return CPP_DKDomHTMLElement_dropzone(pointer);
        }
    });
    Object.defineProperty(this, "hidden", {
        get: function hidden() {
            return CPP_DKDomHTMLElement_hidden(pointer);
        },
        set: function hidden(val) {
            return CPP_DKDomHTMLElement_hidden(pointer, val);
        }
    });
    Object.defineProperty(this, "inert", {
        get: function inert() {
            return CPP_DKDomHTMLElement_inert(pointer);
        }
    });
	Object.defineProperty(this, "innerText", {
        get: function innerText() {
            return CPP_DKDomHTMLElement_innerText(pointer)
        },
        set: function innerText(val) {
            return CPP_DKDomHTMLElement_innerText(pointer, val)
        }
    })
    Object.defineProperty(this, "itemScope", {
        get: function itemScope() {
            return CPP_DKDomHTMLElement_itemScope(pointer);
        }
    });
    Object.defineProperty(this, "itemType", {
        get: function itemType() {
            return CPP_DKDomHTMLElement_itemType(pointer);
        }
    });
    Object.defineProperty(this, "itemId", {
        get: function itemId() {
            return CPP_DKDomHTMLElement_itemId(pointer);
        }
    });
    Object.defineProperty(this, "itemRef", {
        get: function itemRef() {
            return CPP_DKDomHTMLElement_itemRef(pointer);
        }
    });
    Object.defineProperty(this, "itemProp", {
        get: function itemProp() {
            return CPP_DKDomHTMLElement_itemProp(pointer);
        }
    });
    Object.defineProperty(this, "itemValue", {
        get: function itemValue() {
            return CPP_DKDomHTMLElement_itemValue(pointer);
        }
    });
    Object.defineProperty(this, "lang", {
        get: function lang() {
            return CPP_DKDomHTMLElement_lang(pointer);
        },
        set: function lang(val) {
            return CPP_DKDomHTMLElement_lang(pointer, val);
        }
    });
    Object.defineProperty(this, "noModule", {
		get: function noModule() {
            return CPP_DKDomHTMLElement_noModule(pointer);
        }
    });
    Object.defineProperty(this, "nonce", {
        get: function nonce() {
            return CPP_DKDomHTMLElement_nonce(pointer);
        },
        set: function nonce(val) {
            return CPP_DKDomHTMLElement_nonce(pointer, val);
        }
    });
    Object.defineProperty(this, "offsetHeight", {
        get: function offsetHeight() {
            return CPP_DKDomHTMLElement_offsetHeight(pointer);
        }
    });
    Object.defineProperty(this, "offsetLeft", {
        get: function offsetLeft() {
            return CPP_DKDomHTMLElement_offsetLeft(pointer);
        }
    });
    Object.defineProperty(this, "offsetParent", {
        get: function offsetParent() {
            return CPP_DKDomHTMLElement_offsetParent(pointer);
        }
    });
    Object.defineProperty(this, "offsetTop", {
        get: function offsetTop() {
            return CPP_DKDomHTMLElement_offsetTop(pointer);
        }
    });
    Object.defineProperty(this, "offsetWidth", {
        get: function offsetWidth() {
            return CPP_DKDomHTMLElement_offsetWidth(pointer);
        }
    });
	
	// outerText: https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/outerText
	Object.defineProperty(this, "outerText", {
        get: function outerText() {
            return CPP_DKDomHTMLElement_outerText(pointer);
        }
    });
    Object.defineProperty(this, "properties", {
        get: function properties() {
            return CPP_DKDomHTMLElement_properties(pointer);
        }
    });
    Object.defineProperty(this, "spellcheck", {
        get: function spellcheck() {
            return CPP_DKDomHTMLElement_spellcheck(pointer);
        }
    });
    Object.defineProperty(this, "style", {
        get: function style() {
            return new CSSStyleDeclaration(pointer);
        }
    });
    Object.defineProperty(this, "tabIndex", {
        get: function tabIndex() {
            return CPP_DKDomHTMLElement_tabIndex(pointer);
        },
        set: function tabIndex(val) {
            return CPP_DKDomHTMLElement_tabIndex(pointer, val);
        }
    });
    Object.defineProperty(this, "title", {
        get: function title() {
            return CPP_DKDomHTMLElement_title(pointer);
        },
        set: function title(val) {
            return CPP_DKDomHTMLElement_title(pointer, val);
        }
    });
    Object.defineProperty(this, "translate", {
        get: function translate() {
            return CPP_DKDomHTMLElement_translate(pointer);
        }
    });
    Object.defineProperty(this, "oncopy", {
        get: function oncopy() {
            return this.copy;
        },
        set: function oncopy(func) {
            this.addEventListener("copy", func);
            this.copy = func
        }
    });
    Object.defineProperty(this, "oncut", {
        get: function oncut() {
            return this.cut;
        },
        set: function oncut(func) {
            this.addEventListener("cut", func);
            this.cut = func
        }
    });
    Object.defineProperty(this, "onpaste", {
        get: function onpaste() {
            return this.paste;
        },
        set: function onpaste(func) {
            this.addEventListener("paste", func);
            this.paste = func
        }
    });

    // Methods
    HTMLElement.prototype.blur = function blur() {
        console.log("HTMLElement.blur(): TODO");
    }
    HTMLElement.prototype.click = function click() {
        console.log("HTMLElement.click(): TODO");
    }
    HTMLElement.prototype.focus = function focus() {
        //console.log("HTMLElement.focus()");
        CPP_DKDomHTMLElement_focus(this.pointer);
    }
    HTMLElement.prototype.forceSpellCheck = function forceSpellCheck() {
        console.log("HTMLElement.forceSpellCheck(): TODO");
    }

	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object HTMLElement]"
		}
	}
	
    return Element.call(this, pointer);
	//return this;
}

// interface HTMLElement : Element
HTMLElement.prototype = Element.prototype;
//Window includes GlobalEventHandlers
Object.assign(HTMLElement.prototype, GlobalEventHandlers)
//HTMLElement includes DocumentAndElementEventHandlers;
//HTMLElement includes ElementContentEditable;
//HTMLElement includes HTMLOrSVGElement;
