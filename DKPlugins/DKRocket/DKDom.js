//https://hackernoon.com/inheritance-in-javascript-21d2b82ffa6f

var document;
var location;
var window;

//var objectMap;
//var stored_objects = [];


/////////////////////
function DKDom_Init()
{
	DKDEBUGFUNC();
}

////////////////////
function DKDom_End()
{
	DKDEBUGFUNC();
}

/////////////////////////////
function DKDom_OnEvent(event)
{
	DKDEBUGFUNC(event);
}

/*
//////////////////////////
var ObjectMap = function()
{
	this.pointers = [];
	this.objects = [];
	
	ObjectMap.prototype.add = function(pointer, obj){
		if(this.objects.indexOf(obj) > -1){ return null; }
		this.pointers.push(pointer);
		this.objects.push(obj);
	}
	ObjectMap.prototype.get = function(pointer, type){
		//DKWARN("objectMap:get("+pointer+")");
		var i = this.pointers.indexOf(pointer);
		if(i < 0){ return null; }
		
		if(this.objects[i] instanceof type){
			DKWARN("objectMap:get found match");
			return this.objects[i];
		}
		return null;
	}
	ObjectMap.prototype.print = function(){
		for(var i=0; i<this.pointers.length; i++){
			DKWARN(this.pointers[i]+" "+this.objects[i]);
		}
	}
}
*/

///////////////////////////////////////////
var CSSStyleDeclaration = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("CSSStyleDeclaration("+pointer+")");
	this.pointer = pointer;
	
	CSSStyleDeclaration.prototype.setProperty = function(propertyName, propertyValue, priority){
		console.warn("CSSStyleDeclaration:setProperty("+this.pointer+","+propertyName+","+propertyValue+")");
		DKRocket_setProperty(this.pointer, propertyName, propertyValue);
		this[propertyName] = propertyValue;
	}
	CSSStyleDeclaration.prototype.getPropertyValue = function(propertyName){
		this[propertyName] = DKRocket_getPropertyValue(this.pointer, propertyName);
		return this[propertyName];
	}
	
	return new Proxy(this, {
		has: function(target, key){
			return key in target;
		},
		get: function(target, key, recv){
			//console.log("Style:get("+target+","+key+")");
			if(typeof target[key] === "function" || key == "pointer"){ return target[key]; }
			var realKey = key;
			
			//Replace characters ( C ) with ( -c )    I.E.  backgroundColor becomes background-color
			for(var i=0; i < realKey.length; i++){
				if(realKey.charAt(i) == realKey.charAt(i).toUpperCase()){ //is uppercase?
					if(realKey.charAt(i) == "-"){ continue; }
					realKey = realKey.substr(0, i)+"-"+realKey.charAt(i).toLowerCase()+realKey.substr(i+1, realKey.length);
				}
			}

			target[key] = DKRocket_getPropertyValue(target["pointer"], realKey);
			return target[key];
		},
		set: function(target, key, val, recv){
			//console.log("Style:set("+target+","+key+","+val+")");
			if(typeof target[key] === "function" || key == "pointer"){ return true; }
			var realKey = key;
			
			
			//Replace characters ( C ) with ( -c )    I.E.  backgroundColor becomes background-color
			for(var i=0; i < realKey.length; i++){
				if(realKey.charAt(i) == realKey.charAt(i).toUpperCase()){ //is uppercase?
					if(realKey.charAt(i) == "-"){ continue; }
					realKey = realKey.substr(0, i)+"-"+realKey.charAt(i).toLowerCase()+realKey.substr(i+1, realKey.length);
				}
			}
			
			DKRocket_setProperty(target["pointer"], realKey, val);
			target[key] = val;
			return true;
		},
		deleteProperty: function(target, key){
			delete target[key];
			return true;
		}
	});
}


