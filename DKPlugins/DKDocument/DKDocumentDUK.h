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
		DKINFO("CPP_DKDocumentDUK()\n");
		DKDocument* document = new DKDocument();
		DKString eventTargetAddress = pointerToAddress(document);
		dukglue_push(ctx, eventTargetAddress);
		return true;
	}
	
	// [SameObject] readonly attribute DOMImplementation implementation;
	static int implementation(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->implementation(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->implementation());
		return true;
	}
	
	// readonly attribute USVString URL;
	static int URL(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->URL(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->URL());
		return true;
	}
	
	// readonly attribute USVString documentURI;
	static int documentURI(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->documentURI(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->documentURI());
		return true;
	}
	
	// readonly attribute DOMString compatMode;
	static int compatMode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->compatMode(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->compatMode());
		return true;
	}
	
	// readonly attribute DOMString characterSet;
	static int characterSet(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->characterSet(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->characterSet());
		return true;
	}
	
	// readonly attribute DOMString charset; // legacy alias of .characterSet
	static int charset(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->charset(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->charset());
		return true;
	}
	
	// readonly attribute DOMString inputEncoding; // legacy alias of .characterSet
	static int inputEncoding(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->inputEncoding(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->inputEncoding());
		return true;
	}
	
	// readonly attribute DOMString contentType;
	static int contentType(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->contentType(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->contentType());
		return true;
	}
	
	// readonly attribute DocumentType? doctype;
	static int doctype(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->doctype(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->doctype());
		return true;
	}
	
	// readonly attribute Element? documentElement;
	static int documentElement(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->documentElement(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->documentElement());
		return true;
	}
	
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	static int getElementsByTagName(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString qualifiedName = GetString(ctx);
		DKString _getElementsByTagName = eventTarget(ctx)->getElementsByTagName(qualifiedName);
		dukglue_push(ctx, _getElementsByTagName);	
		return true;
	}
	
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	static int getElementsByTagNameNS(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _namespace = GetString(ctx);
		DKString localName = GetString(ctx, 2);
		DKString _getElementsByTagNameNS = eventTarget(ctx)->getElementsByTagNameNS(_namespace, localName);
		dukglue_push(ctx, _getElementsByTagNameNS);	
		return true;
	}
	
	// HTMLCollection getElementsByClassName(DOMString classNames);
	static int getElementsByClassName(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString classNames = GetString(ctx);
		DKString _getElementsByClassName = eventTarget(ctx)->getElementsByClassName(classNames);
		dukglue_push(ctx, _getElementsByClassName);	
		return true;
	}
	
	// [CEReactions, NewObject] Element createElement(DOMString localName, optional (DOMString or ElementCreationOptions) options = {});
	static int createElement(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString localName = GetString(ctx, 1);
		DKString options = GetString(ctx, 2);
		DKString _createElement = eventTarget(ctx)->createElement(localName, options);
		dukglue_push(ctx, _createElement);	
		return true;
	}
	
	// [CEReactions, NewObject] Element createElementNS(DOMString? namespace, DOMString qualifiedName, optional (DOMString or ElementCreationOptions) options = {});
	static int createElementNS(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _namespace = GetString(ctx, 1);
		DKString qualifiedName = GetString(ctx, 2);
		DKString options = GetString(ctx, 3);
		DKString _createElementNS = eventTarget(ctx)->createElementNS(_namespace, qualifiedName, options);
		dukglue_push(ctx, _createElementNS);	
		return true;
	}
	
	// [NewObject] DocumentFragment createDocumentFragment();
	static int createDocumentFragment(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _createDocumentFragment = eventTarget(ctx)->createDocumentFragment();
		dukglue_push(ctx, _createDocumentFragment);	
		return true;
	}
	
	// [NewObject] Text createTextNode(DOMString data);
	static int createTextNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _data = GetString(ctx, 1);
		DKString _createTextNode;
		if(!eventTarget(ctx)->createTextNode(_data, _createTextNode))
			return false;
		dukglue_push(ctx, _createTextNode);	
		return true;
	}
	
	// [NewObject] CDATASection createCDATASection(DOMString data);
	static int createCDATASection(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _data = GetString(ctx, 1);
		DKString _createCDATASection;
		if(!eventTarget(ctx)->createCDATASection(_data, _createCDATASection))
			return false;
		dukglue_push(ctx, _createCDATASection);	
		return true;
	}
	
	// [NewObject] Comment createComment(DOMString data);
	static int createComment(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _data = GetString(ctx, 1);
		DKString _createComment;
		if(!eventTarget(ctx)->createComment(_data, _createComment))
			return false;
		dukglue_push(ctx, _createComment);	
		return true;
	}
	
	// [NewObject] ProcessingInstruction createProcessingInstruction(DOMString target, DOMString data);
	static int createProcessingInstruction(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _target = GetString(ctx, 1);
		DKString _data = GetString(ctx, 2);
		DKString _createProcessingInstruction;
		if(!eventTarget(ctx)->createProcessingInstruction(_target, _data, _createProcessingInstruction))
			return false;
		dukglue_push(ctx, _createProcessingInstruction);	
		return true;
	}
	
	// [CEReactions, NewObject] Node importNode(Node node, optional boolean deep = false);
	static int importNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _node = GetString(ctx, 1);
		bool _deep = GetBool(ctx, 2);
		DKString _importNode;
		if(!eventTarget(ctx)->importNode(_node, _deep, _importNode))
			return false;
		dukglue_push(ctx, _importNode);	
		return true;
	}
	
	// [CEReactions] Node adoptNode(Node node);
	static int adoptNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _node = GetString(ctx, 1);
		DKString _adoptNode;
		if(!eventTarget(ctx)->adoptNode(_node, _adoptNode))
			return false;
		dukglue_push(ctx, _adoptNode);	
		return true;
	}
	
	// [NewObject] Attr createAttribute(DOMString localName);
	static int createAttribute(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _localName = GetString(ctx, 1);
		DKString _createAttribute;
		if(!eventTarget(ctx)->createAttribute(_localName, _createAttribute))
			return false;
		dukglue_push(ctx, _createAttribute);	
		return true;
	}
	
	// [NewObject] Attr createAttributeNS(DOMString? namespace, DOMString qualifiedName);
	static int createAttributeNS(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _namespace = GetString(ctx, 1);
		DKString _qualifiedName = GetString(ctx, 2);
		DKString _createAttributeNS;
		if(!eventTarget(ctx)->createAttributeNS(_namespace, _qualifiedName, _createAttributeNS))
			return false;
		dukglue_push(ctx, _createAttributeNS);	
		return true;
	}
	
	// [NewObject] Event createEvent(DOMString interface); // legacy
	static int createEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _interface = GetString(ctx, 1);
		DKString _createEvent;
		if(!eventTarget(ctx)->createEvent(_interface, _createEvent))
			return false;
		dukglue_push(ctx, _createEvent);	
		return true;
	}
	
	// [NewObject] Range createRange();
	static int createRange(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _createRange;
		if(!eventTarget(ctx)->createRange(_createRange))
			return false;
		dukglue_push(ctx, _createRange);	
		return true;
	}
	
	// NodeFilter.SHOW_ALL = 0xFFFFFFFF
	// TODO 
	
	// [NewObject] NodeIterator createNodeIterator(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	static int createNodeIterator(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _root = GetString(ctx, 1);
		unsigned int _whatToShow = GetUint(ctx, 2);
		DKString _filter = GetString(ctx, 3);
		DKString _createNodeIterator;
		if(!eventTarget(ctx)->createNodeIterator(_root, _whatToShow, _filter, _createNodeIterator))
			return false;
		dukglue_push(ctx, _createNodeIterator);	
		return true;
	}
	
	// [NewObject] TreeWalker createTreeWalker(Node root, optional unsigned long whatToShow = 0xFFFFFFFF, optional NodeFilter? filter = null);
	static int createTreeWalker(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _root = GetString(ctx, 1);
		unsigned int _whatToShow = GetUint(ctx, 2);
		DKString _filter = GetString(ctx, 3);
		DKString _createTreeWalker;
		if(!eventTarget(ctx)->createTreeWalker(_root, _whatToShow, _filter, _createTreeWalker))
			return false;
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
				DKString _element = GetString(ctx, 1);
				DKString _measureElement;
				if(!eventTarget(ctx)->measureElement(_element, _measureElement))
					return false;
				dukglue_push(ctx, _measureElement);	
				return true;
			}
	//
	//		FontMetrics measureText(DOMString text, StylePropertyMapReadOnly styleMap);
			static int measureText(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				DKString _text = GetString(ctx, 1);
				DKString _styleMap = GetString(ctx, 2);
				DKString _measureText;
				if(!eventTarget(ctx)->measureText(_text, _styleMap, _measureText))
					return false;
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
					eventTarget(ctx)->fullscreenEnabled(GetBool(ctx));
				dukglue_push(ctx, eventTarget(ctx)->fullscreenEnabled());
				return true;
			}
	//		
	//		[LegacyLenientSetter, Unscopable] readonly attribute boolean fullscreen; // historical
			static int fullscreen(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->fullscreen(GetBool(ctx));
				dukglue_push(ctx, eventTarget(ctx)->fullscreen());
				return true;
			}
	//
	//		Promise<undefined> exitFullscreen();
			static int exitFullscreen(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				DKString _exitFullscreen;
				if(!eventTarget(ctx)->exitFullscreen(_exitFullscreen))
					return false;
				dukglue_push(ctx, _exitFullscreen);	
				return true;
			}
	//
	//		attribute EventHandler onfullscreenchange;
			static int onfullscreenchange(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->onfullscreenchange(GetString(ctx));
				dukglue_push(ctx, eventTarget(ctx)->onfullscreenchange());
				return true;
			}
	//
	//		attribute EventHandler onfullscreenerror;
			static int onfullscreenerror(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->onfullscreenerror(GetString(ctx));
				dukglue_push(ctx, eventTarget(ctx)->onfullscreenerror());
				return true;
			}
	//};
};
REGISTER_OBJECT(DKDocumentDUK, true)


#endif //DKDocumentDUK_H
#endif //HAVE_DKDuktape