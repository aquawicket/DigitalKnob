// [IDL] https://dom.spec.whatwg.org/#interface-element
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Element
#pragma once
#ifndef TEST_Element_H
#define TEST_Element_H

#include "DKElement/DKElement.h"


class TEST_Element : public DKObjectT<TEST_Element>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_Element.h //////\n");

		DKElement element;
		printElementProperties(element);
		return true;
	}
	
	static void printElementProperties(DKElement& element){
		DKDEBUGFUNC(element);
		
		// readonly attribute DOMString? namespaceURI;
		DKINFO("element.namespaceURI() = "	+toString(element.namespaceURI())	+"\n");
		
		// readonly attribute DOMString? prefix;
		DKINFO("element.prefix() = "		+toString(element.prefix())			+"\n");
		
		// readonly attribute DOMString localName;
		DKINFO("element.localName() = "		+toString(element.localName())		+"\n");
		
		// readonly attribute DOMString tagName;
		DKINFO("element.tagName() = "		+toString(element.tagName())		+"\n");
		
		// [CEReactions] attribute DOMString id;
		DKINFO("element.id() = "			+toString(element.id())				+"\n");
		
		// [CEReactions] attribute DOMString className;
		DKINFO("element.className() = "		+toString(element.className())		+"\n");
		
		// [SameObject, PutForwards=value] readonly attribute DOMTokenList classList;
		DKINFO("element.classList() = "		+toString(element.classList())		+"\n");
		
		//[CEReactions, Unscopable] attribute DOMString slot;
		DKINFO("element.slot() = "			+toString(element.slot())			+"\n");
		
		// boolean hasAttributes();
		// function
		
		// [SameObject] readonly attribute NamedNodeMap attributes;
		DKINFO("element.attributes() = "	+toString(element.attributes())		+"\n");
		
		// sequence<DOMString> getAttributeNames();
		// function
		
		// DOMString? getAttribute(DOMString qualifiedName);
		// function
		
		// DOMString? getAttributeNS(DOMString? namespace, DOMString localName);
		// function
		
		// [CEReactions] undefined setAttribute(DOMString qualifiedName, DOMString value);
		// function
		
		// [CEReactions] undefined setAttributeNS(DOMString? namespace, DOMString qualifiedName, DOMString value);
		// function
		
		// [CEReactions] undefined removeAttribute(DOMString qualifiedName);
		// function
		
		// [CEReactions] undefined removeAttributeNS(DOMString? namespace, DOMString localName);
		// function
		
		// [CEReactions] boolean toggleAttribute(DOMString qualifiedName, optional boolean force);
		// function
		
		// boolean hasAttribute(DOMString qualifiedName);
		// function
		
		// boolean hasAttributeNS(DOMString? namespace, DOMString localName);
		// function
		
		// Attr? getAttributeNode(DOMString qualifiedName);
		// function
		
		// Attr? getAttributeNodeNS(DOMString? namespace, DOMString localName);
		// function
		
		// [CEReactions] Attr? setAttributeNode(Attr attr);
		// function
		
		// [CEReactions] Attr? setAttributeNodeNS(Attr attr);
		// function
		
		// [CEReactions] Attr removeAttributeNode(Attr attr);
		// function
		
		// ShadowRoot attachShadow(ShadowRootInit init);
		// function
		
		// readonly attribute ShadowRoot? shadowRoot;
		DKINFO("element.shadowRoot() = "	+toString(element.shadowRoot())		+"\n");
		
		// Element? closest(DOMString selectors);
		// function
		
		// boolean matches(DOMString selectors);
		// function
		
		// boolean webkitMatchesSelector(DOMString selectors); // legacy alias of .matches
		// function
		
		// HTMLCollection getElementsByTagName(DOMString qualifiedName);
		// function
		
		// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
		// function
		
		// HTMLCollection getElementsByClassName(DOMString classNames);
		// function
		
		// [CEReactions] Element? insertAdjacentElement(DOMString where, Element element); // legacy
		// function
		
		// undefined insertAdjacentText(DOMString where, DOMString data); // legacy
		// function
	}
};
REGISTER_OBJECT(TEST_Element, true);


#endif //TEST_Element_H