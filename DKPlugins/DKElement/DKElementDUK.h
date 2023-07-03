// [IDL] https://dom.spec.whatwg.org/#interface-element
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Element
#if HAVE_DKDuktape

#pragma once
#ifndef DKElementDUK_H
#define DKElementDUK_H

#include "DKDuktape/DKDuktape.h"


// [Exposed=Window]
// interface Element : Node {
class DKElementDUK : public DKObjectT<DKElementDUK>
{
public:
	bool Init(){
		DKDuktape::AttachFunction("CPP_DKElementDUK_constructor", 				DKElementDUK::constructor);
		
		////// NOTE: from DKElementCSSInlineStyle
		// [SameObject, PutForwards=cssText] readonly attribute CSSStyleDeclaration style;
		DKDuktape::AttachFunction("CPP_DKElementDUK_style", 					DKElementDUK::style);
		/////////////////////////////////////////
		
		// readonly attribute DOMString? namespaceURI;
		DKDuktape::AttachFunction("CPP_DKElementDUK_namespaceURI", 				DKElementDUK::namespaceURI);
		
		// readonly attribute DOMString? prefix;
		DKDuktape::AttachFunction("CPP_DKElementDUK_prefix", 					DKElementDUK::prefix);
		
		// readonly attribute DOMString localName;
		DKDuktape::AttachFunction("CPP_DKElementDUK_localName", 				DKElementDUK::localName);
		
		// readonly attribute DOMString tagName;
		DKDuktape::AttachFunction("CPP_DKElementDUK_tagName", 					DKElementDUK::tagName);
		
		// [CEReactions] attribute DOMString id;
		DKDuktape::AttachFunction("CPP_DKElementDUK_id", 						DKElementDUK::id);
		
		// [CEReactions] attribute DOMString className;
		DKDuktape::AttachFunction("CPP_DKElementDUK_className", 				DKElementDUK::className);
		
		// [SameObject, PutForwards=value] readonly attribute DOMTokenList classList;
		DKDuktape::AttachFunction("CPP_DKElementDUK_classList", 				DKElementDUK::classList);
		
		//[CEReactions, Unscopable] attribute DOMString slot;
		DKDuktape::AttachFunction("CPP_DKElementDUK_slot", 						DKElementDUK::slot);
		
		// boolean hasAttributes();
		DKDuktape::AttachFunction("CPP_DKElementDUK_hasAttributes",				DKElementDUK::hasAttributes);
			
		// [SameObject] readonly attribute NamedNodeMap attributes;
		DKDuktape::AttachFunction("CPP_DKElementDUK_attributes", 				DKElementDUK::attributes);
		
		// sequence<DOMString> getAttributeNames();
		DKDuktape::AttachFunction("CPP_DKElementDUK_getAttributeNames",			DKElementDUK::getAttributeNames);
		
		// DOMString? getAttribute(DOMString qualifiedName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_getAttribute",				DKElementDUK::getAttribute);
		
		// DOMString? getAttributeNS(DOMString? namespace, DOMString localName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_getAttributeNS", 			DKElementDUK::getAttributeNS);
		
		// [CEReactions] undefined setAttribute(DOMString qualifiedName, DOMString value);
		DKDuktape::AttachFunction("CPP_DKElementDUK_setAttribute", 				DKElementDUK::setAttribute);
		
		// [CEReactions] undefined setAttributeNS(DOMString? namespace, DOMString qualifiedName, DOMString value);
		DKDuktape::AttachFunction("CPP_DKElementDUK_setAttributeNS", 			DKElementDUK::setAttributeNS);
		
		// [CEReactions] undefined removeAttribute(DOMString qualifiedName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_removeAttribute", 			DKElementDUK::removeAttribute);
		
		// [CEReactions] undefined removeAttributeNS(DOMString? namespace, DOMString localName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_removeAttributeNS",			DKElementDUK::removeAttributeNS);
		
		// [CEReactions] boolean toggleAttribute(DOMString qualifiedName, optional boolean force);
		DKDuktape::AttachFunction("CPP_DKElementDUK_toggleAttribute", 			DKElementDUK::toggleAttribute);
		
		// boolean hasAttribute(DOMString qualifiedName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_hasAttribute", 				DKElementDUK::hasAttribute);
		
		// boolean hasAttributeNS(DOMString? namespace, DOMString localName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_hasAttributeNS", 			DKElementDUK::hasAttributeNS);
		
		// Attr? getAttributeNode(DOMString qualifiedName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_getAttributeNode", 			DKElementDUK::getAttributeNode);
		
		// Attr? getAttributeNodeNS(DOMString? namespace, DOMString localName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_getAttributeNodeNS", 		DKElementDUK::getAttributeNodeNS);
		
		// [CEReactions] Attr? setAttributeNode(Attr attr);
		DKDuktape::AttachFunction("CPP_DKElementDUK_setAttributeNode", 			DKElementDUK::setAttributeNode);
		
		// [CEReactions] Attr? setAttributeNodeNS(Attr attr);
		DKDuktape::AttachFunction("CPP_DKElementDUK_setAttributeNodeNS", 		DKElementDUK::setAttributeNodeNS);
		
		// [CEReactions] Attr removeAttributeNode(Attr attr);
		DKDuktape::AttachFunction("CPP_DKElementDUK_removeAttributeNode", 		DKElementDUK::removeAttributeNode);
		
		// ShadowRoot attachShadow(ShadowRootInit init);
		DKDuktape::AttachFunction("CPP_DKElementDUK_attachShadow",				DKElementDUK::attachShadow);
		
		// readonly attribute ShadowRoot? shadowRoot;
		DKDuktape::AttachFunction("CPP_DKElementDUK_shadowRoot",				DKElementDUK::shadowRoot);
		
		// Element? closest(DOMString selectors);
		DKDuktape::AttachFunction("CPP_DKElementDUK_closest",					DKElementDUK::closest);
		
		// boolean matches(DOMString selectors);
		DKDuktape::AttachFunction("CPP_DKElementDUK_matches",					DKElementDUK::matches);
		
		// boolean webkitMatchesSelector(DOMString selectors); // legacy alias of .matches
		DKDuktape::AttachFunction("CPP_DKElementDUK_webkitMatchesSelector", 	DKElementDUK::webkitMatchesSelector);
		
		// HTMLCollection getElementsByTagName(DOMString qualifiedName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_getElementsByTagName",		DKElementDUK::getElementsByTagName);
		
		// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_getElementsByTagNameNS",	DKElementDUK::getElementsByTagNameNS);
		
		// HTMLCollection getElementsByClassName(DOMString classNames);
		DKDuktape::AttachFunction("CPP_DKElementDUK_getElementsByClassName", 	DKElementDUK::getElementsByClassName);
		
		// [CEReactions] Element? insertAdjacentElement(DOMString where, Element element); // legacy
		DKDuktape::AttachFunction("CPP_DKElementDUK_insertAdjacentElement", 	DKElementDUK::insertAdjacentElement);
		
		// undefined insertAdjacentText(DOMString where, DOMString data); // legacy
		DKDuktape::AttachFunction("CPP_DKElementDUK_insertAdjacentText", 		DKElementDUK::insertAdjacentText);

		
		////// Load .js files //////
		DKClass::DKCreate("DKElement/DKElementDUK.js");
		
		return true;
	}
	
