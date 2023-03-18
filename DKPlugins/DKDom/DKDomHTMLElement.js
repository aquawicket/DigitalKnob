// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
// [INTERFACE] https://html.spec.whatwg.org/multipage/dom.html#htmlelement


var HTMLElement = function HTMLElement(pointer) {
    
	////// Instance properties //////
	// [HTMLElement.accessKey] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/accessKey
	Object.defineProperty(this, "accessKey", {
		configurable: true,
        get: function accessKey() {
            return CPP_DKDomHTMLElement_accessKey(pointer);
        }
    })
	// [HTMLElement.accessKeyLabel](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/accessKeyLabel
	Object.defineProperty(this, "accessKeyLabel", {
        get: function accessKeyLabel() {
            return CPP_DKDomHTMLElement_accessKeyLabel(pointer);
        }
    })
	// [HTMLElement.attributeStyleMap](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/attributeStyleMap
	Object.defineProperty(this, "attributeStyleMap", {
        get: function attributeStyleMap() {
            return CPP_DKDomHTMLElement_attributeStyleMap(pointer);
        }
    })
	// [HTMLElement.contentEditable] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/contentEditable
	Object.defineProperty(this, "contentEditable", {
        get: function contentEditable() {
            return CPP_DKDomHTMLElement_contentEditable(pointer);
        },
        set: function contentEditable(val) {
            return CPP_DKDomHTMLElement_setContentEditable(pointer, val);
        }
    })
	// [HTMLElement.isContentEditable](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/isContentEditable
	Object.defineProperty(this, "isContentEditable", {
        get: function isContentEditable() {
            return CPP_DKDomHTMLElement_isContentEditable(pointer);
        }
    })
	// [HTMLElement.dataset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dataset
	Object.defineProperty(this, "dataset", {
        get: function dataset() {
            return CPP_DKDomHTMLElement_dataset(pointer);
        }
    })
	// [HTMLElement.dir] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dir
	Object.defineProperty(this, "dir", {
        get: function dir() {
            return CPP_DKDomHTMLElement_dir(pointer);
        },
        set: function dir(val) {
            return CPP_DKDomHTMLElement_dir(pointer, val);
        }
    })
	// [HTMLElement.draggable] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/draggable
	Object.defineProperty(this, "draggable", {
        get: function draggable() {
            return CPP_DKDomHTMLElement_draggable(pointer);
        }
    })
	// [HTMLElement.enterKeyHint] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/enterKeyHint
	Object.defineProperty(this, "enterKeyHint", {
        get: function enterKeyHint() {
            return CPP_DKDomHTMLElement_enterKeyHint(pointer);
        },
        set: function enterKeyHint(val) {
            return CPP_DKDomHTMLElement_enterKeyHint(pointer, val);
        }
    })
	// [HTMLElement.hidden] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/hidden
	Object.defineProperty(this, "hidden", {
        get: function hidden() {
            return CPP_DKDomHTMLElement_hidden(pointer);
        },
        set: function hidden(val) {
            return CPP_DKDomHTMLElement_hidden(pointer, val);
        }
    })
	// [HTMLElement.inert] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/inert
	Object.defineProperty(this, "inert", {
        get: function inert() {
            return CPP_DKDomHTMLElement_inert(pointer);
        }
    })
	// [HTMLElement.innerText] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/innerText
	Object.defineProperty(this, "innerText", {
        get: function innerText() {
            return CPP_DKDomHTMLElement_innerText(pointer)
        },
        set: function innerText(val) {
            return CPP_DKDomHTMLElement_innerText(pointer, val)
        }
    })
	// [HTMLElement.inputMode] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/inputMode
	Object.defineProperty(this, "inputMode", {
        get: function lang() {
            return CPP_DKDomHTMLElement_inputMode(pointer);
        },
        set: function lang(val) {
            return CPP_DKDomHTMLElement_inputMode(pointer, val);
        }
    })
	// [HTMLElement.lang] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/lang
	Object.defineProperty(this, "lang", {
        get: function lang() {
            return CPP_DKDomHTMLElement_lang(pointer);
        },
        set: function lang(val) {
            return CPP_DKDomHTMLElement_lang(pointer, val);
        }
    })
	// [HTMLElement.noModule] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/noModule
	Object.defineProperty(this, "noModule", {
		get: function noModule() {
            return CPP_DKDomHTMLElement_noModule(pointer);
        }
    })
	// [HTMLElement.nonce] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/nonce
	Object.defineProperty(this, "nonce", {
        get: function nonce() {
            return CPP_DKDomHTMLElement_nonce(pointer);
        },
        set: function nonce(val) {
            return CPP_DKDomHTMLElement_nonce(pointer, val);
        }
    })
	// [HTMLElement.offsetHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetHeight
	Object.defineProperty(this, "offsetHeight", {
        get: function offsetHeight() {
            return CPP_DKDomHTMLElement_offsetHeight(pointer);
        }
    })
	// [HTMLElement.offsetLeft](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetLeft
	Object.defineProperty(this, "offsetLeft", {
        get: function offsetLeft() {
            return CPP_DKDomHTMLElement_offsetLeft(pointer);
        }
    })
	// [HTMLElement.offsetParent](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetParent
	Object.defineProperty(this, "offsetParent", {
        get: function offsetParent() {
            return CPP_DKDomHTMLElement_offsetParent(pointer);
        }
    })
	// [HTMLElement.offsetTop](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetTop
	Object.defineProperty(this, "offsetTop", {
        get: function offsetTop() {
            return CPP_DKDomHTMLElement_offsetTop(pointer);
        }
    })
	// [HTMLElement.offsetWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/offsetWidth
	Object.defineProperty(this, "offsetWidth", {
        get: function offsetWidth() {
            return CPP_DKDomHTMLElement_offsetWidth(pointer);
        }
    })
	// [HTMLElement.outerText] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/outerText
	Object.defineProperty(this, "outerText", {
        get: function outerText() {
            return CPP_DKDomHTMLElement_outerText(pointer);
        }
    })
	// [HTMLElement.properties](Experimental)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/properties
	Object.defineProperty(this, "properties", {
        get: function properties() {
            return CPP_DKDomHTMLElement_properties(pointer);
        }
    })
	// [HTMLElement.spellcheck] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/spellcheck
	Object.defineProperty(this, "spellcheck", {
        get: function spellcheck() {
            return CPP_DKDomHTMLElement_spellcheck(pointer);
        }
    })
	// [HTMLElement.style] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/style
	Object.defineProperty(this, "style", {
        get: function style() {
            return new CSSStyleDeclaration(pointer);
        }
    })
	// [HTMLElement.tabIndex] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/tabIndex
	Object.defineProperty(this, "tabIndex", {
        get: function tabIndex() {
            return CPP_DKDomHTMLElement_tabIndex(pointer);
        },
        set: function tabIndex(val) {
            return CPP_DKDomHTMLElement_tabIndex(pointer, val);
        }
    })
	// [HTMLElement.title] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/title
	Object.defineProperty(this, "title", {
        get: function title() {
            return CPP_DKDomHTMLElement_title(pointer);
        },
        set: function title(val) {
            return CPP_DKDomHTMLElement_title(pointer, val);
        }
    })
	// [HTMLElement.translate] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/translate
	Object.defineProperty(this, "translate", {
        get: function translate() {
            return CPP_DKDomHTMLElement_translate(pointer);
        }
    })
	
	/*    
    Object.defineProperty(this, "contextMenu", {
        get: function contextMenu() {
            return CPP_DKDomHTMLElement_contextMenu(pointer);
        }
    })
    Object.defineProperty(this, "dropzone", {
        get: function dropzone() {
            return CPP_DKDomHTMLElement_dropzone(pointer);
        }
    })
    Object.defineProperty(this, "itemScope", {
        get: function itemScope() {
            return CPP_DKDomHTMLElement_itemScope(pointer);
        }
    })
    Object.defineProperty(this, "itemType", {
        get: function itemType() {
            return CPP_DKDomHTMLElement_itemType(pointer);
        }
    })
    Object.defineProperty(this, "itemId", {
        get: function itemId() {
            return CPP_DKDomHTMLElement_itemId(pointer);
        }
    })
    Object.defineProperty(this, "itemRef", {
        get: function itemRef() {
            return CPP_DKDomHTMLElement_itemRef(pointer);
        }
    })
    Object.defineProperty(this, "itemProp", {
        get: function itemProp() {
            return CPP_DKDomHTMLElement_itemProp(pointer);
        }
    })
    Object.defineProperty(this, "itemValue", {
        get: function itemValue() {
            return CPP_DKDomHTMLElement_itemValue(pointer);
        }
    })
    Object.defineProperty(this, "oncopy", {
        get: function oncopy() {
            return this.copy;
        },
        set: function oncopy(func) {
            this.addEventListener("copy", func);
            this.copy = func
        }
    })
    Object.defineProperty(this, "oncut", {
        get: function oncut() {
            return this.cut;
        },
        set: function oncut(func) {
            this.addEventListener("cut", func);
            this.cut = func
        }
    })
    Object.defineProperty(this, "onpaste", {
        get: function onpaste() {
            return this.paste;
        },
        set: function onpaste(func) {
            this.addEventListener("paste", func);
            this.paste = func
        }
    })
	*/

    ////// Instance methods //////
	// [HTMLElement.attachInternals()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/attachInternals
	HTMLElement.prototype.attachInternals = function attachInternals() {
        console.log("HTMLElement.attachInternals(): TODO")
    }
	// [HTMLElement.blur()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/blur
	HTMLElement.prototype.blur = function blur() {
        console.log("HTMLElement.blur(): TODO")
    }
	// [HTMLElement.click()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/click
	 HTMLElement.prototype.click = function click() {
        console.log("HTMLElement.click(): TODO")
    }
	// [HTMLElement.focus()] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/focus
	HTMLElement.prototype.focus = function focus() {
        //console.log("HTMLElement.focus()");
        CPP_DKDomHTMLElement_focus(this.pointer)
    }
	
    /*    
    HTMLElement.prototype.forceSpellCheck = function forceSpellCheck() {
        console.log("HTMLElement.forceSpellCheck(): TODO")
    }
	*/
	
	
	////// Events //////
	// [copy] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/copy_event
	// [cut] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/cut_event
	// [paste] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/paste_event
	// [invalid] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/invalid_event
	
	
	/////// Animation events //////
	// [animationcancel] https://developer.mozilla.org/en-US/docs/Web/API/Element/animationcancel_event
	// [animationend] https://developer.mozilla.org/en-US/docs/Web/API/Element/animationend_event
	// [animationiteration] https://developer.mozilla.org/en-US/docs/Web/API/Element/animationiteration_event
	// [animationstart] https://developer.mozilla.org/en-US/docs/Web/API/Element/animationstart_event
	
	
	////// Input events //////
	// [beforeinput] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/beforeinput_event
	// [input] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/input_event
	// [change] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/change_event
	
	
	////// Pointer events //////
	// [gotpointercapture] https://developer.mozilla.org/en-US/docs/Web/API/Element/gotpointercapture_event
	// [lostpointercapture] https://developer.mozilla.org/en-US/docs/Web/API/Element/lostpointercapture_event
	// [pointercancel] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointercancel_event
	// [pointerdown] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerdown_event
	// [pointerenter] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerenter_event
	// [pointerleave] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerleave_event
	// [pointermove] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointermove_event
	// [pointerout] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerout_event
	// [pointerover] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerover_event
	// [pointerup] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerup_event

	
	////// Transition events //////
	// [transitioncancel] https://developer.mozilla.org/en-US/docs/Web/API/Element/transitioncancel_event
	// [transitionend] https://developer.mozilla.org/en-US/docs/Web/API/Element/transitionend_event
	// [transitionrun] https://developer.mozilla.org/en-US/docs/Web/API/Element/transitionrun_event
	// [transitionstart] https://developer.mozilla.org/en-US/docs/Web/API/Element/transitionstart_event
	
	
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object HTMLElement]"
		}
	}
	
    return Element.call(this, pointer)
}
HTMLElement.prototype = Element.prototype;
Object.assign(HTMLElement.prototype, GlobalEventHandlers)
