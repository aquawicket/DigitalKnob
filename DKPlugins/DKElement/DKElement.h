// [IDL] https://dom.spec.whatwg.org/#interface-element
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Element
#pragma once
#ifndef DKElement_H
#define DKElement_H

#include "DKNode/DKNode.h"


// [Exposed=Window]
// interface Element : Node {
class DKElement : public DKNode
{
public:
	DKElement() : DKNode() {
		DKDEBUGFUNC();
		interfaceName = "Element";
		interfaceAddress = pointerToAddress(this);
	}
	
	// readonly attribute DOMString? namespaceURI;
	virtual bool namespaceURI(DOMString&, bool) { return false; }
	
	// readonly attribute DOMString? prefix;
	virtual bool prefix(DOMString&, bool) { return false; }
  
	// readonly attribute DOMString localName;
	virtual bool localName(DOMString&, bool) { return false; }
	
	// readonly attribute DOMString tagName;
	virtual bool tagName(DOMString&, bool) { return false; }

	// [CEReactions] attribute DOMString id;
	virtual bool id(DOMString&, bool) { return false; }
	
	// [CEReactions] attribute DOMString className;
	virtual bool className(DOMString&, bool) { return false; }
	
	// [SameObject, PutForwards=value] readonly attribute DOMTokenList classList;
	virtual bool classList(DKString&, bool) { return false; }
	
	//[CEReactions, Unscopable] attribute DOMString slot;
	virtual bool slot(DOMString&, bool) { return false; }
	
	// boolean hasAttributes();
	// TODO
	
	// [SameObject] readonly attribute NamedNodeMap attributes;
	// TODO
	
	// sequence<DOMString> getAttributeNames();
	// TODO
	
	// DOMString? getAttribute(DOMString qualifiedName);
	// TODO
	
	// DOMString? getAttributeNS(DOMString? namespace, DOMString localName);
	// TODO
	
	// [CEReactions] undefined setAttribute(DOMString qualifiedName, DOMString value);
	// TODO
	
	// [CEReactions] undefined setAttributeNS(DOMString? namespace, DOMString qualifiedName, DOMString value);
	// TODO
	
	// [CEReactions] undefined removeAttribute(DOMString qualifiedName);
	// TODO
	
	// [CEReactions] undefined removeAttributeNS(DOMString? namespace, DOMString localName);
	// TODO
	
	// [CEReactions] boolean toggleAttribute(DOMString qualifiedName, optional boolean force);
	// TODO
	
	// boolean hasAttribute(DOMString qualifiedName);
	// TODO
	
	// boolean hasAttributeNS(DOMString? namespace, DOMString localName);
	// TODO
	
	// Attr? getAttributeNode(DOMString qualifiedName);
	// TODO
	
	// Attr? getAttributeNodeNS(DOMString? namespace, DOMString localName);
	// TODO
	
	// [CEReactions] Attr? setAttributeNode(Attr attr);
	// TODO
	
	// [CEReactions] Attr? setAttributeNodeNS(Attr attr);
	// TODO
	
	// [CEReactions] Attr removeAttributeNode(Attr attr);
	// TODO
	
	// ShadowRoot attachShadow(ShadowRootInit init);
	// TODO
	
	// readonly attribute ShadowRoot? shadowRoot;
	// TODO
	
	// Element? closest(DOMString selectors);
	// TODO
	
	// boolean matches(DOMString selectors);
	// TODO
	
	// boolean webkitMatchesSelector(DOMString selectors); // legacy alias of .matches
	// TODO
  
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	// TODO
	
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	// TODO
	
	// HTMLCollection getElementsByClassName(DOMString classNames);
	// TODO
  
	// [CEReactions] Element? insertAdjacentElement(DOMString where, Element element); // legacy
	// TODO
	
	// undefined insertAdjacentText(DOMString where, DOMString data); // legacy
	// TODO
//};

};


#endif //DKElement_H