	static DKElement* element(duk_context* ctx){
		DKString interfaceAddress = duk_require_string(ctx, 0);
		DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
		DKString elementAddress = interface->address["Element"];
		DKElement* _element = (DKElement*)addressToPointer(elementAddress);
		return _element;
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

	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		
		DKINFO("CPP_DKElementDUK_constructor()\n");
		DKElement* _element = new DKElement();
		dukglue_push(ctx, _element->interfaceAddress);
		return true;
	}
	
	////// NOTE: from DKElementCSSInlineStyle
	// [SameObject, PutForwards=cssText] readonly attribute CSSStyleDeclaration style;
	static int style(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		//if(duk_is_valid_index(ctx, 1))
		//	element(ctx)->style( (CSSStyleDeclaration*)addressToPointer(GetString(ctx)) );
		dukglue_push(ctx, element(ctx)->style()->interfaceAddress);
		return true;
	}
	/////////////////////////////////////////
	
	// readonly attribute DOMString? namespaceURI;
	static int namespaceURI(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			element(ctx)->namespaceURI(GetString(ctx));
		dukglue_push(ctx, element(ctx)->namespaceURI());
		return true;
	}
	
	// readonly attribute DOMString? prefix;
	static int prefix(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			element(ctx)->prefix(GetString(ctx));
		dukglue_push(ctx, element(ctx)->prefix());
		return true;
	}
	
