// [IDL] https://dom.spec.whatwg.org/#interface-element
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Element
#pragma once
#ifndef TEST_Element_H
#define TEST_Element_H

#include "DKElement/DKElement.h"


class TEST_Element //: public DKObjectT<TEST_Element>
{
public:
	TEST_Element(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_Element.h //////");

		DKElement element;
		printElementProperties(&element);
	}
	
	static void printElementProperties(DKElement* element){
		DKDEBUGFUNC(element);
		
		console.log("element = "					+toString(element));
		
		// readonly attribute DOMString? namespaceURI;
		console.log("element->namespaceURI() = "	+toString(element->namespaceURI()));
		
		// readonly attribute DOMString? prefix;
		console.log("element->prefix() = "			+toString(element->prefix()));
		
		// readonly attribute DOMString localName;
		console.log("element->localName() = "		+toString(element->localName()));
		
		// readonly attribute DOMString tagName;
		console.log("element->tagName() = "			+toString(element->tagName()));
		
		// [CEReactions] attribute DOMString id;
		console.log("element->id() = "				+toString(element->id()));
		
		// [CEReactions] attribute DOMString className;
		console.log("element->className() = "		+toString(element->className()));
		
		// [SameObject, PutForwards=value] readonly attribute DOMTokenList classList;
		console.log("element->classList() = "		+toString(element->classList()));
		
		//[CEReactions, Unscopable] attribute DOMString slot;
		console.log("element->slot() = "			+toString(element->slot()));
		
		// boolean hasAttributes();
		// function
		
		// [SameObject] readonly attribute NamedNodeMap attributes;
		console.log("element->attributes() = "		+toString(element->attributes()));
		
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
		console.log("element->shadowRoot() = "		+toString(element->shadowRoot()));
		
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
		
		TEST_Node::printNodeProperties(element);
	}
};
//REGISTER_OBJECT(TEST_Element, true);


#endif //TEST_Element_H