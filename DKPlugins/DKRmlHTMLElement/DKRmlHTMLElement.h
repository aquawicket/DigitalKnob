// [IDL] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
#pragma once
#ifndef DKRmlHTMLElement_H
#define DKRmlHTMLElement_H

#include "DKHTMLElement/DKHTMLElement.h"
#include "DKRmlElement/DKRmlElement.h"
#include "DKRmlEventListener/DKRmlEventListener.h"

// [Exposed=Window]
// interface HTMLElement : Element {
class DKRmlHTMLElement : public DKHTMLElement, public DKRmlElement
{
public:
	DKRmlEventListener* _dkRmlEventListener;
	
	static std::vector<DKRmlHTMLElement*> list;
	static DKRmlHTMLElement* instance(DKRmlEventListener* dkRmlEventListener, Rml::Element* rmlElement){
		for(unsigned int i=0; i<list.size(); ++i){
			if(rmlElement == list[i]->_rmlElement)
				return list[i];
		}
		return new DKRmlHTMLElement(dkRmlEventListener, rmlElement);
	}
	
	// [HTMLConstructor] constructor();
	DKRmlHTMLElement(DKRmlEventListener* dkRmlEventListener, Rml::Element* rmlElement) : DKHTMLElement(), DKRmlElement(dkRmlEventListener, rmlElement) {
		DKDEBUGFUNC();
		DKASSERT(dkRmlEventListener);
		DKASSERT(rmlElement);
		
		interfaceName = "DKRmlHTMLElement";
		address[interfaceName] = pointerToAddress(this);
		DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
		
		_dkRmlEventListener = dkRmlEventListener;
		_rmlElement = rmlElement;
	}
	
	// metadata attributes
	// [CEReactions] attribute DOMString title;
	const DOMString& title() override								{ return _title; }						// getter
	void title(const DOMString& title) override						{ _title = title; } 					// setter
	
	// [CEReactions] attribute DOMString lang;
	const DOMString& lang() override								{ return _lang; }						// getter
	void lang(const DOMString& lang) override						{ _lang = lang; } 						// setter
	
	// [CEReactions] attribute boolean translate;
	const bool& translate()	override								{ return _translate; }					// getter
	void translate(const bool& translate) override					{ _translate = translate; } 			// setter
	
	// [CEReactions] attribute DOMString dir;
	const DOMString& dir() override									{ return _dir; }						// getter
	void dir(const DOMString& dir) override							{ _dir = dir; } 						// setter

	// user interaction
	// [CEReactions] attribute (boolean or unrestricted double or DOMString)? hidden;
	const DOMString& hidden() override								{ return _hidden; }						// getter
	void hidden(const DOMString& hidden) override					{ _hidden = hidden; } 					// setter
	
	// [CEReactions] attribute boolean inert;
	const bool& inert() override									{ return _inert; }						// getter
	void inert(const bool& inert) override							{ _inert = inert; } 					// setter
	
	// undefined click();
	void click() override {
		DKDEBUGFUNC();
	}
	
	// [CEReactions] attribute DOMString accessKey;
	const DOMString& accessKey() override							{ return _accessKey; }					// getter
	void accessKey(const DOMString& accessKey) override				{ _accessKey = accessKey; } 			// setter
	
	// readonly attribute DOMString accessKeyLabel;
	const DOMString& accessKeyLabel() override						{ return _accessKeyLabel; }				// getter
	void accessKeyLabel(const DOMString& accessKeyLabel) override	{ _accessKeyLabel = accessKeyLabel; } 	// setter
	
	// [CEReactions] attribute boolean draggable;
	const bool& draggable() override								{ return _draggable; }					// getter
	void draggable(const bool& draggable) override					{ _draggable = draggable; } 			// setter
	
	// [CEReactions] attribute boolean spellcheck;
	const bool& spellcheck() override								{ return _spellcheck; }					// getter
	void spellcheck(const bool& spellcheck) override				{ _spellcheck = spellcheck; } 			// setter
	
	// [CEReactions] attribute DOMString autocapitalize;
	const DOMString& autocapitalize() override						{ return _autocapitalize; }				// getter
	void autocapitalize(const DOMString& autocapitalize) override	{ _autocapitalize = autocapitalize; } 	// setter

	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerText;
	const DOMString& innerText() override							{ return _innerText; }					// getter
	void innerText(const DOMString& innerText) override				{ _innerText = innerText; } 			// setter
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString outerText;
	const DOMString& outerText() override							{ return _outerText; }					// getter
	void outerText(const DOMString& outerText) override				{ _outerText = outerText; } 			// setter

	// ElementInternals attachInternals();
	const DKString& attachInternals() override {
		DKDEBUGFUNC();
		return _attachInternals;
	}

	// The popover API
	// undefined showPopover();
	void showPopover() override {
		DKDEBUGFUNC();
	}
	
	// undefined hidePopover();
	void hidePopover() override {
		DKDEBUGFUNC();
	}
	
	// undefined togglePopover(optional boolean force);
	void togglePopover(const bool& force) override {
		DKDEBUGFUNC(force);
	}
	
	// [CEReactions] attribute DOMString? popover;
	const DOMString& popover() override								{ return _popover; }					// getter
	void popover(const DOMString& popover) override					{ _popover = popover; } 				// setter
//};

	// HTMLElement includes GlobalEventHandlers;
	// HTMLElement includes ElementContentEditable;
	// HTMLElement includes HTMLOrSVGElement;
	
	// [Exposed=Window]
	// interface HTMLUnknownElement : HTMLElement {
		// Note: intentionally no [HTMLConstructor]
	// };
};


#endif //DKRmlHTMLElement_H