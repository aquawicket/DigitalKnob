//https://developer.mozilla.org/en-US/docs/Web/API/Node


////////////////////////////
var Node = function(pointer)
{
	Object.defineProperty(this, "baseURI", {
		get: function(){ return DKCPP_DKDomNode_baseURI(this.pointer); }
	});
	Object.defineProperty(this, "baseURIObject", { 
		get: function(){ return DKCPP_DKDomNode_baseURIObject(this.pointer); }
	});
	Object.defineProperty(this, "childNodes", { 
		get: function(){
			var addressList = DKCPP_DKDomNode_childNodes(pointer);
			return new HTMLCollection(addressList);   //TODO - switch htmlCollection over to NodeList	
		} 
	});
	Object.defineProperty(this, "firstChild", {
		get: function(){ 
			var address = DKCPP_DKDomNode_firstChild(this.pointer);
			if(!address){ return; }
			return new HTMLElement(address);	
		}
	});
	Object.defineProperty(this, "isConnected", {
		get: function(){ return DKCPP_DKDomNode_isConnected(this.pointer); } 
	});
	Object.defineProperty(this, "lastChild", {
		get: function(){ 
			var address = DKCPP_DKDomNode_lastChild(this.pointer);
			if(!address){ return; }
			return new HTMLElement(address);	
		} 
	});
	Object.defineProperty(this, "nextSibling", {
		get: function(){ return DKCPP_DKDomNode_nextSibling(this.pointer); }
	});
	Object.defineProperty(this, "nodeName", {
		get: function(){ return DKCPP_DKDomNode_nodeName(this.pointer); } 
	});
	Object.defineProperty(this, "nodePrincipal", {
		get: function(){ return DKCPP_DKDomNode_nodePrincipal(this.pointer); } 
	});
	Object.defineProperty(this, "nodeType", {
		get: function(){ return DKCPP_DKDomNode_nodeType(this.pointer); } 
	});
	Object.defineProperty(this, "nodeValue", {
		get: function(){ return DKCPP_DKDomNode_nodeValue(this.pointer); },
		set: function(val){ return DKCPP_DKDomNode_nodeValue(this.pointer, val); }
	});
	Object.defineProperty(this, "ownerDocument", {
		get: function(){ return DKCPP_DKDomNode_ownerDocument(this.pointer); } 
	});
	Object.defineProperty(this, "parentNode", {
		get: function(){ 
			var address = DKCPP_DKDomNode_parentNode(this.pointer); 
			if(!address){ return; }
			return new HTMLElement(address);		
		} 
	});
	Object.defineProperty(this, "parentElement", {
		get: function(){ return DKCPP_DKDomNode_parentElement(this.pointer); } 
	});
	Object.defineProperty(this, "previousSibling", {
		get: function(){ return DKCPP_DKDomNode_previousSibling(this.pointer); } 
	});
	Object.defineProperty(this, "textContent", {
		get: function(){ return DKCPP_DKDomNode_textContent(this.pointer); },
		set: function(val){ return DKCPP_DKDomNode_textContent(this.pointer, val); }
	});
	Object.defineProperty(this, "rootNode", { //Deprecated
		get: function(){ return DKCPP_DKDomNode_rootNode (this.pointer); } 
	}); 
	
	
	// Methods
	Node.prototype.appendChild = function(child){
		var address = DKCPP_DKDomNode_appendChild(this.pointer, child.pointer);
		if(!address){ return; }
		return new HTMLElement(address);
	}
	Node.prototype.cloneNode = function(){
		//TODO
	}
	Node.prototype.compareDocumentPosition = function(){
		//TODO
	}
	Node.prototype.contains = function(node){
		var contains = DKCPP_DKDomNode_contains(this.pointer, node.pointer);
		return contains;
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
	Node.prototype.removeChild = function(child){
		var address = DKCPP_DKDomNode_removeChild(this.pointer, child.pointer);
		if(!address){ return null; }
		//var node = Node(pointer);
		//return node;
	}
	Node.prototype.replaceChild = function(){
		//TODO
	}

	return EventTarget.call(this, pointer);
};
Node.prototype = EventTarget.prototype;