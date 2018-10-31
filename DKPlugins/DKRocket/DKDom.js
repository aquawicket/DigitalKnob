//https://hackernoon.com/inheritance-in-javascript-21d2b82ffa6f

var console;
var document;
//var location;
var navigator;
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
	
	/*
	Object.defineProperty(this, "background-color", { 
		get: function(){ return DKRocket_getPropertyValue(this.pointer, "background-color"); },
		set: function(val){ return DKRocket_setProperty(this.pointer, "background-color", val); }
	});
	Object.defineProperty(this, "backgroundColor", { 
		get: function(){ return DKRocket_getPropertyValue(this.pointer, "background-color"); },
		set: function(val){ return DKRocket_setProperty(this.pointer, "background-color", val); }
	});
	Object.defineProperty(this, "border-width", { 
		get: function(){ return DKRocket_getPropertyValue(this.pointer, "border-width"); },
		set: function(val){ return DKRocket_setProperty(this.pointer, "border-width", val); }
	});
	Object.defineProperty(this, "borderWidth", { 
		get: function(){ return DKRocket_getPropertyValue(this.pointer, "border-width"); },
		set: function(val){ return DKRocket_setProperty(this.pointer, "border-width", val); }
	});
	Object.defineProperty(this, "color", { 
		get: function(){ return DKRocket_getPropertyValue(this.pointer, "color"); },
		set: function(val){ return DKRocket_setProperty(this.pointer, "color", val); }
	});
	Object.defineProperty(this, "height", { 
		get: function(){ return DKRocket_getPropertyValue(this.pointer, "height"); },
		set: function(val){ return DKRocket_setProperty(this.pointer, "height", val); }
	});
	Object.defineProperty(this, "left", { 
		get: function(){ return DKRocket_getPropertyValue(this.pointer, "left"); },
		set: function(val){ return DKRocket_setProperty(this.pointer, "left", val); }
	});
	Object.defineProperty(this, "margin", { 
		get: function(){ return DKRocket_getPropertyValue(this.pointer, "margin"); },
		set: function(val){ return DKRocket_setProperty(this.pointer, "margin", val); }
	});
	Object.defineProperty(this, "overflow", { 
		get: function(){ return DKRocket_getPropertyValue(this.pointer, "overflow"); },
		set: function(val){ return DKRocket_setProperty(this.pointer, "overflow", val); }
	});
	Object.defineProperty(this, "position", { 
		get: function(){ return DKRocket_getPropertyValue(this.pointer, "position"); },
		set: function(val){ return DKRocket_setProperty(this.pointer, "position", val); }
	});
	Object.defineProperty(this, "top", { 
		get: function(){ return DKRocket_getPropertyValue(this.pointer, "top"); },
		set: function(val){ return DKRocket_setProperty(this.pointer, "top", val); }
	});
	Object.defineProperty(this, "width", { 
		get: function(){ return DKRocket_getPropertyValue(this.pointer, "width"); },
		set: function(val){ return DKRocket_setProperty(this.pointer, "width", val); }
	});
	*/
	
	return new Proxy(this, {
		has: function (targ, key){
			return key in targ;
		},
		get: function (targ, key, recv){
			//console.log("Style:get("+targ+","+key+")");
			if(typeof targ[key] === "function" || key == "pointer"){ return targ[key]; }
			var realKey = key;
			
			//Replace characters ( C ) with ( -c )    I.E.  backgroundColor becomes background-color
			for(var i=0; i < realKey.length; i++){
				if(realKey.charAt(i) == realKey.charAt(i).toUpperCase()){ //is uppercase?
					if(realKey.charAt(i) == "-"){ continue; }
					realKey = realKey.substr(0, i)+"-"+realKey.charAt(i).toLowerCase()+realKey.substr(i+1, realKey.length);
				}
			}

			targ[key] = DKRocket_getPropertyValue(targ["pointer"], realKey);
			return targ[key];
		},
		set: function (targ, key, val, recv){
			//console.log("Style:set("+targ+","+key+","+val+")");
			if(typeof targ[key] === "function" || key == "pointer"){ return true; }
			var realKey = key;
			
			
			//Replace characters ( C ) with ( -c )    I.E.  backgroundColor becomes background-color
			for(var i=0; i < realKey.length; i++){
				if(realKey.charAt(i) == realKey.charAt(i).toUpperCase()){ //is uppercase?
					if(realKey.charAt(i) == "-"){ continue; }
					realKey = realKey.substr(0, i)+"-"+realKey.charAt(i).toLowerCase()+realKey.substr(i+1, realKey.length);
				}
			}
			
			DKRocket_setProperty(targ["pointer"], realKey, val);
			targ[key] = val;
			return true;
		},
		deleteProperty: function (targ, key){
			delete targ[key];
			return true;
		}
	});
}


////////////////////////////////
var Document = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("Document("+pointer+")");

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
	
	this.body = this.getElementsByTagName("body")[0];
	this.documentElement = this.getElementsByTagName("html")[0];

	return Node.call(this, pointer);
}


///////////////////////////////
var Element = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("Element("+pointer+")");
	
	Object.defineProperty(this, "clientWidth",  { get: function(){ return DKRocket_clientWidth(this.pointer);  } });
	Object.defineProperty(this, "clientHeight", { get: function(){ return DKRocket_clientHeight(this.pointer); } });
	Object.defineProperty(this, "clientTop",    { get: function(){ return DKRocket_clientTop(this.pointer);    } });
	Object.defineProperty(this, "clientLeft",   { get: function(){ return DKRocket_clientLeft(this.pointer);   } });
	Object.defineProperty(this, "innerHTML", { 
		get: function()   { return DKRocket_innerHTML(this.pointer);         },
		set: function(val){ return DKRocket_setInnerHTML(this.pointer, val); }
	});
	
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
	
	return Node.call(this, pointer);
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
var EventTarget = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("EventTarget("+pointer+")");
	
	this.pointer = pointer;
	this.listeners = {};
	
	EventTarget.prototype.listeners = null;
	EventTarget.prototype.addEventListener = function(type, callback, useCapture){
		
		
		//TODO - make this shorter
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
};


///////////////////////////////
var HTMLCollection = function()
{
	//DKDEBUGFUNC();
	console.warn("HTMLCollection()");
	
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
	
	this.style = new CSSStyleDeclaration(pointer);
	
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

	return EventTarget.call(this, pointer);
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
	
	return EventTarget.call(this, pointer);
}

///////////////////////////////
var Window = function(pointer){
	//DKDEBUGFUNC();
	
	console = new Console("console");
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
	
	return EventTarget.call(this, pointer);
}


//Global prototypes. Must be in order by dependency
Window.prototype = EventTarget.prototype;
Screen.prototype = EventTarget.prototype;
Node.prototype = EventTarget.prototype;
Document.prototype = Node.prototype;
Element.prototype = Node.prototype;	
HTMLElement.prototype = Element.prototype;
HTMLCollection.prototype = [];



////// Create Dom /////////
window = new Window("window");