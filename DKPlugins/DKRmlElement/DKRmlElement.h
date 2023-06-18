// [IDL] https://dom.spec.whatwg.org/#interface-element
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Element
#pragma once
#ifndef DKRmlElement_H
#define DKRmlElement_H

#include "DKRmlNode/DKRmlNode.h"
#include "DKElement/DKElement.h"
#include "DKRmlElementCSSInlineStyle/DKRmlElementCSSInlineStyle.h"


// [Exposed=Window]
// interface Element : Node {
class DKRmlElement : public DKElement, public DKRmlNode  //, public DKRmlElementCSSInlineStyle
{
public:
	DKRmlElement(DKRmlInterface* dkRmlInterface, Rml::Element* rmlElement) : DKElement(), DKRmlNode(dkRmlInterface, rmlElement) {//, DKRmlElementCSSInlineStyle(dkRmlInterface, _rmlElement) {
		DKDEBUGFUNC();
		interfaceName = "DKRmlElement";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKRmlElement("+interfaceAddress+") \n");
		_dkRmlInterface = dkRmlInterface;
		_rmlElement = rmlElement;
		
		if(!_rmlElement)
			DKERROR("_rmlElement invalid! \n");
		
		list.push_back(this);
	}
	~DKRmlElement() {}
	
	static std::vector<DKRmlElement*> list;
	static DKRmlElement* instance(DKRmlInterface* dkRmlInterface, Rml::Element* rmlElement){
		for(unsigned int i=0; i<list.size(); ++i){
			if(rmlElement == list[i]->_rmlElement)
				return list[i];
		}
		return new DKRmlElement(dkRmlInterface, rmlElement);
	}
	
	////// NOTE: from DKRmlElementCSSInlineStyle
	// [SameObject, PutForwards=cssText] readonly attribute CSSStyleDeclaration style;
	DKCSSStyleDeclaration* _style = NULL;
	DKCSSStyleDeclaration&	style()	/*override*/								{ 																// getter
		return _style ? *_style : *new DKRmlCSSStyleDeclaration(_dkRmlInterface, _rmlElement); 
	}	
	void 					style(DKCSSStyleDeclaration& style) /*override*/	{ _style = &style; } 											// setter
	
	/*
	// readonly attribute DOMString? namespaceURI;
	DOMString _namespaceURI = "";
	virtual const DOMString& namespaceURI()	override					{ return _namespaceURI; }			// getter
	virtual void namespaceURI(const DOMString& namespaceURI) override	{ _namespaceURI = namespaceURI; } 	// setter
	
	// readonly attribute DOMString? prefix;
	DOMString _prefix = "";
	virtual const DOMString& prefix() override							{ return _prefix; }					// getter
	virtual void prefix(const DOMString& prefix) override				{ _prefix = prefix; } 				// setter
  
	// readonly attribute DOMString localName;
	DOMString _localName = "";
	virtual const DOMString& localName() override						{ return _localName; }				// getter
	virtual void localName(const DOMString& localName) override			{ _localName = localName; } 		// setter
	*/
	// readonly attribute DOMString tagName;
	const DOMString& tagName() override							{									// getter
		if(!_rmlElement){
			DKERROR("_rmlElement invalid! \n");
			return _tagName;
		}
		_tagName = _rmlElement->GetTagName();
		return _tagName;
	}				
	//virtual void tagName(const DOMString& tagName) override			{ _tagName = tagName; } 			// setter
	
