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
	DKString _implementation = "";
	virtual const DKString& implementation()						{ return _implementation; }					// getter
	virtual void implementation(const DKString& implementation)		{ _implementation = implementation; }		// setter
	
	// readonly attribute USVString URL;
	USVString _URL = "";
	virtual const USVString& URL()									{ return _URL; }							// getter
	virtual void URL(const USVString& URL)							{ _URL = URL; } 							// setter

	// readonly attribute USVString documentURI;
	USVString _documentURI = "";
	virtual const USVString& documentURI()							{ return _documentURI; }					// getter
	virtual void documentURI(const USVString& documentURI)			{ _documentURI = documentURI; } 			// setter
	
	// readonly attribute DOMString compatMode;
	DOMString _compatMode = "";
	virtual const DOMString& compatMode()							{ return _compatMode; }						// getter
	virtual void compatMode(const DOMString& compatMode)			{ _compatMode = compatMode; } 				// setter
	
	// readonly attribute DOMString characterSet;
	DOMString _characterSet = "";
	virtual const DOMString& characterSet()							{ return _characterSet; }					// getter
	virtual void characterSet(const DOMString& characterSet)		{ _characterSet = characterSet; } 			// setter
	
	// readonly attribute DOMString charset; // legacy alias of .characterSet
	DOMString _charset = "";
	virtual const DOMString& charset()								{ return _charset; }						// getter
	virtual void charset(const DOMString& charset)					{ _charset = charset; } 					// setter
	
	// readonly attribute DOMString inputEncoding; // legacy alias of .characterSet
	DOMString _inputEncoding = "";
	virtual const DOMString& inputEncoding()						{ return _inputEncoding; }					// getter
	virtual void inputEncoding(const DOMString& inputEncoding)		{ _inputEncoding = inputEncoding; } 		// setter
	
	// readonly attribute DOMString contentType;
	DOMString _contentType = "";
	virtual const DOMString& contentType()							{ return _contentType; }					// getter
	virtual void contentType(const DOMString& contentType)			{ _contentType = contentType; } 			// setter
	
	// readonly attribute DocumentType? doctype;
	DKString _doctype = "";
	virtual const DKString& doctype()								{ return _doctype; }						// getter
	virtual void doctype(const DKString& doctype)					{ _doctype = doctype; } 					// setter
	
	// readonly attribute Element? documentElement;
	DKString _documentElement = "";
	virtual const DKString& documentElement()						{ return _documentElement; }				// getter
	virtual void documentElement(const DKString& documentElement)	{ _documentElement = documentElement; } 	// setter
	
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	DKString _getElementsByTagName = "";
	virtual const DKString& getElementsByTagName(const DOMString& qualifiedName){
		DKDEBUGFUNC(qualifiedName);
		return _getElementsByTagName;
	}
	
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	DKString _getElementsByTagNameNS = "";
	virtual const DKString& getElementsByTagNameNS(const DOMString& _namespace, const DOMString& localName){
		DKDEBUGFUNC(_namespace, localName);
		return _getElementsByTagNameNS;
	}
	
	// HTMLCollection getElementsByClassName(DOMString classNames);
	DKString _getElementsByClassName = "";
	virtual const DKString& getElementsByClassName(const DOMString& classNames){
		DKDEBUGFUNC(classNames);
		return _getElementsByClassName;
	}
	
	// [CEReactions, NewObject] Element createElement(DOMString localName, optional (DOMString or ElementCreationOptions) options = {});
	DKString _createElement = "";
	virtual const DKString& createElement(const DOMString& localName, const DKString& options){
		DKDEBUGFUNC(localName, options);
		return _createElement;
	}
	
	// [CEReactions, NewObject] Element createElementNS(DOMString? namespace, DOMString qualifiedName, optional (DOMString or ElementCreationOptions) options = {});
	DKString _createElementNS = "";
	virtual const DKString& createElementNS(const DOMString& _namespace, const DOMString& qualifiedName, const DKString& options){ // https://dom.spec.whatwg.org/#dom-document-createelementns
		DKDEBUGFUNC(_namespace, qualifiedName, options);
		return _createElementNS;
	}
	
	// [NewObject] DocumentFragment createDocumentFragment();
	DKString _createDocumentFragment = "";
	virtual const DKString& createDocumentFragment(){
		return _createDocumentFragment;
	}
	
	// [NewObject] Text createTextNode(DOMString data);
	DKString _createTextNode = "";
	virtual const DKString& createTextNode(const DOMString& data){
		DKDEBUGFUNC(data);
		return _createTextNode;
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