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
	virtual bool hasAttributes(bool& _hasAttributes){
		DKDEBUGFUNC(_hasAttributes);
		return DKTODO();
	}
	
	// [SameObject] readonly attribute NamedNodeMap attributes;
	virtual bool attributes(DKString&, bool) { return false; }
	
	// sequence<DOMString> getAttributeNames();
	virtual bool getAttributeNames(DKString& _getAttributeNames){
		DKDEBUGFUNC(_getAttributeNames);
		return DKTODO();
	}
	
	// DOMString? getAttribute(DOMString qualifiedName);
	virtual bool getAttribute(DOMString& _qualifiedName, DOMString& _getAttribute){
		DKDEBUGFUNC(_qualifiedName, _getAttribute);
		return DKTODO();
	}
	
	// DOMString? getAttributeNS(DOMString? namespace, DOMString localName);
	virtual bool getAttribute(DOMString& _namespace, DOMString& _localName, DOMString& _getAttributeNS){
		DKDEBUGFUNC(_namespace, _localName, _getAttributeNS);
		return DKTODO();
	}
	
	// [CEReactions] undefined setAttribute(DOMString qualifiedName, DOMString value);
	virtual bool setAttribute(DOMString& _qualifiedName, DOMString& _value){
		DKDEBUGFUNC(_qualifiedName, _value);
		return DKTODO();
	}
	
	// [CEReactions] undefined setAttributeNS(DOMString? namespace, DOMString qualifiedName, DOMString value);
	virtual bool setAttributeNS(DOMString& _namespace, DOMString& _qualifiedName, DOMString& _value){
		DKDEBUGFUNC(_namespace, _qualifiedName, _value);
		return DKTODO();
	}
	
	// [CEReactions] undefined removeAttribute(DOMString qualifiedName);
	virtual bool removeAttribute(DOMString& _qualifiedName){
		DKDEBUGFUNC(_qualifiedName);
		return DKTODO();
	}
	
	// [CEReactions] undefined removeAttributeNS(DOMString? namespace, DOMString localName);
	virtual bool removeAttributeNS(DOMString& _namespace, DOMString& _localName){
		DKDEBUGFUNC(_namespace, _localName);
		return DKTODO();
	}
	
	// [CEReactions] boolean toggleAttribute(DOMString qualifiedName, optional boolean force);
	virtual bool toggleAttribute(DOMString& _qualifiedName, bool& _force, bool& _toggleAttribute){
		DKDEBUGFUNC(_qualifiedName, _force, _toggleAttribute);
		return DKTODO();
	}
	
	// boolean hasAttribute(DOMString qualifiedName);
	virtual bool hasAttribute(DOMString& _qualifiedName, bool& _hasAttribute){
		DKDEBUGFUNC(_qualifiedName, _hasAttribute);
		return DKTODO();
	}
	
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