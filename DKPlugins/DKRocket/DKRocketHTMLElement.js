//https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement

///////////////////////////////////
var HTMLElement = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("HTMLElement("+pointer+")");
	
	Object.defineProperty(this, "accessKey",        { get: function(){ return DKRocketHTMLElement_accessKey(this.pointer);          } });  //TODO
	Object.defineProperty(this, "accessKeyLabel",   { get: function(){ return DKRocketHTMLElement_accessKeyLabel(this.pointer);     } });  //TODO
	Object.defineProperty(this, "contentEditable", { 
		get: function()   { return DKRocketHTMLElement_contentEditable(this.pointer);         },
		set: function(val){ return DKRocketHTMLElement_setContentEditable(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "isContentEditable", { get: function(){ return DKRocketHTMLElement_isContentEditable(this.pointer); } });  //TODO
	Object.defineProperty(this, "contextMenu",       { get: function(){ return DKRocketHTMLElement_contextMenu(this.pointer);       } });  //TODO
	Object.defineProperty(this, "dataset",           { get: function(){ return DKRocketHTMLElement_dataset(this.pointer);           } });  //TODO
	Object.defineProperty(this, "dir", { 
		get: function()   { return DKRocketHTMLElement_dir(this.pointer);      },
		set: function(val){ return DKRocketHTMLElement_dir(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "draggable",         { get: function(){ return DKRocketHTMLElement_draggable(this.pointer);         } });  //TODO
	Object.defineProperty(this, "dropzone",          { get: function(){ return DKRocketHTMLElement_dropzone(this.pointer);          } });  //TODO
	Object.defineProperty(this, "hidden", { 
		get: function()   { return DKRocketHTMLElement_hidden(this.pointer);      },
		set: function(val){ return DKRocketHTMLElement_hidden(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "inert",             { get: function(){ return DKRocketHTMLElement_inert(this.pointer);             } });  //TODO
	Object.defineProperty(this, "itemScope",         { get: function(){ return DKRocketHTMLElement_itemScope(this.pointer);         } });  //TODO
	Object.defineProperty(this, "itemType",          { get: function(){ return DKRocketHTMLElement_itemType(this.pointer);          } });  //TODO
	Object.defineProperty(this, "itemId",            { get: function(){ return DKRocketHTMLElement_itemId(this.pointer);            } });  //TODO
	Object.defineProperty(this, "itemRef",           { get: function(){ return DKRocketHTMLElement_itemRef(this.pointer);           } });  //TODO
	Object.defineProperty(this, "itemProp",          { get: function(){ return DKRocketHTMLElement_itemProp(this.pointer);          } });  //TODO
	Object.defineProperty(this, "itemValue",         { get: function(){ return DKRocketHTMLElement_itemValue(this.pointer);         } });  //TODO
	Object.defineProperty(this, "lang", { 
		get: function()   { return DKRocketHTMLElement_lang(this.pointer);      },
		set: function(val){ return DKRocketHTMLElement_lang(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "noModule",          { get: function(){ return DKRocketHTMLElement_noModule(this.pointer);          } });  //TODO
	Object.defineProperty(this, "nonce", { 
		get: function()   { return DKRocketHTMLElement_nonce(this.pointer);      },
		set: function(val){ return DKRocketHTMLElement_nonce(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "offsetHeight",      { get: function(){ return DKRocketHTMLElement_offsetHeight(this.pointer);      } });  //TODO
	Object.defineProperty(this, "offsetLeft",        { get: function(){ return DKRocketHTMLElement_offsetLeft(this.pointer);        } });  //TODO
	Object.defineProperty(this, "offsetParent",      { get: function(){ return DKRocketHTMLElement_offsetParent(this.pointer);      } });  //TODO
	Object.defineProperty(this, "offsetTop",         { get: function(){ return DKRocketHTMLElement_offsetTop(this.pointer);         } });  //TODO
	Object.defineProperty(this, "offsetWidth",       { get: function(){ return DKRocketHTMLElement_offsetWidth(this.pointer);       } });  //TODO
	Object.defineProperty(this, "properties",        { get: function(){ return DKRocketHTMLElement_properties(this.pointer);        } });  //TODO
	Object.defineProperty(this, "spellcheck",        { get: function(){ return DKRocketHTMLElement_spellcheck(this.pointer);        } });  //TODO
	Object.defineProperty(this, "style",             { get: function(){ return new CSSStyleDeclaration(this.pointer);    } });  //TODO
	Object.defineProperty(this, "tabIndex", { 
		get: function()   { return DKRocketHTMLElement_tabIndex(this.pointer);      },
		set: function(val){ return DKRocketHTMLElement_tabIndex(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "title", { 
		get: function()   { return DKRocketHTMLElement_title(this.pointer);      },
		set: function(val){ return DKRocketHTMLElement_title(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "translate",         { get: function(){ return DKRocketHTMLElement_translate(this.pointer);         } });  //TODO
	
	
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