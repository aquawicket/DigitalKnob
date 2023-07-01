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
class DKRmlElement : public DKRmlNode, virtual public DKElement  //, public DKRmlElementCSSInlineStyle
{
public:
	//DKRmlEventListener* _dkRmlEventListener;

	static std::vector<DKRmlElement*> _list;
	static DKRmlElement* instance(DKRmlEventListener* dkRmlEventListener, Rml::Element* rmlElement){
		for(unsigned int i=0; i<_list.size(); ++i){
			if(rmlElement == _list[i]->_rmlElement)
				return _list[i];
		}
		return new DKRmlElement(dkRmlEventListener, rmlElement);
	}
	
	DKRmlElement(DKRmlEventListener* dkRmlEventListener, Rml::Element* rmlElement) : DKRmlNode(dkRmlEventListener, rmlElement), DKElement()   /*, DKRmlElementCSSInlineStyle(rmlElement)*/ {
		DKDEBUGFUNC();
		interfaceName = "RmlElement";
		address[interfaceName] = pointerToAddress(this);
		DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
		
		_dkRmlEventListener = dkRmlEventListener;
		_rmlElement = rmlElement;
		
		if(!_rmlElement)
			DKERROR("_rmlElement invalid! \n");
		
		_list.push_back(this);
	}

	////// NOTE: from DKRmlElementCSSInlineStyle
	// [SameObject, PutForwards=cssText] readonly attribute CSSStyleDeclaration style;
	DKCSSStyleDeclaration* style() override { return _style ? _style : DKRmlCSSStyleDeclaration::instance(_rmlElement); }	// getter	
	//void style(DKCSSStyleDeclaration& style) /*override*/	{ _style = &style; } 											// setter
	////////////////////////////////////////////
	
	/*
	// readonly attribute DOMString? namespaceURI;
	const DOMString& namespaceURI()	override					{ return _namespaceURI; }			// getter
	void namespaceURI(const DOMString& namespaceURI) override	{ _namespaceURI = namespaceURI; } 	// setter
	
	// readonly attribute DOMString? prefix;
	const DOMString& prefix() override							{ return _prefix; }					// getter
	void prefix(const DOMString& prefix) override				{ _prefix = prefix; } 				// setter
  
	// readonly attribute DOMString localName;
	const DOMString& localName() override						{ return _localName; }				// getter
	void localName(const DOMString& localName) override			{ _localName = localName; } 		// setter
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
	//void tagName(const DOMString& tagName) override			{ _tagName = tagName; } 			// setter
	
	/*
	// [CEReactions] attribute DOMString id;
	const DOMString& id() override								{ return _id; }						// getter
	void id(const DOMString& id) override						{ _id = id; } 						// setter
	
	// [CEReactions] attribute DOMString className;
	const DOMString& className() override						{ return _className; }				// getter
	void className(const DOMString& className) override			{ _className = className; } 		// setter
	*/
	
	// [SameObject, PutForwards=value] readonly attribute DOMTokenList classList;
	const DKString& classList() override { 									// getter
		if (!_rmlElement) {
			DKERROR("_rmlElement invalid! \n");
			return _classList;
		}
		Rml::StringList list = _rmlElement->GetActivePseudoClasses();
		//_classList = "";
		_classList.clear();
		for (unsigned int n = 0; n < list.size(); ++n) {
			_classList += list[n];
			if (n < list.size()-1)
				_classList += ",";
		}
		return _classList; 
	}				
	//void classList(const DKString& classList) override		{ _classList = classList; } 		// setter
	
	/*
	//[CEReactions, Unscopable] attribute DOMString slot;
	const DOMString& slot() override							{ return _slot; }					// getter
	void slot(const DOMString& slot) override					{ _slot = slot; } 					// setter

	// boolean hasAttributes();
	const bool& hasAttributes() override {
		DKDEBUGFUNC();
		return _hasAttributes;
	}
	
	// [SameObject] readonly attribute NamedNodeMap attributes;
	const DKString& attributes() override						{ return _attributes; }				// getter
	void attributes(const DKString& attributes) override		{ _attributes = attributes; } 		// setter
	
	// sequence<DOMString> getAttributeNames();
	const DKString& getAttributeNames() override {
		DKDEBUGFUNC();
		return _getAttributeNames;
	}
	*/
	
	// DOMString? getAttribute(DOMString qualifiedName);
	const DKString& getAttribute(const DOMString& qualifiedName) override {
		DKDEBUGFUNC(qualifiedName);
		Rml::Variant* variant = _rmlElement->GetAttribute(qualifiedName.c_str());
		if(variant)
			_getAttribute = _rmlElement->GetAttribute(qualifiedName.c_str())->Get<Rml::String>();
		return _getAttribute;
	}
	
