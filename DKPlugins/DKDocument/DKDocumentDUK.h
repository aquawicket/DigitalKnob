// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document
#if HAVE_DKDuktape

#pragma once
#ifndef DKDocumentDUK_H
#define DKDocumentDUK_H

#include "DKDuktape/DKDuktape.h"


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=Window]
// interface Document : Node {
class DKDocumentDUK : public DKObjectT<DKDocumentDUK>
{
public:
	bool Init(){
		
		// constructor();
		DKDuktape::AttachFunction("CPP_DKDocumentDUK", DKDocumentDUK::constructor);

		// [SameObject] readonly attribute DOMImplementation implementation;
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_implementation", DKDocumentDUK::implementation);
		
		// readonly attribute USVString URL;
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_URL", DKDocumentDUK::URL);
		
		// readonly attribute USVString documentURI;
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_documentURI", DKDocumentDUK::documentURI);
		
		// readonly attribute DOMString compatMode;
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_compatMode", DKDocumentDUK::compatMode);
		
		// readonly attribute DOMString characterSet;
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_characterSet", DKDocumentDUK::characterSet);
		
		// readonly attribute DOMString charset; // legacy alias of .characterSet
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_charset", DKDocumentDUK::charset);
		
		// readonly attribute DOMString inputEncoding; // legacy alias of .characterSet
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_inputEncoding", DKDocumentDUK::inputEncoding);
		
		// readonly attribute DOMString contentType;
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_contentType", DKDocumentDUK::contentType);
		
		// readonly attribute DocumentType? doctype;
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_doctype", DKDocumentDUK::doctype);
		
		// readonly attribute Element? documentElement;
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_documentElement", DKDocumentDUK::documentElement);
		
		// HTMLCollection getElementsByTagName(DOMString qualifiedName);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_getElementsByTagName", DKDocumentDUK::getElementsByTagName);
		
		// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_getElementsByTagNameNS", DKDocumentDUK::getElementsByTagNameNS);
		
		// HTMLCollection getElementsByClassName(DOMString classNames);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_getElementsByClassName", DKDocumentDUK::getElementsByClassName);
		
		// [CEReactions, NewObject] Element createElement(DOMString localName, optional (DOMString or ElementCreationOptions) options = {});
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createElement", DKDocumentDUK::createElement);
		
		// [CEReactions, NewObject] Element createElementNS(DOMString? namespace, DOMString qualifiedName, optional (DOMString or ElementCreationOptions) options = {});
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createElementNS", DKDocumentDUK::createElementNS);
		
		// [NewObject] DocumentFragment createDocumentFragment();
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createDocumentFragment", DKDocumentDUK::createDocumentFragment);
		
		// [NewObject] Text createTextNode(DOMString data);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createTextNode", DKDocumentDUK::createTextNode);
		
		// [NewObject] CDATASection createCDATASection(DOMString data);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createCDATASection", DKDocumentDUK::createCDATASection);
		
		// [NewObject] Comment createComment(DOMString data);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createComment", DKDocumentDUK::createComment);
		
		// [NewObject] ProcessingInstruction createProcessingInstruction(DOMString target, DOMString data);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createProcessingInstruction", DKDocumentDUK::createProcessingInstruction);
		
		// [CEReactions, NewObject] Node importNode(Node node, optional boolean deep = false);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_importNode", DKDocumentDUK::importNode);
		
		// [CEReactions] Node adoptNode(Node node);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_adoptNode", DKDocumentDUK::adoptNode);
		
		// [NewObject] Attr createAttribute(DOMString localName);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createAttribute", DKDocumentDUK::createAttribute);
		
		// [NewObject] Attr createAttributeNS(DOMString? namespace, DOMString qualifiedName);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createAttributeNS", DKDocumentDUK::createAttributeNS);
		
		// [NewObject] Event createEvent(DOMString interface); // legacy
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createEvent", DKDocumentDUK::createEvent);
		
		// [NewObject] Range createRange();
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createRange", DKDocumentDUK::createRange);
		
		// NodeFilter.SHOW_ALL = 0xFFFFFFFF
		
		// [NewObject] NodeIterator createNodeIterator(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createNodeIterator", DKDocumentDUK::createNodeIterator);
	
		// [NewObject] TreeWalker createTreeWalker(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createTreeWalker", DKDocumentDUK::createTreeWalker);
		
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
				DKDuktape::AttachFunction("CPP_DKDocumentDUK_measureElement", DKDocumentDUK::measureElement);
		//
		//		FontMetrics measureText(DOMString text, StylePropertyMapReadOnly styleMap);
				DKDuktape::AttachFunction("CPP_DKDocumentDUK_measureText", DKDocumentDUK::measureText);
		//};
	
		// Source: Fullscreen API Standard (https://fullscreen.spec.whatwg.org/)
		// partial interface Document {
		//		[LegacyLenientSetter] readonly attribute boolean fullscreenEnabled;
				DKDuktape::AttachFunction("CPP_DKDocumentDUK_fullscreenEnabled", DKDocumentDUK::fullscreenEnabled);
		//		
		//		[LegacyLenientSetter, Unscopable] readonly attribute boolean fullscreen; // historical
				DKDuktape::AttachFunction("CPP_DKDocumentDUK_fullscreen", DKDocumentDUK::fullscreen);
		//
		//		Promise<undefined> exitFullscreen();
				DKDuktape::AttachFunction("CPP_DKDocumentDUK_exitFullscreen", DKDocumentDUK::exitFullscreen);
		//
		//		attribute EventHandler onfullscreenchange;
				DKDuktape::AttachFunction("CPP_DKDocumentDUK_onfullscreenchange", DKDocumentDUK::onfullscreenchange);
		//
		//		attribute EventHandler onfullscreenerror;
				DKDuktape::AttachFunction("CPP_DKDocumentDUK_onfullscreenerror", DKDocumentDUK::onfullscreenerror);
		//};
	
	
		////// Load .js files //////
		DKClass::DKCreate("DKDocument/DKDocumentDUK.js");
		
		return true;
	}
	
	static DKDocument* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKDocument*)addressToPointer(eventTargetAddress);
	}
	static bool GetBool(duk_context* ctx){
		if (duk_is_boolean(ctx, 1))
			return duk_to_boolean(ctx, 1);
		return false;
	}
	static double GetDouble(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_number(ctx, 1);
		return 0.0;
	}
	static int GetInt(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_int(ctx, 1);
		return 0;
	}
	static DKString GetString(duk_context* ctx){
		if (duk_is_string(ctx, 1))
			return duk_to_string(ctx, 1);
		return "";
	}
	static unsigned int GetUint(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_uint(ctx, 1);
		return 0;
	}
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKDocumentDUK()\n");
		DKDocument* _document = new DKDocument();
		DKString eventTargetAddress = pointerToAddress(_document);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	
	// TODO
	
};
REGISTER_OBJECT(DKDocumentDUK, true)


#endif //DKDocumentDUK_H
#endif //HAVE_DKDuktape