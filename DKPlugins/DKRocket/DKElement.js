///////////////////////////////
var Element = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("Element("+pointer+")");
	
	Object.defineProperty(this, "attributes",   { get: function(){ return DKRocket_attributes(this.pointer);   } });  //TODO
	Object.defineProperty(this, "classList",    { get: function(){ return DKRocket_classList(this.pointer);    } });  //TODO
	Object.defineProperty(this, "className", { 
		get: function()   { return DKRocket_className(this.pointer);      },
		set: function(val){ return DKRocket_setClassName(this.pointer, val); }
	});  //TODO
	Object.defineProperty(this, "clientHeight", { get: function(){ return DKRocket_clientHeight(this.pointer); } });
	Object.defineProperty(this, "clientLeft",   { get: function(){ return DKRocket_clientLeft(this.pointer);   } });
	Object.defineProperty(this, "clientTop",    { get: function(){ return DKRocket_clientTop(this.pointer);    } });
	Object.defineProperty(this, "clientWidth",  { get: function(){ return DKRocket_clientWidth(this.pointer);  } });
	Object.defineProperty(this, "computedName", { get: function(){ return DKRocket_computedName(this.pointer); } });  //TODO
	Object.defineProperty(this, "computedRole", { get: function(){ return DKRocket_computedRole(this.pointer); } });  //TODO
	/*
	Object.defineProperty(this, "id", { 
		get: function()   { return DKRocket_id(this.pointer);      },
		set: function(val){ return DKRocket_id(this.pointer, val); }
	});  //TODO
	*/	
	Object.defineProperty(this, "innerHTML", { 
		get: function()   { return DKRocket_innerHTML(this.pointer);         },
		set: function(val){ return DKRocket_setInnerHTML(this.pointer, val); }
	});
	Object.defineProperty(this, "localName",              { get: function(){ return DKRocket_localName(this.pointer);              } });  //TODO
	Object.defineProperty(this, "namespaceURI",           { get: function(){ return DKRocket_namespaceURI(this.pointer);           } });  //TODO
	Object.defineProperty(this, "nextElementSibling",     { get: function(){ return DKRocket_nextElementSibling(this.pointer);     } });  //TODO, NonDocumentTypeChildNode
	Object.defineProperty(this, "outerHTML", { 
		get: function()   { return DKRocket_outerHTML(this.pointer);         },
		set: function(val){ return DKRocket_setouterHTML(this.pointer, val); }
	});
	Object.defineProperty(this, "prefix",                 { get: function(){ return DKRocket_prefix(this.pointer);                 } });  //TODO
	Object.defineProperty(this, "previousElementSibling", { get: function(){ return DKRocket_previousElementSibling(this.pointer); } });  //TODO, NonDocumentTypeChildNode
	Object.defineProperty(this, "scrollHeight",           { get: function(){ return DKRocket_scrollHeight(this.pointer);           } });  //TODO
	Object.defineProperty(this, "scrollLeft", { 
		get: function()   { return DKRocket_scrollLeft(this.pointer);         },
		set: function(val){ return DKRocket_setScrollLeft(this.pointer, val); }
	});
	Object.defineProperty(this, "scrollLeftMax",          { get: function(){ return DKRocket_scrollLeftMax(this.pointer);          } });  //TODO
	Object.defineProperty(this, "scrollTop", { 
		get: function()   { return DKRocket_scrollTop(this.pointer);         },
		set: function(val){ return DKRocket_setScrollTop(this.pointer, val); }
	});
	Object.defineProperty(this, "scrollTopMax",           { get: function(){ return DKRocket_scrollTopMax(this.pointer);           } });  //TODO
	Object.defineProperty(this, "scrollWidth",            { get: function(){ return DKRocket_scrollWidth(this.pointer);            } });  //TODO
	Object.defineProperty(this, "shadowRoot",             { get: function(){ return DKRocket_shadowRoot(this.pointer);             } });  //TODO
	Object.defineProperty(this, "openOrClosedShadowRoot", { get: function(){ return DKRocket_openOrClosedShadowRoot(this.pointer); } });  //TODO
	Object.defineProperty(this, "slot", { 
		get: function()   { return DKRocket_slot(this.pointer);         },
		set: function(val){ return DKRocket_setSlot(this.pointer, val); }
	});
	Object.defineProperty(this, "tabStop", { 
		get: function()   { return DKRocket_tabStop(this.pointer);         },
		set: function(val){ return DKRocket_setTabStop(this.pointer, val); }
	});
	Object.defineProperty(this, "tagName",                { get: function(){ return DKRocket_tagName(this.pointer);                } });  //TODO
	Object.defineProperty(this, "undoManager",            { get: function(){ return DKRocket_undoManager(this.pointer);            } });  //TODO
	Object.defineProperty(this, "undoScope ",             { get: function(){ return DKRocket_undoScope (this.pointer);             } });  //TODO
	
	
	Object.defineProperty(this, "onfullscreenchange", {
		get: function(){ return this.fullscreenchange; },
		set: function(func){ this.addEventListener("fullscreenchange", func); this.fullscreenchange = func }
	});
	Object.defineProperty(this, "onfullscreenerror", {
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
		this[attribute] = DKRocket_getAttribute(this.pointer, attribute);
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
		var addressList = DKRocket_getElementsByTagName(name);
		var htmlCollection = new HTMLCollection();
		if(!addressList){ return htmlCollection; }
		var arry = addressList.split(",");
		for(var i=0; i<arry.length; i++){
			htmlCollection.push(new HTMLElement(arry[i]))
		}
		return htmlCollection;
	}
	Element.prototype.getElementsByTagName = function(name){
		var addressList = DKRocket_getElementsByTagName(name);
		var htmlCollection = new HTMLCollection();
		if(!addressList){ return htmlCollection; }
		var arry = addressList.split(",");
		for(var i=0; i<arry.length; i++){
			htmlCollection.push(new HTMLElement(arry[i]))
		}
		return htmlCollection;
	}
	Element.prototype.getElementsByTagNameNS = function(){
		//TODO
	}
	Element.prototype.hasAttribute = function(attribute){
		if(DKRocket_hasAttribute(this.pointer, attribute)){ return true; }
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
		DKRocket_setAttribute(this.pointer, attribute, value);
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
			if(typeof target[key] === "function" || key == "pointer" || key == "style" || key == "listeners" || key == "create"){ return target[key]; }
			if(key.substr(0,2) == "on"){ //onevent
				//target.addEventListener(key.substr(2, key.length), val); //val is a callback, let's create and event for it. 
			}
			else{
				target[key] = DKRocket_getAttribute(target["pointer"], key);
			}
			return target[key];
		},
		set: function (target, key, val, recv){
			//console.warn("Element:set("+target+","+key+","+val+")");
			//console.warn("Element:set("+key+")");
			if(typeof target[key] === "function" || key == "pointer" || key == "style" || key == "listeners" || key == "create"){ return true; }
			if(key.substr(0,2) == "on"){ //onevent
				//target.addEventListener(key.substr(2, key.length), val); //val is a callback, let's create and event for it. 
			}
			else{
				DKRocket_setAttribute(target["pointer"], key, val);
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