// [IDL] https://dom.spec.whatwg.org/#interface-node
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Node


// [Exposed=Window]
// interface Node : EventTarget {
var Node = function Node(address) {
	//console.log("Node("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKNodeDUK();
	
	
	// const unsigned short ELEMENT_NODE = 1;
	Object.defineProperty(this, "ELEMENT_NODE", {
        get: function ELEMENT_NODE()									{ return CPP_DKNodeDUK_ELEMENT_NODE(this.address) },
		//set: function ELEMENT_NODE(data)								{ return CPP_DKNodeDUK_ELEMENT_NODE(this.address, data) },
    })
	
	// const unsigned short ATTRIBUTE_NODE = 2;
	Object.defineProperty(this, "ATTRIBUTE_NODE", {
        get: function ATTRIBUTE_NODE()									{ return CPP_DKNodeDUK_ATTRIBUTE_NODE(this.address) },
		//set: function ATTRIBUTE_NODE(data)							{ return CPP_DKNodeDUK_ATTRIBUTE_NODE(this.address, data) },
    })
	
	// const unsigned short TEXT_NODE = 3;
	Object.defineProperty(this, "TEXT_NODE", {
        get: function TEXT_NODE()										{ return CPP_DKNodeDUK_TEXT_NODE(this.address) },
		//set: function TEXT_NODE(data)									{ return CPP_DKNodeDUK_TEXT_NODE(this.address, data) },
    })
	
	// const unsigned short CDATA_SECTION_NODE = 4;
	Object.defineProperty(this, "CDATA_SECTION_NODE", {
        get: function CDATA_SECTION_NODE()								{ return CPP_DKNodeDUK_CDATA_SECTION_NODE(this.address) },
		//set: function CDATA_SECTION_NODE(data)						{ return CPP_DKNodeDUK_CDATA_SECTION_NODE(this.address, data) },
    })
	
	// const unsigned short ENTITY_REFERENCE_NODE = 5; // legacy
	Object.defineProperty(this, "ENTITY_REFERENCE_NODE", {
        get: function ENTITY_REFERENCE_NODE()							{ return CPP_DKNodeDUK_ENTITY_REFERENCE_NODE(this.address) },
		//set: function ENTITY_REFERENCE_NODE(data)						{ return CPP_DKNodeDUK_ENTITY_REFERENCE_NODE(this.address, data) },
    })
	
	// const unsigned short ENTITY_NODE = 6; // legacy
	Object.defineProperty(this, "ENTITY_NODE", {
        get: function ENTITY_NODE()										{ return CPP_DKNodeDUK_ENTITY_NODE(this.address) },
		//set: function ENTITY_NODE(data)								{ return CPP_DKNodeDUK_ENTITY_NODE(this.address, data) },
    })
	
	// const unsigned short PROCESSING_INSTRUCTION_NODE = 7;
	Object.defineProperty(this, "PROCESSING_INSTRUCTION_NODE", {
        get: function PROCESSING_INSTRUCTION_NODE()						{ return CPP_DKNodeDUK_PROCESSING_INSTRUCTION_NODE(this.address) },
		//set: function PROCESSING_INSTRUCTION_NODE(data)				{ return CPP_DKNodeDUK_PROCESSING_INSTRUCTION_NODE(this.address, data) },
    })
	
	// const unsigned short COMMENT_NODE = 8;
	Object.defineProperty(this, "COMMENT_NODE", {
        get: function COMMENT_NODE()									{ return CPP_DKNodeDUK_COMMENT_NODE(this.address) },
		//set: function COMMENT_NODE(data)								{ return CPP_DKNodeDUK_COMMENT_NODE(this.address, data) },
    })
	
	// const unsigned short DOCUMENT_NODE = 9;
	Object.defineProperty(this, "DOCUMENT_NODE", {
        get: function DOCUMENT_NODE()									{ return CPP_DKNodeDUK_DOCUMENT_NODE(this.address) },
		//set: function DOCUMENT_NODE(data)								{ return CPP_DKNodeDUK_DOCUMENT_NODE(this.address, data) },
    })
	
	// const unsigned short DOCUMENT_TYPE_NODE = 10;
	Object.defineProperty(this, "DOCUMENT_TYPE_NODE", {
        get: function DOCUMENT_TYPE_NODE()								{ return CPP_DKNodeDUK_DOCUMENT_TYPE_NODE(this.address) },
		//set: function DOCUMENT_TYPE_NODE(data)						{ return CPP_DKNodeDUK_DOCUMENT_TYPE_NODE(this.address, data) },
    })
	
	// const unsigned short DOCUMENT_FRAGMENT_NODE = 11;
	Object.defineProperty(this, "DOCUMENT_FRAGMENT_NODE", {
        get: function DOCUMENT_FRAGMENT_NODE()							{ return CPP_DKNodeDUK_DOCUMENT_FRAGMENT_NODE(this.address) },
		//set: function DOCUMENT_FRAGMENT_NODE(data)					{ return CPP_DKNodeDUK_DOCUMENT_FRAGMENT_NODE(this.address, data) },
    })
	
	// const unsigned short NOTATION_NODE = 12; // legacy
	Object.defineProperty(this, "NOTATION_NODE", {
        get: function NOTATION_NODE()									{ return CPP_DKNodeDUK_NOTATION_NODE(this.address) },
		//set: function NOTATION_NODE(data)								{ return CPP_DKNodeDUK_NOTATION_NODE(this.address, data) },
    })	
	
	// readonly attribute unsigned short nodeType;
	Object.defineProperty(this, "nodeType", {
        get: function nodeType()										{ return CPP_DKNodeDUK_nodeType(this.address) },
		//set: function nodeType(data)									{ return CPP_DKNodeDUK_nodeType(this.address, data) },
    })
	
	// readonly attribute DOMString nodeName;
	Object.defineProperty(this, "nodeName", {
        get: function nodeName()										{ return CPP_DKNodeDUK_nodeName(this.address) },
		//set: function nodeName(data)									{ return CPP_DKNodeDUK_nodeName(this.address, data) },
    })
	
	// readonly attribute USVString baseURI;
	Object.defineProperty(this, "baseURI", {
        get: function baseURI()											{ return CPP_DKNodeDUK_baseURI(this.address) },
		//set: function baseURI(data)									{ return CPP_DKNodeDUK_baseURI(this.address, data) },
    })
	
	// readonly attribute boolean isConnected;
	Object.defineProperty(this, "isConnected", {
        get: function isConnected()										{ return CPP_DKNodeDUK_isConnected(this.address) },
		//set: function isConnected(data)								{ return CPP_DKNodeDUK_isConnected(this.address, data) },
    })
	
	// readonly attribute Document? ownerDocument;
	Object.defineProperty(this, "ownerDocument", {
        get: function ownerDocument()									{ return CPP_DKNodeDUK_ownerDocument(this.address) },
		//set: function ownerDocument(data)								{ return CPP_DKNodeDUK_ownerDocument(this.address, data) },
    })
	
	// Node getRootNode(optional GetRootNodeOptions options = {});
	Node.prototype.getRootNode = function getRootNode(options) {
		return CPP_DKNodeDUK_getRootNode(this.address, options);
    }
	
	// readonly attribute Node? parentNode;
	Object.defineProperty(this, "parentNode", {
        get: function parentNode()										{ return CPP_DKNodeDUK_parentNode(this.address) },
		//set: function parentNode(data)								{ return CPP_DKNodeDUK_parentNode(this.address, data) },
    })
	
	// readonly attribute Element? parentElement;
	Object.defineProperty(this, "parentElement", {
        get: function parentElement()									{ return CPP_DKNodeDUK_parentElement(this.address) },
		//set: function parentElement(data)								{ return CPP_DKNodeDUK_parentElement(this.address, data) },
    })
	
	// boolean hasChildNodes();
	Node.prototype.hasChildNodes = function hasChildNodes() {
		return CPP_DKNodeDUK_hasChildNodes(this.address);
    }
	
	// [SameObject] readonly attribute NodeList childNodes;
	Object.defineProperty(this, "childNodes", {
        get: function childNodes()										{ return CPP_DKNodeDUK_childNodes(this.address) },
		//set: function childNodes(data)								{ return CPP_DKNodeDUK_childNodes(this.address, data) },
    })
	
	// readonly attribute Node? firstChild;
	Object.defineProperty(this, "firstChild", {
        get: function firstChild()										{ return CPP_DKNodeDUK_firstChild(this.address) },
		//set: function firstChild(data)								{ return CPP_DKNodeDUK_firstChild(this.address, data) },
    })
	
	// readonly attribute Node? lastChild;
	Object.defineProperty(this, "lastChild", {
        get: function lastChild()										{ return CPP_DKNodeDUK_lastChild(this.address) },
		//set: function lastChild(data)									{ return CPP_DKNodeDUK_lastChild(this.address, data) },
    })
	
	// readonly attribute Node? previousSibling;
	Object.defineProperty(this, "previousSibling", {
        get: function previousSibling()									{ return CPP_DKNodeDUK_previousSibling(this.address) },
		//set: function previousSibling(data)							{ return CPP_DKNodeDUK_previousSibling(this.address, data) },
    })
	
	// readonly attribute Node? nextSibling;
	Object.defineProperty(this, "nextSibling", {
        get: function nextSibling()										{ return CPP_DKNodeDUK_nextSibling(this.address) },
		//set: function nextSibling(data)								{ return CPP_DKNodeDUK_nextSibling(this.address, data) },
    })
	
	// [CEReactions] attribute DOMString? nodeValue;
	Object.defineProperty(this, "nodeValue", {
        get: function nodeValue()										{ return CPP_DKNodeDUK_nodeValue(this.address) },
		set: function nodeValue(data)									{ return CPP_DKNodeDUK_nodeValue(this.address, data) },
    })
	
	// [CEReactions] attribute DOMString? textContent;
	Object.defineProperty(this, "textContent", {
        get: function textContent()										{ return CPP_DKNodeDUK_textContent(this.address) },
		set: function textContent(data)									{ return CPP_DKNodeDUK_textContent(this.address, data) },
    })
	
	// [CEReactions] undefined normalize();
	Node.prototype.normalize = function normalize() {
		CPP_DKNodeDUK_normalize(this.address);
    }
	
	// [CEReactions, NewObject] Node cloneNode(optional boolean deep = false);
	Node.prototype.cloneNode = function cloneNode(deep) {
		return CPP_DKNodeDUK_cloneNode(this.address, deep);
    }
	
	// boolean isEqualNode(Node? otherNode);
	Node.prototype.isEqualNode = function isEqualNode(otherNode) {
		return CPP_DKNodeDUK_isEqualNode(this.address, otherNode);
    }
	
	// boolean isSameNode(Node? otherNode); // legacy alias of ===
	Node.prototype.isSameNode = function isSameNode(otherNode) {
		return CPP_DKNodeDUK_isSameNode(this.address, otherNode);
    }
	
	// const unsigned short DOCUMENT_POSITION_DISCONNECTED = 0x01;
	Object.defineProperty(this, "DOCUMENT_POSITION_DISCONNECTED", {
        get: function DOCUMENT_POSITION_DISCONNECTED()					{ return CPP_DKNodeDUK_DOCUMENT_POSITION_DISCONNECTED(this.address) },
		//set: function DOCUMENT_POSITION_DISCONNECTED(data)			{ return CPP_DKNodeDUK_DOCUMENT_POSITION_DISCONNECTED(this.address, data) },
    })
	
	// const unsigned short DOCUMENT_POSITION_PRECEDING = 0x02;
	Object.defineProperty(this, "DOCUMENT_POSITION_PRECEDING", {
        get: function DOCUMENT_POSITION_PRECEDING()						{ return CPP_DKNodeDUK_DOCUMENT_POSITION_PRECEDING(this.address) },
		//set: function DOCUMENT_POSITION_PRECEDING(data)				{ return CPP_DKNodeDUK_DOCUMENT_POSITION_PRECEDING(this.address, data) },
    })
	
	// const unsigned short DOCUMENT_POSITION_FOLLOWING = 0x04;
	Object.defineProperty(this, "DOCUMENT_POSITION_FOLLOWING", {
        get: function DOCUMENT_POSITION_FOLLOWING()						{ return CPP_DKNodeDUK_DOCUMENT_POSITION_FOLLOWING(this.address) },
		//set: function DOCUMENT_POSITION_FOLLOWING(data)				{ return CPP_DKNodeDUK_DOCUMENT_POSITION_FOLLOWING(this.address, data) },
    })
	
	// const unsigned short DOCUMENT_POSITION_CONTAINS = 0x08;
	Object.defineProperty(this, "DOCUMENT_POSITION_CONTAINS", {
        get: function DOCUMENT_POSITION_CONTAINS()						{ return CPP_DKNodeDUK_DOCUMENT_POSITION_CONTAINS(this.address) },
		//set: function DOCUMENT_POSITION_CONTAINS(data)				{ return CPP_DKNodeDUK_DOCUMENT_POSITION_CONTAINS(this.address, data) },
    })
	
	// const unsigned short DOCUMENT_POSITION_CONTAINED_BY = 0x10;
	Object.defineProperty(this, "DOCUMENT_POSITION_CONTAINED_BY", {
        get: function DOCUMENT_POSITION_CONTAINED_BY()					{ return CPP_DKNodeDUK_DOCUMENT_POSITION_CONTAINED_BY(this.address) },
		//set: function DOCUMENT_POSITION_CONTAINED_BY(data)			{ return CPP_DKNodeDUK_DOCUMENT_POSITION_CONTAINED_BY(this.address, data) },
    })
	
	// const unsigned short DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
	Object.defineProperty(this, "DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC", {
        get: function DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC()		{ return CPP_DKNodeDUK_DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC(this.address) },
		//set: function DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC(data)	{ return CPP_DKNodeDUK_DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC(this.address, data) },
    })
	
	// unsigned short compareDocumentPosition(Node other);
	Node.prototype.compareDocumentPosition = function compareDocumentPosition(other) {
		return CPP_DKNodeDUK_compareDocumentPosition(this.address, other);
    }
	
	// boolean contains(Node? other);
	Node.prototype.contains = function contains(other) {
		return CPP_DKNodeDUK_contains(this.address, other);
    }
	
	// DOMString? lookupPrefix(DOMString? namespace);
	Node.prototype.lookupPrefix = function lookupPrefix(namespace) {
		return CPP_DKNodeDUK_lookupPrefix(this.address, namespace);
    }
	
	// DOMString? lookupNamespaceURI(DOMString? prefix);
	Node.prototype.lookupNamespaceURI = function lookupNamespaceURI(prefix) {
		return CPP_DKNodeDUK_lookupNamespaceURI(this.address, prefix);
    }
	
	// boolean isDefaultNamespace(DOMString? namespace);
	Node.prototype.isDefaultNamespace = function isDefaultNamespace(namespace) {
		return CPP_DKNodeDUK_isDefaultNamespace(this.address, namespace);
    }
	
	// [CEReactions] Node insertBefore(Node node, Node? child);
	Node.prototype.insertBefore = function insertBefore(node, child) {
		return CPP_DKNodeDUK_insertBefore(this.address, node, child);
    }
	
	// [CEReactions] Node appendChild(Node node);
	Node.prototype.appendChild = function appendChild(node) {
		return CPP_DKNodeDUK_appendChild(this.address, node);
    }
	
	// [CEReactions] Node replaceChild(Node node, Node child);
	Node.prototype.replaceChild = function replaceChild(node, child) {
		return CPP_DKNodeDUK_replaceChild(this.address, node, child);
    }
	
	// [CEReactions] Node removeChild(Node child);
	Node.prototype.removeChild = function removeChild(child) {
		return CPP_DKNodeDUK_removeChild(this.address, child);
    }
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Node]" }
	
	return EventTarget.call(this, this.address)
}
Node.prototype = EventTarget.prototype
