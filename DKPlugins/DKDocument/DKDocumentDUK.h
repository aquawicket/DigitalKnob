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
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_constructor", 					DKDocumentDUK::constructor);

		// [SameObject] readonly attribute DOMImplementation implementation;
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_implementation", 				DKDocumentDUK::implementation);
		
		// readonly attribute USVString URL;
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_URL", 							DKDocumentDUK::URL);
		
		// readonly attribute USVString documentURI;
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_documentURI", 					DKDocumentDUK::documentURI);
		
		// readonly attribute DOMString compatMode;
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_compatMode", 					DKDocumentDUK::compatMode);
		
		// readonly attribute DOMString characterSet;
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_characterSet", 				DKDocumentDUK::characterSet);
		
		// readonly attribute DOMString charset; // legacy alias of .characterSet
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_charset", 						DKDocumentDUK::charset);
		
		// readonly attribute DOMString inputEncoding; // legacy alias of .characterSet
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_inputEncoding", 				DKDocumentDUK::inputEncoding);
		
		// readonly attribute DOMString contentType;
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_contentType", 					DKDocumentDUK::contentType);
		
		// readonly attribute DocumentType? doctype;
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_doctype", 						DKDocumentDUK::doctype);
		
		// readonly attribute Element? documentElement;
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_documentElement", 				DKDocumentDUK::documentElement);
		
		// HTMLCollection getElementsByTagName(DOMString qualifiedName);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_getElementsByTagName", 		DKDocumentDUK::getElementsByTagName);
		
		// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_getElementsByTagNameNS", 		DKDocumentDUK::getElementsByTagNameNS);
		
		// HTMLCollection getElementsByClassName(DOMString classNames);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_getElementsByClassName", 		DKDocumentDUK::getElementsByClassName);
		
		// [CEReactions, NewObject] Element createElement(DOMString localName, optional (DOMString or ElementCreationOptions) options = {});
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createElement", 				DKDocumentDUK::createElement);
		
		// [CEReactions, NewObject] Element createElementNS(DOMString? namespace, DOMString qualifiedName, optional (DOMString or ElementCreationOptions) options = {});
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createElementNS",				DKDocumentDUK::createElementNS);
		
		// [NewObject] DocumentFragment createDocumentFragment();
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createDocumentFragment", 		DKDocumentDUK::createDocumentFragment);
		
		// [NewObject] Text createTextNode(DOMString data);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createTextNode", 				DKDocumentDUK::createTextNode);
		
		// [NewObject] CDATASection createCDATASection(DOMString data);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createCDATASection", 			DKDocumentDUK::createCDATASection);
		
		// [NewObject] Comment createComment(DOMString data);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createComment", 				DKDocumentDUK::createComment);
		
		// [NewObject] ProcessingInstruction createProcessingInstruction(DOMString target, DOMString data);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createProcessingInstruction",	DKDocumentDUK::createProcessingInstruction);
		
		// [CEReactions, NewObject] Node importNode(Node node, optional boolean deep = false);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_importNode", 					DKDocumentDUK::importNode);
		
		// [CEReactions] Node adoptNode(Node node);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_adoptNode", 					DKDocumentDUK::adoptNode);
		
		// [NewObject] Attr createAttribute(DOMString localName);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createAttribute", 				DKDocumentDUK::createAttribute);
		
		// [NewObject] Attr createAttributeNS(DOMString? namespace, DOMString qualifiedName);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createAttributeNS", 			DKDocumentDUK::createAttributeNS);
		
		// [NewObject] Event createEvent(DOMString interface); // legacy
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createEvent", 					DKDocumentDUK::createEvent);
		
		// [NewObject] Range createRange();
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createRange", 					DKDocumentDUK::createRange);
		
		// NodeFilter.SHOW_ALL = 0xFFFFFFFF
		
		// [NewObject] NodeIterator createNodeIterator(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createNodeIterator", 			DKDocumentDUK::createNodeIterator);
	
		// [NewObject] TreeWalker createTreeWalker(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
		DKDuktape::AttachFunction("CPP_DKDocumentDUK_createTreeWalker", 			DKDocumentDUK::createTreeWalker);
		
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
				DKDuktape::AttachFunction("CPP_DKDocumentDUK_measureElement", 		DKDocumentDUK::measureElement);
		//
		//		FontMetrics measureText(DOMString text, StylePropertyMapReadOnly styleMap);
				DKDuktape::AttachFunction("CPP_DKDocumentDUK_measureText", 			DKDocumentDUK::measureText);
		//};
	
		// Source: Fullscreen API Standard (https://fullscreen.spec.whatwg.org/)
		// partial interface Document {
		//		[LegacyLenientSetter] readonly attribute boolean fullscreenEnabled;
				DKDuktape::AttachFunction("CPP_DKDocumentDUK_fullscreenEnabled", 	DKDocumentDUK::fullscreenEnabled);
		//		
		//		[LegacyLenientSetter, Unscopable] readonly attribute boolean fullscreen; // historical
				DKDuktape::AttachFunction("CPP_DKDocumentDUK_fullscreen", 			DKDocumentDUK::fullscreen);
		//
		//		Promise<undefined> exitFullscreen();
				DKDuktape::AttachFunction("CPP_DKDocumentDUK_exitFullscreen", 		DKDocumentDUK::exitFullscreen);
		//
		//		attribute EventHandler onfullscreenchange;
				DKDuktape::AttachFunction("CPP_DKDocumentDUK_onfullscreenchange", 	DKDocumentDUK::onfullscreenchange);
		//
		//		attribute EventHandler onfullscreenerror;
				DKDuktape::AttachFunction("CPP_DKDocumentDUK_onfullscreenerror", 	DKDocumentDUK::onfullscreenerror);
		//};
	
	
		////// Load .js files //////
		DKClass::DKCreate("DKDocument/DKDocumentDUK.js");
		
		return true;
	}
	
	static DKDocument* document(duk_context* ctx){
		DKString interfaceAddress = duk_require_string(ctx, 0);
		DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
		DKASSERT(interface);
		
		DKString documentAddress = interface->address["Document"];
		DKDocument* _document = (DKDocument*)addressToPointer(documentAddress);
		DKASSERT(_document);
		return _document;
	}
	static bool GetBool(duk_context* ctx, int index = 1){
		if (duk_is_boolean(ctx, index))
			return duk_to_boolean(ctx, index);
		return false;
	}
	static double GetDouble(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_number(ctx, index);
		return 0.0;
	}
	static int GetInt(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_int(ctx, index);
		return 0;
	}
	static DKString GetString(duk_context* ctx, int index = 1){
		if (duk_is_string(ctx, index))
			return duk_to_string(ctx, index);
		return "";
	}
	static unsigned int GetUint(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_uint(ctx, index);
		return 0;
	}
	
	// constructor();
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		
		DKINFO("CPP_DKDocumentDUK_constructor()\n");
		DKDocument* _document = new DKDocument();
		dukglue_push(ctx, _document->interfaceAddress);
		return true;
	}
	
	// [SameObject] readonly attribute DOMImplementation implementation;
	static int implementation(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			document(ctx)->implementation(GetString(ctx));
		dukglue_push(ctx, document(ctx)->implementation());
		return true;
	}
	
	// readonly attribute USVString URL;
	static int URL(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			document(ctx)->URL(GetString(ctx));
		dukglue_push(ctx, document(ctx)->URL());
		return true;
	}
	
	// readonly attribute USVString documentURI;
	static int documentURI(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			document(ctx)->documentURI(GetString(ctx));
		dukglue_push(ctx, document(ctx)->documentURI());
		return true;
	}
	
	// readonly attribute DOMString compatMode;
	static int compatMode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			document(ctx)->compatMode(GetString(ctx));
		dukglue_push(ctx, document(ctx)->compatMode());
		return true;
	}
	
	// readonly attribute DOMString characterSet;
	static int characterSet(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			document(ctx)->characterSet(GetString(ctx));
		dukglue_push(ctx, document(ctx)->characterSet());
		return true;
	}
	
	// readonly attribute DOMString charset; // legacy alias of .characterSet
	static int charset(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			document(ctx)->charset(GetString(ctx));
		dukglue_push(ctx, document(ctx)->charset());
		return true;
	}
	
	// readonly attribute DOMString inputEncoding; // legacy alias of .characterSet
	static int inputEncoding(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			document(ctx)->inputEncoding(GetString(ctx));
		dukglue_push(ctx, document(ctx)->inputEncoding());
		return true;
	}
	
	// readonly attribute DOMString contentType;
	static int contentType(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			document(ctx)->contentType(GetString(ctx));
		dukglue_push(ctx, document(ctx)->contentType());
		return true;
	}
	
	// readonly attribute DocumentType? doctype;
	static int doctype(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			document(ctx)->doctype(GetString(ctx));
		dukglue_push(ctx, document(ctx)->doctype());
		return true;
	}
	
	// readonly attribute Element? documentElement;
	static int documentElement(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKString elementAddress = interface->address["Element"];
			DKElement* element = (DKElement*)addressToPointer(elementAddress);
			document(ctx)->documentElement(element);
		}
		
		if(document(ctx)->documentElement())
			dukglue_push(ctx, document(ctx)->documentElement()->interfaceAddress);
		return true;
	}
	
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	static int getElementsByTagName(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString qualifiedName = GetString(ctx);
		DKHTMLCollection* _getElementsByTagName = document(ctx)->getElementsByTagName(qualifiedName);
		dukglue_push(ctx, _getElementsByTagName->interfaceAddress);	
		return true;
	}
	
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	static int getElementsByTagNameNS(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _namespace = GetString(ctx);
		DKString localName = GetString(ctx, 2);
		DKHTMLCollection* _getElementsByTagNameNS = document(ctx)->getElementsByTagNameNS(_namespace, localName);
		dukglue_push(ctx, _getElementsByTagNameNS->interfaceAddress);	
		return true;
	}
	
	// HTMLCollection getElementsByClassName(DOMString classNames);
	static int getElementsByClassName(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString classNames = GetString(ctx);
		DKHTMLCollection* _getElementsByClassName = document(ctx)->getElementsByClassName(classNames);
		dukglue_push(ctx, _getElementsByClassName->interfaceAddress);	
		return true;
	}
	
	// [CEReactions, NewObject] Element createElement(DOMString localName, optional (DOMString or ElementCreationOptions) options = {});
	static int createElement(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString localName = GetString(ctx, 1);
		DKString options = GetString(ctx, 2);
		DKElement* _createElement = document(ctx)->createElement(localName, options);
		dukglue_push(ctx, _createElement->interfaceAddress);
		return true;
	}
	
	// [CEReactions, NewObject] Element createElementNS(DOMString? namespace, DOMString qualifiedName, optional (DOMString or ElementCreationOptions) options = {});
	static int createElementNS(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _namespace = GetString(ctx, 1);
		DKString qualifiedName = GetString(ctx, 2);
		DKString options = GetString(ctx, 3);
		DKElement* _createElementNS = document(ctx)->createElementNS(_namespace, qualifiedName, options);
		dukglue_push(ctx, _createElementNS->interfaceAddress);	
		return true;
	}
	
	// [NewObject] DocumentFragment createDocumentFragment();
	static int createDocumentFragment(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _createDocumentFragment = document(ctx)->createDocumentFragment();
		dukglue_push(ctx, _createDocumentFragment);	
		return true;
	}
	
	// [NewObject] Text createTextNode(DOMString data);
	static int createTextNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString data = GetString(ctx, 1);
		DKString _createTextNode = document(ctx)->createTextNode(data);
		dukglue_push(ctx, _createTextNode);	
		return true;
	}
	
	// [NewObject] CDATASection createCDATASection(DOMString data);
	static int createCDATASection(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString data = GetString(ctx, 1);
		DKString _createCDATASection = document(ctx)->createCDATASection(data);
		dukglue_push(ctx, _createCDATASection);	
		return true;
	}
	
	// [NewObject] Comment createComment(DOMString data);
	static int createComment(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString data = GetString(ctx, 1);
		DKString _createComment = document(ctx)->createComment(data);
		dukglue_push(ctx, _createComment);	
		return true;
	}
	
	// [NewObject] ProcessingInstruction createProcessingInstruction(DOMString target, DOMString data);
	static int createProcessingInstruction(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString target = GetString(ctx, 1);
		DKString data = GetString(ctx, 2);
		DKString _createProcessingInstruction = document(ctx)->createProcessingInstruction(target, data);
		dukglue_push(ctx, _createProcessingInstruction);	
		return true;
	}
	
	// [CEReactions, NewObject] Node importNode(Node node, optional boolean deep = false);
	static int importNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString nodeAddress = GetString(ctx, 1);
		DKNode* node = (DKNode*)addressToPointer(nodeAddress);
		bool deep = GetBool(ctx, 2);
		DKNode* importNode = document(ctx)->importNode(node, deep);
		dukglue_push(ctx, importNode->interfaceAddress);	
		return true;
	}
	
	// [CEReactions] Node adoptNode(Node node);
	static int adoptNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString nodeAddress = GetString(ctx, 1);
		DKNode* node = (DKNode*)addressToPointer(nodeAddress);
		DKNode* adoptNode = document(ctx)->adoptNode(node);
		dukglue_push(ctx, adoptNode->interfaceAddress);	
		return true;
	}
	
	// [NewObject] Attr createAttribute(DOMString localName);
	static int createAttribute(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString localName = GetString(ctx, 1);
		DKString _createAttribute = document(ctx)->createAttribute(localName);
		dukglue_push(ctx, _createAttribute);	
		return true;
	}
	
	// [NewObject] Attr createAttributeNS(DOMString? namespace, DOMString qualifiedName);
	static int createAttributeNS(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _namespace = GetString(ctx, 1);
		DKString qualifiedName = GetString(ctx, 2);
		DKString _createAttributeNS = document(ctx)->createAttributeNS(_namespace, qualifiedName);
		dukglue_push(ctx, _createAttributeNS);	
		return true;
	}
	
	// [NewObject] Event createEvent(DOMString interface); // legacy
	static int createEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString interface = GetString(ctx, 1);
		DKEvent* createEvent = document(ctx)->createEvent(interface);
		dukglue_push(ctx, createEvent->interfaceAddress);	
		return true;
	}
	
	// [NewObject] Range createRange();
	static int createRange(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _createRange = document(ctx)->createRange();
		dukglue_push(ctx, _createRange);	
		return true;
	}
	
	// NodeFilter.SHOW_ALL = 0xFFFFFFFF
	// TODO 
	
	// [NewObject] NodeIterator createNodeIterator(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	static int createNodeIterator(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString rootAddress = GetString(ctx, 1);
		DKNode* root = (DKNode*)addressToPointer(rootAddress);
		unsigned int whatToShow = GetUint(ctx, 2);
		DKString filter = GetString(ctx, 3);
		DKString _createNodeIterator = document(ctx)->createNodeIterator(root, whatToShow, filter);
		dukglue_push(ctx, _createNodeIterator);	
		return true;
	}
	
	// [NewObject] TreeWalker createTreeWalker(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	static int createTreeWalker(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString rootAddress = GetString(ctx, 1);
		DKNode* root = (DKNode*)addressToPointer(rootAddress);
		unsigned int whatToShow = GetUint(ctx, 2);
		DKString filter = GetString(ctx, 3);
		DKString _createTreeWalker = document(ctx)->createTreeWalker(root, whatToShow, filter);
		dukglue_push(ctx, _createTreeWalker);	
		return true;
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
			static int measureElement(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				DKString elementAddress = GetString(ctx, 1);
				DKElement* element = (DKElement*)addressToPointer(elementAddress);
				DKString _measureElement = document(ctx)->measureElement(element);
				dukglue_push(ctx, _measureElement);	
				return true;
			}
	//
	//		FontMetrics measureText(DOMString text, StylePropertyMapReadOnly styleMap);
			static int measureText(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				DKString text = GetString(ctx, 1);
				DKString styleMap = GetString(ctx, 2);
				DKString _measureText = document(ctx)->measureText(text, styleMap);
				dukglue_push(ctx, _measureText);	
				return true;
			}
	//};

	// Source: Fullscreen API Standard (https://fullscreen.spec.whatwg.org/)
	// partial interface Document {
	//		[LegacyLenientSetter] readonly attribute boolean fullscreenEnabled;
			static int fullscreenEnabled(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					document(ctx)->fullscreenEnabled(GetBool(ctx));
				dukglue_push(ctx, document(ctx)->fullscreenEnabled());
				return true;
			}
	//		
	//		[LegacyLenientSetter, Unscopable] readonly attribute boolean fullscreen; // historical
			static int fullscreen(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					document(ctx)->fullscreen(GetBool(ctx));
				dukglue_push(ctx, document(ctx)->fullscreen());
				return true;
			}
	//
	//		Promise<undefined> exitFullscreen();
			static int exitFullscreen(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				DKString _exitFullscreen = document(ctx)->exitFullscreen();
				dukglue_push(ctx, _exitFullscreen);	
				return true;
			}
	//
	//		attribute EventHandler onfullscreenchange;
			static int onfullscreenchange(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					document(ctx)->onfullscreenchange(GetString(ctx));
				dukglue_push(ctx, document(ctx)->onfullscreenchange());
				return true;
			}
	//
	//		attribute EventHandler onfullscreenerror;
			static int onfullscreenerror(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					document(ctx)->onfullscreenerror(GetString(ctx));
				dukglue_push(ctx, document(ctx)->onfullscreenerror());
				return true;
			}
	//};
};
REGISTER_OBJECT(DKDocumentDUK, true)


#endif //DKDocumentDUK_H
#endif //HAVE_DKDuktape