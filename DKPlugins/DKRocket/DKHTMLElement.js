///////////////////////////////
var HTMLCollection = function()
{
	//DKDEBUGFUNC();
	//console.warn("HTMLCollection()");
	
	HTMLCollection.prototype.item = function(index){
		return this[index];
	}
	HTMLCollection.prototype.namedItem = function(name){
		for(var i=0; i<this.length; i++){
			if(this.id && this.id == name){
				return this[i];
			}
			if(this.name && this.name == name){
				return this[i];
			}
		}
		return null;
	}
}


///////////////////////////////////
var HTMLElement = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("HTMLElement("+pointer+")");
	
	//this.style = new CSSStyleDeclaration(pointer);
	
	Object.defineProperty(this, "accessKey",        { get: function(){ return DKRocket_accessKey(this.pointer);          } });  //TODO
	Object.defineProperty(this, "accessKeyLabel",   { get: function(){ return DKRocket_accessKeyLabel(this.pointer);     } });  //TODO
	Object.defineProperty(this, "contentEditable", { 
		get: function()   { return DKRocket_contentEditable(this.pointer);         },
		set: function(val){ return DKRocket_setContentEditable(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "isContentEditable", { get: function(){ return DKRocket_isContentEditable(this.pointer); } });  //TODO
	Object.defineProperty(this, "contextMenu",       { get: function(){ return DKRocket_contextMenu(this.pointer);       } });  //TODO
	Object.defineProperty(this, "dataset",           { get: function(){ return DKRocket_dataset(this.pointer);           } });  //TODO
	Object.defineProperty(this, "dir", { 
		get: function()   { return DKRocket_dir(this.pointer);      },
		set: function(val){ return DKRocket_dir(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "draggable",         { get: function(){ return DKRocket_draggable(this.pointer);         } });  //TODO
	Object.defineProperty(this, "dropzone",          { get: function(){ return DKRocket_dropzone(this.pointer);          } });  //TODO
	Object.defineProperty(this, "hidden", { 
		get: function()   { return DKRocket_hidden(this.pointer);      },
		set: function(val){ return DKRocket_hidden(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "inert",             { get: function(){ return DKRocket_inert(this.pointer);             } });  //TODO
	Object.defineProperty(this, "itemScope",         { get: function(){ return DKRocket_itemScope(this.pointer);         } });  //TODO
	Object.defineProperty(this, "itemType",          { get: function(){ return DKRocket_itemType(this.pointer);          } });  //TODO
	Object.defineProperty(this, "itemId",            { get: function(){ return DKRocket_itemId(this.pointer);            } });  //TODO
	Object.defineProperty(this, "itemRef",           { get: function(){ return DKRocket_itemRef(this.pointer);           } });  //TODO
	Object.defineProperty(this, "itemProp",          { get: function(){ return DKRocket_itemProp(this.pointer);          } });  //TODO
	Object.defineProperty(this, "itemValue",         { get: function(){ return DKRocket_itemValue(this.pointer);         } });  //TODO
	Object.defineProperty(this, "lang", { 
		get: function()   { return DKRocket_lang(this.pointer);      },
		set: function(val){ return DKRocket_lang(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "noModule",          { get: function(){ return DKRocket_noModule(this.pointer);          } });  //TODO
	Object.defineProperty(this, "nonce", { 
		get: function()   { return DKRocket_nonce(this.pointer);      },
		set: function(val){ return DKRocket_nonce(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "offsetHeight",      { get: function(){ return DKRocket_offsetHeight(this.pointer);      } });  //TODO
	Object.defineProperty(this, "offsetLeft",        { get: function(){ return DKRocket_offsetLeft(this.pointer);        } });  //TODO
	Object.defineProperty(this, "offsetParent",      { get: function(){ return DKRocket_offsetParent(this.pointer);      } });  //TODO
	Object.defineProperty(this, "offsetTop",         { get: function(){ return DKRocket_offsetTop(this.pointer);         } });  //TODO
	Object.defineProperty(this, "offsetWidth",       { get: function(){ return DKRocket_offsetWidth(this.pointer);       } });  //TODO
	Object.defineProperty(this, "properties",        { get: function(){ return DKRocket_properties(this.pointer);        } });  //TODO
	Object.defineProperty(this, "spellcheck",        { get: function(){ return DKRocket_spellcheck(this.pointer);        } });  //TODO
	Object.defineProperty(this, "style",             { get: function(){ return new CSSStyleDeclaration(this.pointer);    } });  //TODO
	Object.defineProperty(this, "tabIndex", { 
		get: function()   { return DKRocket_tabIndex(this.pointer);      },
		set: function(val){ return DKRocket_tabIndex(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "title", { 
		get: function()   { return DKRocket_title(this.pointer);      },
		set: function(val){ return DKRocket_title(this.pointer, val); } 
	});  //TODO
	Object.defineProperty(this, "translate",         { get: function(){ return DKRocket_translate(this.pointer);         } });  //TODO
	
	
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
HTMLCollection.prototype = [];