	// readonly attribute DOMString localName;
	static int localName(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			element(ctx)->localName(GetString(ctx));
		dukglue_push(ctx, element(ctx)->localName());
		return true;
	}
	
	// readonly attribute DOMString tagName;
	static int tagName(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			element(ctx)->tagName(GetString(ctx));
		dukglue_push(ctx, element(ctx)->tagName());
		return true;
	}
	
	// [CEReactions] attribute DOMString id;
	static int id(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			element(ctx)->id(GetString(ctx));
		dukglue_push(ctx, element(ctx)->id());
		return true;
	}
	
	// [CEReactions] attribute DOMString className;
	static int className(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			element(ctx)->className(GetString(ctx));
		dukglue_push(ctx, element(ctx)->className());
		return true;
	}
	
	// [SameObject, PutForwards=value] readonly attribute DOMTokenList classList;
	static int classList(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			element(ctx)->classList(GetString(ctx));
		dukglue_push(ctx, element(ctx)->classList());
		return true;
	}
	
	//[CEReactions, Unscopable] attribute DOMString slot;
	static int slot(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			element(ctx)->slot(GetString(ctx));
		dukglue_push(ctx, element(ctx)->slot());
		return true;
	}
	
	// boolean hasAttributes();
	static int hasAttributes(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, element(ctx)->hasAttributes());
		return true;
	}
	
	// [SameObject] readonly attribute NamedNodeMap attributes;
	static int attributes(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			element(ctx)->attributes(GetString(ctx));
		dukglue_push(ctx, element(ctx)->attributes());
		return true;
	}
	
	// sequence<DOMString> getAttributeNames();
	static int getAttributeNames(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, element(ctx)->getAttributeNames());	
		return true;
	}
	
	// DOMString? getAttribute(DOMString qualifiedName);
	static int getAttribute(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString qualifiedName	= GetString(ctx, 1);
		dukglue_push(ctx, element(ctx)->getAttribute(qualifiedName));
		return true;
	}
	
	// DOMString? getAttributeNS(DOMString? namespace, DOMString localName);
	static int getAttributeNS(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString _namespace	= GetString(ctx, 1);
		DOMString localName		= GetString(ctx, 2);
		dukglue_push(ctx, element(ctx)->getAttributeNS(_namespace, localName));
		return true;
	}
	
	// [CEReactions] undefined setAttribute(DOMString qualifiedName, DOMString value);
	static int setAttribute(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString qualifiedName	= GetString(ctx, 1);
		DOMString value			= GetString(ctx, 2);
		element(ctx)->setAttribute(qualifiedName, value);
		return true;
	}
	
	// [CEReactions] undefined setAttributeNS(DOMString? namespace, DOMString qualifiedName, DOMString value);
	static int setAttributeNS(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString _namespace	= GetString(ctx, 1);
		DOMString qualifiedName	= GetString(ctx, 2);
		DOMString value			= GetString(ctx, 3);
		element(ctx)->setAttributeNS(_namespace, qualifiedName, value);
		return true;
	}
	
	// [CEReactions] undefined removeAttribute(DOMString qualifiedName);
	static int removeAttribute(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString qualifiedName	= GetString(ctx, 1);
		element(ctx)->removeAttribute(qualifiedName);
		return true;
	}
	
	// [CEReactions] undefined removeAttributeNS(DOMString? namespace, DOMString localName);
	static int removeAttributeNS(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString _namespace	= GetString(ctx, 1);
		DOMString localName		= GetString(ctx, 2);
		element(ctx)->removeAttributeNS(_namespace, localName);
		return true;
	}
	
	// [CEReactions] boolean toggleAttribute(DOMString qualifiedName, optional boolean force);
	static int toggleAttribute(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString qualifiedName = GetString(ctx, 1);
		bool force 				= GetBool(ctx, 2);
		dukglue_push(ctx, element(ctx)->toggleAttribute(qualifiedName, force));
		return DKTODO();
	}
	
	// boolean hasAttribute(DOMString qualifiedName);
	static int hasAttribute(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString qualifiedName = GetString(ctx, 1);
		dukglue_push(ctx, element(ctx)->hasAttribute(qualifiedName));
		return true;
	}
	
	// boolean hasAttributeNS(DOMString? namespace, DOMString localName);
	static int hasAttributeNS(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString _namespace = GetString(ctx, 1);
		DOMString localName = GetString(ctx, 1);
		dukglue_push(ctx, element(ctx)->hasAttributeNS(_namespace, localName));
		return true;
	}
	
	// Attr? getAttributeNode(DOMString qualifiedName);
	static int getAttributeNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString qualifiedName = GetString(ctx, 1);
		dukglue_push(ctx, element(ctx)->getAttributeNode(qualifiedName));
		return true;
	}
	
	// Attr? getAttributeNodeNS(DOMString? namespace, DOMString localName);
	static int getAttributeNodeNS(duk_context* ctx){
		DOMString _namespace = GetString(ctx, 1);
		DOMString localName = GetString(ctx, 2);
		dukglue_push(ctx, element(ctx)->getAttributeNodeNS(_namespace, localName));
		return true;
	}
	
	// [CEReactions] Attr? setAttributeNode(Attr attr);
	static int setAttributeNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// [CEReactions] Attr? setAttributeNodeNS(Attr attr);
	static int setAttributeNodeNS(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// [CEReactions] Attr removeAttributeNode(Attr attr);
	static int removeAttributeNode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// ShadowRoot attachShadow(ShadowRootInit init);
	static int attachShadow(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// readonly attribute ShadowRoot? shadowRoot;
	static int shadowRoot(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			element(ctx)->shadowRoot(GetString(ctx));
		dukglue_push(ctx, element(ctx)->shadowRoot());
		return true;
	}
	
	// Element? closest(DOMString selectors);
	static int closest(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString selectors = GetString(ctx, 1);
		dukglue_push(ctx, element(ctx)->closest(selectors)->interfaceAddress);
		return true;
	}
	
	// boolean matches(DOMString selectors);
	static int matches(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString selectors = GetString(ctx, 1);
		dukglue_push(ctx, element(ctx)->matches(selectors));	
		return true;
	}
	
	// boolean webkitMatchesSelector(DOMString selectors); // legacy alias of .matches
	static int webkitMatchesSelector(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString selectors = GetString(ctx, 1);
		dukglue_push(ctx, element(ctx)->webkitMatchesSelector(selectors));	
		return true;
	}
	
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	static int getElementsByTagName(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString qualifiedName = GetString(ctx, 1);
		
		dukglue_push(ctx, element(ctx)->getElementsByTagName(qualifiedName)->interfaceAddress);	
		return true;
	}
	
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	static int getElementsByTagNameNS(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString _namespace = GetString(ctx, 1);
		DOMString localName = GetString(ctx, 2);
		dukglue_push(ctx, element(ctx)->getElementsByTagNameNS(_namespace, localName)->interfaceAddress);
		return true;
	}
	
	// HTMLCollection getElementsByClassName(DOMString classNames);
	static int getElementsByClassName(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString classNames = GetString(ctx, 1);
		dukglue_push(ctx, element(ctx)->getElementsByClassName(classNames)->interfaceAddress);
		return true;
	}
	
	// [CEReactions] Element? insertAdjacentElement(DOMString where, Element element); // legacy
	static int insertAdjacentElement(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString where 		= GetString(ctx, 1);
		DKString elementAddress = GetString(ctx, 2);
		DKElement* _element 	= (DKElement*)addressToPointer(elementAddress);
		dukglue_push(ctx, element(ctx)->insertAdjacentElement(where, _element)->interfaceAddress);	
		return true;
	}
	
	// undefined insertAdjacentText(DOMString where, DOMString data); // legacy
	static int insertAdjacentText(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString where = GetString(ctx, 1);
		DOMString data 	= GetString(ctx, 2);
		element(ctx)->insertAdjacentText(where, data);
		return true;
	}
};
REGISTER_OBJECT(DKElementDUK, true)


#endif //DKElementDUK_H
#endif //HAVE_DKDuktape