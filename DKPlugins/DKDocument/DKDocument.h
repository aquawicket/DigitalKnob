// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/Document.idl
// [SOURCE] https://dom.spec.whatwg.org/#interface-document
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
	DKDocument() : DKNode() { // [Document()] https://developer.mozilla.org/en-US/docs/Web/API/Document/Document
		DKDEBUGFUNC();
		interfaceName = "Document";
		interfaceAddress = pointerToAddress(this);
	}
	
	// [SameObject] readonly attribute DOMImplementation implementation;
	virtual bool implementation(DKString&, bool) { return false; } // [Document.implementation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/implementation
	
	// readonly attribute USVString URL;
	virtual bool URL(DKString&, bool) { return false; } // [Document.URL](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/URL

	// readonly attribute USVString documentURI;
	virtual bool documentURI(DKString&, bool) { return false; } // [Document.documentURI](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/documentURI
	
	// readonly attribute DOMString compatMode;
	virtual bool compatMode(DKString&, bool) { return false; } // [Document.compatMode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/compatMode
	
	// readonly attribute DOMString characterSet;
	virtual bool characterSet(DKString&, bool) { return false; } // [Document.characterSet](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/characterSet
	
	// readonly attribute DOMString charset; // legacy alias of .characterSet
	virtual bool charset(DKString&, bool) { return false; } // [Document.charset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/charset
	
	// readonly attribute DOMString inputEncoding; // legacy alias of .characterSet
	virtual bool inputEncoding(DKString&, bool) { return false; } // [Document.inputEncoding](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/inputEncoding
	
	// readonly attribute DOMString contentType;
	virtual bool contentType(DKString&, bool) { return false; } // [Document.contentType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/contentType
	
	// readonly attribute DocumentType? doctype;
	virtual bool doctype(DKString&, bool) { return false; } // [Document.doctype](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/doctype
	
	// readonly attribute Element? documentElement;
	virtual bool documentElement(DKString&, bool) { return false; } // [Document.documentElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/documentElement
	
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	// TODO
	
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	// TODO
	
	// HTMLCollection getElementsByClassName(DOMString classNames);
	// TODO
	
	// [CEReactions, NewObject] Element createElement(DOMString localName, optional (DOMString or ElementCreationOptions) options = {});
	// TODO
	
	// [CEReactions, NewObject] Element createElementNS(DOMString? namespace, DOMString qualifiedName, optional (DOMString or ElementCreationOptions) options = {});
	// TODO
	
	// [NewObject] DocumentFragment createDocumentFragment();
	// TODO
	
	// [NewObject] Text createTextNode(DOMString data);
	// TODO
	
	// [NewObject] CDATASection createCDATASection(DOMString data);
	// TODO
	
	// [NewObject] Comment createComment(DOMString data);
	// TODO
	
	// [NewObject] ProcessingInstruction createProcessingInstruction(DOMString target, DOMString data);
	// TODO
	
	// [CEReactions, NewObject] Node importNode(Node node, optional boolean deep = false);
	// TODO
	
	// [CEReactions] Node adoptNode(Node node);
	// TODO
	
	// [NewObject] Attr createAttribute(DOMString localName);
	// TODO
	
	// [NewObject] Attr createAttributeNS(DOMString? namespace, DOMString qualifiedName);
	// TODO
	
	// [NewObject] Event createEvent(DOMString interface); // legacy
	// TODO
	
	// [NewObject] Range createRange();
	// TODO
	
	// NodeFilter.SHOW_ALL = 0xFFFFFFFF
	// [NewObject] NodeIterator createNodeIterator(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	// TODO
	
	// [NewObject] TreeWalker createTreeWalker(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	// TODO

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
	
	
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	virtual bool activeElement(DKString&, bool) { return false; } // [Document.activeElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/activeElement
	virtual bool adoptedStyleSheets(DKString&, bool) { return false; } // [Document.adoptedStyleSheets] https://developer.mozilla.org/en-US/docs/Web/API/Document/adoptedStyleSheets
	virtual bool body(DKString&, bool) { return false; } // [Document.body] https://developer.mozilla.org/en-US/docs/Web/API/Document/body
	virtual bool childElementCount(unsigned int&, bool) { return false; } // [Document.childElementCount](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/childElementCount
	virtual bool children(DKString&, bool) { return false; } // [Document.children](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/children
	virtual bool currentScript(DKString&, bool) { return false; } // [Document.currentScript](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/currentScript
	virtual bool embeds(DKString&, bool) { return false; } // [Document.embeds](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/embeds
	virtual bool featurePolicy(DKString&, bool) { return false; } // [Document.featurePolicy Experimental](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/featurePolicy
	virtual bool firstElementChild(DKString&, bool) { return false; } // [Document.firstElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/firstElementChild
	virtual bool fonts(DKString&, bool) { return false; } // [Document.fonts] https://developer.mozilla.org/en-US/docs/Web/API/Document/fonts
	virtual bool forms(DKString&, bool) { return false; } // [Document.forms](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/forms
	virtual bool fragmentDirective(DKString&, bool) { return false; } // [Document.fragmentDirective](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Document/fragmentDirective
	virtual bool fullscreenElement(DKString&, bool) { return false; } // [Document.fullscreenElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/fullscreenElement
	virtual bool head(DKString&, bool) { return false; } // [Document.head](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/head
	virtual bool hidden(bool&, bool) { return false; } // [Document.hidden](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/hidden
	virtual bool images(DKString&, bool) { return false; } // [Document.images](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/images	
	virtual bool lastElementChild(DKString&, bool) { return false; } // [Document.lastElementChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/lastElementChild
	virtual bool links(DKString&, bool) { return false; } // [Document.links](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/links
	virtual bool pictureInPictureElement(DKString&, bool) { return false; } // [Document.pictureInPictureElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pictureInPictureElement
	virtual bool pictureInPictureEnabled(bool&, bool) { return false; } // [Document.pictureInPictureEnabled](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pictureInPictureEnabled
	virtual bool plugins(DKString&, bool) { return false; } // [Document.plugins](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/plugins
	virtual bool pointerLockElement(DKString&, bool) { return false; } // [Document.pointerLockElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/pointerLockElement
	virtual bool scripts(DKString&, bool) { return false; } // [Document.scripts](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/scripts
	virtual bool scrollingElement(DKString&, bool) { return false; } // [Document.scrollingElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/scrollingElement
	virtual bool styleSheets(DKString&, bool) { return false; } // [Document.styleSheets](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/styleSheets
	virtual bool timeline(DKString&, bool) { return false; } // [Document.timeline](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/timeline
	virtual bool visibilityState(DKString&, bool) { return false; } // [Document.visibilityState](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Document/visibilityState
};


#endif //DKDocument_H