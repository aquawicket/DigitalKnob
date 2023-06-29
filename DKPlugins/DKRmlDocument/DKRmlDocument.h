// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document
#pragma once
#ifndef DKRmlDocument_H
#define DKRmlDocument_H

#include "DKDocument/DKDocument.h"
#include "DKRmlInterface/DKRmlInterface.h"
#include "DKRmlNonElementParentNode/DKRmlNonElementParentNode.h"
#include "DKRmlElement/DKRmlElement.h"
class DKHTMLCollection;

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=Window]
// interface Document : Node {
class DKRmlDocument : public DKDocument, public DKRmlNonElementParentNode
{
public:
	static std::vector<DKRmlDocument*> list;
	static DKRmlDocument* instance(DKRmlInterface* dkRmlInterface, DKRmlEventListener* dkRmlEventListener){
		for(unsigned int i=0; i<list.size(); ++i){
			if(dkRmlInterface == list[i]->_dkRmlInterface)
				return list[i];
		}
		return new DKRmlDocument(dkRmlInterface, dkRmlEventListener);
	}
	
	DKRmlInterface* _dkRmlInterface;
	DKRmlEventListener* _dkRmlEventListener;
	
	// constructor();
	DKRmlDocument(DKRmlInterface* dkRmlInterface, DKRmlEventListener* dkRmlEventListener) : DKDocument(), DKRmlNonElementParentNode(dkRmlInterface, dkRmlEventListener) {
		DKDEBUGFUNC();
		interfaceName = "DKRmlDocument";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKRmlDocument("+interfaceAddress+") \n");
		_dkRmlInterface = dkRmlInterface;
		_dkRmlEventListener = dkRmlEventListener;
		
		list.push_back(this);
	}
	virtual ~DKRmlDocument() {	}
	
	/*
	// [SameObject] readonly attribute DOMImplementation implementation;
	DKString _implementation = "";
	virtual const DKString& implementation() override						{ return _implementation; }					// getter
	virtual void implementation(const DKString& implementation) override	{ _implementation = implementation; }		// setter
	*/
	
	// readonly attribute USVString URL;
	//USVString _URL = "";
	virtual const USVString& URL() override									{ return _dkRmlInterface->href_; }			// getter
	virtual void URL(const USVString& URL) override							{ _dkRmlInterface->LoadUrl(URL); } 			// setter

	/*
	// readonly attribute USVString documentURI;
	USVString _documentURI = "";
	virtual const USVString& documentURI() override							{ return _documentURI; }					// getter
	virtual void documentURI(const USVString& documentURI) override			{ _documentURI = documentURI; } 			// setter
	
	// readonly attribute DOMString compatMode;
	DOMString _compatMode = "";
	virtual const DOMString& compatMode() override							{ return _compatMode; }						// getter
	virtual void compatMode(const DOMString& compatMode) override			{ _compatMode = compatMode; } 				// setter
	
	// readonly attribute DOMString characterSet;
	DOMString _characterSet = "";
	virtual const DOMString& characterSet() override						{ return _characterSet; }					// getter
	virtual void characterSet(const DOMString& characterSet) override		{ _characterSet = characterSet; } 			// setter
	
	// readonly attribute DOMString charset; // legacy alias of .characterSet
	DOMString _charset = "";
	virtual const DOMString& charset() override								{ return _charset; }						// getter
	virtual void charset(const DOMString& charset) override					{ _charset = charset; } 					// setter
	
	// readonly attribute DOMString inputEncoding; // legacy alias of .characterSet
	DOMString _inputEncoding = "";
	virtual const DOMString& inputEncoding() override						{ return _inputEncoding; }					// getter
	virtual void inputEncoding(const DOMString& inputEncoding) override		{ _inputEncoding = inputEncoding; } 		// setter
	
	// readonly attribute DOMString contentType;
	DOMString _contentType = "";
	virtual const DOMString& contentType() override							{ return _contentType; }					// getter
	virtual void contentType(const DOMString& contentType) override			{ _contentType = contentType; } 			// setter
	
	// readonly attribute DocumentType? doctype;
	DKString _doctype = "";
	virtual const DKString& doctype() override								{ return _doctype; }						// getter
	virtual void doctype(const DKString& doctype) override					{ _doctype = doctype; } 					// setter
	*/
	
