// [IDL] https://dom.spec.whatwg.org/#interface-node
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Node
#pragma once
#ifndef DKRmlNode_H
#define DKRmlNode_H

#include "DKNode/DKNode.h"
#include "DKRmlInterface/DKRmlInterface.h"
#include "DKRmlEventTarget/DKRmlEventTarget.h"

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=Window]
// interface Node : EventTarget {
class DKRmlNode : public DKNode, public DKRmlEventTarget
{
public:	 
	//DKRmlInterface* _dkRmlInterface;
	//Rml::Element* _rmlElement;
	
	DKRmlNode(DKRmlEventListener* dkRmlEventListener, Rml::Element* rmlElement) : DKNode(), DKRmlEventTarget(dkRmlEventListener, rmlElement)  {
		DKDEBUGFUNC();
		interfaceName = "DKRmlNode";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKRmlNode("+interfaceAddress+") \n");
		//_dkRmlInterface = dkRmlInterface;
		_rmlElement = rmlElement;
		
		if(!_rmlElement)
			DKERROR("_rmlElement invalid! \n");
	}
	~DKRmlNode() {}
	
	/*
	// const unsigned short ELEMENT_NODE = 1;
	const unsigned short _ELEMENT_NODE = 1;
	virtual const unsigned short& 	ELEMENT_NODE() override															{ return _ELEMENT_NODE; }										// getter
	//virtual void 					ELEMENT_NODE(const unsigned short& ELEMENT_NODE) override						{ _ELEMENT_NODE = ELEMENT_NODE; } 								// setter
	
	// const unsigned short ATTRIBUTE_NODE = 2;
	const unsigned short _ATTRIBUTE_NODE = 2;
	virtual const unsigned short&	ATTRIBUTE_NODE() override														{ return _ATTRIBUTE_NODE; }										// getter
	//virtual void 					ATTRIBUTE_NODE(const unsigned short& ATTRIBUTE_NODE) override					{ _ATTRIBUTE_NODE = ATTRIBUTE_NODE; }							// setter
	
	// const unsigned short TEXT_NODE = 3;
	const unsigned short _TEXT_NODE = 3;
	virtual const unsigned short& 	TEXT_NODE()	override															{ return _TEXT_NODE; }											// getter
	//virtual void 					TEXT_NODE(const unsigned short& TEXT_NODE) override								{ _TEXT_NODE = TEXT_NODE; }										// setter
	
	// const unsigned short CDATA_SECTION_NODE = 4;
	const unsigned short _CDATA_SECTION_NODE = 4;
	virtual const unsigned short& 	CDATA_SECTION_NODE() override													{ return _CDATA_SECTION_NODE; }									// getter
	//virtual void 					CDATA_SECTION_NODE(const unsigned short& CDATA_SECTION_NODE) override			{ _CDATA_SECTION_NODE = CDATA_SECTION_NODE; }					// setter
	
	// const unsigned short ENTITY_REFERENCE_NODE = 5; // legacy
	const unsigned short _ENTITY_REFERENCE_NODE = 5;
	virtual const unsigned short& 	ENTITY_REFERENCE_NODE()	override												{ return _ENTITY_REFERENCE_NODE; }								// getter
	//virtual void 					ENTITY_REFERENCE_NODE(const unsigned short& ENTITY_REFERENCE_NODE) override		{ _ENTITY_REFERENCE_NODE = ENTITY_REFERENCE_NODE; }				// setter
	
	// const unsigned short ENTITY_NODE = 6; // legacy
	const unsigned short _ENTITY_NODE = 6;
	virtual const unsigned short& 	ENTITY_NODE() override															{ return _ENTITY_NODE; }										// getter
	//virtual void 					ENTITY_NODE(const unsigned short& ENTITY_NODE) override							{ _ENTITY_NODE = ENTITY_NODE; }									// setter
	
	// const unsigned short PROCESSING_INSTRUCTION_NODE = 7;
	const unsigned short _PROCESSING_INSTRUCTION_NODE = 7;
	virtual const unsigned short& 	PROCESSING_INSTRUCTION_NODE() override													{ return _PROCESSING_INSTRUCTION_NODE; }						// getter
	//virtual void 					PROCESSING_INSTRUCTION_NODE(const unsigned short& PROCESSING_INSTRUCTION_NODE) override	{ _PROCESSING_INSTRUCTION_NODE = PROCESSING_INSTRUCTION_NODE; }	// setter
	
	// const unsigned short COMMENT_NODE = 8;
	const unsigned short _COMMENT_NODE = 8;
	virtual const unsigned short& 	COMMENT_NODE() override															{ return _COMMENT_NODE; }										// getter
	//virtual void 					COMMENT_NODE(const unsigned short& COMMENT_NODE) override						{ _COMMENT_NODE = COMMENT_NODE; }								// setter
	
	// const unsigned short DOCUMENT_NODE = 9;
	const unsigned short _DOCUMENT_NODE = 9;
	virtual const unsigned short& 	DOCUMENT_NODE() override														{ return _DOCUMENT_NODE; }										// getter
	//virtual void 					DOCUMENT_NODE(const unsigned short& DOCUMENT_NODE) override						{ _DOCUMENT_NODE = DOCUMENT_NODE; }								// setter
	
	// const unsigned short DOCUMENT_TYPE_NODE = 10;
	const unsigned short _DOCUMENT_TYPE_NODE = 10;
	virtual const unsigned short& 	DOCUMENT_TYPE_NODE() override													{ return _DOCUMENT_TYPE_NODE; }									// getter
	//virtual void 					DOCUMENT_TYPE_NODE(const unsigned short& DOCUMENT_TYPE_NODE) override			{ _DOCUMENT_TYPE_NODE = DOCUMENT_TYPE_NODE; }					// setter
	
	// const unsigned short DOCUMENT_FRAGMENT_NODE = 11;
	const unsigned short _DOCUMENT_FRAGMENT_NODE = 11;
	virtual const unsigned short& 	DOCUMENT_FRAGMENT_NODE() override												{ return _DOCUMENT_FRAGMENT_NODE; }								// getter
	//virtual void 					DOCUMENT_FRAGMENT_NODE(const unsigned short& DOCUMENT_FRAGMENT_NODE) override	{ _DOCUMENT_FRAGMENT_NODE = DOCUMENT_FRAGMENT_NODE; }			// setter
	
	// const unsigned short NOTATION_NODE = 12; // legacy
	const unsigned short _NOTATION_NODE = 12;
	virtual const unsigned short& 	NOTATION_NODE()	override														{ return _NOTATION_NODE; }										// getter
	//virtual void 					NOTATION_NODE(const unsigned short& NOTATION_NODE) override						{ _NOTATION_NODE = NOTATION_NODE; }								// setter
	
	// readonly attribute unsigned short nodeType;
	unsigned short _nodeType = 0;
	virtual const unsigned short& nodeType() override						{ return _nodeType; }					// getter
	virtual void nodeType(const unsigned short& nodeType) override			{ _nodeType = nodeType; } 				// setter
	
	// readonly attribute DOMString nodeName;
	DOMString _nodeName = "";
	virtual const DOMString& nodeName()	override							{ return _nodeName; }					// getter
	virtual void nodeName(const DOMString& nodeName) override				{ _nodeName = nodeName; } 				// setter

	// readonly attribute USVString baseURI;
	USVString _baseURI = "";
	virtual const USVString& baseURI() override								{ return _baseURI; }					// getter
	virtual void baseURI(const USVString& baseURI) override					{ _baseURI = baseURI; } 				// setter

	// readonly attribute boolean isConnected;
	bool _isConnected = false;
	virtual const bool& isConnected() override								{ return _isConnected; }				// getter
	virtual void isConnected(const bool& isConnected) override				{ _isConnected = isConnected; } 		// setter
	*/
	
