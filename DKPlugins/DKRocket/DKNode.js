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
Node.prototype = EventTarget.prototype;