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
		DKDuktape::AttachFunction("CPP_DKElementDUK", DKElementDUK::constructor);
		
		// readonly attribute DOMString? namespaceURI;
		DKDuktape::AttachFunction("CPP_DKElementDUK_namespaceURI", DKElementDUK::namespaceURI);
		
		// readonly attribute DOMString? prefix;
		DKDuktape::AttachFunction("CPP_DKElementDUK_prefix", DKElementDUK::prefix);
		
		// readonly attribute DOMString localName;
		DKDuktape::AttachFunction("CPP_DKElementDUK_localName", DKElementDUK::localName);
		
		// readonly attribute DOMString tagName;
		DKDuktape::AttachFunction("CPP_DKElementDUK_tagName", DKElementDUK::tagName);
		
		// [CEReactions] attribute DOMString id;
		DKDuktape::AttachFunction("CPP_DKElementDUK_id", DKElementDUK::id);
		
		// [CEReactions] attribute DOMString className;
		DKDuktape::AttachFunction("CPP_DKElementDUK_className", DKElementDUK::className);
		
		// [SameObject, PutForwards=value] readonly attribute DOMTokenList classList;
		DKDuktape::AttachFunction("CPP_DKElementDUK_classList", DKElementDUK::classList);
		
		//[CEReactions, Unscopable] attribute DOMString slot;
		DKDuktape::AttachFunction("CPP_DKElementDUK_slot", DKElementDUK::slot);
		
		// boolean hasAttributes();
		DKDuktape::AttachFunction("CPP_DKElementDUK_hasAttributes", DKElementDUK::hasAttributes);
		
		// [SameObject] readonly attribute NamedNodeMap attributes;
		DKDuktape::AttachFunction("CPP_DKElementDUK_attributes", DKElementDUK::attributes);
		
		// sequence<DOMString> getAttributeNames();
		DKDuktape::AttachFunction("CPP_DKElementDUK_getAttributeNames", DKElementDUK::getAttributeNames);
		
		// DOMString? getAttribute(DOMString qualifiedName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_getAttribute", DKElementDUK::getAttribute);
		
		// DOMString? getAttributeNS(DOMString? namespace, DOMString localName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_getAttributeNS", DKElementDUK::getAttributeNS);
		
		// [CEReactions] undefined setAttribute(DOMString qualifiedName, DOMString value);
		DKDuktape::AttachFunction("CPP_DKElementDUK_setAttribute", DKElementDUK::setAttribute);
		
		// [CEReactions] undefined setAttributeNS(DOMString? namespace, DOMString qualifiedName, DOMString value);
		DKDuktape::AttachFunction("CPP_DKElementDUK_setAttributeNS", DKElementDUK::setAttributeNS);
		
		// [CEReactions] undefined removeAttribute(DOMString qualifiedName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_removeAttribute", DKElementDUK::removeAttribute);
		
		// [CEReactions] undefined removeAttributeNS(DOMString? namespace, DOMString localName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_removeAttributeNS", DKElementDUK::removeAttributeNS);
		
		// [CEReactions] boolean toggleAttribute(DOMString qualifiedName, optional boolean force);
		DKDuktape::AttachFunction("CPP_DKElementDUK_toggleAttribute", DKElementDUK::toggleAttribute);
		
		// boolean hasAttribute(DOMString qualifiedName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_hasAttribute", DKElementDUK::hasAttribute);
		
		// boolean hasAttributeNS(DOMString? namespace, DOMString localName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_hasAttributeNS", DKElementDUK::hasAttributeNS);
		
		// Attr? getAttributeNode(DOMString qualifiedName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_getAttributeNode", DKElementDUK::getAttributeNode);
		
		// Attr? getAttributeNodeNS(DOMString? namespace, DOMString localName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_getAttributeNodeNS", DKElementDUK::getAttributeNodeNS);
		
		// [CEReactions] Attr? setAttributeNode(Attr attr);
		DKDuktape::AttachFunction("CPP_DKElementDUK_setAttributeNode", DKElementDUK::setAttributeNode);
		
		// [CEReactions] Attr? setAttributeNodeNS(Attr attr);
		DKDuktape::AttachFunction("CPP_DKElementDUK_setAttributeNodeNS", DKElementDUK::setAttributeNodeNS);
		
		// [CEReactions] Attr removeAttributeNode(Attr attr);
		DKDuktape::AttachFunction("CPP_DKElementDUK_removeAttributeNode", DKElementDUK::removeAttributeNode);
		
		// ShadowRoot attachShadow(ShadowRootInit init);
		DKDuktape::AttachFunction("CPP_DKElementDUK_attachShadow", DKElementDUK::attachShadow);
		
		// readonly attribute ShadowRoot? shadowRoot;
		DKDuktape::AttachFunction("CPP_DKElementDUK_shadowRoot", DKElementDUK::shadowRoot);
		
		// Element? closest(DOMString selectors);
		DKDuktape::AttachFunction("CPP_DKElementDUK_closest", DKElementDUK::closest);
		
		// boolean matches(DOMString selectors);
		DKDuktape::AttachFunction("CPP_DKElementDUK_matches", DKElementDUK::matches);
		
		// boolean webkitMatchesSelector(DOMString selectors); // legacy alias of .matches
		DKDuktape::AttachFunction("CPP_DKElementDUK_webkitMatchesSelector", DKElementDUK::webkitMatchesSelector);
		
		// HTMLCollection getElementsByTagName(DOMString qualifiedName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_getElementsByTagName", DKElementDUK::getElementsByTagName);
		
		// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
		DKDuktape::AttachFunction("CPP_DKElementDUK_getElementsByTagNameNS", DKElementDUK::getElementsByTagNameNS);
		
		// HTMLCollection getElementsByClassName(DOMString classNames);
		DKDuktape::AttachFunction("CPP_DKElementDUK_getElementsByClassName", DKElementDUK::getElementsByClassName);
		
		// [CEReactions] Element? insertAdjacentElement(DOMString where, Element element); // legacy
		DKDuktape::AttachFunction("CPP_DKElementDUK_insertAdjacentElement", DKElementDUK::insertAdjacentElement);
		
		// undefined insertAdjacentText(DOMString where, DOMString data); // legacy
		DKDuktape::AttachFunction("CPP_DKElementDUK_insertAdjacentText", DKElementDUK::insertAdjacentText);
		
		
		////// Load .js files //////
		DKClass::DKCreate("DKElement/DKElementDUK.js");
		
		return true;
	}
	
	static DKElement* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKElement*)addressToPointer(eventTargetAddress);
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
		DKINFO("CPP_DKElementDUK()\n");
		DKElement* _element = new DKElement();
		DKString eventTargetAddress = pointerToAddress(_element);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	// readonly attribute DOMString? namespaceURI;
	static int namespaceURI(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString _namespaceURI = GetString(ctx);
		if(!eventTarget(ctx)->namespaceURI(_namespaceURI, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _namespaceURI);
		return true;
	}
	
	// TODO
};
REGISTER_OBJECT(DKElementDUK, true)


#endif //DKElementDUK_H
#endif //HAVE_DKDuktape