	// readonly attribute Document? ownerDocument;
	//DKString _ownerDocument = "";
	virtual DKDocument* ownerDocument() override { 																// getter
		if(!_rmlElement){
			DKERROR("_rmlElement invalid! \n");
			return _ownerDocument;
		}
		Rml::ElementDocument* rmlElementDocument = _rmlElement->GetOwnerDocument();
		//_ownerDocument = DKRmlDocument::instance(_dkRmlEventListener, rmlElementDocument);	//FIXME
		return _ownerDocument; 
	}
	//virtual void ownerDocument(DKDocument* ownerDocument) override	{ _ownerDocument = ownerDocument; }	 	// setter
	
	/*
	// Node getRootNode(optional GetRootNodeOptions options = {});
	DKString _getRootNode = "";
	virtual const DKString& getRootNode(const DKString& options = "{}") override {
		DKDEBUGFUNC(options);
		return _getRootNode;
	}
	
	// readonly attribute Node? parentNode;
	DKString _parentNode = "";
	virtual const DKString& parentNode() override							{ return _parentNode; }					// getter
	virtual void parentNode(const DKString& parentNode) override			{ _parentNode = parentNode; } 			// setter
	
	// readonly attribute Element? parentElement;
	DKString _parentElement = "";
	virtual const DKString& parentElement() override						{ return _parentElement; }				// getter
	virtual void parentElement(const DKString& parentElement) override		{ _parentElement = parentElement; } 	// setter
	
	// boolean hasChildNodes();
	virtual bool hasChildNodes(bool& _hasChildNodes) override {
		DKDEBUGFUNC(_hasChildNodes);
		return DKTODO();
	}
	
	// [SameObject] readonly attribute NodeList childNodes;
	DKString _childNodes = "";
	virtual const DKString& childNodes() override							{ return _childNodes; }					// getter
	virtual void childNodes(const DKString& childNodes) override			{ _childNodes = childNodes; } 			// setter
	
	// readonly attribute Node? firstChild;
	DKString _firstChild = "";
	virtual const DKString& firstChild() override							{ return _firstChild; }					// getter
	virtual void firstChild(const DKString& firstChild) override			{ _firstChild = firstChild; } 			// setter
	
	// readonly attribute Node? lastChild;
	DKString _lastChild = "";
	virtual const DKString& lastChild()	override							{ return _lastChild; }					// getter
	virtual void lastChild(const DKString& lastChild) override				{ _lastChild = lastChild; } 			// setter
	
	// readonly attribute Node? previousSibling;
	DKString _previousSibling = "";
	virtual const DKString& previousSibling() override						{ return _previousSibling; }			// getter
	virtual void previousSibling(const DKString& previousSibling) override	{ _previousSibling = previousSibling; } // setter
	
	// readonly attribute Node? nextSibling;
	DKString _nextSibling = "";
	virtual const DKString& nextSibling() override							{ return _nextSibling; }				// getter
	virtual void nextSibling(const DKString& nextSibling) override			{ _nextSibling = nextSibling; } 		// setter

	// [CEReactions] attribute DOMString? nodeValue;
	DKString _nodeValue = "";
	virtual const DKString& nodeValue()	override							{ return _nodeValue; }					// getter
	virtual void nodeValue(const DKString& nodeValue) override				{ _nodeValue = nodeValue; } 			// setter
	
	// [CEReactions] attribute DOMString? textContent;
	DOMString _textContent = "";
	virtual const DOMString& textContent() override							{ return _textContent; }				// getter
	virtual void textContent(const DOMString& textContent) override			{ _textContent = textContent; } 		// setter
	
	// [CEReactions] undefined normalize();
	virtual void normalize() override {
		DKDEBUGFUNC();
		DKTODO();
	}

	// [CEReactions, NewObject] Node cloneNode(optional boolean deep = false);
	DKString _cloneNode = "";
	virtual const DKString& cloneNode(const bool& deep = false) override {
		DKDEBUGFUNC(deep);
		return _cloneNode;
	}
	
	// boolean isEqualNode(Node? otherNode);
	bool _isEqualNode = false;
	virtual const bool& isEqualNode(const DKString& otherNode) override {
		DKDEBUGFUNC(otherNode);
		return _isEqualNode;
	}
	
	// boolean isSameNode(Node? otherNode); // legacy alias of ===
	bool _isSameNode = false;
	virtual const bool& isSameNode(const DKString& otherNode) override {
		DKDEBUGFUNC(otherNode);
		return _isSameNode;
	}

	// const unsigned short DOCUMENT_POSITION_DISCONNECTED = 0x01;
	const unsigned short _DOCUMENT_POSITION_DISCONNECTED = 0x01;
	virtual const unsigned short& DOCUMENT_POSITION_DISCONNECTED() override											{ return _DOCUMENT_POSITION_DISCONNECTED; }								// getter
	//virtual void DOCUMENT_POSITION_DISCONNECTED(const unsigned short& DOCUMENT_POSITION_DISCONNECTED) override	{ _DOCUMENT_POSITION_DISCONNECTED = DOCUMENT_POSITION_DISCONNECTED; }	// setter
	
	// const unsigned short DOCUMENT_POSITION_PRECEDING = 0x02;
	const unsigned short _DOCUMENT_POSITION_PRECEDING = 0x02;
	virtual const unsigned short& DOCUMENT_POSITION_PRECEDING() override											{ return _DOCUMENT_POSITION_PRECEDING; }								// getter
	//virtual void DOCUMENT_POSITION_PRECEDING(const unsigned short& DOCUMENT_POSITION_PRECEDING) override			{ _DOCUMENT_POSITION_PRECEDING = DOCUMENT_POSITION_PRECEDING; }			// setter
	
	// const unsigned short DOCUMENT_POSITION_FOLLOWING = 0x04;
	const unsigned short _DOCUMENT_POSITION_FOLLOWING = 0x04;
	virtual const unsigned short& DOCUMENT_POSITION_FOLLOWING()	override											{ return _DOCUMENT_POSITION_FOLLOWING; }								// getter
	//virtual void DOCUMENT_POSITION_FOLLOWING(const unsigned short& DOCUMENT_POSITION_FOLLOWING) override			{ _DOCUMENT_POSITION_FOLLOWING = DOCUMENT_POSITION_FOLLOWING; }			// setter
	
	// const unsigned short DOCUMENT_POSITION_CONTAINS = 0x08;
	const unsigned short _DOCUMENT_POSITION_CONTAINS = 0x08;
	virtual const unsigned short& DOCUMENT_POSITION_CONTAINS() override												{ return _DOCUMENT_POSITION_CONTAINS; }									// getter
	//virtual void DOCUMENT_POSITION_CONTAINS(const unsigned short& DOCUMENT_POSITION_CONTAINS)	override			{ _DOCUMENT_POSITION_CONTAINS = DOCUMENT_POSITION_CONTAINS; }			// setter
	
	// const unsigned short DOCUMENT_POSITION_CONTAINED_BY = 0x10;
	const unsigned short _DOCUMENT_POSITION_CONTAINED_BY = 0x10;
	virtual const unsigned short& DOCUMENT_POSITION_CONTAINED_BY() override											{ return _DOCUMENT_POSITION_CONTAINED_BY; }								// getter
	//virtual void DOCUMENT_POSITION_CONTAINED_BY(const unsigned short& DOCUMENT_POSITION_CONTAINED_BY) override	{ _DOCUMENT_POSITION_CONTAINED_BY = DOCUMENT_POSITION_CONTAINED_BY; }	// setter
	
	// const unsigned short DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
	const unsigned short _DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
	virtual const unsigned short& DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC() override													{ return _DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC; }										// getter
	//virtual void DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC(const unsigned short& DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC) override	{ _DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC; }	// setter
	
	// unsigned short compareDocumentPosition(Node other);
	unsigned short _compareDocumentPosition = 0;
	virtual const unsigned short& compareDocumentPosition(const DKString& other) override {
		DKDEBUGFUNC(other);
		return _compareDocumentPosition;
	}
	
	// boolean contains(Node? other);
	bool _contains = false;
	virtual const bool& contains(const DKString& other) override {
		DKDEBUGFUNC(other);
		return _contains;
	}
	
	// DOMString? lookupPrefix(DOMString? namespace);
	DOMString _lookupPrefix = "";
	virtual const DOMString& lookupPrefix(const DOMString& _namespace) override {
		DKDEBUGFUNC(_namespace);
		return _lookupPrefix;
	}
	
	// DOMString? lookupNamespaceURI(DOMString? prefix);
	DOMString _lookupNamespaceURI = "";
	virtual const DOMString& lookupNamespaceURI(const DOMString& prefix) override {
		DKDEBUGFUNC(prefix);
		return _lookupNamespaceURI;
	}
	
	// boolean isDefaultNamespace(DOMString? namespace);
	bool _isDefaultNamespace = false;
	virtual const bool& isDefaultNamespace(const DOMString& _namespace) override {
		DKDEBUGFUNC(_namespace);
		return _isDefaultNamespace;
	}
	
	// [CEReactions] Node insertBefore(Node node, Node? child);
	DKString _insertBefore = "";
	virtual const DKString& insertBefore(const DKString& node, const DKString& child) override {
		DKDEBUGFUNC(node, child);
		return _insertBefore;
	}
	
	// [CEReactions] Node appendChild(Node node);
	DKString _appendChild = "";
	virtual const DKString& appendChild(const DKString& node) override {
		DKDEBUGFUNC(node);
		return _appendChild;
	}
	
	// [CEReactions] Node replaceChild(Node node, Node child);
	DKString _replaceChild = "";
	virtual const DKString& replaceChild(const DKString& node, const DKString& child) override {
		DKDEBUGFUNC(node, child);
		return _replaceChild;
	}
	
	// [CEReactions] Node removeChild(Node child);
	DKString _removeChild = "";
	virtual const DKString& removeChild(const DKString& child) override {
		DKDEBUGFUNC(child);
		return _removeChild;
	}
	*/
	
	////// toString //////
	operator std::string() const { return "[object DKRmlNode]"; }
};


#endif //DKRmlNode_H