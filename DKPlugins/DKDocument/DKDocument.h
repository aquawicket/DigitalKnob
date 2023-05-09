// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document
#pragma once
#ifndef DKDocument_H
#define DKDocument_H

#include "DKNode/DKNode.h"

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=Window]
// interface Document : Node {
class DKDocument : public DKNode
{
public:
	// constructor();
	DKDocument() : DKNode() { // https://dom.spec.whatwg.org/#dom-document-document
		DKDEBUGFUNC();
		interfaceName = "Document";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKDocument("+interfaceAddress+") \n");
	}
	
	// [SameObject] readonly attribute DOMImplementation implementation;
	virtual bool implementation(DKString&, bool) { return false; } // https://dom.spec.whatwg.org/#dom-document-implementation
	
	// readonly attribute USVString URL;
	virtual bool URL(DKString&, bool) { return false; } // https://dom.spec.whatwg.org/#dom-document-url

	// readonly attribute USVString documentURI;
	virtual bool documentURI(DKString&, bool) { return false; } // https://dom.spec.whatwg.org/#dom-document-documenturi
	
	// readonly attribute DOMString compatMode;
	virtual bool compatMode(DKString&, bool) { return false; } // https://dom.spec.whatwg.org/#dom-document-compatmode
	
	// readonly attribute DOMString characterSet;
	virtual bool characterSet(DKString&, bool) { return false; } // https://dom.spec.whatwg.org/#dom-document-characterset
	
	// readonly attribute DOMString charset; // legacy alias of .characterSet
	virtual bool charset(DKString&, bool) { return false; } // https://dom.spec.whatwg.org/#dom-document-charset
	
	// readonly attribute DOMString inputEncoding; // legacy alias of .characterSet
	virtual bool inputEncoding(DKString&, bool) { return false; } // https://dom.spec.whatwg.org/#dom-document-inputencoding
	
	// readonly attribute DOMString contentType;
	virtual bool contentType(DKString&, bool) { return false; } // https://dom.spec.whatwg.org/#dom-document-contenttype
	
	// readonly attribute DocumentType? doctype;
	virtual bool doctype(DKString&, bool) { return false; } // https://dom.spec.whatwg.org/#dom-document-doctype
	
	// readonly attribute Element? documentElement;
	virtual bool documentElement(DKString&, bool) { return false; } // https://dom.spec.whatwg.org/#dom-document-documentelement
	
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	virtual bool getElementsByTagName(DKString& _qualifiedName, DKString& _getElementsByTagName){ // https://dom.spec.whatwg.org/#dom-document-getelementsbytagname
		DKDEBUGFUNC(_qualifiedName, _getElementsByTagName);
		return DKTODO();
	}
	
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	virtual bool getElementsByTagNameNS(DKString& _namespace, DKString& _localName, DKString& _getElementsByTagNameNS){ // https://dom.spec.whatwg.org/#dom-document-getelementsbytagnamens
		DKDEBUGFUNC(_namespace, _localName, _getElementsByTagNameNS);
		return DKTODO();
	}
	
	// HTMLCollection getElementsByClassName(DOMString classNames);
	virtual bool getElementsByClassName(DKString& _classNames, DKString& _getElementsByClassName){ //https://dom.spec.whatwg.org/#dom-document-getelementsbyclassname
		DKDEBUGFUNC(_classNames, _getElementsByClassName);
		return DKTODO();
	}
	
	// [CEReactions, NewObject] Element createElement(DOMString localName, optional (DOMString or ElementCreationOptions) options = {});
	virtual bool createElement(DKString& _localName, DKString& _options, DKString& _createElement){ // https://dom.spec.whatwg.org/#dom-document-createelement
		DKDEBUGFUNC(_localName, _options, _createElement);
		return DKTODO();
	}
	
	// [CEReactions, NewObject] Element createElementNS(DOMString? namespace, DOMString qualifiedName, optional (DOMString or ElementCreationOptions) options = {});
	virtual bool createElementNS(DKString& _namespace, DKString& _qualifiedName, DKString& _options, DKString& _createElementNS){ // https://dom.spec.whatwg.org/#dom-document-createelementns
		DKDEBUGFUNC(_namespace, _qualifiedName, _options, _createElementNS);
		return DKTODO();
	}
	
	// [NewObject] DocumentFragment createDocumentFragment();
	virtual bool createDocumentFragment(DKString& _createDocumentFragment){
		DKDEBUGFUNC(_createDocumentFragment);
		return DKTODO();
	}
	
