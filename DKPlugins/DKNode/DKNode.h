// [IDL] https://dom.spec.whatwg.org/#interface-node
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
		DKINFO("DKNode("+interfaceAddress+") \n");
	}
	
	// const unsigned short ELEMENT_NODE = 1;
	const unsigned short _ELEMENT_NODE = 1;
	virtual unsigned short ELEMENT_NODE()				{ return _ELEMENT_NODE; }			// getter
	//virtual void ELEMENT_NODE(const unsigned short&)	{ _ELEMENT_NODE = _ELEMENT_NODE; } 	// setter
	
	// const unsigned short ATTRIBUTE_NODE = 2;
	const unsigned short ATTRIBUTE_NODE = 2;
	
	// const unsigned short TEXT_NODE = 3;
	const unsigned short TEXT_NODE = 3;
	
	// const unsigned short CDATA_SECTION_NODE = 4;
	const unsigned short CDATA_SECTION_NODE = 4;
	
	// const unsigned short ENTITY_REFERENCE_NODE = 5; // legacy
	const unsigned short ENTITY_REFERENCE_NODE = 5;
	
	// const unsigned short ENTITY_NODE = 6; // legacy
	const unsigned short ENTITY_NODE = 6;
	
	// const unsigned short PROCESSING_INSTRUCTION_NODE = 7;
	const unsigned short PROCESSING_INSTRUCTION_NODE = 7;
	
	// const unsigned short COMMENT_NODE = 8;
	const unsigned short COMMENT_NODE = 8;
	
	// const unsigned short DOCUMENT_NODE = 9;
	const unsigned short DOCUMENT_NODE = 9;
	
	// const unsigned short DOCUMENT_TYPE_NODE = 10;
	const unsigned short DOCUMENT_TYPE_NODE = 10;
	
	// const unsigned short DOCUMENT_FRAGMENT_NODE = 11;
	const unsigned short DOCUMENT_FRAGMENT_NODE = 11;
	
	// const unsigned short NOTATION_NODE = 12; // legacy
	const unsigned short NOTATION_NODE = 12;
	
	// readonly attribute unsigned short nodeType;
	virtual bool nodeType(unsigned int&, bool) { return false; }
	
	// readonly attribute DOMString nodeName;
	virtual bool nodeName(DOMString&, bool) { return false; }

	// readonly attribute USVString baseURI;
	virtual bool baseURI(DKString&, bool) { return false; }

	// readonly attribute boolean isConnected;
	virtual bool isConnected(bool&, bool) { return false; }
	
	// readonly attribute Document? ownerDocument;
	virtual bool ownerDocument(DKString&, bool) { return false; }
	
	// Node getRootNode(optional GetRootNodeOptions options = {});
	virtual bool getRootNode(DKString& _options, DKString& _node) {
		DKDEBUGFUNC(_options, _node);
		return DKTODO();
	}
	
	// readonly attribute Node? parentNode;
	virtual bool parentNode(DKString&, bool) { return false; }
	
	// readonly attribute Element? parentElement;
	virtual bool parentElement(DKString&, bool) { return false; }
	
	// boolean hasChildNodes();
	virtual bool hasChildNodes(bool& _hasChildNodes) {
		DKDEBUGFUNC(_hasChildNodes);
		return DKTODO();
	}
	
	// [SameObject] readonly attribute NodeList childNodes;
	virtual bool childNodes(DKString&, bool) { return false; }
	
	// readonly attribute Node? firstChild;
	virtual bool firstChild(DKString&, bool) { return false; }
	
	// readonly attribute Node? lastChild;
	virtual bool lastChild(DKString&, bool) { return false; }
	
	// readonly attribute Node? previousSibling;
	virtual bool previousSibling(DKString&, bool) { return false; }
	
	// readonly attribute Node? nextSibling;
	virtual bool nextSibling(DKString&, bool) { return false; }

	// [CEReactions] attribute DOMString? nodeValue;
	virtual bool nodeValue(DOMString&, bool) { return false; }
	
	// [CEReactions] attribute DOMString? textContent;
	virtual bool textContent(DOMString&, bool) { return false; }
	
	// [CEReactions] undefined normalize();
	virtual bool normalize() {
		DKDEBUGFUNC();
		return DKTODO();
	}

	// [CEReactions, NewObject] Node cloneNode(optional boolean deep = false);
	virtual bool cloneNode(bool& _deep, DKString& _cloneNode) {
		DKDEBUGFUNC(_deep, _cloneNode);
		return DKTODO();
	}
	
	// boolean isEqualNode(Node? otherNode);
	virtual bool isEqualNode(DKString& _otherNode, bool& _isEqualNode) {
		DKDEBUGFUNC(_otherNode, _isEqualNode);
		return DKTODO();
	}
	
	// boolean isSameNode(Node? otherNode); // legacy alias of ===
	virtual bool isSameNode(DKString& _otherNode, bool& _isSameNode) {
		DKDEBUGFUNC(_otherNode, _isSameNode);
		return DKTODO();
	}

	// const unsigned short DOCUMENT_POSITION_DISCONNECTED = 0x01;
	const unsigned short DOCUMENT_POSITION_DISCONNECTED = 0x01;
	
	// const unsigned short DOCUMENT_POSITION_PRECEDING = 0x02;
	const unsigned short DOCUMENT_POSITION_PRECEDING = 0x02;
	
	// const unsigned short DOCUMENT_POSITION_FOLLOWING = 0x04;
	const unsigned short DOCUMENT_POSITION_FOLLOWING = 0x04;
	
	// const unsigned short DOCUMENT_POSITION_CONTAINS = 0x08;
	const unsigned short DOCUMENT_POSITION_CONTAINS = 0x08;
	
	// const unsigned short DOCUMENT_POSITION_CONTAINED_BY = 0x10;
	const unsigned short DOCUMENT_POSITION_CONTAINED_BY = 0x10;
	
	// const unsigned short DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
	const unsigned short DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
	
	// unsigned short compareDocumentPosition(Node other);
	virtual bool compareDocumentPosition(DKString& _other, unsigned short& _compareDocumentPosition) {
		DKDEBUGFUNC(_other, _compareDocumentPosition);
		return DKTODO();
	}
	
	// boolean contains(Node? other);
	virtual bool contains(DKString& _other, bool& _contains) {
		DKDEBUGFUNC(_other, _contains);
		return DKTODO();
	}
	
	// DOMString? lookupPrefix(DOMString? namespace);
	virtual bool lookupPrefix(DOMString& _namespace, DOMString& _lookupPrefix) {
		DKDEBUGFUNC(_namespace, _lookupPrefix);
		return DKTODO();
	}
	
	// DOMString? lookupNamespaceURI(DOMString? prefix);
	virtual bool lookupNamespaceURI(DOMString& _prefix, DOMString& _lookupNamespaceURI) {
		DKDEBUGFUNC(_prefix, _lookupNamespaceURI);
		return DKTODO();
	}
	
	// boolean isDefaultNamespace(DOMString? namespace);
	virtual bool isDefaultNamespace(DOMString& _namespace, bool& _isDefaultNamespace) {
		DKDEBUGFUNC(_namespace, _isDefaultNamespace);
		return DKTODO();
	}
	
	// [CEReactions] Node insertBefore(Node node, Node? child);
	virtual bool insertBefore(DKString& _node, DKString& _child, DKString& _insertBefore) {
		DKDEBUGFUNC(_node, _child, _insertBefore);
		return DKTODO();
	}
	
	// [CEReactions] Node appendChild(Node node);
	virtual bool appendChild(DKString& _node, DKString& _appendChild) {
		DKDEBUGFUNC(_node, _appendChild);
		return DKTODO();
	}
	
	// [CEReactions] Node replaceChild(Node node, Node child);
	virtual bool replaceChild(DKString& _node, DKString& _child, DKString& _replaceChild) {
		DKDEBUGFUNC(_node, _child, _replaceChild);
		return DKTODO();
	}
	
	// [CEReactions] Node removeChild(Node child);
	virtual bool removeChild(DKString& _child, DKString& _removeChild) {
		DKDEBUGFUNC(_child, _removeChild);
		return DKTODO();
	}
};


#endif //DKNode_H