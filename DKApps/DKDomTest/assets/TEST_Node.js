// [IDL] https://dom.spec.whatwg.org/#interface-node
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Node
console.log("\n////// TEST_Node.js //////")


function printNodeProperties(node){
	
	// const unsigned short ELEMENT_NODE = 1;
	console.log("node.ELEMENT_NODE = "								+node.ELEMENT_NODE);
	
	// const unsigned short ATTRIBUTE_NODE = 2;
	console.log("node.ATTRIBUTE_NODE = "							+node.ATTRIBUTE_NODE);
	
	// const unsigned short TEXT_NODE = 3;
	console.log("node.TEXT_NODE = "									+node.TEXT_NODE);
	
	// const unsigned short CDATA_SECTION_NODE = 4;
	console.log("node.CDATA_SECTION_NODE = "						+node.CDATA_SECTION_NODE);
	
	// const unsigned short ENTITY_REFERENCE_NODE = 5; // legacy
	console.log("node.ENTITY_REFERENCE_NODE = "						+node.ENTITY_REFERENCE_NODE);
	
	// const unsigned short ENTITY_NODE = 6; // legacy
	console.log("node.ENTITY_NODE = "								+node.ENTITY_NODE);
	
	// const unsigned short PROCESSING_INSTRUCTION_NODE = 7;
	console.log("node.PROCESSING_INSTRUCTION_NODE = "				+node.PROCESSING_INSTRUCTION_NODE);
	
	// const unsigned short COMMENT_NODE = 8;
	console.log("node.COMMENT_NODE = "								+node.COMMENT_NODE);
	
	// const unsigned short DOCUMENT_NODE = 9;
	console.log("node.DOCUMENT_NODE = "								+node.DOCUMENT_NODE);
	
	// const unsigned short DOCUMENT_TYPE_NODE = 10;
	console.log("node.DOCUMENT_TYPE_NODE = "						+node.DOCUMENT_TYPE_NODE);
	
	// const unsigned short DOCUMENT_FRAGMENT_NODE = 11;
	console.log("node.DOCUMENT_FRAGMENT_NODE = "					+node.DOCUMENT_FRAGMENT_NODE);
	
	// const unsigned short NOTATION_NODE = 12; // legacy
	console.log("node.NOTATION_NODE = "								+node.NOTATION_NODE);
	
	// readonly attribute unsigned short nodeType;
	console.log("node.nodeType = "									+node.nodeType);
	
	// readonly attribute DOMString nodeName;
	console.log("node.nodeName = "									+node.nodeName);
	
	// readonly attribute USVString baseURI;
	console.log("node.baseURI = "									+node.baseURI);
	
	// readonly attribute boolean isConnected;
	console.log("node.isConnected = "								+node.isConnected);
	
	// readonly attribute Document? ownerDocument;
	console.log("node.ownerDocument = "								+node.ownerDocument);
	
	// Node getRootNode(optional GetRootNodeOptions options = {});
	// function
	
	// readonly attribute Node? parentNode;
	console.log("node.parentNode = "								+node.parentNode);
	
	// readonly attribute Element? parentElement;
	console.log("node.parentElement = "								+node.parentElement);
	
	// boolean hasChildNodes();
	// function
	
	// [SameObject] readonly attribute NodeList childNodes;
	console.log("node.childNodes = "								+node.childNodes);
	
	// readonly attribute Node? firstChild;
	console.log("node.firstChild = "								+node.firstChild);
	
	// readonly attribute Node? lastChild;
	console.log("node.lastChild = "									+node.lastChild);
	
	// readonly attribute Node? previousSibling;
	console.log("node.previousSibling = "							+node.previousSibling);
	
	// readonly attribute Node? nextSibling;
	console.log("node.nextSibling = "								+node.nextSibling);
	
	// [CEReactions] attribute DOMString? nodeValue;
	console.log("node.nodeValue = "									+node.nodeValue);
	
	// [CEReactions] attribute DOMString? textContent;
	console.log("node.textContent = "								+node.textContent);
	
	// [CEReactions] undefined normalize();
	// function
		
	// [CEReactions, NewObject] Node cloneNode(optional boolean deep = false);
	// function
		
	// boolean isEqualNode(Node? otherNode);
	// function
		
	// boolean isSameNode(Node? otherNode); // legacy alias of ===
	// function
	
	// const unsigned short DOCUMENT_POSITION_DISCONNECTED = 0x01;
	console.log("node.DOCUMENT_POSITION_DISCONNECTED = "			+node.DOCUMENT_POSITION_DISCONNECTED);
	
	// const unsigned short DOCUMENT_POSITION_PRECEDING = 0x02;
	console.log("node.DOCUMENT_POSITION_PRECEDING = "				+node.DOCUMENT_POSITION_PRECEDING);
	
	// const unsigned short DOCUMENT_POSITION_FOLLOWING = 0x04;
	console.log("node.DOCUMENT_POSITION_FOLLOWING = "				+node.DOCUMENT_POSITION_FOLLOWING);
	
	// const unsigned short DOCUMENT_POSITION_CONTAINS = 0x08;
	console.log("node.DOCUMENT_POSITION_CONTAINS = "				+node.DOCUMENT_POSITION_CONTAINS);
	
	// const unsigned short DOCUMENT_POSITION_CONTAINED_BY = 0x10;
	console.log("node.DOCUMENT_POSITION_CONTAINED_BY = "			+node.DOCUMENT_POSITION_CONTAINED_BY);
	
	// const unsigned short DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
	console.log("node.DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = "	+node.DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC);
	
	// unsigned short compareDocumentPosition(Node other);
	// function
		
	// boolean contains(Node? other);
	// function
		
	// DOMString? lookupPrefix(DOMString? namespace);
	// function
		
	// DOMString? lookupNamespaceURI(DOMString? prefix);
	// function
		
	// boolean isDefaultNamespace(DOMString? namespace);
	// function
		
	// [CEReactions] Node insertBefore(Node node, Node? child);
	// function
		
	// [CEReactions] Node appendChild(Node node);
	// function
		
	// [CEReactions] Node replaceChild(Node node, Node child);
	// function
		
	// [CEReactions] Node removeChild(Node child);
	// function
	
	
	printEventTargetProperties(node);
}


var node = new Node();
printNodeProperties(node);