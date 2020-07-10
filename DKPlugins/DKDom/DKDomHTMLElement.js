//https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement

///////////////////////////////////
var HTMLElement = function(pointer)
{
	//DKDEBUGFUNC();
	//console.log("var HTMLElement = function("+pointer+")");
	Element.call(this, pointer);
	
	Object.defineProperty(this, "accessKey", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_accessKey(this.pointer); } 
	});
	Object.defineProperty(this, "accessKeyLabel", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_accessKeyLabel(this.pointer); }
	});
	Object.defineProperty(this, "contentEditable", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_contentEditable(this.pointer); },
		set: function(val){ return DKDomHTMLElement_setContentEditable(this.pointer, val); } 
	});
	Object.defineProperty(this, "isContentEditable", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_isContentEditable(this.pointer); } 
	});
	Object.defineProperty(this, "contextMenu", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_contextMenu(this.pointer); }
	});
	Object.defineProperty(this, "dataset", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_dataset(this.pointer); }
	});
	Object.defineProperty(this, "dir", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_dir(this.pointer); },
		set: function(val){ return DKDomHTMLElement_dir(this.pointer, val); } 
	});
	Object.defineProperty(this, "draggable", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_draggable(this.pointer); }
	});
	Object.defineProperty(this, "dropzone", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_dropzone(this.pointer); } 
	});
	Object.defineProperty(this, "hidden", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_hidden(this.pointer); },
		set: function(val){ return DKDomHTMLElement_hidden(this.pointer, val); } 
	});
	Object.defineProperty(this, "inert", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_inert(this.pointer); }
	});
	Object.defineProperty(this, "itemScope", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_itemScope(this.pointer); } 
	});
	Object.defineProperty(this, "itemType", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_itemType(this.pointer); }
	});
	Object.defineProperty(this, "itemId", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_itemId(this.pointer); }
	});
	Object.defineProperty(this, "itemRef", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_itemRef(this.pointer); }
	});
	Object.defineProperty(this, "itemProp", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_itemProp(this.pointer); }
	});
	Object.defineProperty(this, "itemValue", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_itemValue(this.pointer); }
	});
	Object.defineProperty(this, "lang", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_lang(this.pointer);      },
		set: function(val){ return DKDomHTMLElement_lang(this.pointer, val); } 
	});
	Object.defineProperty(this, "noModule", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_noModule(this.pointer); }
	});
	Object.defineProperty(this, "nonce", { 
		configurable: true,
		get: function()   { return DKDomHTMLElement_nonce(this.pointer); },
		set: function(val){ return DKDomHTMLElement_nonce(this.pointer, val); } 
	});
	Object.defineProperty(this, "offsetHeight", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_offsetHeight(this.pointer); }
	});
	Object.defineProperty(this, "offsetLeft", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_offsetLeft(this.pointer); }
	});
	Object.defineProperty(this, "offsetParent", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_offsetParent(this.pointer); }
	});
	Object.defineProperty(this, "offsetTop", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_offsetTop(this.pointer); }
	});
	Object.defineProperty(this, "offsetWidth", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_offsetWidth(this.pointer); }
	});
	Object.defineProperty(this, "properties", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_properties(this.pointer); }
	});
	Object.defineProperty(this, "spellcheck", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_spellcheck(this.pointer); }
	});
	Object.defineProperty(this, "style", {
		configurable: true,
		get: function(){ return CSSStyleDeclaration(pointer); }
	});
	Object.defineProperty(this, "tabIndex", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_tabIndex(this.pointer); },
		set: function(val){ return DKDomHTMLElement_tabIndex(this.pointer, val); } 
	});
	Object.defineProperty(this, "title", {
		configurable: true,
		get: function(){ return DKDomHTMLElement_title(this.pointer); },
		set: function(val){ return DKDomHTMLElement_title(this.pointer, val); } 
	});
	Object.defineProperty(this, "translate", { 
		configurable: true,
		get: function(){ return DKDomHTMLElement_translate(this.pointer); }
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


	HTMLElement.prototype.blur = function(){
		//TODO
		console.log("HTMLElement.prototype.blur");
		return true;
	}
	HTMLElement.prototype.click = function(){
		//TODO
		console.log("HTMLElement.prototype.click");
		return true;
	}
	HTMLElement.prototype.focus = function(){
		//TODO
		console.log("HTMLElement.prototype.focus");
		return true;
	}
	/*
	HTMLElement.prototype.forceSpellCheck = function(){
		//TODO
		console.log("HTMLElement.prototype.forceSpellCheck");
		return true;
	}
	*/
	
	Object.defineProperty(this, "forceSpellCheck", {
		configurable: true,
		value: function(){ console.log("forceSpellCheck"); }
	});
	
	//return Element.call(this, pointer);
	return this;
}
HTMLElement.prototype = Element.prototype;