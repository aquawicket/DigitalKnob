//https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement

// https://html.spec.whatwg.org/multipage/dom.html#htmlelement
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
var HTMLElement = function HTMLElement(pointer) {
    // Properties
    Object.defineProperty(this, "accessKey", {
		configurable: true,
        get: function accessKey() {
=======
var HTMLElement = function HTMLElement(pointer){
    // Properties
    Object.defineProperty(this, "accessKey", {
		configurable: true,
        get: function accessKey(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_accessKey(pointer);
        }
    });
    Object.defineProperty(this, "accessKeyLabel", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function accessKeyLabel() {
=======
        get: function accessKeyLabel(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_accessKeyLabel(pointer);
        }
    });
    Object.defineProperty(this, "contentEditable", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function contentEditable() {
            return CPP_DKDomHTMLElement_contentEditable(pointer);
        },
        set: function contentEditable(val) {
=======
        get: function contentEditable(){
            return CPP_DKDomHTMLElement_contentEditable(pointer);
        },
        set: function contentEditable(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_setContentEditable(pointer, val);
        }
    });
    Object.defineProperty(this, "isContentEditable", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function isContentEditable() {
=======
        get: function isContentEditable(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_isContentEditable(pointer);
        }
    });
    Object.defineProperty(this, "contextMenu", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function contextMenu() {
=======
        get: function contextMenu(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_contextMenu(pointer);
        }
    });
    Object.defineProperty(this, "dataset", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function dataset() {
=======
        get: function dataset(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_dataset(pointer);
        }
    });
    Object.defineProperty(this, "dir", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function dir() {
            return CPP_DKDomHTMLElement_dir(pointer);
        },
        set: function dir(val) {
=======
        get: function dir(){
            return CPP_DKDomHTMLElement_dir(pointer);
        },
        set: function dir(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_dir(pointer, val);
        }
    });
    Object.defineProperty(this, "draggable", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function draggable() {
=======
        get: function draggable(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_draggable(pointer);
        }
    });
    Object.defineProperty(this, "dropzone", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function dropzone() {
=======
        get: function dropzone(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_dropzone(pointer);
        }
    });
    Object.defineProperty(this, "hidden", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function hidden() {
            return CPP_DKDomHTMLElement_hidden(pointer);
        },
        set: function hidden(val) {
=======
        get: function hidden(){
            return CPP_DKDomHTMLElement_hidden(pointer);
        },
        set: function hidden(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_hidden(pointer, val);
        }
    });
    Object.defineProperty(this, "inert", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function inert() {
=======
        get: function inert(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_inert(pointer);
        }
    });
	Object.defineProperty(this, "innerText", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function innerText() {
            return CPP_DKDomHTMLElement_innerText(pointer)
        },
        set: function innerText(val) {
=======
        get: function innerText(){
            return CPP_DKDomHTMLElement_innerText(pointer)
        },
        set: function innerText(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_innerText(pointer, val)
        }
    })
    Object.defineProperty(this, "itemScope", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function itemScope() {
=======
        get: function itemScope(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_itemScope(pointer);
        }
    });
    Object.defineProperty(this, "itemType", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function itemType() {
=======
        get: function itemType(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_itemType(pointer);
        }
    });
    Object.defineProperty(this, "itemId", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function itemId() {
=======
        get: function itemId(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_itemId(pointer);
        }
    });
    Object.defineProperty(this, "itemRef", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function itemRef() {
=======
        get: function itemRef(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_itemRef(pointer);
        }
    });
    Object.defineProperty(this, "itemProp", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function itemProp() {
=======
        get: function itemProp(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_itemProp(pointer);
        }
    });
    Object.defineProperty(this, "itemValue", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function itemValue() {
=======
        get: function itemValue(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_itemValue(pointer);
        }
    });
    Object.defineProperty(this, "lang", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function lang() {
            return CPP_DKDomHTMLElement_lang(pointer);
        },
        set: function lang(val) {
=======
        get: function lang(){
            return CPP_DKDomHTMLElement_lang(pointer);
        },
        set: function lang(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_lang(pointer, val);
        }
    });
    Object.defineProperty(this, "noModule", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
		get: function noModule() {
=======
		get: function noModule(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_noModule(pointer);
        }
    });
    Object.defineProperty(this, "nonce", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function nonce() {
            return CPP_DKDomHTMLElement_nonce(pointer);
        },
        set: function nonce(val) {
=======
        get: function nonce(){
            return CPP_DKDomHTMLElement_nonce(pointer);
        },
        set: function nonce(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_nonce(pointer, val);
        }
    });
    Object.defineProperty(this, "offsetHeight", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function offsetHeight() {
=======
        get: function offsetHeight(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_offsetHeight(pointer);
        }
    });
    Object.defineProperty(this, "offsetLeft", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function offsetLeft() {
=======
        get: function offsetLeft(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_offsetLeft(pointer);
        }
    });
    Object.defineProperty(this, "offsetParent", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function offsetParent() {
=======
        get: function offsetParent(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_offsetParent(pointer);
        }
    });
    Object.defineProperty(this, "offsetTop", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function offsetTop() {
=======
        get: function offsetTop(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_offsetTop(pointer);
        }
    });
    Object.defineProperty(this, "offsetWidth", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function offsetWidth() {
=======
        get: function offsetWidth(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_offsetWidth(pointer);
        }
    });
	
	// outerText: https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/outerText
	Object.defineProperty(this, "outerText", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function outerText() {
=======
        get: function outerText(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_outerText(pointer);
        }
    });
    Object.defineProperty(this, "properties", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function properties() {
=======
        get: function properties(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_properties(pointer);
        }
    });
    Object.defineProperty(this, "spellcheck", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function spellcheck() {
=======
        get: function spellcheck(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_spellcheck(pointer);
        }
    });
    Object.defineProperty(this, "style", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function style() {
=======
        get: function style(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return new CSSStyleDeclaration(pointer);
        }
    });
    Object.defineProperty(this, "tabIndex", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function tabIndex() {
            return CPP_DKDomHTMLElement_tabIndex(pointer);
        },
        set: function tabIndex(val) {
=======
        get: function tabIndex(){
            return CPP_DKDomHTMLElement_tabIndex(pointer);
        },
        set: function tabIndex(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_tabIndex(pointer, val);
        }
    });
    Object.defineProperty(this, "title", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function title() {
            return CPP_DKDomHTMLElement_title(pointer);
        },
        set: function title(val) {
=======
        get: function title(){
            return CPP_DKDomHTMLElement_title(pointer);
        },
        set: function title(val){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_title(pointer, val);
        }
    });
    Object.defineProperty(this, "translate", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function translate() {
=======
        get: function translate(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            return CPP_DKDomHTMLElement_translate(pointer);
        }
    });
    Object.defineProperty(this, "oncopy", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function oncopy() {
            return this.copy;
        },
        set: function oncopy(func) {
=======
        get: function oncopy(){
            return this.copy;
        },
        set: function oncopy(func){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            this.addEventListener("copy", func);
            this.copy = func
        }
    });
    Object.defineProperty(this, "oncut", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function oncut() {
            return this.cut;
        },
        set: function oncut(func) {
=======
        get: function oncut(){
            return this.cut;
        },
        set: function oncut(func){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            this.addEventListener("cut", func);
            this.cut = func
        }
    });
    Object.defineProperty(this, "onpaste", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
        get: function onpaste() {
            return this.paste;
        },
        set: function onpaste(func) {
=======
        get: function onpaste(){
            return this.paste;
        },
        set: function onpaste(func){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
            this.addEventListener("paste", func);
            this.paste = func
        }
    });

    // Methods
<<<<<<< HEAD:DKPlugins/DKDom/DKDomHTMLElement.js
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
=======
    HTMLElement.prototype.blur = function blur(){
        console.log("HTMLElement.blur(): TODO");
    }
    HTMLElement.prototype.click = function click(){
        console.log("HTMLElement.click(): TODO");
    }
    HTMLElement.prototype.focus = function focus(){
        //console.log("HTMLElement.focus()");
        CPP_DKDomHTMLElement_focus(this.pointer);
    }
    HTMLElement.prototype.forceSpellCheck = function forceSpellCheck(){
>>>>>>> Development:DKCpp/plugins/DKDom/DKDomHTMLElement.js
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
