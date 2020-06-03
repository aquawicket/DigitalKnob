//https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement

///////////////////////////////////
var HTMLElement = function(pointer)
{
	//DKDEBUGFUNC();
	
	Object.defineProperty(this, "accessKey",        { get: function(){ return DKDomHTMLElement_accessKey(this.pointer);          } });  //TODO
	Object.defineProperty(this, "accessKeyLabel",   { get: function(){ return DKDomHTMLElement_accessKeyLabel(this.pointer);     } });  //TODO
	Object.defineProperty(this, "contentEditable", { 
		get: function()   { return DKDomHTMLElement_contentEditable(this.pointer);         },
		set: function(val){ return DKDomHTMLElement_setContentEditable(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "isContentEditable", { get: function(){ return DKDomHTMLElement_isContentEditable(this.pointer); } });  //TODO
	Object.defineProperty(this, "contextMenu",       { get: function(){ return DKDomHTMLElement_contextMenu(this.pointer);       } });  //TODO
	Object.defineProperty(this, "dataset",           { get: function(){ return DKDomHTMLElement_dataset(this.pointer);           } });  //TODO
	Object.defineProperty(this, "dir", { 
		get: function()   { return DKDomHTMLElement_dir(this.pointer);      },
		set: function(val){ return DKDomHTMLElement_dir(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "draggable",         { get: function(){ return DKDomHTMLElement_draggable(this.pointer);         } });  //TODO
	Object.defineProperty(this, "dropzone",          { get: function(){ return DKDomHTMLElement_dropzone(this.pointer);          } });  //TODO
	Object.defineProperty(this, "hidden", { 
		get: function()   { return DKDomHTMLElement_hidden(this.pointer);      },
		set: function(val){ return DKDomHTMLElement_hidden(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "inert",             { get: function(){ return DKDomHTMLElement_inert(this.pointer);             } });  //TODO
	Object.defineProperty(this, "itemScope",         { get: function(){ return DKDomHTMLElement_itemScope(this.pointer);         } });  //TODO
	Object.defineProperty(this, "itemType",          { get: function(){ return DKDomHTMLElement_itemType(this.pointer);          } });  //TODO
	Object.defineProperty(this, "itemId",            { get: function(){ return DKDomHTMLElement_itemId(this.pointer);            } });  //TODO
	Object.defineProperty(this, "itemRef",           { get: function(){ return DKDomHTMLElement_itemRef(this.pointer);           } });  //TODO
	Object.defineProperty(this, "itemProp",          { get: function(){ return DKDomHTMLElement_itemProp(this.pointer);          } });  //TODO
	Object.defineProperty(this, "itemValue",         { get: function(){ return DKDomHTMLElement_itemValue(this.pointer);         } });  //TODO
	Object.defineProperty(this, "lang", { 
		get: function()   { return DKDomHTMLElement_lang(this.pointer);      },
		set: function(val){ return DKDomHTMLElement_lang(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "noModule",          { get: function(){ return DKDomHTMLElement_noModule(this.pointer);          } });  //TODO
	Object.defineProperty(this, "nonce", { 
		get: function()   { return DKDomHTMLElement_nonce(this.pointer);      },
		set: function(val){ return DKDomHTMLElement_nonce(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "offsetHeight",      { get: function(){ return DKDomHTMLElement_offsetHeight(this.pointer);      } });  //TODO
	Object.defineProperty(this, "offsetLeft",        { get: function(){ return DKDomHTMLElement_offsetLeft(this.pointer);        } });  //TODO
	Object.defineProperty(this, "offsetParent",      { get: function(){ return DKDomHTMLElement_offsetParent(this.pointer);      } });  //TODO
	Object.defineProperty(this, "offsetTop",         { get: function(){ return DKDomHTMLElement_offsetTop(this.pointer);         } });  //TODO
	Object.defineProperty(this, "offsetWidth",       { get: function(){ return DKDomHTMLElement_offsetWidth(this.pointer);       } });  //TODO
	Object.defineProperty(this, "properties",        { get: function(){ return DKDomHTMLElement_properties(this.pointer);        } });  //TODO
	Object.defineProperty(this, "spellcheck",        { get: function(){ return DKDomHTMLElement_spellcheck(this.pointer);        } });  //TODO
	Object.defineProperty(this, "style",             { get: function(){ return new CSSStyleDeclaration(this.pointer);    } });  //TODO
	Object.defineProperty(this, "tabIndex", { 
		get: function()   { return DKDomHTMLElement_tabIndex(this.pointer);      },
		set: function(val){ return DKDomHTMLElement_tabIndex(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "title", { 
		get: function()   { return DKDomHTMLElement_title(this.pointer);      },
		set: function(val){ return DKDomHTMLElement_title(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "translate",         { get: function(){ return DKDomHTMLElement_translate(this.pointer);         } });  //TODO
	
	
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
	
	
	HTMLElement.prototype.blur = function(){
		//TODO
	}
	HTMLElement.prototype.click = function(){
		//TODO
	}
	HTMLElement.prototype.focus = function(){
		//TODO
	}
	HTMLElement.prototype.forceSpellCheck = function(){
		//TODO
	}
	
	return Element.call(this, pointer);
}
HTMLElement.prototype = Element.prototype;