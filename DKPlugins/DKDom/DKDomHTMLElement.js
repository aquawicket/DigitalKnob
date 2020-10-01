//https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement

///////////////////////////////////
var HTMLElement = function(pointer)
{	
	// Properties
	Object.defineProperty(this, "accessKey", {
		get: function(){ return DKCPP_DKDomHTMLElement_accessKey(pointer); } 
	});
	Object.defineProperty(this, "accessKeyLabel", {
		get: function(){ return DKCPP_DKDomHTMLElement_accessKeyLabel(pointer); }
	});
	Object.defineProperty(this, "contentEditable", {
		get: function(){ return DKCPP_DKDomHTMLElement_contentEditable(pointer); },
		set: function(val){ return DKCPP_DKDomHTMLElement_setContentEditable(pointer, val); } 
	});
	Object.defineProperty(this, "isContentEditable", {
		get: function(){ return DKCPP_DKDomHTMLElement_isContentEditable(pointer); } 
	});
	Object.defineProperty(this, "contextMenu", {
		get: function(){ return DKCPP_DKDomHTMLElement_contextMenu(pointer); }
	});
	Object.defineProperty(this, "dataset", {
		get: function(){ return DKCPP_DKDomHTMLElement_dataset(pointer); }
	});
	Object.defineProperty(this, "dir", {
		get: function(){ return DKCPP_DKDomHTMLElement_dir(pointer); },
		set: function(val){ return DKCPP_DKDomHTMLElement_dir(pointer, val); } 
	});
	Object.defineProperty(this, "draggable", {
		get: function(){ return DKCPP_DKDomHTMLElement_draggable(pointer); }
	});
	Object.defineProperty(this, "dropzone", {
		get: function(){ return DKCPP_DKDomHTMLElement_dropzone(pointer); } 
	});
	Object.defineProperty(this, "hidden", {
		get: function(){ return DKCPP_DKDomHTMLElement_hidden(pointer); },
		set: function(val){ return DKCPP_DKDomHTMLElement_hidden(pointer, val); } 
	});
	Object.defineProperty(this, "inert", {
		get: function(){ return DKCPP_DKDomHTMLElement_inert(pointer); }
	});
	Object.defineProperty(this, "itemScope", {
		get: function(){ return DKCPP_DKDomHTMLElement_itemScope(pointer); } 
	});
	Object.defineProperty(this, "itemType", {
		get: function(){ return DKCPP_DKDomHTMLElement_itemType(pointer); }
	});
	Object.defineProperty(this, "itemId", {
		get: function(){ return DKCPP_DKDomHTMLElement_itemId(pointer); }
	});
	Object.defineProperty(this, "itemRef", {
		get: function(){ return DKCPP_DKDomHTMLElement_itemRef(pointer); }
	});
	Object.defineProperty(this, "itemProp", {
		get: function(){ return DKCPP_DKDomHTMLElement_itemProp(pointer); }
	});
	Object.defineProperty(this, "itemValue", {
		get: function(){ return DKCPP_DKDomHTMLElement_itemValue(pointer); }
	});
	Object.defineProperty(this, "lang", {
		get: function(){ return DKCPP_DKDomHTMLElement_lang(pointer);      },
		set: function(val){ return DKCPP_DKDomHTMLElement_lang(pointer, val); } 
	});
	Object.defineProperty(this, "noModule", {
		get: function(){ return DKCPP_DKDomHTMLElement_noModule(pointer); }
	});
	Object.defineProperty(this, "nonce", {
		get: function()   { return DKCPP_DKDomHTMLElement_nonce(pointer); },
		set: function(val){ return DKCPP_DKDomHTMLElement_nonce(pointer, val); } 
	});
	Object.defineProperty(this, "offsetHeight", {
		get: function(){ return DKCPP_DKDomHTMLElement_offsetHeight(pointer); }
	});
	Object.defineProperty(this, "offsetLeft", {
		get: function(){ return DKCPP_DKDomHTMLElement_offsetLeft(pointer); }
	});
	Object.defineProperty(this, "offsetParent", {
		get: function(){ return DKCPP_DKDomHTMLElement_offsetParent(pointer); }
	});
	Object.defineProperty(this, "offsetTop", {
		get: function(){ return DKCPP_DKDomHTMLElement_offsetTop(pointer); }
	});
	Object.defineProperty(this, "offsetWidth", {
		get: function(){ return DKCPP_DKDomHTMLElement_offsetWidth(pointer); }
	});
	Object.defineProperty(this, "properties", {
		get: function(){ return DKCPP_DKDomHTMLElement_properties(pointer); }
	});
	Object.defineProperty(this, "spellcheck", {
		get: function(){ return DKCPP_DKDomHTMLElement_spellcheck(pointer); }
	});
	Object.defineProperty(this, "style", {
		get: function(){ return new CSSStyleDeclaration(pointer); }
	});
	Object.defineProperty(this, "tabIndex", {
		get: function(){ return DKCPP_DKDomHTMLElement_tabIndex(pointer); },
		set: function(val){ return DKCPP_DKDomHTMLElement_tabIndex(pointer, val); } 
	});
	Object.defineProperty(this, "title", {
		get: function(){ return DKCPP_DKDomHTMLElement_title(pointer); },
		set: function(val){ return DKCPP_DKDomHTMLElement_title(pointer, val); } 
	});
	Object.defineProperty(this, "translate", {
		get: function(){ return DKCPP_DKDomHTMLElement_translate(pointer); }
	});
	Object.defineProperty(this, "oncopy", {
		get: function(){ return this.copy; },
		set: function(func){ this.addEventListener("copy", func); this.copy = func }
	});
	Object.defineProperty(this, "oncut", {
		get: function(){ return this.cut; },
		set: function(func){ this.addEventListener("cut", func); this.cut = func }
	});
	Object.defineProperty(this, "onpaste", {
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
		//console.log("HTMLElement.focus()");
		DKCPP_DKDomHTMLElement_focus(this.pointer);
	}
	HTMLElement.prototype.forceSpellCheck = function(){
		console.log("HTMLElement.forceSpellCheck(): TODO");
	}

	
	return Element.call(this, pointer);
}
HTMLElement.prototype = Element.prototype;