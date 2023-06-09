// [IDL] https://dom.spec.whatwg.org/#interface-node
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Node
#pragma once
#ifndef DKRmlNode_H
#define DKRmlNode_H

#include "DKNode/DKNode.h"
#include "DKRmlDocument/DKRmlDocument.h"

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=Window]
// interface Node : EventTarget {
class DKRmlNode : public DKNode
{
public:
	DKRmlDocument* _dkRmlDocument;
	
	DKRmlNode(DKRmlDocument* dkRmlDocument) : DKNode() {
		DKDEBUGFUNC();
		interfaceName = "RmlNode";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKRmlNode("+interfaceAddress+") \n");
		_dkRmlDocument = dkRmlDocument;
	}
	
	virtual ~DKRmlNode() {}
	
	/*
	// const unsigned short ELEMENT_NODE = 1;
	const unsigned short _ELEMENT_NODE = 1;
	virtual const unsigned short& 	ELEMENT_NODE()																	{ return _ELEMENT_NODE; }										// getter
	//virtual void 					ELEMENT_NODE(const unsigned short& ELEMENT_NODE)								{ _ELEMENT_NODE = ELEMENT_NODE; } 								// setter
	
	// const unsigned short ATTRIBUTE_NODE = 2;
	const unsigned short _ATTRIBUTE_NODE = 2;
	virtual const unsigned short&	ATTRIBUTE_NODE()																{ return _ATTRIBUTE_NODE; }										// getter
	//virtual void 					ATTRIBUTE_NODE(const unsigned short& ATTRIBUTE_NODE)							{ _ATTRIBUTE_NODE = ATTRIBUTE_NODE; }							// setter
	
	// const unsigned short TEXT_NODE = 3;
	const unsigned short _TEXT_NODE = 3;
	virtual const unsigned short& 	TEXT_NODE()																		{ return _TEXT_NODE; }											// getter
	//virtual void 					TEXT_NODE(const unsigned short& TEXT_NODE)										{ _TEXT_NODE = TEXT_NODE; }										// setter
	
	// const unsigned short CDATA_SECTION_NODE = 4;
	const unsigned short _CDATA_SECTION_NODE = 4;
	virtual const unsigned short& 	CDATA_SECTION_NODE()															{ return _CDATA_SECTION_NODE; }									// getter
	//virtual void 					CDATA_SECTION_NODE(const unsigned short& CDATA_SECTION_NODE)					{ _CDATA_SECTION_NODE = CDATA_SECTION_NODE; }					// setter
	
	// const unsigned short ENTITY_REFERENCE_NODE = 5; // legacy
	const unsigned short _ENTITY_REFERENCE_NODE = 5;
	virtual const unsigned short& 	ENTITY_REFERENCE_NODE()															{ return _ENTITY_REFERENCE_NODE; }								// getter
	//virtual void 					ENTITY_REFERENCE_NODE(const unsigned short& ENTITY_REFERENCE_NODE)				{ _ENTITY_REFERENCE_NODE = ENTITY_REFERENCE_NODE; }				// setter
	
	// const unsigned short ENTITY_NODE = 6; // legacy
	const unsigned short _ENTITY_NODE = 6;
	virtual const unsigned short& 	ENTITY_NODE()																	{ return _ENTITY_NODE; }										// getter
	//virtual void 					ENTITY_NODE(const unsigned short& ENTITY_NODE)									{ _ENTITY_NODE = ENTITY_NODE; }									// setter
	
	// const unsigned short PROCESSING_INSTRUCTION_NODE = 7;
	const unsigned short _PROCESSING_INSTRUCTION_NODE = 7;
	virtual const unsigned short& 	PROCESSING_INSTRUCTION_NODE()													{ return _PROCESSING_INSTRUCTION_NODE; }						// getter
	//virtual void 					PROCESSING_INSTRUCTION_NODE(const unsigned short& PROCESSING_INSTRUCTION_NODE)	{ _PROCESSING_INSTRUCTION_NODE = PROCESSING_INSTRUCTION_NODE; }	// setter
	
	// const unsigned short COMMENT_NODE = 8;
	const unsigned short _COMMENT_NODE = 8;
	virtual const unsigned short& 	COMMENT_NODE()																	{ return _COMMENT_NODE; }										// getter
	//virtual void 					COMMENT_NODE(const unsigned short& COMMENT_NODE)								{ _COMMENT_NODE = COMMENT_NODE; }								// setter
	
	// const unsigned short DOCUMENT_NODE = 9;
	const unsigned short _DOCUMENT_NODE = 9;
	virtual const unsigned short& 	DOCUMENT_NODE()																	{ return _DOCUMENT_NODE; }										// getter
	//virtual void 					DOCUMENT_NODE(const unsigned short& DOCUMENT_NODE)								{ _DOCUMENT_NODE = DOCUMENT_NODE; }								// setter
	
	// const unsigned short DOCUMENT_TYPE_NODE = 10;
	const unsigned short _DOCUMENT_TYPE_NODE = 10;
	virtual const unsigned short& 	DOCUMENT_TYPE_NODE()															{ return _DOCUMENT_TYPE_NODE; }									// getter
	//virtual void 					DOCUMENT_TYPE_NODE(const unsigned short& DOCUMENT_TYPE_NODE)					{ _DOCUMENT_TYPE_NODE = DOCUMENT_TYPE_NODE; }					// setter
	
	// const unsigned short DOCUMENT_FRAGMENT_NODE = 11;
	const unsigned short _DOCUMENT_FRAGMENT_NODE = 11;
	virtual const unsigned short& 	DOCUMENT_FRAGMENT_NODE()														{ return _DOCUMENT_FRAGMENT_NODE; }								// getter
	//virtual void 					DOCUMENT_FRAGMENT_NODE(const unsigned short& DOCUMENT_FRAGMENT_NODE)			{ _DOCUMENT_FRAGMENT_NODE = DOCUMENT_FRAGMENT_NODE; }			// setter
	
	// const unsigned short NOTATION_NODE = 12; // legacy
	const unsigned short _NOTATION_NODE = 12;
	virtual const unsigned short& 	NOTATION_NODE()																	{ return _NOTATION_NODE; }										// getter
	//virtual void 					NOTATION_NODE(const unsigned short& NOTATION_NODE)								{ _NOTATION_NODE = NOTATION_NODE; }								// setter
	
	// readonly attribute unsigned short nodeType;
	unsigned short _nodeType = 0;
	virtual const unsigned short& nodeType()						{ return _nodeType; }					// getter
	virtual void nodeType(const unsigned short& nodeType)			{ _nodeType = nodeType; } 				// setter
	
	// readonly attribute DOMString nodeName;
	DOMString _nodeName = "";
	virtual const DOMString& nodeName()								{ return _nodeName; }					// getter
	virtual void nodeName(const DOMString& nodeName)				{ _nodeName = nodeName; } 				// setter

	// readonly attribute USVString baseURI;
	USVString _baseURI = "";
	virtual const USVString& baseURI()								{ return _baseURI; }					// getter
	virtual void baseURI(const USVString& baseURI)					{ _baseURI = baseURI; } 				// setter

	// readonly attribute boolean isConnected;
	bool _isConnected = false;
	virtual const bool& isConnected()								{ return _isConnected; }				// getter
	virtual void isConnected(const bool& isConnected)				{ _isConnected = isConnected; } 		// setter
	
	// readonly attribute Document? ownerDocument;
	DKString _ownerDocument = "";
	virtual const DKString& ownerDocument()							{ return _ownerDocument; }				// getter
	virtual void ownerDocument(const DKString& ownerDocument)		{ _ownerDocument = ownerDocument; }	 	// setter
	
	// Node getRootNode(optional GetRootNodeOptions options = {});
	DKString _getRootNode = "";
	virtual const DKString& getRootNode(const DKString& options = "{}") {
		DKDEBUGFUNC(options);
		return _getRootNode;
	}
	
	// readonly attribute Node? parentNode;
	DKString _parentNode = "";
	virtual const DKString& parentNode()							{ return _parentNode; }					// getter
	virtual void parentNode(const DKString& parentNode)				{ _parentNode = parentNode; } 			// setter
	
	// readonly attribute Element? parentElement;
	DKString _parentElement = "";
	virtual const DKString& parentElement()							{ return _parentElement; }				// getter
	virtual void parentElement(const DKString& parentElement)		{ _parentElement = parentElement; } 	// setter
	
	// boolean hasChildNodes();
	virtual bool hasChildNodes(bool& _hasChildNodes) {
		DKDEBUGFUNC(_hasChildNodes);
		return DKTODO();
	}
	
	// [SameObject] readonly attribute NodeList childNodes;
	DKString _childNodes = "";
	virtual const DKString& childNodes()							{ return _childNodes; }					// getter
	virtual void childNodes(const DKString& childNodes)				{ _childNodes = childNodes; } 			// setter
	
	// readonly attribute Node? firstChild;
	DKString _firstChild = "";
	virtual const DKString& firstChild()							{ return _firstChild; }					// getter
	virtual void firstChild(const DKString& firstChild)				{ _firstChild = firstChild; } 			// setter
	
	// readonly attribute Node? lastChild;
	DKString _lastChild = "";
	virtual const DKString& lastChild()								{ return _lastChild; }					// getter
	virtual void lastChild(const DKString& lastChild)				{ _lastChild = lastChild; } 			// setter
	
	// readonly attribute Node? previousSibling;
	DKString _previousSibling = "";
	virtual const DKString& previousSibling()						{ return _previousSibling; }			// getter
	virtual void previousSibling(const DKString& previousSibling)	{ _previousSibling = previousSibling; } // setter
	
	// readonly attribute Node? nextSibling;
	DKString _nextSibling = "";
	virtual const DKString& nextSibling()							{ return _nextSibling; }				// getter
	virtual void nextSibling(const DKString& nextSibling)			{ _nextSibling = nextSibling; } 		// setter

	// [CEReactions] attribute DOMString? nodeValue;
	DKString _nodeValue = "";
	virtual const DKString& nodeValue()								{ return _nodeValue; }					// getter
	virtual void nodeValue(const DKString& nodeValue)				{ _nodeValue = nodeValue; } 			// setter
	
	// [CEReactions] attribute DOMString? textContent;
	DOMString _textContent = "";
	virtual const DOMString& textContent()							{ return _textContent; }				// getter
	virtual void textContent(const DOMString& textContent)			{ _textContent = textContent; } 		// setter
	
	// [CEReactions] undefined normalize();
	virtual void normalize() {
		DKDEBUGFUNC();
		DKTODO();
	}

	// [CEReactions, NewObject] Node cloneNode(optional boolean deep = false);
	DKString _cloneNode = "";
	virtual const DKString& cloneNode(const bool& deep = false) {
		DKDEBUGFUNC(deep);
		return _cloneNode;
	}
	
	// boolean isEqualNode(Node? otherNode);
	bool _isEqualNode = false;
	virtual const bool& isEqualNode(const DKString& otherNode) {
		DKDEBUGFUNC(otherNode);
		return _isEqualNode;
	}
	
	// boolean isSameNode(Node? otherNode); // legacy alias of ===
	bool _isSameNode = false;
	virtual const bool& isSameNode(const DKString& otherNode) {
		DKDEBUGFUNC(otherNode);
		return _isSameNode;
	}

	// const unsigned short DOCUMENT_POSITION_DISCONNECTED = 0x01;
	const unsigned short _DOCUMENT_POSITION_DISCONNECTED = 0x01;
	virtual const unsigned short& DOCUMENT_POSITION_DISCONNECTED()										{ return _DOCUMENT_POSITION_DISCONNECTED; }								// getter
	//virtual void DOCUMENT_POSITION_DISCONNECTED(const unsigned short& DOCUMENT_POSITION_DISCONNECTED)	{ _DOCUMENT_POSITION_DISCONNECTED = DOCUMENT_POSITION_DISCONNECTED; }	// setter
	
	// const unsigned short DOCUMENT_POSITION_PRECEDING = 0x02;
	const unsigned short _DOCUMENT_POSITION_PRECEDING = 0x02;
	virtual const unsigned short& DOCUMENT_POSITION_PRECEDING()											{ return _DOCUMENT_POSITION_PRECEDING; }								// getter
	//virtual void DOCUMENT_POSITION_PRECEDING(const unsigned short& DOCUMENT_POSITION_PRECEDING)		{ _DOCUMENT_POSITION_PRECEDING = DOCUMENT_POSITION_PRECEDING; }			// setter
	
	// const unsigned short DOCUMENT_POSITION_FOLLOWING = 0x04;
	const unsigned short _DOCUMENT_POSITION_FOLLOWING = 0x04;
	virtual const unsigned short& DOCUMENT_POSITION_FOLLOWING()											{ return _DOCUMENT_POSITION_FOLLOWING; }								// getter
	//virtual void DOCUMENT_POSITION_FOLLOWING(const unsigned short& DOCUMENT_POSITION_FOLLOWING)		{ _DOCUMENT_POSITION_FOLLOWING = DOCUMENT_POSITION_FOLLOWING; }			// setter
	
	// const unsigned short DOCUMENT_POSITION_CONTAINS = 0x08;
	const unsigned short _DOCUMENT_POSITION_CONTAINS = 0x08;
	virtual const unsigned short& DOCUMENT_POSITION_CONTAINS()											{ return _DOCUMENT_POSITION_CONTAINS; }									// getter
	//virtual void DOCUMENT_POSITION_CONTAINS(const unsigned short& DOCUMENT_POSITION_CONTAINS)			{ _DOCUMENT_POSITION_CONTAINS = DOCUMENT_POSITION_CONTAINS; }			// setter
	
	// const unsigned short DOCUMENT_POSITION_CONTAINED_BY = 0x10;
	const unsigned short _DOCUMENT_POSITION_CONTAINED_BY = 0x10;
	virtual const unsigned short& DOCUMENT_POSITION_CONTAINED_BY()										{ return _DOCUMENT_POSITION_CONTAINED_BY; }								// getter
	//virtual void DOCUMENT_POSITION_CONTAINED_BY(const unsigned short& DOCUMENT_POSITION_CONTAINED_BY)	{ _DOCUMENT_POSITION_CONTAINED_BY = DOCUMENT_POSITION_CONTAINED_BY; }	// setter
	
	// const unsigned short DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
	const unsigned short _DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
	virtual const unsigned short& DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC()													{ return _DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC; }										// getter
	//virtual void DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC(const unsigned short& DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC)	{ _DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC; }	// setter
	
	// unsigned short compareDocumentPosition(Node other);
	unsigned short _compareDocumentPosition = 0;
	virtual const unsigned short& compareDocumentPosition(const DKString& other) {
		DKDEBUGFUNC(other);
		return _compareDocumentPosition;
	}
	
	// boolean contains(Node? other);
	bool _contains = false;
	virtual const bool& contains(const DKString& other) {
		DKDEBUGFUNC(other);
		return _contains;
	}
	
	// DOMString? lookupPrefix(DOMString? namespace);
	DOMString _lookupPrefix = "";
	virtual const DOMString& lookupPrefix(const DOMString& _namespace) {
		DKDEBUGFUNC(_namespace);
		return _lookupPrefix;
	}
	
	// DOMString? lookupNamespaceURI(DOMString? prefix);
	DOMString _lookupNamespaceURI = "";
	virtual const DOMString& lookupNamespaceURI(const DOMString& prefix) {
		DKDEBUGFUNC(prefix);
		return _lookupNamespaceURI;
	}
	
	// boolean isDefaultNamespace(DOMString? namespace);
	bool _isDefaultNamespace = false;
	virtual const bool& isDefaultNamespace(const DOMString& _namespace) {
		DKDEBUGFUNC(_namespace);
		return _isDefaultNamespace;
	}
	
	// [CEReactions] Node insertBefore(Node node, Node? child);
	DKString _insertBefore = "";
	virtual const DKString& insertBefore(const DKString& node, const DKString& child) {
		DKDEBUGFUNC(node, child);
		return _insertBefore;
	}
	
	// [CEReactions] Node appendChild(Node node);
	DKString _appendChild = "";
	virtual const DKString& appendChild(const DKString& node) {
		DKDEBUGFUNC(node);
		return _appendChild;
	}
	
	// [CEReactions] Node replaceChild(Node node, Node child);
	DKString _replaceChild = "";
	virtual const DKString& replaceChild(const DKString& node, const DKString& child) {
		DKDEBUGFUNC(node, child);
		return _replaceChild;
	}
	
	// [CEReactions] Node removeChild(Node child);
	DKString _removeChild = "";
	virtual const DKString& removeChild(const DKString& child) {
		DKDEBUGFUNC(child);
		return _removeChild;
	}
	*/
};


#endif //DKRmlNode_H