	/*
	// [CEReactions] attribute DOMString id;
	DOMString _id = "";
	virtual const DOMString& id() override								{ return _id; }						// getter
	virtual void id(const DOMString& id) override						{ _id = id; } 						// setter
	
	// [CEReactions] attribute DOMString className;
	DOMString _className = "";
	virtual const DOMString& className() override						{ return _className; }				// getter
	virtual void className(const DOMString& className) override			{ _className = className; } 		// setter
	
	// [SameObject, PutForwards=value] readonly attribute DOMTokenList classList;
	DKString _classList = "";
	virtual const DKString& classList() override						{ return _classList; }				// getter
	virtual void classList(const DKString& classList) override			{ _classList = classList; } 		// setter
	
	//[CEReactions, Unscopable] attribute DOMString slot;
	DOMString _slot = "";
	virtual const DOMString& slot() override							{ return _slot; }					// getter
	virtual void slot(const DOMString& slot) override					{ _slot = slot; } 					// setter

	// boolean hasAttributes();
	bool _hasAttributes = false;
	virtual const bool& hasAttributes() override {
		DKDEBUGFUNC();
		return _hasAttributes;
	}
	
	// [SameObject] readonly attribute NamedNodeMap attributes;
	DKString _attributes = "";
	virtual const DKString& attributes() override						{ return _attributes; }				// getter
	virtual void attributes(const DKString& attributes) override		{ _attributes = attributes; } 		// setter
	
	// sequence<DOMString> getAttributeNames();
	DKString _getAttributeNames = "";
	virtual const DKString& getAttributeNames() override {
		DKDEBUGFUNC();
		return _getAttributeNames;
	}
	
	// DOMString? getAttribute(DOMString qualifiedName);
	DKString _getAttribute = "";
	virtual const DKString& getAttribute(const DOMString& qualifiedName) override {
		DKDEBUGFUNC(qualifiedName);
		return _getAttribute;
	}
	
	// DOMString? getAttributeNS(DOMString? namespace, DOMString localName);
	DOMString _getAttributeNS = "";
	virtual const DOMString& getAttribute(const DOMString& _namespace, const DOMString& localName) override {
		DKDEBUGFUNC(_namespace, localName);
		return _getAttributeNS;
	}
	
	// [CEReactions] undefined setAttribute(DOMString qualifiedName, DOMString value);
	virtual void setAttribute(const DOMString& qualifiedName, const DOMString& value) override {
		DKDEBUGFUNC(qualifiedName, value);
	}
	
	// [CEReactions] undefined setAttributeNS(DOMString? namespace, DOMString qualifiedName, DOMString value);
	virtual void setAttributeNS(const DOMString& _namespace, const DOMString& qualifiedName, const DOMString& value) override {
		DKDEBUGFUNC(_namespace, qualifiedName, value);
	}
	
	// [CEReactions] undefined removeAttribute(DOMString qualifiedName);
	virtual void removeAttribute(const DOMString& qualifiedName) override {
		DKDEBUGFUNC(qualifiedName);
	}
	
	// [CEReactions] undefined removeAttributeNS(DOMString? namespace, DOMString localName);
	virtual void removeAttributeNS(const DOMString& _namespace, const DOMString& localName) override {
		DKDEBUGFUNC(_namespace, localName);
	}
	
	// [CEReactions] boolean toggleAttribute(DOMString qualifiedName, optional boolean force);
	bool _toggleAttribute = false;
	virtual const bool& toggleAttribute(const DOMString& qualifiedName, const bool& force) override {
		DKDEBUGFUNC(qualifiedName, force);
		return _toggleAttribute;
	}
	*/
	
	// boolean hasAttribute(DOMString qualifiedName);
	const bool& hasAttribute(const DOMString& qualifiedName) override {
		DKDEBUGFUNC(qualifiedName);
		_hasAttribute = _rmlElement->HasAttribute(qualifiedName.c_str());
		return _hasAttribute;
	}
	
