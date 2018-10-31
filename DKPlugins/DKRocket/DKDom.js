//https://hackernoon.com/inheritance-in-javascript-21d2b82ffa6f

var window;
var document;
var navigator;
//var location;
//var screen;
var console;
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

////////////////////////////////////////
function EventFromRocket(pointer, event)
{
	for(var i=0; i<stored_events.length; i++){
		if(pointer == stored_events[i].pointer){
			stored_events[i].dispatchEvent(event);
		}
	}
}

////////////////////////////////////
var EventTarget = function(pointer){
	//DKDEBUGFUNC();
	//console.warn("EventTarget("+pointer+")");
	this.pointer = pointer;
	this.listeners = {};
};
EventTarget.prototype.listeners = null;
EventTarget.prototype.addEventListener = function(type, callback, useCapture){
	var already_has = false;
	for(var i=0; i < stored_events.length; i++){
        if(stored_events[i] === this){
			already_has = true;
        }
    }
	if(!already_has){
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
EventTarget.prototype.removeEventListener = function(type, callback, useCapture){
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
EventTarget.prototype.dispatchEvent = function(event){
	if(!(event.type in this.listeners)){
		return true;
	}
	var stack = this.listeners[event.type].slice();
	for (var i = 0, l = stack.length; i < l; i++){
		stack[i].call(this, event);
	}
	return !event.defaultPrevented;
};
	
	
/////////////////////////////
var Node = function(pointer){
	//DKDEBUGFUNC();
	//console.warn("Node("+pointer+")");
	EventTarget.call(this, pointer);
	
	return new Proxy(this, { 
		has: function(targ, key){
			return key in targ;
		},
		get: function(targ, key, recv){
			//console.log("Node:get("+targ+","+key+")");
			if(typeof targ[key] === "function" || typeof key === "symbol" || key == "pointer" || key == "style" || key == "listeners"){ return targ[key]; }
			if(key == "innerHTML"){
				targ[key] = DKRocket_innerHTML(targ["pointer"], key); 
			}
			else if(key == "parentNode"){
				var parentNode = DKRocket_parentNode(targ["pointer"], key);
				targ[key] = new Node(parentNode);
			}
			else{
				//console.warn("targ['pointer']: "+targ["pointer"]);
				if(targ["pointer"]){
					targ[key] = DKRocket_getAttribute(targ["pointer"], key); 
				}
			}
			return targ[key];
		},
		set: function(targ, key, val, recv){
			//console.log("Node:set("+targ+","+key+","+val+")");
			if(typeof targ[key] === "function" || typeof key === "symbol" || key == "pointer" || key == "style"){ return true; }
			if(key == "innerHTML"){
				DKRocket_setInnerHTML(targ["pointer"], val);
			}
			else{
				DKRocket_setAttribute(targ["pointer"], key, val);
			}
			targ[key] = val;
			return true;
		},
		deleteProperty: function(targ, key){
			delete targ[key];
			return true;
		}
	});
};
Node.prototype = EventTarget.prototype;
Node.prototype.appendChild = function(aChild){
	var pointer = DKRocket_appendChild(this.pointer, aChild.pointer);
	if(!pointer){ return; }
	var element = new Node(pointer);
	return element;
}
Node.prototype.removeChild = function(aChild){
	var pointer = DKRocket_removeChild(this.pointer, aChild.pointer);
	if(!pointer){ return null; }
	var node = new Node(pointer);
	return node;
}

	
////////////////////////////////
var Element = function(pointer){
	//DKDEBUGFUNC();
	//console.warn("Element("+pointer+")");
	return Node.call(this, pointer);
}
Element.prototype = Node.prototype;
Element.prototype.hasAttribute = function(attribute){
	if(DKRocket_hasAttribute(this.pointer, attribute)){ return true; }
	else{ return false; }
}
Element.prototype.getAttribute = function(attribute){
	this[attribute] = DKRocket_getAttribute(this.pointer, attribute);
	if(!this[attribute]){ return null; }
	return this[attribute];
}
Element.prototype.setAttribute = function(attribute, value){
	DKRocket_setAttribute(this.pointer, attribute, value);
	this[attribute] = value;
}
	

////////////////////////////////////
var HTMLElement = function(pointer){
	//DKDEBUGFUNC();
	//console.warn("HTMLElement("+pointer+")");
	this.style = new CSSStyleDeclaration(pointer);
	return Element.call(this, pointer);
}
HTMLElement.prototype = Element.prototype;


/////////////////////////////////
var HTMLCollection = function(){}
HTMLCollection.prototype = [];
HTMLCollection.prototype.item = function(index){
	return this[index];
}
	


////////////////////////////////////////////
var CSSStyleDeclaration = function(pointer){
	//DKDEBUGFUNC();
	//console.warn("CSSStyleDeclaration("+pointer+")");
	this.pointer = pointer;
	
	return new Proxy(this, {
		has: function (targ, key){
			return key in targ;
		},
		get: function (targ, key, recv){
			//console.log("Style:get("+targ+","+key+")");
			if(typeof targ[key] === "function" || key == "pointer"){ return targ[key]; }
			if(key == "backgroundColor"){ targ[key] = DKRocket_getPropertyValue(targ["pointer"], "background-color"); }
			else{ targ[key] = DKRocket_getPropertyValue(targ["pointer"], key); }
			return targ[key];
		},
		set: function (targ, key, val, recv){
			//console.log("Style:set("+targ+","+key+","+val+")");
			if(typeof targ[key] === "function" || key == "pointer"){ return true; }
			if(key == "backgroundColor"){ DKRocket_setProperty(targ["pointer"], "background-color", val); }
			else{ DKRocket_setProperty(targ["pointer"], key, val); }
			targ[key] = val;
			return true;
		},
		deleteProperty: function (targ, key){
			delete targ[key];
			return true;
		}
	});
}
CSSStyleDeclaration.prototype.setProperty = function(propertyName, propertyValue, priority){
	DKRocket_setProperty(this.pointer, propertyName, propertyValue);
	this[propertyName] = propertyValue;
}
CSSStyleDeclaration.prototype.getPropertyValue = function(propertyName){
	this[propertyName] = DKRocket_getPropertyValue(this.pointer, propertyName);
	return this[propertyName];
}
	
	
/////////////////////////////////
var Document = function(pointer){
	//DKDEBUGFUNC();
	//console.warn("Document("+pointer+")");
	this.body = this.getElementsByTagName("body")[0];
	this.documentElement = this.getElementsByTagName("html")[0];
	return Node.call(this, pointer);
}
Document.prototype = Node.prototype;
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
Document.prototype.getElementsByClassName = function(name){
	var addressList = DKRocket_getElementsByTagName(name);
	var htmlCollection = new HTMLCollection();
	if(!addressList){ return htmlCollection; }
	var arry = addressList.split(",");
	for(var i=0; i<arry.length; i++){
		htmlCollection.push(new HTMLElement(arry[i]))
	}
	return htmlCollection;
}
Document.prototype.getElementsByTagName = function(name){
	var addressList = DKRocket_getElementsByTagName(name);
	var htmlCollection = new HTMLCollection();
	if(!addressList){ return htmlCollection; }
	var arry = addressList.split(",");
	for(var i=0; i<arry.length; i++){
		htmlCollection.push(new HTMLElement(arry[i]))
	}
	return htmlCollection;
}

	
///////////////////////////////
var Window = function(pointer){
	//DKDEBUGFUNC();
	//console.warn("Window()");
	console = new Console();
	this.console = console;
	EventTarget.call(this, pointer);
	document = new Document();
	this.document = document;
	navigator = new Navigator();
	this.navigator = navigator;
	
	return new Proxy(this, { // Wrap it behind a proxy
		has: function (targ, key) {
			return key in targ;  // return unmodified existence status
		},
		get: function(targ, key, recv){
			//console.log("Window:get("+targ+","+key+")");
			if(key == "innerHeight"){ targ[key] = DKRocket_innerHeight(); }
			if(key == "innerWidth"){ targ[key] = DKRocket_innerWidth(); }
			if(key == "name"){ targ[key] = DKRocket_name(); }
			return targ[key];  // return unmodified value
		},
		set: function(targ, key, val, recv){
			//console.log("Window:get("+targ+","+key+","+val+")");
			//if(key == "innerHeight"){ DKRocket_SetInnerHeight(val); }  //TODO
			//if(key == "innerWidth"){ DKRocket_SetInnerWidth(val); }    //TODO
			//if(key == "name"){ DKRocket_SetName(val); }    //TODO
			targ[key] = val;
			return true;
		},
		deleteProperty: function(targ, key){
			delete targ[key];
			return true;
		}
	});
}
Window.prototype = EventTarget.prototype;
Window.prototype.alert = function(msg){
	console.warn("alert: "+msg);
}


///////////////////////////
var Navigator = function(){
	//DKDEBUGFUNC();
	//console.warn("Navigator()");
	Object.defineProperty(this, "appCodeName",{
		value: "Mozilla",
		writable: false
	});
	Object.defineProperty(this, "appName",{
		value: "Netscape",
		writable: false
	});
	Object.defineProperty(this, "appVersion",{
		value: "5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36",
		writable: false
	});
	Object.defineProperty(this, "cookieEnabled",{
		value: "false",
		writable: false
	});
	Object.defineProperty(this, "language",{
		value: "en-US",
		writable: false
	});
	Object.defineProperty(this, "mimeTypes",{
		value: "",
		writable: false
	});
	Object.defineProperty(this, "onLine",{
		value: true, //TODO - pull this value from C++
		writable: false
	});
	Object.defineProperty(this, "platform",{
		value: "Win32", //TODO - pull this value from C++
		writable: false
	});
	Object.defineProperty(this, "product",{
		value: "Duktape",
		writable: false
	});
	Object.defineProperty(this, "productSub",{
		value: "1", //TODO - pull this value from C++
		writable: false
	});
	Object.defineProperty(this, "userAgent",{
		value: "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36 Rocket/1.0",
		writable: false
	});
	Object.defineProperty(this, "vendor",{
		value: "DigitalKnob.com",
		writable: false
	});
	
	Navigator.prototype.javaEnabled = function(){
		return false;
	}
}


/////////////////////////
var Console = function(){
	//DKDEBUGFUNC();
	//console.warn("Console()");
	
}
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


////// Create Dom /////////
window = new Window("window");