////////////////////////////////
var Document = function(pointer)
{
	//DKDEBUGFUNC();
	console.warn("Document("+pointer+")");
	
	Object.defineProperty(this, "location", { get: function(){ return location; } });
	
	Document.prototype.createElement = function(tagName){
		var pointer = DKRocket_createElement(tagName);
		var htmlElement = new HTMLElement(pointer);
		return htmlElement;
	}
	Document.prototype.getElementById = function(id){
		var pointer = DKRocket_getElementById(id);
		if(!pointer){ return null; }
		var htmlElement = new HTMLElement(pointer); //MDN specs say getElementById returns an Element object, but then we have no access to .style
		return htmlElement;
	}
	
	Element.call(this, pointer);
	
	this.body = this.getElementsByTagName("body")[0];
	this.documentElement = this.getElementsByTagName("html")[0];
}


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

////////////////////////////////
var Location = function(pointer)
{
	Object.defineProperty(this, "hash",{
		value: "TODO",
	});
	Object.defineProperty(this, "host",{
		value: "TODO",
	});
	Object.defineProperty(this, "hostname",{
		value: "TODO",
	});
	Object.defineProperty(this, "href", {
		get: function()   { return DKRocket_href(this.pointer);      },
		set: function(val){ return DKRocket_setHref(this.pointer, val); }
	});  //TODO
	Object.defineProperty(this, "origin",{
		value: "TODO",
	});
	Object.defineProperty(this, "pathname",{
		value: "TODO",
	});
	Object.defineProperty(this, "port",{
		value: "TODO",
	});
	Object.defineProperty(this, "protocol",{
		value: "TODO",
	});
	Object.defineProperty(this, "search",{
		value: "TODO",
	});
	
	Location.prototype.assign = function(url){
		//TODO
	}
	Location.prototype.reload = function(forceGet){
		//TODO
	}
	Location.prototype.replace = function(newUrl){
		//TODO
	}
}

////////////////////////////
var Node = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("Node("+pointer+")");
	
	Object.defineProperty(this, "baseURI",         { get: function(){ return DKRocket_baseURI(this.pointer);         } });  //TODO
	Object.defineProperty(this, "baseURIObject",   { get: function(){ return DKRocket_baseURIObject(this.pointer);   } });  //TODO
	Object.defineProperty(this, "childNodes",      { 
		get: function(){
			var addressList = DKRocket_childNodes(this.pointer);
			var htmlCollection = new HTMLCollection();   //TODO - switch htmlCollection over to NodeList
			if(!addressList){ return htmlCollection; }
			var arry = addressList.split(",");
			for(var i=0; i<arry.length; i++){
				htmlCollection.push(new HTMLElement(arry[i]))
			}
			return htmlCollection;	
		} 
	});  //TODO
	Object.defineProperty(this, "firstChild",      { get: function(){ return DKRocket_firstChild(this.pointer);      } });  //TODO
	Object.defineProperty(this, "isConnected",     { get: function(){ return DKRocket_isConnected(this.pointer);     } });  //TODO
	Object.defineProperty(this, "lastChild",       { get: function(){ return DKRocket_lastChild(this.pointer);       } });  //TODO
	Object.defineProperty(this, "nextSibling",     { get: function(){ return DKRocket_nextSibling(this.pointer);     } });  //TODO
	Object.defineProperty(this, "nodeName",        { get: function(){ return DKRocket_nodeName(this.pointer);        } });  //TODO
	Object.defineProperty(this, "nodePrincipal",   { get: function(){ return DKRocket_nodePrincipal(this.pointer);   } });  //TODO
	Object.defineProperty(this, "nodeType",        { get: function(){ return DKRocket_nodeType(this.pointer);        } });  //TODO
	Object.defineProperty(this, "nodeValue", { 
		get: function()   { return DKRocket_nodeValue(this.pointer);         },
		set: function(val){ return DKRocket_setNodeValue(this.pointer, val); }
	});  //TODO
	Object.defineProperty(this, "ownerDocument",   { get: function(){ return DKRocket_ownerDocument(this.pointer);   } });  //TODO
	Object.defineProperty(this, "parentNode",      { get: function(){ return DKRocket_parentNode(this.pointer);      } });
	Object.defineProperty(this, "parentElement",   { get: function(){ return DKRocket_parentElement(this.pointer);   } });  //TODO
	Object.defineProperty(this, "previousSibling", { get: function(){ return DKRocket_previousSibling(this.pointer); } });  //TODO
	Object.defineProperty(this, "textContent", { 
		get: function()   { return DKRocket_textContent(this.pointer);         },
		set: function(val){ return DKRocket_setTextContent(this.pointer, val); }
	});  //TODO
	Object.defineProperty(this, "rootNode ",       { get: function(){ return DKRocket_rootNode (this.pointer);       } });  //Deprecated
	
	Node.prototype.appendChild = function(aChild){
		var pointer = DKRocket_appendChild(this.pointer, aChild.pointer);
		if(!pointer){ return; }
		var element = new Node(pointer);
		return element;
	}
	Node.prototype.cloneNode = function(){
		//TODO
	}
	Node.prototype.compareDocumentPosition = function(){
		//TODO
	}
	Node.prototype.contains = function(){
		//TODO
	}
	Node.prototype.getRootNode = function(){
		//TODO
	}
	Node.prototype.hasChildNodes = function(){
		//TODO
	}
	Node.prototype.insertBefore = function(){
		//TODO
	}
	Node.prototype.isDefaultNamespace = function(){
		//TODO
	}
	Node.prototype.isEqualNode = function(){
		//TODO
	}
	Node.prototype.isSameNode = function(){
		//TODO
	}
	Node.prototype.lookupPrefix = function(){
		//TODO
	}
	Node.prototype.lookupNamespaceURI = function(){
		//TODO
	}
	Node.prototype.normalize = function(){
		//TODO
	}
	Node.prototype.removeChild = function(aChild){
		var pointer = DKRocket_removeChild(this.pointer, aChild.pointer);
		if(!pointer){ return null; }
		var node = new Node(pointer);
		return node;
	}
	Node.prototype.replaceChild = function(){
		//TODO
	}

	return EventTarget.call(this, pointer);
};