	// readonly attribute Element? documentElement;
	virtual DKElement* documentElement() override { 																	// getter
		DKDEBUGFUNC();
		Rml::Element* element = _dkRmlInterface->document;
		return (DKElement*)DKRmlElement::instance(_dkRmlEventListener, element);
	}				
	virtual void documentElement(DKElement* documentElement) override { 												// setter
		DKDEBUGFUNC(documentElement);
		DKTODO();
	} 	
	
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);	
	virtual DKHTMLCollection* getElementsByTagName(const DOMString& qualifiedName) override {
		DKDEBUGFUNC(qualifiedName);
		Rml::ElementList elements;
		_dkRmlInterface->document->GetElementsByTagName(elements, qualifiedName.c_str());
		if(elements.empty()){
			DKERROR("elements.empty()\n");
			return NULL;
		}
		std::vector<DKElement*>* element_list = new std::vector<DKElement*>;
		for(unsigned int i=0; i<elements.size(); ++i){
			element_list->push_back(DKRmlElement::instance(_dkRmlEventListener, elements[i]));
		}
		DKINFO("element_list->size() = "+toString(element_list->size())+"\n");
		DKHTMLCollection* htmlCollection = new DKHTMLCollection(*element_list);	// FIXME: dangling pointer
		DKINFO("htmlCollection->length() = "+toString(htmlCollection->length())+"\n");
		return htmlCollection; 
	}
	
	/*
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	DKString _getElementsByTagNameNS = "";
	virtual const DKString& getElementsByTagNameNS(const DOMString& _namespace, const DOMString& localName) override {
		DKDEBUGFUNC(_namespace, localName);
		return _getElementsByTagNameNS;
	}
	
	// HTMLCollection getElementsByClassName(DOMString classNames);
	DKString _getElementsByClassName = "";
	virtual const DKString& getElementsByClassName(const DOMString& classNames) override {
		DKDEBUGFUNC(classNames);
		return _getElementsByClassName;
	}
	*/
	// [CEReactions, NewObject] Element createElement(DOMString localName, optional (DOMString or ElementCreationOptions) options = {});
	virtual DKElement* createElement(const DOMString& localName, const DOMString& options = "{}") override {
		DKDEBUGFUNC(localName, options);
		Rml::Element* element = _dkRmlInterface->document->AppendChild(_dkRmlInterface->document->CreateElement(localName.c_str()), false);
		_createElement = DKRmlElement::instance(_dkRmlEventListener, element);
		return _createElement;
	}
	/*
	// [CEReactions, NewObject] Element createElementNS(DOMString? namespace, DOMString qualifiedName, optional (DOMString or ElementCreationOptions) options = {});
	DKString _createElementNS = "";
	virtual const DKString& createElementNS(const DOMString& _namespace, const DOMString& qualifiedName, const DKString& options = "{}") override {
		DKDEBUGFUNC(_namespace, qualifiedName, options);
		return _createElementNS;
	}
	
	// [NewObject] DocumentFragment createDocumentFragment();
	DKString _createDocumentFragment = "";
	virtual const DKString& createDocumentFragment() override {
		return _createDocumentFragment;
	}
	
	// [NewObject] Text createTextNode(DOMString data);
	DKString _createTextNode = "";
	virtual const DKString& createTextNode(const DOMString& data) override {
		DKDEBUGFUNC(data);
		return _createTextNode;
	}
	
	// [NewObject] CDATASection createCDATASection(DOMString data);
	DKString _createCDATASection = "";
	virtual const DKString& createCDATASection(const DOMString& data) override {
		DKDEBUGFUNC(data);
		return _createCDATASection;
	}
	
	// [NewObject] Comment createComment(DOMString data);
	DKString _createComment = "";
	virtual const DKString& createComment(const DOMString& _data) override {
		DKDEBUGFUNC(_data);
		return _createComment;
	}
	
	// [NewObject] ProcessingInstruction createProcessingInstruction(DOMString target, DOMString data);
	DKString _createProcessingInstruction = "";
	virtual const DKString& createProcessingInstruction(const DOMString& target, const DOMString& data) override {
		DKDEBUGFUNC(target, data);
		return _createProcessingInstruction;
	}
	
	// [CEReactions, NewObject] Node importNode(Node node, optional boolean deep = false);
	DKString _importNode = "";
	virtual const DKString& importNode(const DKString& node, const bool& deep = false) override {
		DKDEBUGFUNC(node, deep);
		return _importNode;
	}
	
	// [CEReactions] Node adoptNode(Node node);
	DKString _adoptNode = "";
	virtual const DKString& adoptNode(const DKString& node) override {
		DKDEBUGFUNC(node);
		return _adoptNode;
	}
	
	// [NewObject] Attr createAttribute(DOMString localName);
	DKString _createAttribute = "";
	virtual const DKString& createAttribute(const DOMString& localName) override {
		DKDEBUGFUNC(localName);
		return _createAttribute;
	}
	
	// [NewObject] Attr createAttributeNS(DOMString? namespace, DOMString qualifiedName);
	DKString _createAttributeNS = "";
	virtual const DKString& createAttributeNS(const DOMString& _namespace, const DOMString& qualifiedName) override {
		DKDEBUGFUNC(_namespace, qualifiedName);
		return _createAttributeNS;
	}
	
	// [NewObject] Event createEvent(DOMString interface); // legacy
	DKString _createEvent = "";
	virtual const DKString& createEvent(const DOMString& interface) override {
		DKDEBUGFUNC(interface);
		return _createEvent;
	}
	
	// [NewObject] Range createRange();
	DKString _createRange = "";
	virtual const DKString& createRange() override {
		DKDEBUGFUNC();
		return _createRange;
	}
	
	// NodeFilter.SHOW_ALL = 0xFFFFFFFF
	// TODO 
	
	// [NewObject] NodeIterator createNodeIterator(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	DKString _createNodeIterator = "";
	virtual const DKString& createNodeIterator(const DKString& root, const unsigned int& whatToShow = 0xFFFFFFFF, const DKString& filter = "null") override {
		DKDEBUGFUNC(root, whatToShow, filter);
		return _createNodeIterator;
	}
	
	// [NewObject] TreeWalker createTreeWalker(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	DKString _createTreeWalker = "";
	virtual const DKString& createTreeWalker(const DKString& root, const unsigned int& whatToShow = 0xFFFFFFFF, const DKString& filter = "null") override {
		DKDEBUGFUNC(root, whatToShow, filter);
		return _createTreeWalker;
	}

// };
  */
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// Document includes NonElementParentNode;
	/*
	virtual DKElement* getElementById(const DOMString& elementId) override {
		DKDEBUGFUNC(elementId);
		Rml::Element* element = _dkRmlInterface->document->GetElementById(elementId.c_str());
		return new DKRmlElement(_dkRmlInterface, element);		// FIXME: danggling pointer
	}
	*/
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
			virtual const DKString& measureElement(const DKString& element) override {
				DKDEBUGFUNC(element);
				return _measureElement;
			}
	//
	//		FontMetrics measureText(DOMString text, StylePropertyMapReadOnly styleMap);
			DKString _measureText = "";
			virtual const DKString& measureText(const DOMString& text, const DKString& styleMap) override {
				DKDEBUGFUNC(text, styleMap);
				return _measureText;
			}
	//};

	// Source: Fullscreen API Standard (https://fullscreen.spec.whatwg.org/)
	// partial interface Document {
	//		[LegacyLenientSetter] readonly attribute boolean fullscreenEnabled;
			bool _fullscreenEnabled = false;
			virtual const bool& fullscreenEnabled() override							{ return _fullscreenEnabled; }					// getter
			virtual void fullscreenEnabled(const bool& fullscreenEnabled) override		{ _fullscreenEnabled = fullscreenEnabled; } 	// setter
	//		
	//		[LegacyLenientSetter, Unscopable] readonly attribute boolean fullscreen; // historical
			bool _fullscreen = false;
			virtual const bool& fullscreen() override									{ return _fullscreen; }							// getter
			virtual void fullscreen(const bool& fullscreen) override					{ _fullscreen = fullscreen; } 					// setter
	//
	//		Promise<undefined> exitFullscreen();
			DKString _exitFullscreen = "";
			virtual const DKString& exitFullscreen() override {
				DKDEBUGFUNC();
				return _exitFullscreen;
			}
	//
	//		attribute EventHandler onfullscreenchange;
			DKString _onfullscreenchange = "";
			virtual const DKString& onfullscreenchange() override							{ return _onfullscreenchange; }					// getter
			virtual void onfullscreenchange(const DKString& onfullscreenchange) override	{ _onfullscreenchange = onfullscreenchange; } 	// setter
	//
	//		attribute EventHandler onfullscreenerror;
			DKString _onfullscreenerror = "";
			virtual const DKString& onfullscreenerror() override							{ return _onfullscreenerror; }					// getter
			virtual void onfullscreenerror(const DKString& onfullscreenerror) override		{ _onfullscreenerror = onfullscreenerror; } 	// setter
	//};
	*/
};


#endif //DKRmlDocument_H