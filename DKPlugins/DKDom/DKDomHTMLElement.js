//https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement

///////////////////////////////////
var HTMLElement = function(pointer)
{	
	// Properties
	Object.defineProperty(this, "accessKey", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_accessKey(pointer); } 
	});
	Object.defineProperty(this, "accessKeyLabel", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_accessKeyLabel(pointer); }
	});
	Object.defineProperty(this, "contentEditable", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_contentEditable(pointer); },
		set: function(val){ return DKDomHTMLElement_setContentEditable(pointer, val); } 
	});
	Object.defineProperty(this, "isContentEditable", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_isContentEditable(pointer); } 
	});
	Object.defineProperty(this, "contextMenu", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_contextMenu(pointer); }
	});
	Object.defineProperty(this, "dataset", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_dataset(pointer); }
	});
	Object.defineProperty(this, "dir", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_dir(pointer); },
		set: function(val){ return DKDomHTMLElement_dir(pointer, val); } 
	});
	Object.defineProperty(this, "draggable", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_draggable(pointer); }
	});
	Object.defineProperty(this, "dropzone", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_dropzone(pointer); } 
	});
	Object.defineProperty(this, "hidden", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_hidden(pointer); },
		set: function(val){ return DKDomHTMLElement_hidden(pointer, val); } 
	});
	Object.defineProperty(this, "inert", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_inert(pointer); }
	});
	Object.defineProperty(this, "itemScope", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_itemScope(pointer); } 
	});
	Object.defineProperty(this, "itemType", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_itemType(pointer); }
	});
	Object.defineProperty(this, "itemId", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_itemId(pointer); }
	});
	Object.defineProperty(this, "itemRef", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_itemRef(pointer); }
	});
	Object.defineProperty(this, "itemProp", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_itemProp(pointer); }
	});
	Object.defineProperty(this, "itemValue", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_itemValue(pointer); }
	});
	Object.defineProperty(this, "lang", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_lang(pointer);      },
		set: function(val){ return DKDomHTMLElement_lang(pointer, val); } 
	});
	Object.defineProperty(this, "noModule", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_noModule(pointer); }
	});
	Object.defineProperty(this, "nonce", { 
		configurable: true,
		get: function()   { return DKDomHTMLElement_nonce(pointer); },
		set: function(val){ return DKDomHTMLElement_nonce(pointer, val); } 
	});
	Object.defineProperty(this, "offsetHeight", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_offsetHeight(pointer); }
	});
	Object.defineProperty(this, "offsetLeft", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_offsetLeft(pointer); }
	});
	Object.defineProperty(this, "offsetParent", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_offsetParent(pointer); }
	});
	Object.defineProperty(this, "offsetTop", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_offsetTop(pointer); }
	});
	Object.defineProperty(this, "offsetWidth", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_offsetWidth(pointer); }
	});
	Object.defineProperty(this, "properties", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_properties(pointer); }
	});
	Object.defineProperty(this, "spellcheck", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_spellcheck(pointer); }
	});
	Object.defineProperty(this, "style", {
		configurable: true,
		get: function(){ return CSSStyleDeclaration(pointer); }
	});
	Object.defineProperty(this, "tabIndex", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_tabIndex(pointer); },
		set: function(val){ return DKDomHTMLElement_tabIndex(pointer, val); } 
	});
	Object.defineProperty(this, "title", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_title(pointer); },
		set: function(val){ return DKDomHTMLElement_title(pointer, val); } 
	});
	Object.defineProperty(this, "translate", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_translate(pointer); }
	});
	Object.defineProperty(this, "oncopy", {
		configurable: true,
		get: function(){ return this.copy; },
		set: function(func){ this.addEventListener("copy", func); this.copy = func }
	});
	Object.defineProperty(this, "oncut", {
		configurable: true,
		get: function(){ return this.cut; },
		set: function(func){ this.addEventListener("cut", func); this.cut = func }
	});
	Object.defineProperty(this, "onpaste", {
		configurable: true,
		get: function(){ return this.paste; },
		set: function(func){ this.addEventListener("paste", func); this.paste = func }
	});


	// Methods
	HTMLElement.prototype.blur = function(){
		console.log("HTMLElement.blur(): TODO");
	}
	HTMLElement.prototype.click = function(){
		console.log("HTMLElement.click(): TODO");
	}
	HTMLElement.prototype.focus = function(){
		console.log("HTMLElement.focus()");
		DKDomHTMLElement_focus(this.pointer);
	}
	HTMLElement.prototype.forceSpellCheck = function(){
		console.log("HTMLElement.forceSpellCheck(): TODO");
	}

	
	return Element.call(this, pointer);
}
HTMLElement.prototype = Element.prototype;