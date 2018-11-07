//https://hackernoon.com/inheritance-in-javascript-21d2b82ffa6f

//var console;
var document;
//var location;
var navigator;
var objectMap;
var screen;
var window;

var stored_objects = [];
var stored_events = [];


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

/*
///////////////////////////////
var Console = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("Console()");
	
	Console.prototype.assert = function(assertion, msg){
		if(assertion){ return; }
		DKLogError(msg+"\n");
	}
	Console.prototype.clear = function(){
		DK_System("cls");
	}
	Console.prototype.debug = function(msg){
		DKLogDebug(msg+"\n");
	}
	Console.prototype.error = function(msg){
		DKLogError(msg+"\n");
	}
	Console.prototype.exception = Console.prototype.error; //alias
	Console.prototype.info = function(msg){
		DKLogInfo(msg+"\n");
	}
	Console.prototype.log = function(msg){
		DKLogInfo(msg+"\n");
	}
	Console.prototype.trace = function(){
		DKLogError("console.trace() not implemented\n");
	}
	Console.prototype.warn = function(msg){
			DKLogWarn(msg+"\n");
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

	Document.prototype.createElement = function(tagName){
		var pointer = DKRocket_createElement(tagName);
		var htmlElement = new HTMLElement(pointer);
		return htmlElement;
	}
	Document.prototype.getElementById = function(id){
		var pointer = DKRocket_getElementById(id);
		if(!pointer){ return null; }
		var element = new Element(pointer);
		return element;
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
			//console.log("Element:get("+target+","+key+","+recv+")");
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
			//console.log("Element:set("+target+","+key+","+val+")");
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


//////////////////////////////////////////////
var EventFromRocket = function(pointer, event)
{
	for(var i=0; i<stored_events.length; i++){
		if(pointer == stored_events[i].pointer){
			stored_events[i].dispatchEvent(event);
		}
	}
}

///////////////////////////////////
var Eventtargetet = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("Eventtargetet("+pointer+")");
	
	this.pointer = pointer;
	this.listeners = {};
	
	Eventtargetet.prototype.listeners = null;
	Eventtargetet.prototype.addEventListener = function(type, callback, useCapture){
		if(stored_events.indexOf(this) < 0){
			stored_events.push(this);
		}
		if(this.pointer != "window"){
			DKRocket_addEventListener(this.pointer, type, useCapture);
		}
		if(!(type in this.listeners)){
			this.listeners[type] = [];
		}
		this.listeners[type].push(callback);
	};
	Eventtargetet.prototype.removeEventListener = function(type, callback, useCapture){
		DKRocket_removeEventListener(this.pointer, type, useCapture);
		if(!(type in this.listeners)){
			return;
		}
		var stack = this.listeners[type];
		for(var i = 0, l = stack.length; i < l; i++){
			if(stack[i] === callback){
				stack.splice(i, 1);
				return;
			}
		}
	};
	Eventtargetet.prototype.dispatchEvent = function(event){
		if(!(event.type in this.listeners)){
			return true;
		}
		var stack = this.listeners[event.type].slice();
		for (var i = 0, l = stack.length; i < l; i++){
			stack[i].call(this, event);
		}
		return !event.defaultPrevented;
	};
};


///////////////////////////////////////////
var GlobalEventHandlers = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("GlobalEventHandlers("+pointer+")");
	
	this.pointer = pointer;
	
	Object.defineProperty(this, "onabort", {
		get: function(){ return this.abort; },
		set: function(func){ this.addEventListener("abort", func); this.abort = func }
	});
	Object.defineProperty(this, "onanimationcancel", {
		get: function(){ return this.animationcancel; },
		set: function(func){ this.addEventListener("animationcancel", func); this.animationcancel = func }
	});
	Object.defineProperty(this, "onanimationend", {
		get: function(){ return this.animationend; },
		set: function(func){ this.addEventListener("animationend", func); this.animationend = func }
	});
	Object.defineProperty(this, "onanimationiteration", {
		get: function(){ return this.animationiteration; },
		set: function(func){ this.addEventListener("animationiteration", func); this.animationiteration = func }
	});
	Object.defineProperty(this, "onanimationstart", {
		get: function(){ return this.animationstart; },
		set: function(func){ this.addEventListener("animationstart", func); this.animationstart = func }
	});
	Object.defineProperty(this, "onauxclick", {
		get: function(){ return this.auxclick; },
		set: function(func){ this.addEventListener("auxclick", func); this.auxclick = func }
	});
	Object.defineProperty(this, "onblur", {
		get: function(){ return this.blur; },
		set: function(func){ this.addEventListener("blur", func); this.blur = func }
	});
	Object.defineProperty(this, "onerror", {
		get: function(){ return this.error; },
		set: function(func){ this.addEventListener("error", func); this.error = func }
	});
	Object.defineProperty(this, "onfocus", {
		get: function(){ return this.focus; },
		set: function(func){ this.addEventListener("focus", func); this.focus = func }
	});
	Object.defineProperty(this, "oncanplay", {
		get: function(){ return this.canplay; },
		set: function(func){ this.addEventListener("canplay", func); this.canplay = func }
	});
	Object.defineProperty(this, "oncanplaythrough", {
		get: function(){ return this.canplaythrough; },
		set: function(func){ this.addEventListener("canplaythrough", func); this.canplaythrough = func }
	});
	Object.defineProperty(this, "onchange", {
		get: function(){ return this.change; },
		set: function(func){ this.addEventListener("change", func); this.change = func }
	});
	Object.defineProperty(this, "onclick", {
		get: function(){ return this.click; },
		set: function(func){ this.addEventListener("click", func); this.click = func }
	});
	Object.defineProperty(this, "onclose", {
		get: function(){ return this.close; },
		set: function(func){ this.addEventListener("close", func); this.close = func }
	});
	Object.defineProperty(this, "oncontextmenu", {
		get: function(){ return this.contextmenu; },
		set: function(func){ this.addEventListener("contextmenu", func); this.contextmenu = func }
	});
	Object.defineProperty(this, "oncuechange", {
		get: function(){ return this.cuechange; },
		set: function(func){ this.addEventListener("cuechange", func); this.cuechange = func }
	});
	Object.defineProperty(this, "ondblclick", {
		get: function(){ return this.dblclick; },
		set: function(func){ this.addEventListener("dblclick", func); this.dblclick = func }
	});
	Object.defineProperty(this, "ondrag", {
		get: function(){ return this.drag; },
		set: function(func){ this.addEventListener("drag", func); this.drag = func }
	});
	Object.defineProperty(this, "ondragend", {
		get: function(){ return this.dragend; },
		set: function(func){ this.addEventListener("dragend", func); this.dragend = func }
	});
	Object.defineProperty(this, "ondragenter", {
		get: function(){ return this.dragenter; },
		set: function(func){ this.addEventListener("dragenter", func); this.dragenter = func }
	});
	Object.defineProperty(this, "ondragexit", {
		get: function(){ return this.dragexit; },
		set: function(func){ this.addEventListener("dragexit", func); this.dragexit = func }
	});
	Object.defineProperty(this, "ondragleave", {
		get: function(){ return this.dragleave; },
		set: function(func){ this.addEventListener("dragleave", func); this.dragleave = func }
	});
	Object.defineProperty(this, "ondragover", {
		get: function(){ return this.dragover; },
		set: function(func){ this.addEventListener("dragover", func); this.dragover = func }
	});
	Object.defineProperty(this, "ondragstart", {
		get: function(){ return this.dragstart; },
		set: function(func){ this.addEventListener("dragstart", func); this.dragstart = func }
	});
	Object.defineProperty(this, "ondrop", {
		get: function(){ return this.drop; },
		set: function(func){ this.addEventListener("drop", func); this.drop = func }
	});
	Object.defineProperty(this, "ondurationchange", {
		get: function(){ return this.durationchange; },
		set: function(func){ this.addEventListener("durationchange", func); this.durationchange = func }
	});
	Object.defineProperty(this, "onemptied", {
		get: function(){ return this.emptied; },
		set: function(func){ this.addEventListener("emptied", func); this.emptied = func }
	});
	Object.defineProperty(this, "onended", {
		get: function(){ return this.ended; },
		set: function(func){ this.addEventListener("ended", func); this.ended = func }
	});
	Object.defineProperty(this, "ongotpointercapture", {
		get: function(){ return this.gotpointercapture; },
		set: function(func){ this.addEventListener("gotpointercapture", func); this.gotpointercapture = func }
	});
	Object.defineProperty(this, "oninput", {
		get: function(){ return this.input; },
		set: function(func){ this.addEventListener("input", func); this.input = func }
	});
	Object.defineProperty(this, "oninvalid", {
		get: function(){ return this.invalid; },
		set: function(func){ this.addEventListener("invalid", func); this.invalid = func }
	});
	Object.defineProperty(this, "onkeydown", {
		get: function(){ return this.keydown; },
		set: function(func){ this.addEventListener("keydown", func); this.keydown = func }
	});
	Object.defineProperty(this, "onkeypress", {
		get: function(){ return this.keypress; },
		set: function(func){ this.addEventListener("keypress", func); this.keypress = func }
	});
	Object.defineProperty(this, "onkeyup", {
		get: function(){ return this.keyup; },
		set: function(func){ this.addEventListener("keyup", func); this.keyup = func }
	});
	Object.defineProperty(this, "onload", {
		get: function(){ return this.load; },
		set: function(func){ this.addEventListener("load", func); this.load = func }
	});
	Object.defineProperty(this, "onloadeddata", {
		get: function(){ return this.loadeddata; },
		set: function(func){ this.addEventListener("loadeddata", func); this.loadeddata = func }
	});
	Object.defineProperty(this, "onloadedmetadata", {
		get: function(){ return this.loadedmetadata; },
		set: function(func){ this.addEventListener("loadedmetadata", func); this.loadedmetadata = func }
	});
	Object.defineProperty(this, "onloadend", {
		get: function(){ return this.loadend; },
		set: function(func){ this.addEventListener("loadend", func); this.loadend = func }
	});
	Object.defineProperty(this, "onloadstart", {
		get: function(){ return this.loadstart; },
		set: function(func){ this.addEventListener("loadstart", func); this.loadstart = func }
	});
	Object.defineProperty(this, "onlostpointercapture", {
		get: function(){ return this.lostpointercapture; },
		set: function(func){ this.addEventListener("lostpointercapture", func); this.lostpointercapture = func }
	});
	Object.defineProperty(this, "onmousedown", {
		get: function(){ return this.mousedown; },
		set: function(func){ this.addEventListener("mousedown", func); this.mousedown = func }
	});
	Object.defineProperty(this, "onmouseenter", {
		get: function(){ return this.mouseenter; },
		set: function(func){ this.addEventListener("mouseenter", func); this.mouseenter = func }
	});
	Object.defineProperty(this, "onmouseleave", {
		get: function(){ return this.mouseleave; },
		set: function(func){ this.addEventListener("mouseleave", func); this.mouseleave = func }
	});
	Object.defineProperty(this, "onmousemove", {
		get: function(){ return this.mousemove; },
		set: function(func){ this.addEventListener("mousemove", func); this.mousemove = func }
	});
	Object.defineProperty(this, "onmouseout", {
		get: function(){ return this.mouseout; },
		set: function(func){ this.addEventListener("mouseout", func); this.mouseout = func }
	});
	Object.defineProperty(this, "onmouseover", {
		get: function(){ return this.mouseover; },
		set: function(func){ this.addEventListener("mouseover", func); this.mouseover = func }
	});
	Object.defineProperty(this, "onmouseup", {
		get: function(){ return this.mouseup; },
		set: function(func){ this.addEventListener("mouseup", func); this.mouseup = func }
	});
	Object.defineProperty(this, "onmousewheel", {
		get: function(){ return this.mousewheel; },
		set: function(func){ this.addEventListener("mousewheel", func); this.mousewheel = func }
	});
	Object.defineProperty(this, "onwheel", {
		get: function(){ return this.wheel; },
		set: function(func){ this.addEventListener("wheel", func); this.wheel = func }
	});
	Object.defineProperty(this, "onpause", {
		get: function(){ return this.pause; },
		set: function(func){ this.addEventListener("pause", func); this.pause = func }
	});
	Object.defineProperty(this, "onplay", {
		get: function(){ return this.play; },
		set: function(func){ this.addEventListener("play", func); this.play = func }
	});
	Object.defineProperty(this, "onplaying", {
		get: function(){ return this.playing; },
		set: function(func){ this.addEventListener("playing", func); this.playing = func }
	});
	Object.defineProperty(this, "onpointerdown", {
		get: function(){ return this.pointerdown; },
		set: function(func){ this.addEventListener("pointerdown", func); this.pointerdown = func }
	});
	Object.defineProperty(this, "onpointermove", {
		get: function(){ return this.pointermov; },
		set: function(func){ this.addEventListener("pointermov", func); this.pointermov = func }
	});
	Object.defineProperty(this, "onpointerup", {
		get: function(){ return this.pointerup; },
		set: function(func){ this.addEventListener("pointerup", func); this.pointerup = func }
	});
	Object.defineProperty(this, "onpointercancel", {
		get: function(){ return this.pointercancel; },
		set: function(func){ this.addEventListener("pointercancel", func); this.pointercancel = func }
	});
	Object.defineProperty(this, "onpointerover", {
		get: function(){ return this.pointerover; },
		set: function(func){ this.addEventListener("pointerover", func); this.pointerover = func }
	});
	Object.defineProperty(this, "onpointerout", {
		get: function(){ return this.pointerout; },
		set: function(func){ this.addEventListener("pointerout", func); this.pointerout = func }
	});
	Object.defineProperty(this, "onpointerenter", {
		get: function(){ return this.pointerenter; },
		set: function(func){ this.addEventListener("pointerenter", func); this.pointerenter = func }
	});
	Object.defineProperty(this, "onpointerleave", {
		get: function(){ return this.pointerleave; },
		set: function(func){ this.addEventListener("pointerleave", func); this.pointerleave = func }
	});
	Object.defineProperty(this, "onpointerlockchange", {
		get: function(){ return this.pointerlockchange; },
		set: function(func){ this.addEventListener("pointerlockchange", func); this.pointerlockchange = func }
	});
	Object.defineProperty(this, "onpointerlockerror", {
		get: function(){ return this.pointerlockerror; },
		set: function(func){ this.addEventListener("pointerlockerror", func); this.pointerlockerror = func }
	});
	Object.defineProperty(this, "onprogress", {
		get: function(){ return this.progress; },
		set: function(func){ this.addEventListener("progress", func); this.progress = func }
	});
	Object.defineProperty(this, "onratechange", {
		get: function(){ return this.ratechange; },
		set: function(func){ this.addEventListener("ratechange", func); this.ratechange = func }
	});
	Object.defineProperty(this, "onreset", {
		get: function(){ return this.reset; },
		set: function(func){ this.addEventListener("reset", func); this.reset = func }
	});
	Object.defineProperty(this, "onresize", {
		get: function(){ return this.resize; },
		set: function(func){ this.addEventListener("resize", func); this.resize = func }
	});
	Object.defineProperty(this, "onscroll", {
		get: function(){ return this.scroll; },
		set: function(func){ this.addEventListener("scroll", func); this.scroll = func }
	});
	Object.defineProperty(this, "onseeked", {
		get: function(){ return this.seeked; },
		set: function(func){ this.addEventListener("seeked", func); this.seeked = func }
	});
	Object.defineProperty(this, "onseeking", {
		get: function(){ return this.seeking; },
		set: function(func){ this.addEventListener("seeking", func); this.seeking = func }
	});
	Object.defineProperty(this, "onselect", {
		get: function(){ return this.select; },
		set: function(func){ this.addEventListener("select", func); this.select = func }
	});
	Object.defineProperty(this, "onselectstart", {
		get: function(){ return this.selectstart; },
		set: function(func){ this.addEventListener("selectstart", func); this.selectstart = func }
	});
	Object.defineProperty(this, "onselectionchange", {
		get: function(){ return this.selectionchange; },
		set: function(func){ this.addEventListener("selectionchange", func); this.selectionchange = func }
	});
	Object.defineProperty(this, "onshow", {
		get: function(){ return this.show; },
		set: function(func){ this.addEventListener("show", func); this.show = func }
	});
	Object.defineProperty(this, "onsort", {
		get: function(){ return this.sort; },
		set: function(func){ this.addEventListener("sort", func); this.sort = func }
	});
	Object.defineProperty(this, "onstalled", {
		get: function(){ return this.stalled; },
		set: function(func){ this.addEventListener("stalled", func); this.stalled = func }
	});
	Object.defineProperty(this, "onsubmit", {
		get: function(){ return this.submit; },
		set: function(func){ this.addEventListener("submit", func); this.submit = func }
	});
	Object.defineProperty(this, "onsuspend", {
		get: function(){ return this.suspend; },
		set: function(func){ this.addEventListener("suspend", func); this.suspend = func }
	});
	Object.defineProperty(this, "ontimeupdate", {
		get: function(){ return this.timeupdate; },
		set: function(func){ this.addEventListener("timeupdate", func); this.timeupdate = func }
	});
	Object.defineProperty(this, "onvolumechange", {
		get: function(){ return this.volumechange; },
		set: function(func){ this.addEventListener("volumechange", func); this.volumechange = func }
	});
	Object.defineProperty(this, "ontouchcancel", {
		get: function(){ return this.touchcancel; },
		set: function(func){ this.addEventListener("touchcancel", func); this.touchcancel = func }
	});
	Object.defineProperty(this, "ontouchend", {
		get: function(){ return this.touchend; },
		set: function(func){ this.addEventListener("touchend", func); this.touchend = func }
	});
	Object.defineProperty(this, "ontouchmove", {
		get: function(){ return this.touchmove; },
		set: function(func){ this.addEventListener("touchmove", func); this.touchmove = func }
	});
	Object.defineProperty(this, "ontouchstart", {
		get: function(){ return this.touchstart; },
		set: function(func){ this.addEventListener("touchstart", func); this.touchstart = func }
	});
	Object.defineProperty(this, "ontransitioncancel", {
		get: function(){ return this.transitioncancel; },
		set: function(func){ this.addEventListener("transitioncancel", func); this.transitioncancel = func }
	});
	Object.defineProperty(this, "ontransitionend", {
		get: function(){ return this.transitionend; },
		set: function(func){ this.addEventListener("transitionend", func); this.transitionend = func }
	});
	Object.defineProperty(this, "onwaiting", {
		get: function(){ return this.waiting; },
		set: function(func){ this.addEventListener("waiting", func); this.waiting = func }
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


/////////////////////////////////
var Navigator = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("Navigator()");
	
	Object.defineProperty(this, "appCodeName",{
		value: "Mozilla",
	});
	Object.defineProperty(this, "appName",{
		value: "Netscape",
	});
	Object.defineProperty(this, "appVersion",{
		value: "5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36", //TODO - pull this value from C++
	});
	Object.defineProperty(this, "cookieEnabled",{
		value: "false",
	});
	Object.defineProperty(this, "language",{
		value: "en-US",
	});
	Object.defineProperty(this, "mimeTypes",{
		value: "",
	});
	Object.defineProperty(this, "onLine",{
		value: true, //TODO - pull this value from C++
	});
	Object.defineProperty(this, "platform",{
		value: "Win32", //TODO - pull this value from C++
	});
	Object.defineProperty(this, "product",{
		value: "Duktape",
	});
	Object.defineProperty(this, "productSub",{
		value: "1", //TODO - pull this value from C++
	});
	Object.defineProperty(this, "userAgent",{
		value: "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36 Rocket/1.0", //TODO - pull this value from C++
	});
	Object.defineProperty(this, "vendor",{
		value: "DigitalKnob.com",
	});
	
	Navigator.prototype.javaEnabled = function(){
		return false;
	}
}


////////////////////////////
var Node = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("Node("+pointer+")");
	
	Object.defineProperty(this, "baseURI",         { get: function(){ return DKRocket_baseURI(this.pointer);         } });  //TODO
	Object.defineProperty(this, "baseURIObject",   { get: function(){ return DKRocket_baseURIObject(this.pointer);   } });  //TODO
	Object.defineProperty(this, "childNodes",      { get: function(){ return DKRocket_childNodes(this.pointer);      } });  //TODO
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

	return Eventtargetet.call(this, pointer);
};


//////////////////////////////
var Screen = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("Screen()");
	
	Object.defineProperty(this, "availTop",      { get: function(){ return DKRocket_availTop(this.pointer);      } });  //TODO
	Object.defineProperty(this, "availLeft",     { get: function(){ return DKRocket_availLeft(this.pointer);     } });  //TODO
	Object.defineProperty(this, "availHeight",   { get: function(){ return DKRocket_availHeight(this.pointer);   } });  //TODO
	Object.defineProperty(this, "availWidth",    { get: function(){ return DKRocket_availWidth(this.pointer);    } });  //TODO
	Object.defineProperty(this, "colorDepth",    { get: function(){ return DKRocket_colorDepth(this.pointer);    } });  //TODO
	Object.defineProperty(this, "height",        { get: function(){ return DKRocket_height(this.pointer);        } });  //TODO
	Object.defineProperty(this, "left",          { get: function(){ return DKRocket_left(this.pointer);          } });  //TODO
	Object.defineProperty(this, "orientation",   { get: function(){ return DKRocket_orientation(this.pointer);   } });  //TODO
	Object.defineProperty(this, "pixelDepth",    { get: function(){ return DKRocket_pixelDepth(this.pointer);    } });  //TODO
	Object.defineProperty(this, "top",           { get: function(){ return DKRocket_top(this.pointer);           } });  //TODO
	Object.defineProperty(this, "width",         { get: function(){ return DKRocket_width(this.pointer);         } });  //TODO
	Object.defineProperty(this, "mozEnabled",    { get: function(){ return DKRocket_mozEnabled(this.pointer);    } });  //TODO
	Object.defineProperty(this, "mozBrightness", { get: function(){ return DKRocket_mozBrightness(this.pointer); } });  //TODO
	
	Screen.prototype.lockOrientation = function(){
		//TODO
	}
	Screen.prototype.unlockOrientation = function(){
		//TODO
	}
	Screen.prototype.unlockOrientation = function(){
		//TODO
	}
	
	return Eventtargetet.call(this, pointer);
}

///////////////////////////////
var Window = function(pointer){
	//DKDEBUGFUNC();
	
	//console = new Console("console");
	document = new Document("document");
	navigator = new Navigator("navigator");
	screen = new Screen("screen");
	
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
	Object.defineProperty(this, "location", { 
		get: function()   { return DKRocket_location();       },
		set: function(val){ return DKRocket_setLocation(val); }
	});  //TODO
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
	
	return Eventtargetet.call(this, pointer);
}


//Global prototypes. Must be in order by dependency
Window.prototype = Eventtargetet.prototype;
Screen.prototype = Eventtargetet.prototype;
Node.prototype = Eventtargetet.prototype;
Element.prototype = Node.prototype;	
Document.prototype = Element.prototype;
HTMLElement.prototype = Element.prototype;
HTMLCollection.prototype = [];
GlobalEventHandlers.prototype = Eventtargetet.prototype;



////// Create Dom /////////
//objectMap = new ObjectMap();
window = new Window("window");