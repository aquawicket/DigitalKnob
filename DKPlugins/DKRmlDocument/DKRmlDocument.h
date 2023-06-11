// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document
#pragma once
#ifndef DKRmlDocument_H
#define DKRmlDocument_H

#include "DKDocument/DKDocument.h"
#include "DKRmlInterface/DKRmlInterface.h"

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=Window]
// interface Document : Node {
class DKRmlDocument : public DKDocument
{
public:
	DKRmlInterface* _dkRmlInterface;
	
	// constructor();
	DKRmlDocument(DKRmlInterface* dkRmlInterface) : DKDocument() {
		DKDEBUGFUNC();
		interfaceName = "DKRmlDocument";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKRmlDocument("+interfaceAddress+") \n");
		_dkRmlInterface = dkRmlInterface;
	}
	
	virtual ~DKRmlDocument() {	}
	
	/*
	// [SameObject] readonly attribute DOMImplementation implementation;
	DKString _implementation = "";
	virtual const DKString& implementation()						{ return _implementation; }					// getter
	virtual void implementation(const DKString& implementation)		{ _implementation = implementation; }		// setter
	*/
	
	// readonly attribute USVString URL;
	//USVString _URL = "";
	virtual const USVString& URL()									{ return _dkRmlInterface->href_; }			// getter
	virtual void URL(const USVString& URL)							{ _dkRmlInterface->LoadUrl(URL); } 			// setter

