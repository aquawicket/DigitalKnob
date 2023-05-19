// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document
#pragma once
#ifndef TEST_Document_H
#define TEST_Document_H

#include "DKDocument/DKDocument.h"


class TEST_Document : public DKObjectT<TEST_Document>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_Document.h //////\n");
		
		DKDocument document;
		printDocumentProperties(document);
		return true;
	}
	
	static void printDocumentProperties(DKDocument& document){
		DKDEBUGFUNC(document);
		
		// constructor();
		// function
		
		// [SameObject] readonly attribute DOMImplementation implementation;
		DKINFO("document.implementation = "	+toString(document.implementation)	+"\n");
		
		// readonly attribute USVString URL;
		DKINFO("document.URL = "			+toString(document.URL)				+"\n");
		
		// readonly attribute USVString documentURI;
		DKINFO("document.documentURI = "	+toString(document.documentURI)		+"\n");
		
		// readonly attribute DOMString compatMode;
		DKINFO("document.compatMode = "		+toString(document.compatMode)		+"\n");
		
		// readonly attribute DOMString characterSet;
		DKINFO("document.characterSet = "	+toString(document.characterSet)	+"\n");
		
		// readonly attribute DOMString charset; // legacy alias of .characterSet
		DKINFO("document.charset = "		+toString(document.charset)			+"\n");
		
		// readonly attribute DOMString inputEncoding; // legacy alias of .characterSet
		DKINFO("document.inputEncoding = "	+toString(document.inputEncoding)	+"\n");
		
		// readonly attribute DOMString contentType;
		DKINFO("document.contentType = "	+toString(document.contentType)		+"\n");
		
		// readonly attribute DocumentType? doctype;
		DKINFO("document.doctype = "		+toString(document.doctype)			+"\n");
		
		// readonly attribute Element? documentElement;
		DKINFO("document.documentElement = "+toString(document.documentElement)	+"\n");
		
		// HTMLCollection getElementsByTagName(DOMString qualifiedName);
		// function
		
		// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
		// function
		
		// HTMLCollection getElementsByClassName(DOMString classNames);
		// function
		
		// [CEReactions, NewObject] Element createElement(DOMString localName, optional (DOMString or ElementCreationOptions) options = {});
		// function
		
		// [CEReactions, NewObject] Element createElementNS(DOMString? namespace, DOMString qualifiedName, optional (DOMString or ElementCreationOptions) options = {});
		// function
		
		// [NewObject] DocumentFragment createDocumentFragment();
		// function
		
		// [NewObject] Text createTextNode(DOMString data);
		// function
		
		// [NewObject] CDATASection createCDATASection(DOMString data);
		// function
		
		// [NewObject] Comment createComment(DOMString data);
		// function
		
		// [NewObject] ProcessingInstruction createProcessingInstruction(DOMString target, DOMString data);
		// function
		
		// [CEReactions, NewObject] Node importNode(Node node, optional boolean deep = false);
		// function
		
		// [CEReactions] Node adoptNode(Node node);
		// function
		
		// [NewObject] Attr createAttribute(DOMString localName);
		// function
		
		// [NewObject] Attr createAttributeNS(DOMString? namespace, DOMString qualifiedName);
		// function
		
		// [NewObject] Event createEvent(DOMString interface); // legacy
		// function
		
		// [NewObject] Range createRange();
		// function
		
		// NodeFilter.SHOW_ALL = 0xFFFFFFFF
		// TODO 
		
		// [NewObject] NodeIterator createNodeIterator(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
		// function
		
		// [NewObject] TreeWalker createTreeWalker(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
		// function
		
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
				// function
		//
		//		FontMetrics measureText(DOMString text, StylePropertyMapReadOnly styleMap);
				// function
		//};
		
		// Source: Fullscreen API Standard (https://fullscreen.spec.whatwg.org/)
		// partial interface Document {
		//		[LegacyLenientSetter] readonly attribute boolean fullscreenEnabled;
				DKINFO("document.fullscreenEnabled = "	+toString(document.fullscreenEnabled)	+"\n");
		//		
		//		[LegacyLenientSetter, Unscopable] readonly attribute boolean fullscreen; // historical
				DKINFO("document.fullscreen = "			+toString(document.fullscreen)			+"\n");
		//
		//		Promise<undefined> exitFullscreen();
				// function
		//
		//		attribute EventHandler onfullscreenchange;
				DKINFO("document.onfullscreenchange = "	+toString(document.onfullscreenchange)	+"\n");
		//
		//		attribute EventHandler onfullscreenerror;
				DKINFO("document.onfullscreenerror = "	+toString(document.onfullscreenerror)	+"\n");
		//};
	}
};
REGISTER_OBJECT(TEST_Document, true);


#endif //TEST_Document_H