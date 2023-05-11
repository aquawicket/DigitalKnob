// [IDL] https://dom.spec.whatwg.org/#interface-node
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Node


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=Window]
// interface Node : EventTarget {
var Node = function Node(address) {
	//console.log("Node("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKNodeDUK();
	
	
	// const unsigned short ELEMENT_NODE = 1;
	// const unsigned short ATTRIBUTE_NODE = 2;
	// const unsigned short TEXT_NODE = 3;
	// const unsigned short CDATA_SECTION_NODE = 4;
	// const unsigned short ENTITY_REFERENCE_NODE = 5; // legacy
	// const unsigned short ENTITY_NODE = 6; // legacy
	// const unsigned short PROCESSING_INSTRUCTION_NODE = 7;
	// const unsigned short COMMENT_NODE = 8;
	// const unsigned short DOCUMENT_NODE = 9;
	// const unsigned short DOCUMENT_TYPE_NODE = 10;
	// const unsigned short DOCUMENT_FRAGMENT_NODE = 11;
	// const unsigned short NOTATION_NODE = 12; // legacy
		
	
	// readonly attribute unsigned short nodeType;
	Object.defineProperty(this, "nodeType", {
        get: function nodeType()				{ return CPP_DKDocumentDUK_nodeType(this.address) },
		//set: function nodeType(data)			{ return CPP_DKDocumentDUK_nodeType(this.address, data) },
    })
	
	// readonly attribute DOMString nodeName;
	Object.defineProperty(this, "nodeName", {
        get: function nodeName()				{ return CPP_DKDocumentDUK_nodeName(this.address) },
		//set: function nodeName(data)			{ return CPP_DKDocumentDUK_nodeName(this.address, data) },
    })
	
	// readonly attribute USVString baseURI;
	Object.defineProperty(this, "baseURI", {
        get: function baseURI()					{ return CPP_DKDocumentDUK_baseURI(this.address) },
		//set: function baseURI(data)			{ return CPP_DKDocumentDUK_baseURI(this.address, data) },
    })
	
	// readonly attribute boolean isConnected;
	Object.defineProperty(this, "isConnected", {
        get: function isConnected()				{ return CPP_DKDocumentDUK_isConnected(this.address) },
		//set: function isConnected(data)		{ return CPP_DKDocumentDUK_isConnected(this.address, data) },
    })
	
	// readonly attribute Document? ownerDocument;
	Object.defineProperty(this, "ownerDocument", {
        get: function ownerDocument()			{ return CPP_DKDocumentDUK_ownerDocument(this.address) },
		//set: function ownerDocument(data)		{ return CPP_DKDocumentDUK_ownerDocument(this.address, data) },
    })
	
	// Node getRootNode(optional GetRootNodeOptions options = {});
	// TODO
	
	// readonly attribute Node? parentNode;
	Object.defineProperty(this, "parentNode", {
        get: function parentNode()				{ return CPP_DKDocumentDUK_parentNode(this.address) },
		//set: function parentNode(data)		{ return CPP_DKDocumentDUK_parentNode(this.address, data) },
    })
	
	// readonly attribute Element? parentElement;
	Object.defineProperty(this, "parentElement", {
        get: function parentElement()			{ return CPP_DKDocumentDUK_parentElement(this.address) },
		//set: function parentElement(data)		{ return CPP_DKDocumentDUK_parentElement(this.address, data) },
    })
	
	// boolean hasChildNodes();
	// TODO
	
	// [SameObject] readonly attribute NodeList childNodes;
	Object.defineProperty(this, "childNodes", {
        get: function childNodes()				{ return CPP_DKDocumentDUK_childNodes(this.address) },
		//set: function childNodes(data)		{ return CPP_DKDocumentDUK_childNodes(this.address, data) },
    })
	
	// readonly attribute Node? firstChild;
	Object.defineProperty(this, "firstChild", {
        get: function firstChild()				{ return CPP_DKDocumentDUK_firstChild(this.address) },
		//set: function firstChild(data)		{ return CPP_DKDocumentDUK_firstChild(this.address, data) },
    })
	
	// readonly attribute Node? lastChild;
	Object.defineProperty(this, "lastChild", {
        get: function lastChild()				{ return CPP_DKDocumentDUK_lastChild(this.address) },
		//set: function lastChild(data)			{ return CPP_DKDocumentDUK_lastChild(this.address, data) },
    })
	
	// readonly attribute Node? previousSibling;
	Object.defineProperty(this, "previousSibling", {
        get: function previousSibling()			{ return CPP_DKDocumentDUK_previousSibling(this.address) },
		//set: function previousSibling(data)	{ return CPP_DKDocumentDUK_previousSibling(this.address, data) },
    })
	
	// readonly attribute Node? nextSibling;
	Object.defineProperty(this, "nextSibling", {
        get: function nextSibling()				{ return CPP_DKDocumentDUK_nextSibling(this.address) },
		//set: function nextSibling(data)		{ return CPP_DKDocumentDUK_nextSibling(this.address, data) },
    })
	
	// [CEReactions] attribute DOMString? nodeValue;
	Object.defineProperty(this, "nodeValue", {
        get: function nodeValue()				{ return CPP_DKDocumentDUK_nodeValue(this.address) },
		set: function nodeValue(data)			{ return CPP_DKDocumentDUK_nodeValue(this.address, data) },
    })
	
	// [CEReactions] attribute DOMString? textContent;
	Object.defineProperty(this, "textContent", {
        get: function textContent()				{ return CPP_DKDocumentDUK_textContent(this.address) },
		set: function textContent(data)			{ return CPP_DKDocumentDUK_textContent(this.address, data) },
    })
	
	// [CEReactions] undefined normalize();
	Node.prototype.normalize = function normalize() {
		CPP_DKNodeDUK_normalize(this.address);
    }
	
	// [CEReactions, NewObject] Node cloneNode(optional boolean deep = false);
	Node.prototype.cloneNode = function cloneNode(deep) {
		CPP_DKNodeDUK_cloneNode(this.address, deep);
		// TODO
    }
	
	// boolean isEqualNode(Node? otherNode);
	Node.prototype.isEqualNode = function isEqualNode(otherNode) {
		CPP_DKNodeDUK_isEqualNode(this.address, otherNode);
		// TODO
    }
	
	// boolean isSameNode(Node? otherNode); // legacy alias of ===
	Node.prototype.isSameNode = function isSameNode(otherNode) {
		CPP_DKNodeDUK_isSameNode(this.address, otherNode);
		// TODO
    }
	
	// const unsigned short DOCUMENT_POSITION_DISCONNECTED = 0x01;
	// const unsigned short DOCUMENT_POSITION_PRECEDING = 0x02;
	// const unsigned short DOCUMENT_POSITION_FOLLOWING = 0x04;
	// const unsigned short DOCUMENT_POSITION_CONTAINS = 0x08;
	// const unsigned short DOCUMENT_POSITION_CONTAINED_BY = 0x10;
	// const unsigned short DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
	
	// unsigned short compareDocumentPosition(Node other);
	Node.prototype.compareDocumentPosition = function compareDocumentPosition(other) {
		CPP_DKNodeDUK_compareDocumentPosition(this.address, other);
		// TODO
    }
	
	// boolean contains(Node? other);
	Node.prototype.contains = function contains(other) {
		CPP_DKNodeDUK_contains(this.address, other);
		// TODO
    }
	
	// DOMString? lookupPrefix(DOMString? namespace);
	Node.prototype.lookupPrefix = function lookupPrefix(namespace) {
		CPP_DKNodeDUK_lookupPrefix(this.address, namespace);
		// TODO
    }
	
	// DOMString? lookupNamespaceURI(DOMString? prefix);
	Node.prototype.lookupNamespaceURI = function lookupNamespaceURI(prefix) {
		CPP_DKNodeDUK_lookupNamespaceURI(this.address, prefix);
		// TODO
    }
	
	// boolean isDefaultNamespace(DOMString? namespace);
	Node.prototype.isDefaultNamespace = function isDefaultNamespace(namespace) {
		CPP_DKNodeDUK_isDefaultNamespace(this.address, namespace);
		// TODO
    }
	
	// [CEReactions] Node insertBefore(Node node, Node? child);
	Node.prototype.insertBefore = function insertBefore(node, child) {
		CPP_DKNodeDUK_insertBefore(this.address, node, child);
		// TODO
    }
	
	// [CEReactions] Node appendChild(Node node);
	Node.prototype.appendChild = function appendChild(node) {
		CPP_DKNodeDUK_appendChild(this.address, node);
		// TODO
    }
	
	// [CEReactions] Node replaceChild(Node node, Node child);
	Node.prototype.replaceChild = function replaceChild(node, child) {
		CPP_DKNodeDUK_replaceChild(this.address, node, child);
		// TODO
    }
	
	// [CEReactions] Node removeChild(Node child);
	Node.prototype.removeChild = function removeChild(child) {
		CPP_DKNodeDUK_removeChild(this.address, child);
		// TODO
    }
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Node]" }
	
	return EventTarget.call(this, this.address)
}
Node.prototype = EventTarget.prototype
