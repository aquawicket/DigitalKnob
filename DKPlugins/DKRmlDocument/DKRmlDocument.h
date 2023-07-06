// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document
#pragma once
#ifndef DKRmlDocument_H
#define DKRmlDocument_H

#include "DKDocument/DKDocument.h"
#include "DKRmlNode/DKRmlNode.h"
#include "DKRmlNonElementParentNode/DKRmlNonElementParentNode.h"

#include "DKRmlInterface/DKRmlInterface.h"
#include "DKRmlElement/DKRmlElement.h"
class DKHTMLCollection;

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=Window]
// interface Document : Node {
class DKRmlDocument : public DKRmlNonElementParentNode, virtual public DKDocument /*public DKRmlNode,*/ 
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
	DKRmlDocument(DKRmlInterface* dkRmlInterface, DKRmlEventListener* dkRmlEventListener) : DKRmlNonElementParentNode(dkRmlInterface, dkRmlEventListener), DKDocument() /*DKRmlNode(_dkRmlEventListener, NULL),*/ 
	{
		DKDEBUGFUNC();
		DKASSERT(dkRmlInterface);
		DKASSERT(dkRmlEventListener);
		
		interfaceName = "RmlDocument";
		address[interfaceName] = pointerToAddress(this);
		DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
		
		_dkRmlInterface = dkRmlInterface;
		_dkRmlEventListener = dkRmlEventListener;

		list.push_back(this);
	}
	
	/*
	// [SameObject] readonly attribute DOMImplementation implementation;
	const DKString& implementation() override						{ return _implementation; }					// getter
	void implementation(const DKString& implementation) override	{ _implementation = implementation; }		// setter
	*/
	
	// readonly attribute USVString URL;
	const USVString& URL() override									{ return _dkRmlInterface->href_; }			// getter
	void URL(const USVString& URL) override							{ _dkRmlInterface->LoadUrl(URL); } 			// setter

	/*
	// readonly attribute USVString documentURI;
	const USVString& documentURI() override							{ return _documentURI; }					// getter
	void documentURI(const USVString& documentURI) override			{ _documentURI = documentURI; } 			// setter
	
	// readonly attribute DOMString compatMode;
	const DOMString& compatMode() override							{ return _compatMode; }						// getter
	void compatMode(const DOMString& compatMode) override			{ _compatMode = compatMode; } 				// setter
	
	// readonly attribute DOMString characterSet;
	const DOMString& characterSet() override						{ return _characterSet; }					// getter
	void characterSet(const DOMString& characterSet) override		{ _characterSet = characterSet; } 			// setter
	
	// readonly attribute DOMString charset; // legacy alias of .characterSet
	const DOMString& charset() override								{ return _charset; }						// getter
	void charset(const DOMString& charset) override					{ _charset = charset; } 					// setter
	
	// readonly attribute DOMString inputEncoding; // legacy alias of .characterSet
	const DOMString& inputEncoding() override						{ return _inputEncoding; }					// getter
	void inputEncoding(const DOMString& inputEncoding) override		{ _inputEncoding = inputEncoding; } 		// setter
	
	// readonly attribute DOMString contentType;
	const DOMString& contentType() override							{ return _contentType; }					// getter
	void contentType(const DOMString& contentType) override			{ _contentType = contentType; } 			// setter
	
	// readonly attribute DocumentType? doctype;
	const DKString& doctype() override								{ return _doctype; }						// getter
	void doctype(const DKString& doctype) override					{ _doctype = doctype; } 					// setter
	*/
	
	// readonly attribute Element? documentElement;
	DKElement* documentElement() override { 																	// getter
		DKDEBUGFUNC();
		Rml::Element* element = _dkRmlInterface->document;
		return (DKElement*)DKRmlElement::instance(_dkRmlEventListener, element);
	}				
	void documentElement(DKElement* documentElement) override { 												// setter
		DKDEBUGFUNC(documentElement);
		DKTODO();
	} 	
	
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);	
	DKHTMLCollection* getElementsByTagName(const DOMString& qualifiedName) override {
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
		return htmlCollection; 
	}
	
	/*
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	const DKString& getElementsByTagNameNS(const DOMString& _namespace, const DOMString& localName) override {
		DKDEBUGFUNC(_namespace, localName);
		return _getElementsByTagNameNS;
	}
	
	// HTMLCollection getElementsByClassName(DOMString classNames);
	const DKString& getElementsByClassName(const DOMString& classNames) override {
		DKDEBUGFUNC(classNames);
		return _getElementsByClassName;
	}
	*/
	// [CEReactions, NewObject] Element createElement(DOMString localName, optional (DOMString or ElementCreationOptions) options = {});
	DKElement* createElement(const DOMString& localName, const DOMString& options = "{}") override {
		DKDEBUGFUNC(localName, options);
		Rml::Element* element = _dkRmlInterface->document->AppendChild(_dkRmlInterface->document->CreateElement(localName.c_str()), false);
		return (DKElement*)DKRmlElement::instance(_dkRmlEventListener, element);
		//_createElement = DKRmlElement::instance(_dkRmlEventListener, element);
		//return _createElement;
	}
	/*
	// [CEReactions, NewObject] Element createElementNS(DOMString? namespace, DOMString qualifiedName, optional (DOMString or ElementCreationOptions) options = {});
	const DKString& createElementNS(const DOMString& _namespace, const DOMString& qualifiedName, const DKString& options = "{}") override {
		DKDEBUGFUNC(_namespace, qualifiedName, options);
		return _createElementNS;
	}
	
	// [NewObject] DocumentFragment createDocumentFragment();
	const DKString& createDocumentFragment() override {
		return _createDocumentFragment;
	}
	
	// [NewObject] Text createTextNode(DOMString data);
	const DKString& createTextNode(const DOMString& data) override {
		DKDEBUGFUNC(data);
		return _createTextNode;
	}
	
	// [NewObject] CDATASection createCDATASection(DOMString data);
	const DKString& createCDATASection(const DOMString& data) override {
		DKDEBUGFUNC(data);
		return _createCDATASection;
	}
	
	// [NewObject] Comment createComment(DOMString data);
	const DKString& createComment(const DOMString& _data) override {
		DKDEBUGFUNC(_data);
		return _createComment;
	}
	
	// [NewObject] ProcessingInstruction createProcessingInstruction(DOMString target, DOMString data);
	const DKString& createProcessingInstruction(const DOMString& target, const DOMString& data) override {
		DKDEBUGFUNC(target, data);
		return _createProcessingInstruction;
	}
	
	// [CEReactions, NewObject] Node importNode(Node node, optional boolean deep = false);
	const DKString& importNode(const DKString& node, const bool& deep = false) override {
		DKDEBUGFUNC(node, deep);
		return _importNode;
	}
	
	// [CEReactions] Node adoptNode(Node node);
	const DKString& adoptNode(const DKString& node) override {
		DKDEBUGFUNC(node);
		return _adoptNode;
	}
	
	// [NewObject] Attr createAttribute(DOMString localName);
	const DKString& createAttribute(const DOMString& localName) override {
		DKDEBUGFUNC(localName);
		return _createAttribute;
	}
	
	// [NewObject] Attr createAttributeNS(DOMString? namespace, DOMString qualifiedName);
	const DKString& createAttributeNS(const DOMString& _namespace, const DOMString& qualifiedName) override {
		DKDEBUGFUNC(_namespace, qualifiedName);
		return _createAttributeNS;
	}
	
	// [NewObject] Event createEvent(DOMString interface); // legacy
	const DKString& createEvent(const DOMString& interface) override {
		DKDEBUGFUNC(interface);
		return _createEvent;
	}
	
	// [NewObject] Range createRange();
	const DKString& createRange() override {
		DKDEBUGFUNC();
		return _createRange;
	}
	
	// NodeFilter.SHOW_ALL = 0xFFFFFFFF
	// TODO 
	
	// [NewObject] NodeIterator createNodeIterator(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	const DKString& createNodeIterator(const DKString& root, const unsigned int& whatToShow = 0xFFFFFFFF, const DKString& filter = "null") override {
		DKDEBUGFUNC(root, whatToShow, filter);
		return _createNodeIterator;
	}
	
	// [NewObject] TreeWalker createTreeWalker(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	const DKString& createTreeWalker(const DKString& root, const unsigned int& whatToShow = 0xFFFFFFFF, const DKString& filter = "null") override {
		DKDEBUGFUNC(root, whatToShow, filter);
		return _createTreeWalker;
	}

// };
  */
	/*
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// Document includes NonElementParentNode;
	DKElement* getElementById(const DOMString& elementId) override {
		DKDEBUGFUNC(elementId);
		Rml::Element* element = _dkRmlInterface->document->GetElementById(elementId.c_str());
		return (DKElement*)DKRmlElement::instance(_dkRmlEventListener, element);
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
			const DKString& measureElement(const DKString& element) override {
				DKDEBUGFUNC(element);
				return _measureElement;
			}
	//
	//		FontMetrics measureText(DOMString text, StylePropertyMapReadOnly styleMap);
			const DKString& measureText(const DOMString& text, const DKString& styleMap) override {
				DKDEBUGFUNC(text, styleMap);
				return _measureText;
			}
	//};

	// Source: Fullscreen API Standard (https://fullscreen.spec.whatwg.org/)
	// partial interface Document {
	//		[LegacyLenientSetter] readonly attribute boolean fullscreenEnabled;
			const bool& fullscreenEnabled() override							{ return _fullscreenEnabled; }					// getter
			void fullscreenEnabled(const bool& fullscreenEnabled) override		{ _fullscreenEnabled = fullscreenEnabled; } 	// setter
	//		
	//		[LegacyLenientSetter, Unscopable] readonly attribute boolean fullscreen; // historical
			const bool& fullscreen() override									{ return _fullscreen; }							// getter
			void fullscreen(const bool& fullscreen) override					{ _fullscreen = fullscreen; } 					// setter
	//
	//		Promise<undefined> exitFullscreen();
			const DKString& exitFullscreen() override {
				DKDEBUGFUNC();
				return _exitFullscreen;
			}
	//
	//		attribute EventHandler onfullscreenchange;
			const DKString& onfullscreenchange() override							{ return _onfullscreenchange; }					// getter
			void onfullscreenchange(const DKString& onfullscreenchange) override	{ _onfullscreenchange = onfullscreenchange; } 	// setter
	//
	//		attribute EventHandler onfullscreenerror;
			const DKString& onfullscreenerror() override							{ return _onfullscreenerror; }					// getter
			void onfullscreenerror(const DKString& onfullscreenerror) override		{ _onfullscreenerror = onfullscreenerror; } 	// setter
	//};
	*/
	
	
	////// toString //////
	operator std::string() const { return "[object DKRmlDocument]"; }
};


#endif //DKRmlDocument_H