	// [NewObject] Text createTextNode(DOMString data);
	virtual bool createTextNode(DKString& _data, DKString& _createTextNode){
		DKDEBUGFUNC(_data, _createTextNode);
		return DKTODO();
	}
	
	// [NewObject] CDATASection createCDATASection(DOMString data);
	virtual bool createCDATASection(DKString& _data, DKString& _createCDATASection){
		DKDEBUGFUNC(_data, _createCDATASection);
		return DKTODO();
	}
	
	// [NewObject] Comment createComment(DOMString data);
	virtual bool createComment(DKString& _data, DKString& _createComment){
		DKDEBUGFUNC(_data, _createComment);
		return DKTODO();
	}
	
	// [NewObject] ProcessingInstruction createProcessingInstruction(DOMString target, DOMString data);
	virtual bool createProcessingInstruction(DKString& _target, DKString& _data, DKString& _createProcessingInstruction){
		DKDEBUGFUNC(_target, _data, _createProcessingInstruction);
		return DKTODO();
	}
	
	// [CEReactions, NewObject] Node importNode(Node node, optional boolean deep = false);
	virtual bool importNode(DKString& _node, bool& _deep, DKString& _importNode){
		DKDEBUGFUNC(_node, _deep, _importNode);
		return DKTODO();
	}
	
	// [CEReactions] Node adoptNode(Node node);
	virtual bool adoptNode(DKString& _node, DKString& _adoptNode){
		DKDEBUGFUNC(_node, _adoptNode);
		return DKTODO();
	}
	
	// [NewObject] Attr createAttribute(DOMString localName);
	virtual bool createAttribute(DKString& _localName, DKString& _createAttribute){
		DKDEBUGFUNC(_localName, _createAttribute);
		return DKTODO();
	}
	
	// [NewObject] Attr createAttributeNS(DOMString? namespace, DOMString qualifiedName);
	virtual bool createAttributeNS(DKString& _namespace, DKString& _qualifiedName, DKString& _createAttributeNS){
		DKDEBUGFUNC(_namespace, _qualifiedName, _createAttributeNS);
		return DKTODO();
	}
	
	// [NewObject] Event createEvent(DOMString interface); // legacy
	virtual bool createEvent(DKString& _interface, DKString& _createEvent){
		DKDEBUGFUNC(_interface, _createEvent);
		return DKTODO();
	}
	
	// [NewObject] Range createRange();
	virtual bool createRange(DKString& _createRange){
		DKDEBUGFUNC(_createRange);
		return DKTODO();
	}
	
	// NodeFilter.SHOW_ALL = 0xFFFFFFFF
	// TODO 
	
	// [NewObject] NodeIterator createNodeIterator(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	virtual bool createNodeIterator(DKString& _root, unsigned int& _whatToShow, DKString& _filter, DKString& _createNodeIterator){
		DKDEBUGFUNC(_root, _whatToShow, _filter, _createNodeIterator);
		return DKTODO();
	}
	
	// [NewObject] TreeWalker createTreeWalker(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	virtual bool createTreeWalker(DKString& _root, unsigned int& _whatToShow, DKString& _filter, DKString& _createTreeWalker){
		DKDEBUGFUNC(_root, _whatToShow, _filter, _createTreeWalker);
		return DKTODO();
	}

// };
  
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// Document includes NonElementParentNode;

	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// Document includes DocumentOrShadowRoot;

	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// Document includes ParentNode;

	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// Document includes XPathEvaluatorBase;
	
	// Source: Font Metrics API Level 1 (https://drafts.css-houdini.org/font-metrics-api-1/)
	// partial interface Document {
	//		FontMetrics measureElement(Element element);
			// TODO
	//
	//		FontMetrics measureText(DOMString text, StylePropertyMapReadOnly styleMap);
			// TODO
	//};

	// Source: Fullscreen API Standard (https://fullscreen.spec.whatwg.org/)
	// partial interface Document {
	//		[LegacyLenientSetter] readonly attribute boolean fullscreenEnabled;
			// TODO
	//		
	//		[LegacyLenientSetter, Unscopable] readonly attribute boolean fullscreen; // historical
			// TODO
	//
	//		Promise<undefined> exitFullscreen();
			// TODO
	//
	//		attribute EventHandler onfullscreenchange;
			// TODO
	//
	//		attribute EventHandler onfullscreenerror;
	//		// TODO
	//};
};


#endif //DKDocument_H