	/*
	// boolean hasAttributeNS(DOMString? namespace, DOMString localName);
	bool _hasAttributeNS = false;
	virtual const bool& hasAttributeNS(const DOMString& _namespace, const DOMString& localName) override {
		DKDEBUGFUNC(_namespace, localName);
		return _hasAttributeNS;
	}
	
	// Attr? getAttributeNode(DOMString qualifiedName);
	DKString _getAttributeNode = "";
	virtual const DKString& getAttributeNode(const DOMString& qualifiedName) override {
		DKDEBUGFUNC(qualifiedName);
		return _getAttributeNode;
	}
	
	// Attr? getAttributeNodeNS(DOMString? namespace, DOMString localName);
	DKString _getAttributeNodeNS = "";
	virtual const DKString& getAttributeNodeNS(const DOMString& _namespace, const DOMString& localName) override {
		DKDEBUGFUNC(_namespace, localName);
		return _getAttributeNodeNS;
	}
	
	// [CEReactions] Attr? setAttributeNode(Attr attr);
	DKString _setAttributeNode = "";
	virtual const DKString& setAttributeNode(const DKString& attr) override {
		DKDEBUGFUNC(attr);
		return _setAttributeNode;
	}
	
	// [CEReactions] Attr? setAttributeNodeNS(Attr attr);
	DKString _setAttributeNodeNS = "";
	virtual const DKString& setAttributeNodeNS(const DKString& attr) override {
		DKDEBUGFUNC(attr);
		return _setAttributeNodeNS;
	}
	
	// [CEReactions] Attr removeAttributeNode(Attr attr);
	DKString _removeAttributeNode = "";
	virtual const DKString& removeAttributeNode(const DKString& attr) override {
		DKDEBUGFUNC(attr);
		return _removeAttributeNode;
	}
	
	// ShadowRoot attachShadow(ShadowRootInit init);
	DKString _attachShadow = "";
	virtual const DKString& attachShadow(const DKString& init) override {
		DKDEBUGFUNC(init);
		return _attachShadow;
	}
	
	// readonly attribute ShadowRoot? shadowRoot;
	DKString _shadowRoot = "";
	virtual const DKString& shadowRoot() override							{ return _shadowRoot; }					// getter
	virtual void shadowRoot(const DKString& shadowRoot) override			{ _shadowRoot = shadowRoot; } 			// setter
	
	// Element? closest(DOMString selectors);
	DKString _closest = "";
	virtual const DKString& closest(const DOMString& selectors) override {
		DKDEBUGFUNC(selectors);
		return _closest;
	}
	
	// boolean matches(DOMString selectors);
	bool _matches = false;
	virtual const bool& matches(const DOMString& selectors) override {
		DKDEBUGFUNC(selectors);
		return _matches;
	}
	
	// boolean webkitMatchesSelector(DOMString selectors); // legacy alias of .matches
	bool _webkitMatchesSelector = false;
	virtual const bool& webkitMatchesSelector(const DOMString& selectors) override {
		DKDEBUGFUNC(selectors);
		return _webkitMatchesSelector;
	}
  
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);
	DKString _getElementsByTagName = "";
	virtual const DKString& getElementsByTagName(const DOMString& qualifiedName) override {
		DKDEBUGFUNC(qualifiedName);
		return _getElementsByTagName;
	}
	
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	DKString _getElementsByTagNameNS = "";
	virtual const DKString& getElementsByTagNameNS(const DOMString& _namespace, const DOMString& localName) override {
		DKDEBUGFUNC(_namespace, localName);
		return _getElementsByTagNameNS;
	}
	
	// HTMLCollection getElementsByClassName(DOMString classNames);
	DKString _getElementsByClassName = "";
	virtual const DKString& getElementsByClassName(const DOMString& classNames) override {
		DKDEBUGFUNC(classNames);
		return _getElementsByClassName;
	}
  
	// [CEReactions] Element? insertAdjacentElement(DOMString where, Element element); // legacy
	DKString _insertAdjacentElement = "";
	virtual const DKString& insertAdjacentElement(const DOMString& where, const DKString& element) override {
		DKDEBUGFUNC(where, element);
		return _insertAdjacentElement;
	}
	
	// undefined insertAdjacentText(DOMString where, DOMString data); // legacy
	DKString _insertAdjacentText = "";
	virtual const DKString& insertAdjacentText(const DOMString& where, const DOMString& data) override {
		DKDEBUGFUNC(where, data);
		return _insertAdjacentText;
	}
//};
	*/

	////// toString //////
	operator std::string() const { return "[object DKRmlElement]"; }
};

//std::vector<DKRmlElement*> DKRmlElement::list;

#endif //DKRmlElement_H