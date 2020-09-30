//https://developer.mozilla.org/en-US/docs/Web/API/Element

///////////////////////////////
var Element = function(pointer)
{
	//console.warn("Element("+pointer+")");
	
	Object.defineProperty(this, "attributes",   { get: function(){ return DKRocketElement_attributes(this.pointer);   } });  //TODO
	Object.defineProperty(this, "classList",    { get: function(){ return DKRocketElement_classList(this.pointer);    } });  //TODO
	Object.defineProperty(this, "className", { 
		get: function()   { return DKRocketElement_className(this.pointer);      },
		set: function(val){ return DKRocketElement_className(this.pointer, val); }
	});  //TODO
	Object.defineProperty(this, "clientHeight", { get: function(){ return DKRocketElement_clientHeight(this.pointer); } });
	Object.defineProperty(this, "clientLeft",   { get: function(){ return DKRocketElement_clientLeft(this.pointer);   } });
	Object.defineProperty(this, "clientTop",    { get: function(){ return DKRocketElement_clientTop(this.pointer);    } });
	Object.defineProperty(this, "clientWidth",  { get: function(){ return DKRocketElement_clientWidth(this.pointer);  } });
	Object.defineProperty(this, "computedName", { get: function(){ return DKRocketElement_computedName(this.pointer); } });  //TODO
	Object.defineProperty(this, "computedRole", { get: function(){ return DKRocketElement_computedRole(this.pointer); } });  //TODO
	/*
	Object.defineProperty(this, "id", { 
		get: function()   { return DKRocketElement_id(this.pointer);      },
		set: function(val){ return DKRocketElement_id(this.pointer, val); }
	});  //TODO
	*/	
	Object.defineProperty(this, "innerHTML", { 
		get: function()   { return DKRocketElement_innerHTML(this.pointer);      },
		set: function(val){ return DKRocketElement_innerHTML(this.pointer, val); }
	});
	Object.defineProperty(this, "localName",              { get: function(){ return DKRocketElement_localName(this.pointer);              } });  //TODO
	Object.defineProperty(this, "namespaceURI",           { get: function(){ return DKRocketElement_namespaceURI(this.pointer);           } });  //TODO
	Object.defineProperty(this, "nextElementSibling",     { get: function(){ return DKRocketElement_nextElementSibling(this.pointer);     } });  //TODO, NonDocumentTypeChildNode
	Object.defineProperty(this, "outerHTML", { 
		get: function()   { return DKRocketElement_outerHTML(this.pointer);      },
		set: function(val){ return DKRocketElement_outerHTML(this.pointer, val); }
	});
	Object.defineProperty(this, "prefix",                 { get: function(){ return DKRocketElement_prefix(this.pointer);                 } });  //TODO
	Object.defineProperty(this, "previousElementSibling", { get: function(){ return DKRocketElement_previousElementSibling(this.pointer); } });  //TODO, NonDocumentTypeChildNode
	Object.defineProperty(this, "scrollHeight",           { get: function(){ return DKRocketElement_scrollHeight(this.pointer);           } });  //TODO
	Object.defineProperty(this, "scrollLeft", { 
		get: function()   { return DKRocketElement_scrollLeft(this.pointer);      },
		set: function(val){ return DKRocketElement_scrollLeft(this.pointer, val); }
	});   //TODO
	Object.defineProperty(this, "scrollLeftMax",          { get: function(){ return DKRocketElement_scrollLeftMax(this.pointer);          } });  //TODO
	Object.defineProperty(this, "scrollTop", { 
		get: function()   { return DKRocketElement_scrollTop(this.pointer);      },
		set: function(val){ return DKRocketElement_scrollTop(this.pointer, val); }
	});   //TODO
	Object.defineProperty(this, "scrollTopMax",           { get: function(){ return DKRocketElement_scrollTopMax(this.pointer);           } });  //TODO
	Object.defineProperty(this, "scrollWidth",            { get: function(){ return DKRocketElement_scrollWidth(this.pointer);            } });  //TODO
	Object.defineProperty(this, "shadowRoot",             { get: function(){ return DKRocketElement_shadowRoot(this.pointer);             } });  //TODO
	Object.defineProperty(this, "openOrClosedShadowRoot", { get: function(){ return DKRocketElement_openOrClosedShadowRoot(this.pointer); } });  //TODO
	Object.defineProperty(this, "slot", { 
		get: function()   { return DKRocketElement_slot(this.pointer);      },
		set: function(val){ return DKRocketElement_slot(this.pointer, val); }
	});   //TODO
	Object.defineProperty(this, "tabStop", { 
		get: function()   { return DKRocketElement_tabStop(this.pointer);      },
		set: function(val){ return DKRocketElement_tabStop(this.pointer, val); }
	});  //TODO
	Object.defineProperty(this, "tagName",                { get: function(){ return DKRocketElement_tagName(this.pointer);                } });  //TODO
	Object.defineProperty(this, "undoManager",            { get: function(){ return DKRocketElement_undoManager(this.pointer);            } });  //TODO
	Object.defineProperty(this, "undoScope ",             { get: function(){ return DKRocketElement_undoScope (this.pointer);             } });  //TODO
	
	
	Object.defineProperty(this, "onfullscreenchange", {
		get: function(){ return this.fullscreenchange; },
		set: function(func){ this.addEventListener("fullscreenchange", func); this.fullscreenchange = func }
	});   //TODO
	Object.defineProperty(this, "onfullscreenerror", {
		get: function(){ return this.fullscreenerror; },
		set: function(func){ this.addEventListener("fullscreenerror", func); this.fullscreenerror = func }
	});   //TODO
	
	
	Element.prototype.attachShadow = function(){
		//TODO
	}
	Element.prototype.animate = function(){
		//TODO
	}
	Element.prototype.closest = function(){
		//TODO
	}
	Element.prototype.createShadowRoot = function(){
		//TODO, Deprecated
	}
	Element.prototype.computedStyleMap = function(){
		//TODO
	}
	Element.prototype.getAnimations = function(){
		//TODO
	}
	Element.prototype.getAttribute = function(attribute){
		this[attribute] = DKRocketElement_getAttribute(this.pointer, attribute);
		if(!this[attribute]){ return null; }
		return this[attribute];
	}
	Element.prototype.getAttributeNames = function(){
		//TODO
	}
	Element.prototype.getAttributeNS = function(){
		//TODO
	}
	Element.prototype.getBoundingClientRect = function(){
		//TODO
	}
	Element.prototype.getClientRects = function(){
		//TODO
	}
	Element.prototype.getElementsByClassName = function(name){
		//FIXME: only search within the element
		//DKRocketElements_getElementsByClassName(this.pointer, name)
		var pointers = DKRocketElement_getElementsByClassName(name);
		if(!pointers){ return; }
		var elements = new HTMLCollection(pointers);
		return elements;
	}
	Element.prototype.getElementsByTagName = function(tag){
		//FIXME: only search within the element
		//DKRocketElements_getElementsByTagName(this.pointer, tag)
		var pointers = DKRocketElement_getElementsByTagName(tag);
		if(!pointers){ return; }
		var elements = new HTMLCollection(pointers);
		return elements;
	}
	Element.prototype.getElementsByTagNameNS = function(){
		//TODO
	}
	Element.prototype.hasAttribute = function(attribute){
		if(DKRocketElement_hasAttribute(this.pointer, attribute)){ return true; }
		else{ return false; }
	}
	Element.prototype.hasAttributeNS = function(){
		//TODO
	}
	Element.prototype.hasAttributes = function(){
		//TODO
	}
	Element.prototype.insertAdjacentElement = function(){
		//TODO
	}
	Element.prototype.insertAdjacentHTML = function(){
		//TODO
	}
	Element.prototype.insertAdjacentText = function(){
		//TODO
	}
	Element.prototype.matches = function(){
		//TODO
	}
	Element.prototype.querySelector = function(){
		//TODO
	}
	Element.prototype.querySelectorAll = function(){
		//TODO
	}
	Element.prototype.releasePointerCapture = function(){
		//TODO
	}
	Element.prototype.remove = function(){
		//TODO
	}
	Element.prototype.removeAttribute = function(){
		//TODO
	}
	Element.prototype.removeAttributeNS = function(){
		//TODO
	}
	Element.prototype.requestFullscreen = function(){
		//TODO
	}
	Element.prototype.requestPointerLock = function(){
		//TODO
	}
	Element.prototype.scrollIntoView = function(){
		//TODO
	}
	Element.prototype.setAttribute = function(attribute, value){
		DKRocketElement_setAttribute(this.pointer, attribute, value);
		this[attribute] = value;
	}
	Element.prototype.setAttributeNS = function(){
		//TODO
	}
	Element.prototype.setCapture = function(){
		//TODO
	}
	Element.prototype.setPointerCapture = function(){
		//TODO
	}
	Element.prototype.toggleAttribute = function(){
		//TODO
	}
	

	this.pointer = pointer;
	Node.call(this, pointer);
	GlobalEventHandlers.call(this, pointer);
	
	return new Proxy(this, {
		has: function (target, key){
			return key in target;
		},
		get: function (target, key, recv){
			//console.warn("Element:get("+target+","+key+","+recv+")");
			//console.warn("Element:get("+key+")");
			if(typeof target[key] === "function" || key === "pointer" || key === "style" || key === "listeners" || key === "create"){ return target[key]; }
			if(key.substr(0,2) === "on"){ //onevent
				//target.addEventListener(key.substr(2, key.length), val); //val is a callback, let's create and event for it. 
			}
			else{
				target[key] = DKRocketElement_getAttribute(target["pointer"], key);
			}
			return target[key];
		},
		set: function (target, key, val, recv){
			//console.warn("Element:set("+target+","+key+","+val+")");
			//console.warn("Element:set("+key+")");
			if(typeof target[key] === "function" || key === "pointer" || key === "style" || key === "listeners" || key === "create"){ return true; }
			if(key.substr(0,2) === "on"){ //onevent
				//target.addEventListener(key.substr(2, key.length), val); //val is a callback, let's create and event for it. 
			}
			else{
				DKRocketElement_setAttribute(target["pointer"], key, val);
			}
			target[key] = val;
			return true;
		},
		deleteProperty: function (target, key){
			delete target[key];
			return true;
		}
	});
}
Element.prototype = Node.prototype;	