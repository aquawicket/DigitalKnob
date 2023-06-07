// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document
#pragma once
#ifndef TEST_Document_H
#define TEST_Document_H

#include "DKDocument/DKDocument.h"


class TEST_Document //: public DKObjectT<TEST_Document>
{
public:
	TEST_Document(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_Document.h //////");
		
		DKDocument document;
		printDocumentProperties(document);
	}
	
	static void printDocumentProperties(DKDocument& document){
		DKDEBUGFUNC(document);
		
		// constructor();
		// function
		
		// [SameObject] readonly attribute DOMImplementation implementation;
		console.log("document.implementation() = "	+toString(document.implementation()));
		
		// readonly attribute USVString URL;
		console.log("document.URL() = "				+toString(document.URL()));
		
		// readonly attribute USVString documentURI;
		console.log("document.documentURI() = "		+toString(document.documentURI()));
		
		// readonly attribute DOMString compatMode;
		console.log("document.compatMode() = "		+toString(document.compatMode()));
		
		// readonly attribute DOMString characterSet;
		console.log("document.characterSet() = "		+toString(document.characterSet()));
		
		// readonly attribute DOMString charset; // legacy alias of .characterSet
		console.log("document.charset() = "			+toString(document.charset()));
		
		// readonly attribute DOMString inputEncoding; // legacy alias of .characterSet
		console.log("document.inputEncoding() = "	+toString(document.inputEncoding()));
		
		// readonly attribute DOMString contentType;
		console.log("document.contentType() = "		+toString(document.contentType()));
		
		// readonly attribute DocumentType? doctype;
		console.log("document.doctype() = "			+toString(document.doctype()));
		
		// readonly attribute Element? documentElement;
		console.log("document.documentElement() = "	+toString(document.documentElement()));
		
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
				console.log("document.fullscreenEnabled() = "	+toString(document.fullscreenEnabled()));
		//		
		//		[LegacyLenientSetter, Unscopable] readonly attribute boolean fullscreen; // historical
				console.log("document.fullscreen() = "			+toString(document.fullscreen()));
		//
		//		Promise<undefined> exitFullscreen();
				// function
		//
		//		attribute EventHandler onfullscreenchange;
				console.log("document.onfullscreenchange() = "	+toString(document.onfullscreenchange()));
		//
		//		attribute EventHandler onfullscreenerror;
				console.log("document.onfullscreenerror() = "	+toString(document.onfullscreenerror()));
		//};
		
		
		TEST_Node::printNodeProperties(dynamic_cast<DKNode&>(document));	//TODO: try to remove the need for dynamic_cast
	}
};
//REGISTER_OBJECT(TEST_Document, true);


#endif //TEST_Document_H