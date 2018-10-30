//https://hackernoon.com/inheritance-in-javascript-21d2b82ffa6f

var window;
var document;
//var location;
//var screen;
var console;

/////////////////////
function DKDom_Init()
{
	DKDEBUGFUNC();
	if(DK_GetBrowser() != "Rocket"){ return; }  //This class is a wrapper for libRocket only
	//DKDom_Create();
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



////////////////////////////////////
var EventTarget = function(pointer){
	//DKDEBUGFUNC();
	//DKWARN("EventTarget("+pointer+")\n");
	this.pointer = pointer;
	this.listeners = {};
};
EventTarget.prototype.listeners = null;
EventTarget.prototype.addEventListener = function(type, callback){
	if(!(type in this.listeners)){
		this.listeners[type] = [];
	}
	this.listeners[type].push(callback);
};
EventTarget.prototype.removeEventListener = function(type, callback){
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
	//DKWARN("Node("+pointer+")\n");
	EventTarget.call(this, pointer);
	
	return new Proxy(this, { 
		has: function(targ, key){
			return key in targ;
		},
		get: function(targ, key, recv){
			//DKINFO("Node:get("+targ+","+key+")\n");
			if(typeof targ[key] === "function" || typeof key === "symbol" || key == "pointer" || key == "style"){ return targ[key]; }
			if(key == "innerHTML"){
				targ[key] = DKRocket_innerHTML(targ["pointer"], key); 
			}
			else if(key == "parentNode"){
				var parentNode = DKRocket_parentNode(targ["pointer"], key);
				targ[key] = new Node(parentNode);
			}
			else{
				//DKWARN("targ['pointer']: "+targ["pointer"]+"\n");
				if(targ["pointer"]){
					targ[key] = DKRocket_getAttribute(targ["pointer"], key); 
				}
			}
			return targ[key];
		},
		set: function(targ, key, val, recv){
			//DKINFO("Node:set("+targ+","+key+","+val+")\n");
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
	//DKWARN("Element("+pointer+")\n");
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
	//DKWARN("HTMLElement("+pointer+")\n");
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
	//DKWARN("CSSStyleDeclaration("+pointer+")\n");
	this.pointer = pointer;
	
	return new Proxy(this, {
		has: function (targ, key){
			return key in targ;
		},
		get: function (targ, key, recv){
			//DKINFO("Style:get("+targ+","+key+")\n");
			if(typeof targ[key] === "function" || key == "pointer"){ return targ[key]; }
			if(key == "backgroundColor"){ targ[key] = DKRocket_getPropertyValue(targ["pointer"], "background-color"); }
			else{ targ[key] = DKRocket_getPropertyValue(targ["pointer"], key); }
			return targ[key];
		},
		set: function (targ, key, val, recv){
			//DKINFO("Style:set("+targ+","+key+","+val+")\n");
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
	//DKWARN("Document("+pointer+")\n");
	this.body = this.getElementsByTagName("body")[0];
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

	
////////////////////////
var Window = function(){
	//DKDEBUGFUNC();
	//DKWARN("Window()\n");
	document = new Document();
	this.document = document;

	return new Proxy(this, { // Wrap it behind a proxy
		has: function (targ, key) {
			return key in targ;  // return unmodified existence status
		},
		get: function(targ, key, recv){
			//DKINFO("Window:get("+targ+","+key+")\n");
			if(key == "innerHeight"){ targ[key] = DKRocket_innerHeight(); }
			if(key == "innerWidth"){ targ[key] = DKRocket_innerWidth(); }
			if(key == "name"){ targ[key] = DKRocket_name(); }
			return targ[key];  // return unmodified value
		},
		set: function(targ, key, val, recv){
			//DKINFO("Window:get("+targ+","+key+","+val+")\n");
			//if(key == "innerHeight"){ DKRocket_SetInnerHeight(val); }  //TODO
			//if(key == "innerWidth"){ DKRocket_SetInnerWidth(val); }    //TODO
			//if(key == "name"){ DKRocket_SetName(val); }    //TODO
			targ[key] = val;  // must perform write to target manually if 'set' defined
			return true;      // true: indicate that property write was allowed
		},
			deleteProperty: function (targ, key) {
			delete targ[key];  // must perform delete to target manually if 'deleteProperty' defined
			return true;       // true: indicate that property delete was allowed
		}
	});
}
Window.prototype.alert = function(msg){
	DKINFO("alert: "+msg+'\n');
}


/////////////////////////
var Console = function(){
	//DKDEBUGFUNC();
	//DKWARN("Console()\n");
	
}
Console.prototype.assert = function(assertion, msg){
	if(assertion){ return; }
	DKERROR(msg+"\n");
}
Console.prototype.clear = function(){
	DK_System("cls");
}
Console.prototype.debug = function(msg){
	DKDEBUG(msg+"\n");
}
Console.prototype.error = function(msg){
	DKERROR(msg+"\n");
}
Console.prototype.exception = Console.prototype.error; //alias
Console.prototype.info = function(msg){
	DKINFO(msg+"\n");
}
Console.prototype.log = function(msg){
	DKINFO(msg+"\n");
}
Console.prototype.trace = function(){
	DKERROR("console.trace() not implemented\n");
}
Console.prototype.warn = function(msg){
		DKWARN(msg+"\n");
}

//////////////////////	
window = new Window();
console = new Console();