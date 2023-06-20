// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document
#pragma once
#ifndef DKDocument_H
#define DKDocument_H

#include "DKNode/DKNode.h"
//#include "DKNonElementParentNode/DKNonElementParentNode.h"	// mixin
#include "DKHTMLCollection/DKHTMLCollection.h"


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=Window]
// interface Document : Node {
class DKDocument : public DKNode//, public DKNonElementParentNode
{
public:
	// constructor();
	DKDocument() : DKNode() { // https://dom.spec.whatwg.org/#dom-document-document
		DKDEBUGFUNC();
		interfaceName = "Document";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKDocument("+interfaceAddress+") \n");
	}
	//virtual ~DKDocument(){}
	
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
	DKElement* _documentElement = NULL;
	virtual DKElement* documentElement()							{ return _documentElement; }				// getter
	virtual void documentElement(DKElement* documentElement)		{ _documentElement = documentElement; } 	// setter
	
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	DKHTMLCollection* _getElementsByTagName = NULL;
	virtual DKHTMLCollection* getElementsByTagName(const DOMString& qualifiedName){
		DKDEBUGFUNC(qualifiedName);
		return _getElementsByTagName;
	}
	
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	DKHTMLCollection* _getElementsByTagNameNS = NULL;
	virtual DKHTMLCollection* getElementsByTagNameNS(const DOMString& _namespace, const DOMString& localName){
		DKDEBUGFUNC(_namespace, localName);
		return _getElementsByTagNameNS;
	}
	
	// HTMLCollection getElementsByClassName(DOMString classNames);
	DKHTMLCollection* _getElementsByClassName = NULL;
	virtual DKHTMLCollection* getElementsByClassName(const DOMString& classNames){
		DKDEBUGFUNC(classNames);
		return _getElementsByClassName;
	}
	
	// [CEReactions, NewObject] Element createElement(DOMString localName, optional (DOMString or ElementCreationOptions) options = {});
	DKElement* _createElement = NULL;
	virtual DKElement* createElement(const DOMString& localName, const DKString& options = "{}"){
		DKDEBUGFUNC(localName, options);
		return _createElement;
	}
	
	// [CEReactions, NewObject] Element createElementNS(DOMString? namespace, DOMString qualifiedName, optional (DOMString or ElementCreationOptions) options = {});
	DKElement* _createElementNS = NULL;
	virtual DKElement* createElementNS(const DOMString& _namespace, const DOMString& qualifiedName, const DKString& options = "{}"){ // https://dom.spec.whatwg.org/#dom-document-createelementns
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
	DKNode* _importNode = NULL;
	virtual DKNode* importNode(DKNode* node, const bool& deep = false){
		DKDEBUGFUNC(node, deep);
		return _importNode;
	}
	
	// [CEReactions] Node adoptNode(Node node);
	DKNode* _adoptNode = NULL;
	virtual DKNode* adoptNode(DKNode* node){
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
	DKEvent* _createEvent = NULL;
	virtual DKEvent* createEvent(const DOMString& interface){
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
	virtual const DKString& createNodeIterator(DKNode* root, const unsigned int& whatToShow = 0xFFFFFFFF, const DKString& filter = "null"){
		DKDEBUGFUNC(root, whatToShow, filter);
		return _createNodeIterator;
	}
	
	// [NewObject] TreeWalker createTreeWalker(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	DKString _createTreeWalker = "";
	virtual const DKString& createTreeWalker(DKNode* root, const unsigned int& whatToShow = 0xFFFFFFFF, const DKString& filter = "null"){
		DKDEBUGFUNC(root, whatToShow, filter);
		return _createTreeWalker;
	}

// };
  
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// Document includes NonElementParentNode;
	//friend class DKNonElementParentNode;

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
			virtual const DKString& measureElement(DKElement* element){
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
	
	
	////// toString //////
	operator std::string() const { return "[object Document]"; }
};


class DKNullDocument : public DKDocument
{
public:
	operator std::string() const { return "null"; }
};


#endif //DKDocument_H