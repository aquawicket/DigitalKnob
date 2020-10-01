//https://developer.mozilla.org/en-US/docs/Web/API/Element

///////////////////////////////
var Element = function(pointer)
{
	// Properties
	Object.defineProperty(this, "attributes", {
		get: function(){ return DKCPP_DKDomElement_attributes(pointer); }
	});
	Object.defineProperty(this, "classList", {
		get: function(){ return DKCPP_DKDomElement_classList(pointer); }
	});
	Object.defineProperty(this, "className", {
		get: function()   { return DKCPP_DKDomElement_className(pointer);      },
		set: function(val){ return DKCPP_DKDomElement_className(pointer, val); }
	});
	Object.defineProperty(this, "clientHeight", {
		get: function(){ return DKCPP_DKDomElement_clientHeight(pointer); }
	});
	Object.defineProperty(this, "clientLeft", {
		get: function(){ return DKCPP_DKDomElement_clientLeft(pointer); }
	});
	Object.defineProperty(this, "clientTop", {
		get: function(){ return DKCPP_DKDomElement_clientTop(pointer); }
	});
	Object.defineProperty(this, "clientWidth", {
		get: function(){ return DKCPP_DKDomElement_clientWidth(pointer); }
	});
	Object.defineProperty(this, "computedName", {
		get: function(){ return DKCPP_DKDomElement_computedName(pointer); } 
	});
	Object.defineProperty(this, "computedRole", {
		get: function(){ return DKCPP_DKDomElement_computedRole(pointer); }
	});
	Object.defineProperty(this, "id", {
		get: function()   { return DKCPP_DKDomElement_getAttribute(pointer, "id"); },
		set: function(val){ return DKCPP_DKDomElement_setAttribute(pointer, "id", val); }
	});
	Object.defineProperty(this, "innerHTML", {
		get: function(){ return DKCPP_DKDomElement_innerHTML(pointer); },
		set: function(val){ return DKCPP_DKDomElement_innerHTML(pointer, val); }
	});
	Object.defineProperty(this, "localName", {
		get: function(){ return DKCPP_DKDomElement_localName(pointer); }
	});
	Object.defineProperty(this, "namespaceURI", {
		get: function(){ return DKCPP_DKDomElement_namespaceURI(pointer); } 
	});
	Object.defineProperty(this, "nextElementSibling", {
		get: function(){ return DKCPP_DKDomElement_nextElementSibling(pointer); }
	});
	Object.defineProperty(this, "outerHTML", {
		get: function(){ return DKCPP_DKDomElement_outerHTML(pointer); },
		set: function(val){ return DKCPP_DKDomElement_outerHTML(pointer, val); }
	});
	Object.defineProperty(this, "prefix", {
		get: function(){ return DKCPP_DKDomElement_prefix(pointer); } 
	});
	Object.defineProperty(this, "previousElementSibling", {
		get: function(){ return DKCPP_DKDomElement_previousElementSibling(pointer); }
	});
	Object.defineProperty(this, "scrollHeight", {
		get: function(){ return DKCPP_DKDomElement_scrollHeight(pointer); } 
	});
	Object.defineProperty(this, "scrollLeft", {
		get: function(){ return DKCPP_DKDomElement_scrollLeft(pointer); },
		set: function(val){ return DKCPP_DKDomElement_scrollLeft(pointer, val); }
	});
	Object.defineProperty(this, "scrollLeftMax", {
		get: function(){ return DKCPP_DKDomElement_scrollLeftMax(pointer); } 
	});
	Object.defineProperty(this, "scrollTop", {
		get: function(){ return DKCPP_DKDomElement_scrollTop(pointer); },
		set: function(val){ return DKCPP_DKDomElement_scrollTop(pointer, val); }
	});
	Object.defineProperty(this, "scrollTopMax", {
		get: function(){ return DKCPP_DKDomElement_scrollTopMax(pointer); } 
	});
	Object.defineProperty(this, "scrollWidth", {
		get: function(){ return DKCPP_DKDomElement_scrollWidth(pointer); }
	});
	Object.defineProperty(this, "shadowRoot", {
		get: function(){ return DKCPP_DKDomElement_shadowRoot(pointer); }
	});
	Object.defineProperty(this, "openOrClosedShadowRoot", {
		get: function(){ return DKCPP_DKDomElement_openOrClosedShadowRoot(pointer); }
	});
	Object.defineProperty(this, "slot", {
		get: function(){ return DKCPP_DKDomElement_slot(pointer); },
		set: function(val){ return DKCPP_DKDomElement_slot(pointer, val); }
	});
	Object.defineProperty(this, "tabStop", {
		get: function(){ return DKCPP_DKDomElement_tabStop(pointer); },
		set: function(val){ return DKCPP_DKDomElement_tabStop(pointer, val); }
	});
	Object.defineProperty(this, "tagName", {
		get: function(){ return DKCPP_DKDomElement_tagName(pointer); } 
	});
	Object.defineProperty(this, "undoManager", {
		get: function(){ return DKCPP_DKDomElement_undoManager(pointer); }
	});
	Object.defineProperty(this, "undoScope", {
		get: function(){ return DKCPP_DKDomElement_undoScope (pointer); }
	});
	Object.defineProperty(this, "onfullscreenchange", {
		get: function(){ return this.fullscreenchange; },
		set: function(func){ this.addEventListener("fullscreenchange", func); this.fullscreenchange = func }
	});
	Object.defineProperty(this, "onfullscreenerror", {
		get: function(){ return this.fullscreenerror; },
		set: function(func){ this.addEventListener("fullscreenerror", func); this.fullscreenerror = func }
	});
	Object.defineProperty(this, "value", {
		get: function()   { return DKCPP_DKDomElement_getAttribute(pointer, "value"); },
		set: function(val){ return DKCPP_DKDomElement_setAttribute(pointer, "value", val); }
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
		this[attribute] = DKCPP_DKDomElement_getAttribute(this.pointer, attribute);
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
		var addresses = DKCPP_DKDomElement_getElementsByClassName(name);
		if(!addresses){ return; }
		return new HTMLCollection(addresses);
	}
	Element.prototype.getElementsByTagName = function(tag){
		//FIXME: only search within the element
		//DKDomElements_getElementsByTagName(pointer, tag)
		var addresses = DKCPP_DKDomElement_getElementsByTagName(tag);
		if(!addresses){ return; }
		return new HTMLCollection(addresses);
	}
	Element.prototype.getElementsByTagNameNS = function(){
		//TODO
	}
	Element.prototype.hasAttribute = function(attribute){
		if(DKCPP_DKDomElement_hasAttribute(this.pointer, attribute)){ return true; }
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
		DKCPP_DKDomElement_setAttribute(this.pointer, attribute, value);
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
			if(typeof target[key] === "function" || key === "pointer" || key === "style" || key === "listeners" || key === "create"){ 
				//console.log("tyoeof target[key] === "+typeof target[key]);
				return target[key]; 
			}
			else{
				target[key] = DKCPP_DKDomElement_getAttribute(target["pointer"], key);
			}
			return target[key];
		},
		set: function (target, key, val, recv){
			//console.log("Element:set("+key+")");
			if(typeof target[key] === "function" || key === "pointer" || key === "style" || key === "listeners" || key === "create"){ 
				//console.warn("tyoeof target[key] === "+typeof target[key]);
				return true; 
			}
			else{
				console.log("DKCPP_DKDomElement_setAttribute(target[pointer], "+key+", "+val+");");
				DKCPP_DKDomElement_setAttribute(target["pointer"], key, val);
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