///////////////////////////////
var Window = function(pointer){
	//DKDEBUGFUNC();
	
	document = new Document("document");
	location = new Location("location");
	
	Object.defineProperty(this, "closed",                { get: function(){ return DKRocket_closed(this.pointer);           } });  //TODO
	Object.defineProperty(this, "console",               { get: function(){ return console;                                 } });
	Object.defineProperty(this, "controllers",           { get: function(){ return DKRocket_controllers(this.pointer);      } });  //TODO
	Object.defineProperty(this, "customElements",        { get: function(){ return DKRocket_customElements(this.pointer);   } });  //TODO
	Object.defineProperty(this, "crypto",                { get: function(){ return DKRocket_crypto(this.pointer);           } });  //TODO
	Object.defineProperty(this, "devicePixelRatio",      { get: function(){ return DKRocket_devicePixelRatio(this.pointer); } });  //TODO
	Object.defineProperty(this, "dialogArguments",       { get: function(){ return DKRocket_dialogArguments(this.pointer);  } });  //TODO
	Object.defineProperty(this, "document",              { get: function(){ return document;                                } });
	Object.defineProperty(this, "event",                 { get: function(){ return DKRocket_event(this.pointer);            } });  //TODO
	Object.defineProperty(this, "frameElement",          { get: function(){ return DKRocket_frameElement(this.pointer);     } });  //TODO
	Object.defineProperty(this, "frames",                { get: function(){ return DKRocket_frames(this.pointer);           } });  //TODO
	Object.defineProperty(this, "fullScreen", {
		get: function()   { return DKRocket_fullScreen(this.pointer);      },
		set: function(val){ return DKRocket_fullScreen(this.pointer, val); }
	});  //TODO
	Object.defineProperty(this, "history",               { get: function(){ return DKRocket_history(this.pointer);          } });  //TODO
	Object.defineProperty(this, "innerHeight",           { get: function(){ return DKRocket_innerHeight();                  } });  //TODO
	Object.defineProperty(this, "innerWidth",            { get: function(){ return DKRocket_innerWidth();                   } });  //TODO
	Object.defineProperty(this, "isSecureContext",       { get: function(){ return DKRocket_isSecureContext();              } });  //TODO, Experimental
	Object.defineProperty(this, "length",                { get: function(){ return DKRocket_length();                       } });  //TODO
	Object.defineProperty(this, "location",              { get: function(){ return location;                                } });
	Object.defineProperty(this, "locationbar",           { get: function(){ return DKRocket_locationbar();                  } });  //TODO
	Object.defineProperty(this, "localStorage",          { get: function(){ return DKRocket_localStorage();                 } });  //TODO
	Object.defineProperty(this, "menubar",               { get: function(){ return DKRocket_menubar();                      } });  //TODO
	Object.defineProperty(this, "messageManager",        { get: function(){ return DKRocket_messageManager();               } });  //TODO
	Object.defineProperty(this, "mozAnimationStartTime", { get: function(){ return DKRocket_mozAnimationStartTime();        } });  //TODO, Deprecated
	Object.defineProperty(this, "mozInnerScreenX",       { get: function(){ return DKRocket_mozInnerScreenX();              } });  //TODO
	Object.defineProperty(this, "mozInnerScreenY",       { get: function(){ return DKRocket_mozInnerScreenX();              } });  //TODO
	Object.defineProperty(this, "mozPaintCount",         { get: function(){ return DKRocket_mozPaintCount();                } });  //TODO
	Object.defineProperty(this, "name", { 
		get: function()   { return DKRocket_name();    },
		set: function(val){ return DKRocket_setName(); }  
	});  //TODO
	Object.defineProperty(this, "navigator",             { get: function(){ return navigator;                               } });
	Object.defineProperty(this, "opener",                { get: function(){ return DKRocket_opener();                       } });  //TODO
	Object.defineProperty(this, "orientation",           { get: function(){ return DKRocket_orientation();                  } });  //TODO, Deprecated
	Object.defineProperty(this, "outerHeight",           { get: function(){ return DKRocket_outerHeight();                  } });  //TODO
	Object.defineProperty(this, "outerWidth",            { get: function(){ return DKRocket_outerWidth();                   } });  //TODO
	Object.defineProperty(this, "pageXOffset",           { get: function(){ return DKRocket_pageXOffset();                  } });  //TODO
	Object.defineProperty(this, "pageYOffset",           { get: function(){ return DKRocket_pageYOffset();                  } });  //TODO
	Object.defineProperty(this, "parent",                { get: function(){ return DKRocket_parent ();                      } });  //TODO
	Object.defineProperty(this, "performance",           { get: function(){ return DKRocket_performance();                  } });  //TODO
	Object.defineProperty(this, "personalbar",           { get: function(){ return DKRocket_personalbar();                  } });  //TODO
	Object.defineProperty(this, "returnValue",           { get: function(){ return DKRocket_returnValue();                  } });  //TODO
	Object.defineProperty(this, "screen",                { get: function(){ return screen;                                  } });  //TODO
	Object.defineProperty(this, "screenX",               { get: function(){ return DKRocket_screenX();                      } });  //TODO
	Object.defineProperty(this, "screenY",               { get: function(){ return DKRocket_screenY();                      } });  //TODO
	Object.defineProperty(this, "scrollbars",            { get: function(){ return DKRocket_scrollbars();                   } });  //TODO
	Object.defineProperty(this, "scrollMaxX",            { get: function(){ return DKRocket_scrollMaxX();                   } });  //TODO
	Object.defineProperty(this, "scrollMaxY",            { get: function(){ return DKRocket_scrollMaxY();                   } });  //TODO
	Object.defineProperty(this, "scrollX",               { get: function(){ return DKRocket_scrollX();                      } });  //TODO
	Object.defineProperty(this, "scrollY",               { get: function(){ return DKRocket_scrollY();                      } });  //TODO
	Object.defineProperty(this, "self",                  { get: function(){ return DKRocket_self();                         } });  //TODO
	Object.defineProperty(this, "sessionStorage",        { get: function(){ return DKRocket_sessionStorage();               } });  //TODO
	Object.defineProperty(this, "sidebar",               { get: function(){ return DKRocket_sidebar();                      } });  //TODO
	Object.defineProperty(this, "speechSynthesis",       { get: function(){ return DKRocket_speechSynthesis();              } });  //TODO
	Object.defineProperty(this, "status", {
		get: function()   { return DKRocket_status();    },
		set: function(val){ return DKRocket_setStatus(); }
	});  //TODO
	Object.defineProperty(this, "statusbar",             { get: function(){ return DKRocket_statusbar();                    } });  //TODO
	Object.defineProperty(this, "toolbar",               { get: function(){ return DKRocket_toolbar();                      } });  //TODO
	Object.defineProperty(this, "top",                   { get: function(){ return DKRocket_top();                          } });  //TODO
	Object.defineProperty(this, "visualViewport",        { get: function(){ return DKRocket_visualViewport();               } });  //TODO
	Object.defineProperty(this, "window",                { get: function(){ return DKRocket_window();                       } });  //TODO
	
	Window.prototype.alert = function(msg){
		console.warn("alert: "+msg); //TODO - create an actual popup window
	}
	Window.prototype.blur = function(){
		//TODO
	}
	Window.prototype.cancelAnimationFrame = function(){
		//TODO
	}
	Window.prototype.cancelIdleCallback = function(){
		//TODO
	}
	Window.prototype.captureEvents = function(){
		//TODO, deprecated
	}
	Window.prototype.clearImmediate = function(){
		//TODO
	}
	Window.prototype.close = function(){
		//TODO
	}
	Window.prototype.confirm = function(){
		//TODO
	}
	Window.prototype.dispatchEvent = function(){
		//TODO
	}
	Window.prototype.dump = function(){
		//TODO
	}
	Window.prototype.find = function(){
		//TODO
	}
	Window.prototype.focus = function(){
		//TODO
	}
	Window.prototype.getAttentionWithCycleCount = function(){
		//TODO
	}
	Window.prototype.getComputedStyle = function(){
		//TODO
	}
	Window.prototype.getDefaultComputedStyle = function(){
		//TODO
	}
	Window.prototype.getSelection = function(){
		//TODO
	}
	Window.prototype.matchMedia = function(){
		//TODO
	}
	Window.prototype.maximize = function(){
		//TODO
	}
	Window.prototype.minimize = function(){
		//TODO
	}
	Window.prototype.moveBy = function(){
		//TODO
	}
	Window.prototype.moveTo = function(){
		//TODO
	}
	Window.prototype.open = function(){
		//TODO
	}
	Window.prototype.postMessage = function(){
		//TODO
	}
	Window.prototype.print = function(){
		//TODO
	}
	Window.prototype.prompt = function(){
		//TODO
	}
	Window.prototype.releaseEvents = function(){
		//TODO, deprecated
	}
	Window.prototype.requestAnimationFrame = function(){
		//TODO
	}
	Window.prototype.requestIdleCallback = function(){
		//TODO
	}
	Window.prototype.resizeBy = function(){
		//TODO
	}
	Window.prototype.resizeTo = function(){
		//TODO
	}
	Window.prototype.scroll = function(){
		//TODO
	}
	Window.prototype.scrollBy = function(){
		//TODO
	}
	Window.prototype.scrollByLines = function(){
		//TODO
	}
	Window.prototype.scrollByPages = function(){
		//TODO
	}
	Window.prototype.scrollTo = function(){
		//TODO
	}
	Window.prototype.setCursor = function(){
		//TODO
	}
	Window.prototype.setImmediate = function(){
		//TODO
	}
	Window.prototype.setResizable = function(){
		//TODO
	}
	Window.prototype.sizeToContent = function(){
		//TODO
	}
	Window.prototype.stop = function(){
		//TODO
	}
	Window.prototype.updateCommands = function(){
		//TODO
	}
	
	return EventTarget.call(this, pointer);
}



//Global prototypes. Must be in order by dependency
Window.prototype = EventTarget.prototype;
Node.prototype = EventTarget.prototype;
Element.prototype = Node.prototype;	
Document.prototype = Element.prototype;
HTMLElement.prototype = Element.prototype;
HTMLCollection.prototype = [];



////// Create Dom /////////
//objectMap = new ObjectMap();
window = new Window("window");