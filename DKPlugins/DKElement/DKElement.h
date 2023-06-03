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
	DOMString _namespaceURI = "";
	virtual const DOMString& namespaceURI()						{ return _namespaceURI; }			// getter
	virtual void namespaceURI(const DOMString& namespaceURI)	{ _namespaceURI = namespaceURI; } 	// setter
	
	// readonly attribute DOMString? prefix;
	DOMString _prefix = "";
	virtual const DOMString& prefix()							{ return _prefix; }					// getter
	virtual void prefix(const DOMString& prefix)				{ _prefix = prefix; } 				// setter
  
	// readonly attribute DOMString localName;
	DOMString _localName = "";
	virtual const DOMString& localName()						{ return _localName; }				// getter
	virtual void localName(const DOMString& localName)			{ _localName = localName; } 		// setter
	
	// readonly attribute DOMString tagName;
	DOMString _tagName = "";
	virtual const DOMString& tagName()							{ return _tagName; }				// getter
	virtual void tagName(const DOMString& tagName)				{ _tagName = tagName; } 			// setter

	// [CEReactions] attribute DOMString id;
	DOMString _id = "";
	virtual const DOMString& id()								{ return _id; }						// getter
	virtual void id(const DOMString& id)						{ _id = id; } 						// setter
	
	// [CEReactions] attribute DOMString className;
	DOMString _className = "";
	virtual const DOMString& className()						{ return _className; }				// getter
	virtual void className(const DOMString& className)			{ _className = className; } 		// setter
	
	// [SameObject, PutForwards=value] readonly attribute DOMTokenList classList;
	DKString _classList = "";
	virtual const DKString& classList()							{ return _classList; }				// getter
	virtual void classList(const DKString& classList)			{ _classList = classList; } 		// setter
	
	//[CEReactions, Unscopable] attribute DOMString slot;
	DOMString _slot = "";
	virtual const DOMString& slot()								{ return _slot; }					// getter
	virtual void slot(const DOMString& slot)					{ _slot = slot; } 					// setter
	
	// boolean hasAttributes();
	bool _hasAttributes = false;
	virtual const bool& hasAttributes(){
		DKDEBUGFUNC();
		return _hasAttributes;
	}
	
	// [SameObject] readonly attribute NamedNodeMap attributes;
	DKString _attributes = "";
	virtual const DKString& attributes()						{ return _attributes; }				// getter
	virtual void attributes(const DKString& attributes)			{ _attributes = attributes; } 		// setter
	
	// sequence<DOMString> getAttributeNames();
	DKString _getAttributeNames = "";
	virtual const DKString& getAttributeNames(){
		DKDEBUGFUNC();
		return _getAttributeNames
	}
	
	// DOMString? getAttribute(DOMString qualifiedName);
	virtual bool getAttribute(DOMString& qualifiedName, DOMString& getAttribute){
		DKDEBUGFUNC(qualifiedName, getAttribute);
		return DKTODO();
	}
	
	// DOMString? getAttributeNS(DOMString? namespace, DOMString localName);
	virtual bool getAttribute(DOMString& _namespace, DOMString& localName, DOMString& getAttributeNS){
		DKDEBUGFUNC(_namespace, localName, getAttributeNS);
		return DKTODO();
	}
	
	// [CEReactions] undefined setAttribute(DOMString qualifiedName, DOMString value);
	virtual bool setAttribute(DOMString& qualifiedName, DOMString& value){
		DKDEBUGFUNC(qualifiedName, value);
		return DKTODO();
	}
	
	// [CEReactions] undefined setAttributeNS(DOMString? namespace, DOMString qualifiedName, DOMString value);
	virtual bool setAttributeNS(DOMString& _namespace, DOMString& qualifiedName, DOMString& value){
		DKDEBUGFUNC(_namespace, qualifiedName, value);
		return DKTODO();
	}
	
	// [CEReactions] undefined removeAttribute(DOMString qualifiedName);
	virtual bool removeAttribute(DOMString& qualifiedName){
		DKDEBUGFUNC(qualifiedName);
		return DKTODO();
	}
	
	// [CEReactions] undefined removeAttributeNS(DOMString? namespace, DOMString localName);
	virtual bool removeAttributeNS(DOMString& _namespace, DOMString& localName){
		DKDEBUGFUNC(_namespace, localName);
		return DKTODO();
	}
	
	// [CEReactions] boolean toggleAttribute(DOMString qualifiedName, optional boolean force);
	virtual bool toggleAttribute(DOMString& qualifiedName, bool& force, bool& toggleAttribute){
		DKDEBUGFUNC(qualifiedName, force, toggleAttribute);
		return DKTODO();
	}
	
	// boolean hasAttribute(DOMString qualifiedName);
	virtual bool hasAttribute(DOMString& qualifiedName, bool& hasAttribute){
		DKDEBUGFUNC(qualifiedName, hasAttribute);
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
	virtual DKString shadowRoot()							{ return ""; }	// getter
	virtual void shadowRoot(const DKString&)				{ } 			// setter
	
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