//https://developer.mozilla.org/en-US/docs/Web/API/Element

///////////////////////////////
var Element = function(pointer)
{
	// Properties
	Object.defineProperty(this, "attributes", {
		configurable: true,
		get: function(){ return DKDomElement_attributes(pointer); }
	});
	Object.defineProperty(this, "classList", { 
		configurable: true,
		get: function(){ return DKDomElement_classList(pointer); }
	});
	Object.defineProperty(this, "className", {
		configurable: true,
		get: function()   { return DKDomElement_className(pointer);      },
		set: function(val){ return DKDomElement_className(pointer, val); }
	});
	Object.defineProperty(this, "clientHeight", { 
		configurable: true,
		get: function(){ return DKDomElement_clientHeight(pointer); }
	});
	Object.defineProperty(this, "clientLeft", { 
		configurable: true,
		get: function(){ return DKDomElement_clientLeft(pointer); }
	});
	Object.defineProperty(this, "clientTop", { 
		configurable: true,
		get: function(){ return DKDomElement_clientTop(pointer); }
	});
	Object.defineProperty(this, "clientWidth", { 
		configurable: true,
		get: function(){ return DKDomElement_clientWidth(pointer); }
	});
	Object.defineProperty(this, "computedName", { 
		configurable: true,
		get: function(){ return DKDomElement_computedName(pointer); } 
	});
	Object.defineProperty(this, "computedRole", { 
		configurable: true,
		get: function(){ return DKDomElement_computedRole(pointer); }
	});
	Object.defineProperty(this, "id", { 
		configurable: true,
		get: function()   { return DKDomElement_getAttribute(pointer, "id"); },
		set: function(val){ return DKDomElement_setAttribute(pointer, "id", val); }
	});
	Object.defineProperty(this, "innerHTML", {
		configurable: true,
		get: function(){ return DKDomElement_innerHTML(pointer); },
		set: function(val){ return DKDomElement_innerHTML(pointer, val); }
	});
	Object.defineProperty(this, "localName", { 
		configurable: true,
		get: function(){ return DKDomElement_localName(pointer); }
	});
	Object.defineProperty(this, "namespaceURI", {
		configurable: true,
		get: function(){ return DKDomElement_namespaceURI(pointer); } 
	});
	Object.defineProperty(this, "nextElementSibling", { 
		configurable: true,
		get: function(){ return DKDomElement_nextElementSibling(pointer); }
	});
	Object.defineProperty(this, "outerHTML", {
		configurable: true,
		get: function(){ return DKDomElement_outerHTML(pointer); },
		set: function(val){ return DKDomElement_outerHTML(pointer, val); }
	});
	Object.defineProperty(this, "prefix", { 
		configurable: true,
		get: function(){ return DKDomElement_prefix(pointer); } 
	});
	Object.defineProperty(this, "previousElementSibling", {
		configurable: true,
		get: function(){ return DKDomElement_previousElementSibling(pointer); }
	});
	Object.defineProperty(this, "scrollHeight", { 
		configurable: true,
		get: function(){ return DKDomElement_scrollHeight(pointer); } 
	});
	Object.defineProperty(this, "scrollLeft", { 
		configurable: true,
		get: function(){ return DKDomElement_scrollLeft(pointer); },
		set: function(val){ return DKDomElement_scrollLeft(pointer, val); }
	});
	Object.defineProperty(this, "scrollLeftMax", { 
		configurable: true,
		get: function(){ return DKDomElement_scrollLeftMax(pointer); } 
	});
	Object.defineProperty(this, "scrollTop", { 
		configurable: true,
		get: function(){ return DKDomElement_scrollTop(pointer); },
		set: function(val){ return DKDomElement_scrollTop(pointer, val); }
	});
	Object.defineProperty(this, "scrollTopMax", { 
		configurable: true,
		get: function(){ return DKDomElement_scrollTopMax(pointer); } 
	});
	Object.defineProperty(this, "scrollWidth", { 
		configurable: true,
		get: function(){ return DKDomElement_scrollWidth(pointer); }
	});
	Object.defineProperty(this, "shadowRoot", { 
		configurable: true,
		get: function(){ return DKDomElement_shadowRoot(pointer); }
	});
	Object.defineProperty(this, "openOrClosedShadowRoot", { 
		configurable: true,
		get: function(){ return DKDomElement_openOrClosedShadowRoot(pointer); }
	});
	Object.defineProperty(this, "slot", {
		configurable: true,
		get: function(){ return DKDomElement_slot(pointer); },
		set: function(val){ return DKDomElement_slot(pointer, val); }
	});
	Object.defineProperty(this, "tabStop", { 
		configurable: true,
		get: function(){ return DKDomElement_tabStop(pointer); },
		set: function(val){ return DKDomElement_tabStop(pointer, val); }
	});
	Object.defineProperty(this, "tagName", { 
		configurable: true,
		get: function(){ return DKDomElement_tagName(pointer); } 
	});
	Object.defineProperty(this, "undoManager", {
		configurable: true,
		get: function(){ return DKDomElement_undoManager(pointer); }
	});
	Object.defineProperty(this, "undoScope", { 
		configurable: true,
		get: function(){ return DKDomElement_undoScope (pointer); }
	});
	Object.defineProperty(this, "onfullscreenchange", {
		configurable: true,
		get: function(){ return this.fullscreenchange; },
		set: function(func){ this.addEventListener("fullscreenchange", func); this.fullscreenchange = func }
	});
	Object.defineProperty(this, "onfullscreenerror", {
		configurable: true,
		get: function(){ return this.fullscreenerror; },
		set: function(func){ this.addEventListener("fullscreenerror", func); this.fullscreenerror = func }
	});
	
	
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
		this[attribute] = DKDomElement_getAttribute(this.pointer, attribute);
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
		//DKDomElements_getElementsByClassName(pointer, name)
		var addresses = DKDomElement_getElementsByClassName(name);
		if(!addresses){ return; }
		return new HTMLCollection(addresses);
	}
	Element.prototype.getElementsByTagName = function(tag){
		//FIXME: only search within the element
		//DKDomElements_getElementsByTagName(pointer, tag)
		var addresses = DKDomElement_getElementsByTagName(tag);
		if(!addresses){ return; }
		return new HTMLCollection(addresses);
	}
	Element.prototype.getElementsByTagNameNS = function(){
		//TODO
	}
	Element.prototype.hasAttribute = function(attribute){
		if(DKDomElement_hasAttribute(this.pointer, attribute)){ return true; }
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
		DKDomElement_setAttribute(this.pointer, attribute, value);
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
	
	GlobalEventHandlers.call(this, pointer); //FIXME: should be a mixin
	return Node.call(this, pointer);
	
	/*
	return new Proxy(this, {
	//const proxy = new Proxy(this, {
		has: function (target, key){
			//console.log("Element:has("+key+")");
			return key in target;
		},
		get: function (target, key, recv){
			//console.log("Element:get("+key+")");
			if(typeof target[key] === "function" || key == "pointer" || key == "style" || key == "listeners" || key == "create"){ 
				//console.log("tyoeof target[key] == "+typeof target[key]);
				return target[key]; 
			}
			else{
				target[key] = DKDomElement_getAttribute(target["pointer"], key);
			}
			return target[key];
		},
		set: function (target, key, val, recv){
			//console.log("Element:set("+key+")");
			if(typeof target[key] === "function" || key == "pointer" || key == "style" || key == "listeners" || key == "create"){ 
				//console.warn("tyoeof target[key] == "+typeof target[key]);
				return true; 
			}
			else{
				console.log("DKDomElement_setAttribute(target[pointer], "+key+", "+val+");");
				DKDomElement_setAttribute(target["pointer"], key, val);
			}
			target[key] = val;
			return true;
		},
		deleteProperty: function (target, key){
			//console.log("Element:deleteProperty("+key+")");
			delete target[key];
			return true;
		}
	});
	*/
}
Element.prototype = Node.prototype;