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
        get: function nodeType()			{ return CPP_DKDocumentDUK_nodeType(this.address) },
		//set: function nodeType(data)	{ return CPP_DKDocumentDUK_nodeType(this.address, data) },
    })
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Node]" }
	
	return EventTarget.call(this, this.address)
}
Node.prototype = EventTarget.prototype
