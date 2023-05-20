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
	virtual DKString implementation()						{ return ""; }	// getter
	virtual void implementation(const DKString&)			{ } 			// setter
	
	// readonly attribute USVString URL;
	virtual USVString URL()									{ return ""; }	// getter
	virtual void URL(const USVString&)						{ } 			// setter

	// readonly attribute USVString documentURI;
	virtual USVString documentURI()							{ return ""; }	// getter
	virtual void documentURI(const USVString&)				{ } 			// setter
	
	// readonly attribute DOMString compatMode;
	virtual DOMString compatMode()							{ return ""; }	// getter
	virtual void compatMode(const DOMString&)				{ } 			// setter
	
	// readonly attribute DOMString characterSet;
	virtual DOMString characterSet()						{ return ""; }	// getter
	virtual void characterSet(const DOMString&)				{ } 			// setter
	
	// readonly attribute DOMString charset; // legacy alias of .characterSet
	virtual DOMString charset()								{ return ""; }	// getter
	virtual void charset(const DOMString&)					{ } 			// setter
	
	// readonly attribute DOMString inputEncoding; // legacy alias of .characterSet
	virtual DOMString inputEncoding()						{ return ""; }	// getter
	virtual void inputEncoding(const DOMString&)			{ } 			// setter
	
	// readonly attribute DOMString contentType;
	virtual DOMString contentType()							{ return ""; }	// getter
	virtual void contentType(const DOMString&)				{ } 			// setter
	
	// readonly attribute DocumentType? doctype;
	virtual DKString doctype()								{ return ""; }	// getter
	virtual void doctype(const DKString&)					{ } 			// setter
	
	// readonly attribute Element? documentElement;
	virtual DKString documentElement()						{ return ""; }	// getter
	virtual void documentElement(const DKString&)			{ } 			// setter
	
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	virtual bool getElementsByTagName(DOMString& qualifiedName, DKString& getElementsByTagName){ // https://dom.spec.whatwg.org/#dom-document-getelementsbytagname
		DKDEBUGFUNC(qualifiedName, getElementsByTagName);
		return DKTODO();
	}
	
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	virtual bool getElementsByTagNameNS(DOMString& _namespace, DOMString& localName, DKString& getElementsByTagNameNS){ // https://dom.spec.whatwg.org/#dom-document-getelementsbytagnamens
		DKDEBUGFUNC(_namespace, localName, getElementsByTagNameNS);
		return DKTODO();
	}
	
	// HTMLCollection getElementsByClassName(DOMString classNames);
	virtual bool getElementsByClassName(DOMString& classNames, DKString& getElementsByClassName){ //https://dom.spec.whatwg.org/#dom-document-getelementsbyclassname
		DKDEBUGFUNC(classNames, getElementsByClassName);
		return DKTODO();
	}
	
	// [CEReactions, NewObject] Element createElement(DOMString localName, optional (DOMString or ElementCreationOptions) options = {});
	virtual bool createElement(DOMString& localName, DKString& options, DKString& createElement){ // https://dom.spec.whatwg.org/#dom-document-createelement
		DKDEBUGFUNC(localName, options, createElement);
		return DKTODO();
	}
	
	// [CEReactions, NewObject] Element createElementNS(DOMString? namespace, DOMString qualifiedName, optional (DOMString or ElementCreationOptions) options = {});
	virtual bool createElementNS(DOMString& _namespace, DOMString& qualifiedName, DKString& options, DKString& createElementNS){ // https://dom.spec.whatwg.org/#dom-document-createelementns
		DKDEBUGFUNC(_namespace, qualifiedName, options, createElementNS);
		return DKTODO();
	}
	
	// [NewObject] DocumentFragment createDocumentFragment();
	virtual bool createDocumentFragment(DKString& createDocumentFragment){
		DKDEBUGFUNC(createDocumentFragment);
		return DKTODO();
	}
	
	// [NewObject] Text createTextNode(DOMString data);
	virtual bool createTextNode(DOMString& data, DKString& createTextNode){
		DKDEBUGFUNC(data, createTextNode);
		return DKTODO();
	}
	
	// [NewObject] CDATASection createCDATASection(DOMString data);
	virtual bool createCDATASection(DOMString& _data, DKString& _createCDATASection){
		DKDEBUGFUNC(_data, _createCDATASection);
		return DKTODO();
	}
	
	// [NewObject] Comment createComment(DOMString data);
	virtual bool createComment(DOMString& _data, DKString& _createComment){
		DKDEBUGFUNC(_data, _createComment);
		return DKTODO();
	}
	
	// [NewObject] ProcessingInstruction createProcessingInstruction(DOMString target, DOMString data);
	virtual bool createProcessingInstruction(DOMString& _target, DOMString& _data, DKString& _createProcessingInstruction){
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
	virtual bool createAttribute(DOMString& _localName, DKString& _createAttribute){
		DKDEBUGFUNC(_localName, _createAttribute);
		return DKTODO();
	}
	
	// [NewObject] Attr createAttributeNS(DOMString? namespace, DOMString qualifiedName);
	virtual bool createAttributeNS(DOMString& _namespace, DOMString& _qualifiedName, DKString& _createAttributeNS){
		DKDEBUGFUNC(_namespace, _qualifiedName, _createAttributeNS);
		return DKTODO();
	}
	
	// [NewObject] Event createEvent(DOMString interface); // legacy
	virtual bool createEvent(DOMString& _interface, DKString& _createEvent){
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
			virtual bool measureElement(DKString& _element, DKString& _measureElement){
				DKDEBUGFUNC(_element, _measureElement);
				return DKTODO();
			}
	//
	//		FontMetrics measureText(DOMString text, StylePropertyMapReadOnly styleMap);
			virtual bool measureText(DOMString& _text, DKString& _styleMap, DKString& _measureText){
				DKDEBUGFUNC(_text, _styleMap, _measureText);
				return DKTODO();
			}
	//};

	// Source: Fullscreen API Standard (https://fullscreen.spec.whatwg.org/)
	// partial interface Document {
	//		[LegacyLenientSetter] readonly attribute boolean fullscreenEnabled;
			virtual bool fullscreenEnabled()							{ return false; }	// getter
			virtual void fullscreenEnabled(const bool&)					{ } 				// setter
	//		
	//		[LegacyLenientSetter, Unscopable] readonly attribute boolean fullscreen; // historical
			virtual bool fullscreen()									{ return false; }	// getter
			virtual void fullscreen(const bool&)						{ } 				// setter
	//
	//		Promise<undefined> exitFullscreen();
			virtual bool exitFullscreen(DKString& _exitFullscreen){
				DKDEBUGFUNC(_exitFullscreen);
				return DKTODO();
			}
	//
	//		attribute EventHandler onfullscreenchange;
			virtual DKString onfullscreenchange()						{ return ""; }		// getter
			virtual void onfullscreenchange(const DKString&)			{ } 				// setter
	//
	//		attribute EventHandler onfullscreenerror;
			virtual DKString onfullscreenerror()						{ return ""; }		// getter
			virtual void onfullscreenerror(const DKString&)				{ } 				// setter
	//};
};


#endif //DKDocument_H