	/*
	// DOMString? getAttributeNS(DOMString? namespace, DOMString localName);
	const DOMString& getAttribute(const DOMString& _namespace, const DOMString& localName) override {
		DKDEBUGFUNC(_namespace, localName);
		return _getAttributeNS;
	}
	
	// [CEReactions] undefined setAttribute(DOMString qualifiedName, DOMString value);
	void setAttribute(const DOMString& qualifiedName, const DOMString& value) override {
		DKDEBUGFUNC(qualifiedName, value);
	}
	
	// [CEReactions] undefined setAttributeNS(DOMString? namespace, DOMString qualifiedName, DOMString value);
	void setAttributeNS(const DOMString& _namespace, const DOMString& qualifiedName, const DOMString& value) override {
		DKDEBUGFUNC(_namespace, qualifiedName, value);
	}
	
	// [CEReactions] undefined removeAttribute(DOMString qualifiedName);
	void removeAttribute(const DOMString& qualifiedName) override {
		DKDEBUGFUNC(qualifiedName);
	}
	
	// [CEReactions] undefined removeAttributeNS(DOMString? namespace, DOMString localName);
	void removeAttributeNS(const DOMString& _namespace, const DOMString& localName) override {
		DKDEBUGFUNC(_namespace, localName);
	}
	
	// [CEReactions] boolean toggleAttribute(DOMString qualifiedName, optional boolean force);
	const bool& toggleAttribute(const DOMString& qualifiedName, const bool& force) override {
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
	const bool& hasAttributeNS(const DOMString& _namespace, const DOMString& localName) override {
		DKDEBUGFUNC(_namespace, localName);
		return _hasAttributeNS;
	}
	
	// Attr? getAttributeNode(DOMString qualifiedName);
	const DKString& getAttributeNode(const DOMString& qualifiedName) override {
		DKDEBUGFUNC(qualifiedName);
		return _getAttributeNode;
	}
	
	// Attr? getAttributeNodeNS(DOMString? namespace, DOMString localName);
	const DKString& getAttributeNodeNS(const DOMString& _namespace, const DOMString& localName) override {
		DKDEBUGFUNC(_namespace, localName);
		return _getAttributeNodeNS;
	}
	
	// [CEReactions] Attr? setAttributeNode(Attr attr);
	const DKString& setAttributeNode(const DKString& attr) override {
		DKDEBUGFUNC(attr);
		return _setAttributeNode;
	}
	
	// [CEReactions] Attr? setAttributeNodeNS(Attr attr);
	const DKString& setAttributeNodeNS(const DKString& attr) override {
		DKDEBUGFUNC(attr);
		return _setAttributeNodeNS;
	}
	
	// [CEReactions] Attr removeAttributeNode(Attr attr);
	const DKString& removeAttributeNode(const DKString& attr) override {
		DKDEBUGFUNC(attr);
		return _removeAttributeNode;
	}
	
	// ShadowRoot attachShadow(ShadowRootInit init);
	const DKString& attachShadow(const DKString& init) override {
		DKDEBUGFUNC(init);
		return _attachShadow;
	}
	
	// readonly attribute ShadowRoot? shadowRoot;
	const DKString& shadowRoot() override							{ return _shadowRoot; }					// getter
	void shadowRoot(const DKString& shadowRoot) override			{ _shadowRoot = shadowRoot; } 			// setter
	*/
	
	// Element? closest(DOMString selectors);
	DKElement* closest(const DOMString& selectors) override {
		DKDEBUGFUNC(selectors);
		Rml::Element* closestElement = _rmlElement->Closest(selectors);
		//if(!closestElement)
		//	DKERROR("closestElement invalid");
		_closest = DKRmlElement::instance(_dkRmlEventListener, closestElement);
		return _closest;
	}
	
	/*
	// boolean matches(DOMString selectors);
	const bool& matches(const DOMString& selectors) override {
		DKDEBUGFUNC(selectors);
		return _matches;
	}
	
	// boolean webkitMatchesSelector(DOMString selectors); // legacy alias of .matches
	const bool& webkitMatchesSelector(const DOMString& selectors) override {
		DKDEBUGFUNC(selectors);
		return _webkitMatchesSelector;
	}
	*/
	
	// HTMLCollection getElementsByTagName(DOMString qualifiedName);	
	DKHTMLCollection* getElementsByTagName(const DOMString& qualifiedName) override {
		DKDEBUGFUNC(qualifiedName);
		Rml::ElementList elements;
		_rmlElement->GetElementsByTagName(elements, qualifiedName.c_str());
		if(elements.empty()){
			DKERROR("elements.empty()\n");
			return NULL;
		}
		std::vector<DKElement*>* element_list = new std::vector<DKElement*>;
		for(unsigned int i=0; i<elements.size(); ++i){
			element_list->push_back(DKRmlElement::instance(_dkRmlEventListener, elements[i]));
		}
		DKINFO("element_list->size() = "+toString(element_list->size())+"\n");
		DKHTMLCollection* htmlCollection = new DKHTMLCollection(*element_list);	// FIXME: dangling pointer
		DKINFO("htmlCollection->length() = "+toString(htmlCollection->length())+"\n");
		return htmlCollection; 
	}
	
	/*
	// HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString localName);
	const DKString& getElementsByTagNameNS(const DOMString& _namespace, const DOMString& localName) override {
		DKDEBUGFUNC(_namespace, localName);
		return _getElementsByTagNameNS;
	}
	
	// HTMLCollection getElementsByClassName(DOMString classNames);
	const DKString& getElementsByClassName(const DOMString& classNames) override {
		DKDEBUGFUNC(classNames);
		return _getElementsByClassName;
	}
  
	// [CEReactions] Element? insertAdjacentElement(DOMString where, Element element); // legacy
	const DKString& insertAdjacentElement(const DOMString& where, const DKString& element) override {
		DKDEBUGFUNC(where, element);
		return _insertAdjacentElement;
	}
	
	// undefined insertAdjacentText(DOMString where, DOMString data); // legacy
	const DKString& insertAdjacentText(const DOMString& where, const DOMString& data) override {
		DKDEBUGFUNC(where, data);
		return _insertAdjacentText;
	}
//};
	*/


	////// toString //////
	operator std::string() const { return "[object DKRmlElement]"; }
};

//std::vector<DKRmlElement*> DKRmlElement::_list;

#endif //DKRmlElement_H