	/*
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
	virtual const DKString& createElement(const DOMString& localName, const DKString& options = "{}"){
		DKDEBUGFUNC(localName, options);
		return _createElement;
	}
	
	// [CEReactions, NewObject] Element createElementNS(DOMString? namespace, DOMString qualifiedName, optional (DOMString or ElementCreationOptions) options = {});
	DKString _createElementNS = "";
	virtual const DKString& createElementNS(const DOMString& _namespace, const DOMString& qualifiedName, const DKString& options = "{}"){ // https://dom.spec.whatwg.org/#dom-document-createelementns
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
	DKString _createCDATASection = "";
	virtual const DKString& createCDATASection(const DOMString& data){
		DKDEBUGFUNC(data);
		return _createCDATASection;
	}
	
	// [NewObject] Comment createComment(DOMString data);
	DKString _createComment = "";
	virtual const DKString& createComment(const DOMString& _data){
		DKDEBUGFUNC(_data);
		return _createComment;
	}
	
	// [NewObject] ProcessingInstruction createProcessingInstruction(DOMString target, DOMString data);
	DKString _createProcessingInstruction = "";
	virtual const DKString& createProcessingInstruction(const DOMString& target, const DOMString& data){
		DKDEBUGFUNC(target, data);
		return _createProcessingInstruction;
	}
	
	// [CEReactions, NewObject] Node importNode(Node node, optional boolean deep = false);
	DKString _importNode = "";
	virtual const DKString& importNode(const DKString& node, const bool& deep = false){
		DKDEBUGFUNC(node, deep);
		return _importNode;
	}
	
	// [CEReactions] Node adoptNode(Node node);
	DKString _adoptNode = "";
	virtual const DKString& adoptNode(const DKString& node){
		DKDEBUGFUNC(node);
		return _adoptNode;
	}
	
	// [NewObject] Attr createAttribute(DOMString localName);
	DKString _createAttribute = "";
	virtual const DKString& createAttribute(const DOMString& localName){
		DKDEBUGFUNC(localName);
		return _createAttribute;
	}
	
	// [NewObject] Attr createAttributeNS(DOMString? namespace, DOMString qualifiedName);
	DKString _createAttributeNS = "";
	virtual const DKString& createAttributeNS(const DOMString& _namespace, const DOMString& qualifiedName){
		DKDEBUGFUNC(_namespace, qualifiedName);
		return _createAttributeNS;
	}
	
	// [NewObject] Event createEvent(DOMString interface); // legacy
	DKString _createEvent = "";
	virtual const DKString& createEvent(const DOMString& interface){
		DKDEBUGFUNC(interface);
		return _createEvent;
	}
	
	// [NewObject] Range createRange();
	DKString _createRange = "";
	virtual const DKString& createRange(){
		DKDEBUGFUNC();
		return _createRange;
	}
	
	// NodeFilter.SHOW_ALL = 0xFFFFFFFF
	// TODO 
	
	// [NewObject] NodeIterator createNodeIterator(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	DKString _createNodeIterator = "";
	virtual const DKString& createNodeIterator(const DKString& root, const unsigned int& whatToShow = 0xFFFFFFFF, const DKString& filter = "null"){
		DKDEBUGFUNC(root, whatToShow, filter);
		return _createNodeIterator;
	}
	
	// [NewObject] TreeWalker createTreeWalker(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	DKString _createTreeWalker = "";
	virtual const DKString& createTreeWalker(const DKString& root, const unsigned int& whatToShow = 0xFFFFFFFF, const DKString& filter = "null"){
		DKDEBUGFUNC(root, whatToShow, filter);
		return _createTreeWalker;
	}

// };
  */
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// Document includes NonElementParentNode;
	DKElement* _getElementById = NULL;
	virtual const DKElement* getElementById(const DOMString& elementId) {
		DKDEBUGFUNC(elementId);
		DKTODO();
		return _getElementById;
	}
/*
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// Document includes DocumentOrShadowRoot;

	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// Document includes ParentNode;

	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// Document includes XPathEvaluatorBase;
	
	// Source: Font Metrics API Level 1 (https://drafts.css-houdini.org/font-metrics-api-1/)
	// partial interface Document {
	//		FontMetrics measureElement(Element element);
			DKString _measureElement = "";
			virtual const DKString& measureElement(const DKString& element){
				DKDEBUGFUNC(element);
				return _measureElement;
			}
	//
	//		FontMetrics measureText(DOMString text, StylePropertyMapReadOnly styleMap);
			DKString _measureText = "";
			virtual const DKString& measureText(const DOMString& text, const DKString& styleMap){
				DKDEBUGFUNC(text, styleMap);
				return _measureText;
			}
	//};

	// Source: Fullscreen API Standard (https://fullscreen.spec.whatwg.org/)
	// partial interface Document {
	//		[LegacyLenientSetter] readonly attribute boolean fullscreenEnabled;
			bool _fullscreenEnabled = false;
			virtual const bool& fullscreenEnabled()							{ return _fullscreenEnabled; }					// getter
			virtual void fullscreenEnabled(const bool& fullscreenEnabled)	{ _fullscreenEnabled = fullscreenEnabled; } 	// setter
	//		
	//		[LegacyLenientSetter, Unscopable] readonly attribute boolean fullscreen; // historical
			bool _fullscreen = false;
			virtual const bool& fullscreen()								{ return _fullscreen; }							// getter
			virtual void fullscreen(const bool& fullscreen)					{ _fullscreen = fullscreen; } 					// setter
	//
	//		Promise<undefined> exitFullscreen();
			DKString _exitFullscreen = "";
			virtual const DKString& exitFullscreen(){
				DKDEBUGFUNC();
				return _exitFullscreen;
			}
	//
	//		attribute EventHandler onfullscreenchange;
			DKString _onfullscreenchange = "";
			virtual const DKString& onfullscreenchange()							{ return _onfullscreenchange; }					// getter
			virtual void onfullscreenchange(const DKString& onfullscreenchange)		{ _onfullscreenchange = onfullscreenchange; } 	// setter
	//
	//		attribute EventHandler onfullscreenerror;
			DKString _onfullscreenerror = "";
			virtual const DKString& onfullscreenerror()								{ return _onfullscreenerror; }					// getter
			virtual void onfullscreenerror(const DKString& onfullscreenerror)		{ _onfullscreenerror = onfullscreenerror; } 	// setter
	//};
	*/
};


#endif //DKRmlDocument_H