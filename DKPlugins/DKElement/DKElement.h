// [IDL] https://dom.spec.whatwg.org/#interface-element
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Element
#pragma once
#ifndef DKElement_H
#define DKElement_H

#include "DKNode/DKNode.h"
#include "DKinnerHTML/DKinnerHTML.h"
#include "DKElementCSSInlineStyle/DKElementCSSInlineStyle.h"
class DKHTMLCollection;

// [Exposed=Window]
// interface Element : Node {
class DKElement : virtual public DKNode, public DKinnerHTML //, virtual public DKElementCSSInlineStyle
{
public:
	DKElement() : DKNode(), DKinnerHTML() //, DKElementCSSInlineStyle()
	{
		DKDEBUGFUNC();
		interfaceName = "Element";
		address[interfaceName] = pointerToAddress(this);
		DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
	}
	//virtual ~DKElement(){}
	
	////// NOTE: from DKElementCSSInlineStyle
	// [SameObject, PutForwards=cssText] readonly attribute CSSStyleDeclaration style;
	DKCSSStyleDeclaration* _style = NULL;
	virtual DKCSSStyleDeclaration* style() 						{ return _style; }					// getter
	virtual void style(DKCSSStyleDeclaration* style)			{ _style = style; } 				// setter
	////////////////////////////////////////////
	
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
		return _getAttributeNames;
	}
	
	// DOMString? getAttribute(DOMString qualifiedName);
	DOMString _getAttribute = "";
	virtual const DKString& getAttribute(const DOMString& qualifiedName){
		DKDEBUGFUNC(qualifiedName);
		return _getAttribute;
	}
	
	// DOMString? getAttributeNS(DOMString? namespace, DOMString localName);
	DOMString _getAttributeNS = "";
	virtual const DOMString& getAttributeNS(const DOMString& _namespace, const DOMString& localName){
		DKDEBUGFUNC(_namespace, localName);
		return _getAttributeNS;
	}
	
	// [CEReactions] undefined setAttribute(DOMString qualifiedName, DOMString value);
	virtual void setAttribute(const DOMString& qualifiedName, const DOMString& value){
		DKDEBUGFUNC(qualifiedName, value);
	}
	
	// [CEReactions] undefined setAttributeNS(DOMString? namespace, DOMString qualifiedName, DOMString value);
	virtual void setAttributeNS(const DOMString& _namespace, const DOMString& qualifiedName, const DOMString& value){
		DKDEBUGFUNC(_namespace, qualifiedName, value);
	}
	
	// [CEReactions] undefined removeAttribute(DOMString qualifiedName);
	virtual void removeAttribute(const DOMString& qualifiedName){
		DKDEBUGFUNC(qualifiedName);
	}
	
	// [CEReactions] undefined removeAttributeNS(DOMString? namespace, DOMString localName);
	virtual void removeAttributeNS(const DOMString& _namespace, const DOMString& localName){
		DKDEBUGFUNC(_namespace, localName);
	}
	
	// [CEReactions] boolean toggleAttribute(DOMString qualifiedName, optional boolean force);
	bool _toggleAttribute = false;
	virtual const bool& toggleAttribute(const DOMString& qualifiedName, const bool& force){
		DKDEBUGFUNC(qualifiedName, force);
		return _toggleAttribute;
	}
	
	// boolean hasAttribute(DOMString qualifiedName);
	bool _hasAttribute = false;
	virtual const bool& hasAttribute(const DOMString& qualifiedName){
		DKDEBUGFUNC(qualifiedName);
		return _hasAttribute;
	}
	
	// boolean hasAttributeNS(DOMString? namespace, DOMString localName);
	bool _hasAttributeNS = false;
	virtual const bool& hasAttributeNS(const DOMString& _namespace, const DOMString& localName){
		DKDEBUGFUNC(_namespace, localName);
		return _hasAttributeNS;
	}
	
	// Attr? getAttributeNode(DOMString qualifiedName);
	DKString _getAttributeNode = "";
	virtual const DKString& getAttributeNode(const DOMString& qualifiedName){
		DKDEBUGFUNC(qualifiedName);
		return _getAttributeNode;
	}
	
	// Attr? getAttributeNodeNS(DOMString? namespace, DOMString localName);
	DKString _getAttributeNodeNS = "";
	virtual const DKString& getAttributeNodeNS(const DOMString& _namespace, const DOMString& localName){
		DKDEBUGFUNC(_namespace, localName);
		return _getAttributeNodeNS;
	}
	
	// [CEReactions] Attr? setAttributeNode(Attr attr);
	DKString _setAttributeNode = "";
	virtual const DKString& setAttributeNode(const DKString& attr){
		DKDEBUGFUNC(attr);
		return _setAttributeNode;
	}
	
	// [CEReactions] Attr? setAttributeNodeNS(Attr attr);
	DKString _setAttributeNodeNS = "";
	virtual const DKString& setAttributeNodeNS(const DKString& attr){
		DKDEBUGFUNC(attr);
		return _setAttributeNodeNS;
	}
	
	// [CEReactions] Attr removeAttributeNode(Attr attr);
	DKString _removeAttributeNode = "";
	virtual const DKString& removeAttributeNode(const DKString& attr){
		DKDEBUGFUNC(attr);
		return _removeAttributeNode;
	}
	
	// ShadowRoot attachShadow(ShadowRootInit init);
	DKString _attachShadow = "";
	virtual const DKString& attachShadow(const DKString& init){
		DKDEBUGFUNC(init);
		return _attachShadow;
	}
	
	// readonly attribute ShadowRoot? shadowRoot;
	DKString _shadowRoot = "";
	virtual const DKString& shadowRoot()							{ return _shadowRoot; }					// getter
	virtual void shadowRoot(const DKString& shadowRoot)				{ _shadowRoot = shadowRoot; } 			// setter
	
	// Element? closest(DOMString selectors);
	DKElement* _closest = NULL;
	virtual DKElement* closest(const DOMString& selectors) {
		DKDEBUGFUNC(selectors);
		return _closest;
	}
	
	// boolean matches(DOMString selectors);
	bool _matches = false;
	virtual const bool& matches(const DOMString& selectors){
		DKDEBUGFUNC(selectors);
		return _matches;
	}
	
	// boolean webkitMatchesSelector(DOMString selectors); // legacy alias of .matches
	bool _webkitMatchesSelector = false;
	virtual const bool& webkitMatchesSelector(const DOMString& selectors){
		DKDEBUGFUNC(selectors);
		return _webkitMatchesSelector;
	}
  
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	DKHTMLCollection* _getElementsByTagName = NULL;
	virtual DKHTMLCollection* getElementsByTagName(const DOMString& qualifiedName) {
		DKDEBUGFUNC(qualifiedName);
		return _getElementsByTagName;
	}
	
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	DKHTMLCollection* _getElementsByTagNameNS = NULL;
	virtual const DKHTMLCollection* getElementsByTagNameNS(const DOMString& _namespace, const DOMString& localName){
		DKDEBUGFUNC(_namespace, localName);
		return _getElementsByTagNameNS;
	}
	
	// HTMLCollection getElementsByClassName(DOMString classNames);
	DKHTMLCollection* _getElementsByClassName = NULL;
	virtual DKHTMLCollection* getElementsByClassName(const DOMString& classNames){
		DKDEBUGFUNC(classNames);
		return _getElementsByClassName;
	}
  
	// [CEReactions] Element? insertAdjacentElement(DOMString where, Element element); // legacy
	DKElement* _insertAdjacentElement = NULL;
	virtual DKElement* insertAdjacentElement(const DOMString& where, DKElement* element){
		DKDEBUGFUNC(where, element);
		return _insertAdjacentElement;
	}
	
	// undefined insertAdjacentText(DOMString where, DOMString data); // legacy
	DKString _insertAdjacentText = "";
	virtual const DKString& insertAdjacentText(const DOMString& where, const DOMString& data){
		DKDEBUGFUNC(where, data);
		return _insertAdjacentText;
	}
//};

	
	////// toString //////
	operator std::string() const { return "[object Element]"; }
};


class DKNullElement : public DKElement
{
public:
	operator std::string() const { return "null"; }
};


#endif //DKElement_H