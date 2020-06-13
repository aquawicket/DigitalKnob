//https://developer.mozilla.org/en-US/docs/Web/API/Node

////////////////////////////
var Node = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("Node("+pointer+")");
	//this.pointer = pointer;
	
	Object.defineProperty(this, "baseURI", { 
		configurable: true,
		get: function(){ return DKDomNode_baseURI(this.pointer); }
	});
	Object.defineProperty(this, "baseURIObject", { 
		configurable: true,
		get: function(){ return DKDomNode_baseURIObject(this.pointer); }
	});
	Object.defineProperty(this, "childNodes", { 
		configurable: true,
		get: function(){
			var addressList = DKDomNode_childNodes(this.pointer);
			var htmlCollection = HTMLCollection();   //TODO - switch htmlCollection over to NodeList
			if(!addressList){ return htmlCollection; }
			var arry = addressList.split(",");
			for(var i=0; i<arry.length; i++){
				htmlCollection.push(HTMLElement(arry[i]))
			}
			return htmlCollection;	
		} 
	});
	Object.defineProperty(this, "firstChild", { 
		configurable: true,
		get: function(){ return DKDomNode_firstChild(this.pointer); } 
	});
	Object.defineProperty(this, "isConnected", { 
		configurable: true,
		get: function(){ return DKDomNode_isConnected(this.pointer); } 
	});
	Object.defineProperty(this, "lastChild", { 
		configurable: true,
		get: function(){ 
			var pointer = DKDomNode_lastChild(this.pointer);
			if(!pointer){ return; }
			var element = HTMLElement(pointer);
			return element;	
		} 
	});
	Object.defineProperty(this, "nextSibling", { 
		configurable: true,
		get: function(){ return DKDomNode_nextSibling(this.pointer); }
	});
	Object.defineProperty(this, "nodeName", { 
		configurable: true,
		get: function(){ return DKDomNode_nodeName(this.pointer); } 
	});
	Object.defineProperty(this, "nodePrincipal", { 
		configurable: true,
		get: function(){ return DKDomNode_nodePrincipal(this.pointer); } 
	});
	Object.defineProperty(this, "nodeType", { 
		configurable: true,
		get: function(){ return DKDomNode_nodeType(this.pointer); } 
	});
	Object.defineProperty(this, "nodeValue", { 
		configurable: true,
		get: function(){ return DKDomNode_nodeValue(this.pointer); },
		set: function(val){ return DKDomNode_nodeValue(this.pointer, val); }
	});
	Object.defineProperty(this, "ownerDocument", { 
		configurable: true,
		get: function(){ return DKDomNode_ownerDocument(this.pointer); } 
	});
	Object.defineProperty(this, "parentNode", { 
		configurable: true,
		get: function(){ 
			var pointer = DKDomNode_parentNode(this.pointer); 
			if(!pointer){ return; }
			var element = HTMLElement(pointer);
			return element;			
		} 
	});
	Object.defineProperty(this, "parentElement", { 
		configurable: true,
		get: function(){ return DKDomNode_parentElement(this.pointer); } 
	});
	Object.defineProperty(this, "previousSibling", { 
		configurable: true,
		get: function(){ return DKDomNode_previousSibling(this.pointer); } 
	});
	Object.defineProperty(this, "textContent", { 
		configurable: true,
		get: function(){ return DKDomNode_textContent(this.pointer); },
		set: function(val){ return DKDomNode_textContent(this.pointer, val); }
	});
	Object.defineProperty(this, "rootNode", { //Deprecated
		configurable: true,
		get: function(){ return DKDomNode_rootNode (this.pointer); } 
	}); 
	
	Node.prototype.appendChild = function(aChild){
		var pointer = DKDomNode_appendChild(this.pointer, aChild.pointer);
		if(!pointer){ return; }
		var element = HTMLElement(pointer);
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
		console.log("Node.removeChild("+this.pointer+","+aChild.pointer+")");
		var pointer = DKDomNode_removeChild(this.pointer, aChild.pointer);
		if(!pointer){ return null; }
		//var node = Node(pointer);
		//return node;
	}
	Node.prototype.replaceChild = function(){
		//TODO
	}

	return EventTarget.call(this, pointer);
};
Node.prototype = EventTarget.prototype;