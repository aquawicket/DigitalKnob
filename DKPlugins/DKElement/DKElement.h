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
	virtual bool hasAttributeNS(DOMString& _namespace, DOMString& _localName, bool& _hasAttributeNS){
		DKDEBUGFUNC(_namespace, _localName, _hasAttributeNS);
		return DKTODO();
	}
	
	// Attr? getAttributeNode(DOMString qualifiedName);
	virtual bool getAttributeNode(DOMString& _qualifiedName, DKString& _getAttributeNode){
		DKDEBUGFUNC(_qualifiedName, _getAttributeNode);
		return DKTODO();
	}
	
	// Attr? getAttributeNodeNS(DOMString? namespace, DOMString localName);
	virtual bool getAttributeNodeNS(DOMString& _namespace, DOMString& _localName, DKString& _getAttributeNodeNS){
		DKDEBUGFUNC(_namespace, _localName, _getAttributeNodeNS);
		return DKTODO();
	}
	
	// [CEReactions] Attr? setAttributeNode(Attr attr);
	virtual bool setAttributeNode(DKString& _attr, DKString& _setAttributeNode){
		DKDEBUGFUNC(_attr, _setAttributeNode);
		return DKTODO();
	}
	
	// [CEReactions] Attr? setAttributeNodeNS(Attr attr);
	virtual bool setAttributeNodeNS(DKString& _attr, DKString& _setAttributeNodeNS){
		DKDEBUGFUNC(_attr, _setAttributeNodeNS);
		return DKTODO();
	}
	
	// [CEReactions] Attr removeAttributeNode(Attr attr);
	virtual bool removeAttributeNode(DKString& _attr, DKString& _removeAttributeNode){
		DKDEBUGFUNC(_attr, _removeAttributeNode);
		return DKTODO();
	}
	
	// ShadowRoot attachShadow(ShadowRootInit init);
	virtual bool attachShadow(DKString& _init, DKString& _attachShadow){
		DKDEBUGFUNC(_init, _attachShadow);
		return DKTODO();
	}
	
	// readonly attribute ShadowRoot? shadowRoot;
	virtual bool shadowRoot(DKString&, bool) { return false; }
	
	// Element? closest(DOMString selectors);
	virtual bool closest(DOMString& _selectors, DKString& _closest){
		DKDEBUGFUNC(_selectors, _closest);
		return DKTODO();
	}
	
	// boolean matches(DOMString selectors);
	virtual bool matches(DOMString& _selectors, bool& _matches){
		DKDEBUGFUNC(_selectors, _matches);
		return DKTODO();
	}
	
	// boolean webkitMatchesSelector(DOMString selectors); // legacy alias of .matches
	virtual bool webkitMatchesSelector(DOMString& _selectors, bool& _webkitMatchesSelector){
		DKDEBUGFUNC(_selectors, _webkitMatchesSelector);
		return DKTODO();
	}
  
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	virtual bool getElementsByTagName(DOMString& _qualifiedName, DKString& _getElementsByTagName){
		DKDEBUGFUNC(_qualifiedName, _getElementsByTagName);
		return DKTODO();
	}
	
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	virtual bool getElementsByTagNameNS(DOMString& _namespace, DOMString& _localName, DKString& _getElementsByTagNameNS){
		DKDEBUGFUNC(_namespace, _localName, _getElementsByTagNameNS);
		return DKTODO();
	}
	
	// HTMLCollection getElementsByClassName(DOMString classNames);
	virtual bool getElementsByClassName(DOMString& _classNames, DKString& _getElementsByClassName){
		DKDEBUGFUNC(_classNames, _getElementsByClassName);
		return DKTODO();
	}
  
	// [CEReactions] Element? insertAdjacentElement(DOMString where, Element element); // legacy
	virtual bool insertAdjacentElement(DOMString& _where, DKString& _element, DKString& _insertAdjacentElement){
		DKDEBUGFUNC(_where, _element, _insertAdjacentElement);
		return DKTODO();
	}
	
	// undefined insertAdjacentText(DOMString where, DOMString data); // legacy
	virtual bool insertAdjacentText(DOMString& _where, DOMString& _data){
		DKDEBUGFUNC(_where, _data);
		return DKTODO();
	}
//};

};


#endif //DKElement_H