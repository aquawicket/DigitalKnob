// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/Node.idl
// [SOURCE] https://dom.spec.whatwg.org/#interface-node
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Node
#pragma once
#ifndef DKNode_H
#define DKNode_H

#include "DKEventTarget/DKEventTarget.h"

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=Window]
// interface Node : EventTarget {
class DKNode : public DKEventTarget
{
public:

	DKNode() : DKEventTarget() {
		DKDEBUGFUNC();
		interfaceName = "Node";
		interfaceAddress = pointerToAddress(this);
	}
	
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
	virtual bool nodeType(DKString&, bool) { return false; } // [Node.nodeType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeType
	
	// readonly attribute DOMString nodeName;
	virtual bool nodeName(DKString&, bool) { return false; } // [Node.nodeName](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeName

	// readonly attribute USVString baseURI;
	virtual bool baseURI(DKString&, bool) { return false; } // [Node.baseURI](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/baseURI

	// readonly attribute boolean isConnected;
	virtual bool isConnected(bool&, bool) { return false; } // [Node.isConnected](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/isConnected
	
	// readonly attribute Document? ownerDocument;
	virtual bool ownerDocument(DKString&, bool) { return false; } // [Node.ownerDocument](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/ownerDocument
	
	// Node getRootNode(optional GetRootNodeOptions options = {});
	virtual bool getRootNode() { // [Node.getRootNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/getRootNode
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// readonly attribute Node? parentNode;
	virtual bool parentNode(DKString&, bool) { return false; } // [Node.parentNode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/parentNode
	
	// readonly attribute Element? parentElement;
	virtual bool parentElement(DKString&, bool) { return false; } // [Node.parentElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/parentElement
	
	// boolean hasChildNodes();
	virtual bool hasChildNodes() { // [Node.hasChildNodes()] https://developer.mozilla.org/en-US/docs/Web/API/Node/hasChildNodes
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// [SameObject] readonly attribute NodeList childNodes;
	virtual bool childNodes(DKString&, bool) { return false; } // [Node.childNodes](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/childNodes
	
	// readonly attribute Node? firstChild;
	virtual bool firstChild(DKString&, bool) { return false; } // [Node.firstChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/firstChild
	
	// readonly attribute Node? lastChild;
	virtual bool lastChild(DKString&, bool) { return false; } // [Node.lastChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/lastChild
	
	// readonly attribute Node? previousSibling;
	virtual bool previousSibling(DKString&, bool) { return false; } // [Node.previousSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/previousSibling
	
	// readonly attribute Node? nextSibling;
	virtual bool nextSibling(DKString&, bool) { return false; } // [Node.nextSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nextSibling

	// [CEReactions] attribute DOMString? nodeValue;
	virtual bool nodeValue(DKString&, bool) { return false; } // [Node.nodeValue] https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeValue
	
	// [CEReactions] attribute DOMString? textContent;
	virtual bool textContent(DKString&, bool) { return false; } // [Node.textContent] https://developer.mozilla.org/en-US/docs/Web/API/Node/textContent
	
	// [CEReactions] undefined normalize();
	virtual bool normalize() { // [Node.normalize()] https://developer.mozilla.org/en-US/docs/Web/API/Node/normalize
		DKDEBUGFUNC();
		return DKTODO();
	}

	// [CEReactions, NewObject] Node cloneNode(optional boolean deep = false);
	virtual bool cloneNode() { // [Node.cloneNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/cloneNode
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// boolean isEqualNode(Node? otherNode);
	virtual bool isEqualNode() { // [Node.isEqualNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/isEqualNode
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// boolean isSameNode(Node? otherNode); // legacy alias of ===
	virtual bool isSameNode() { // [Node.isSameNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/isSameNode
		DKDEBUGFUNC();
		return DKTODO();
	}

	// const unsigned short DOCUMENT_POSITION_DISCONNECTED = 0x01;
	// const unsigned short DOCUMENT_POSITION_PRECEDING = 0x02;
	// const unsigned short DOCUMENT_POSITION_FOLLOWING = 0x04;
	// const unsigned short DOCUMENT_POSITION_CONTAINS = 0x08;
	// const unsigned short DOCUMENT_POSITION_CONTAINED_BY = 0x10;
	// const unsigned short DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
	
	// unsigned short compareDocumentPosition(Node other);
	virtual bool compareDocumentPosition() { // [Node.compareDocumentPosition()] https://developer.mozilla.org/en-US/docs/Web/API/Node/compareDocumentPosition
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// boolean contains(Node? other);
	virtual bool contains() { // [Node.contains()] https://developer.mozilla.org/en-US/docs/Web/API/Node/contains
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// DOMString? lookupPrefix(DOMString? namespace);
	virtual bool lookupPrefix() { // [Node.lookupPrefix()] https://developer.mozilla.org/en-US/docs/Web/API/Node/lookupPrefix
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// DOMString? lookupNamespaceURI(DOMString? prefix);
	virtual bool lookupNamespaceURI() { // [Node.lookupNamespaceURI()] https://developer.mozilla.org/en-US/docs/Web/API/Node/lookupNamespaceURI
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// boolean isDefaultNamespace(DOMString? namespace);
	virtual bool isDefaultNamespace() { // [Node.isDefaultNamespace()] https://developer.mozilla.org/en-US/docs/Web/API/Node/isDefaultNamespace
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// [CEReactions] Node insertBefore(Node node, Node? child);
	virtual bool insertBefore() { // [Node.insertBefore()] https://developer.mozilla.org/en-US/docs/Web/API/Node/insertBefore
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// [CEReactions] Node appendChild(Node node);
	virtual bool appendChild(DKString& aChild) { // [Node.appendChild()] https://developer.mozilla.org/en-US/docs/Web/API/Node/appendChild
		DKDEBUGFUNC(aChild);
		return DKTODO();
	}
	
	// [CEReactions] Node replaceChild(Node node, Node child);
	virtual bool replaceChild() { // [Node.replaceChild()] https://developer.mozilla.org/en-US/docs/Web/API/Node/replaceChild
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// [CEReactions] Node removeChild(Node child);
	virtual bool removeChild() { // [Node.removeChild()] https://developer.mozilla.org/en-US/docs/Web/API/Node/removeChild
		DKDEBUGFUNC();
		return DKTODO();
	}
};


#endif //DKNode_H