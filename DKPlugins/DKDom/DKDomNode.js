//https://developer.mozilla.org/en-US/docs/Web/API/Node

////////////////////////////
var Node = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("Node("+pointer+")");
	//this.pointer = pointer;
	
	Object.defineProperty(this, "baseURI",         { get: function(){ return DKDomNode_baseURI(this.pointer);         } });  //TODO
	Object.defineProperty(this, "baseURIObject",   { get: function(){ return DKDomNode_baseURIObject(this.pointer);   } });  //TODO
	Object.defineProperty(this, "childNodes",      { 
		get: function(){
			var addressList = DKDomNode_childNodes(this.pointer);
			var htmlCollection = new HTMLCollection();   //TODO - switch htmlCollection over to NodeList
			if(!addressList){ return htmlCollection; }
			var arry = addressList.split(",");
			for(var i=0; i<arry.length; i++){
				htmlCollection.push(new HTMLElement(arry[i]))
			}
			return htmlCollection;	
		} 
	});  //TODO
	Object.defineProperty(this, "firstChild",      { get: function(){ return DKDomNode_firstChild(this.pointer);      } });  //TODO
	Object.defineProperty(this, "isConnected",     { get: function(){ return DKDomNode_isConnected(this.pointer);     } });  //TODO
	Object.defineProperty(this, "lastChild",       { get: function(){ return DKDomNode_lastChild(this.pointer);       } });  //TODO
	Object.defineProperty(this, "nextSibling",     { get: function(){ return DKDomNode_nextSibling(this.pointer);     } });  //TODO
	Object.defineProperty(this, "nodeName",        { get: function(){ return DKDomNode_nodeName(this.pointer);        } });  //TODO
	Object.defineProperty(this, "nodePrincipal",   { get: function(){ return DKDomNode_nodePrincipal(this.pointer);   } });  //TODO
	Object.defineProperty(this, "nodeType",        { get: function(){ return DKDomNode_nodeType(this.pointer);        } });  //TODO
	Object.defineProperty(this, "nodeValue", { 
		get: function()   { return DKDomNode_nodeValue(this.pointer);         },
		set: function(val){ return DKDomNode_nodeValue(this.pointer, val); }
	});  //TODO
	Object.defineProperty(this, "ownerDocument",   { get: function(){ return DKDomNode_ownerDocument(this.pointer);   } });  //TODO
	Object.defineProperty(this, "parentNode",      { get: function(){ return DKDomNode_parentNode(this.pointer);      } });
	Object.defineProperty(this, "parentElement",   { get: function(){ return DKDomNode_parentElement(this.pointer);   } });  //TODO
	Object.defineProperty(this, "previousSibling", { get: function(){ return DKDomNode_previousSibling(this.pointer); } });  //TODO
	Object.defineProperty(this, "textContent", { 
		get: function()   { return DKDomNode_textContent(this.pointer);         },
		set: function(val){ return DKDomNode_textContent(this.pointer, val); }
	});  //TODO
	Object.defineProperty(this, "rootNode ",       { get: function(){ return DKDomNode_rootNode (this.pointer);       } });  //Deprecated
	
	Node.prototype.appendChild = function(aChild){
		var pointer = DKDomNode_appendChild(this.pointer, aChild.pointer);
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
		console.log("Node.removeChild("+this.pointer+","+aChild.pointer+")");
		var pointer = DKDomNode_removeChild(this.pointer, aChild.pointer);
		if(!pointer){ return null; }
		//var node = new Node(pointer);
		//return node;
	}
	Node.prototype.replaceChild = function(){
		//TODO
	}

	return EventTarget.call(this, pointer);
};
Node.prototype = EventTarget.prototype;