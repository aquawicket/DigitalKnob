// [IDL] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
#pragma once
#ifndef DKRmlHTMLElement_H
#define DKRmlHTMLElement_H

#include "DKHTMLElement/DKHTMLElement.h"
#include "DKRmlInterface/DKRmlInterface.h"

// [Exposed=Window]
// interface HTMLElement : Element {
class DKRmlHTMLElement : public DKHTMLElement
{
public:
	DKRmlInterface* _dkRmlInterface;
	Rml::Element* _rmlElement;
	
	// [HTMLConstructor] constructor();
	DKRmlHTMLElement(DKRmlInterface* dkRmlInterface, Rml::Element* rmlElement) : DKHTMLElement() {
		DKDEBUGFUNC();
		interfaceName = "DKRmlHTMLElement";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKRmlHTMLElement("+interfaceAddress+") \n");
		_dkRmlInterface = dkRmlInterface;
		_rmlElement = rmlElement;
	}
	
	virtual ~DKRmlHTMLElement() {}
	
	// metadata attributes
	// [CEReactions] attribute DOMString title;
	DOMString _title = "";
	virtual const DOMString& title() override					{ return _title; }				// getter
	virtual void title(const DOMString& title) override			{ _title = title; } 			// setter
	
	// [CEReactions] attribute DOMString lang;
	DOMString _lang = "";
	virtual const DOMString& lang() override					{ return _lang; }				// getter
	virtual void lang(const DOMString& lang) override			{ _lang = lang; } 				// setter
	
	// [CEReactions] attribute boolean translate;
	bool _translate = false;
	virtual const bool& translate()	override					{ return _translate; }			// getter
	virtual void translate(const bool& translate) override		{ _translate = translate; } 	// setter
	
	// [CEReactions] attribute DOMString dir;
	DOMString _dir = "";
	virtual const DOMString& dir() override						{ return _dir; }				// getter
	virtual void dir(const DOMString& dir) override				{ _dir = dir; } 				// setter

	// user interaction
	// [CEReactions] attribute (boolean or unrestricted double or DOMString)? hidden;
	DOMString _hidden = "";
	virtual const DOMString& hidden() override					{ return _hidden; }				// getter
	virtual void hidden(const DOMString& hidden) override		{ _hidden = hidden; } 			// setter
	
	// [CEReactions] attribute boolean inert;
	bool _inert = false;
	virtual const bool& inert() override						{ return _inert; }				// getter
	virtual void inert(const bool& inert) override				{ _inert = inert; } 			// setter
	
	// undefined click();
	virtual void click() override {
		DKDEBUGFUNC();
	}
	
	// [CEReactions] attribute DOMString accessKey;
	DOMString _accessKey = "";
	virtual const DOMString& accessKey() override							{ return _accessKey; }					// getter
	virtual void accessKey(const DOMString& accessKey) override				{ _accessKey = accessKey; } 			// setter
	
	// readonly attribute DOMString accessKeyLabel;
	DOMString _accessKeyLabel = "";
	virtual const DOMString& accessKeyLabel() override						{ return _accessKeyLabel; }				// getter
	virtual void accessKeyLabel(const DOMString& accessKeyLabel) override	{ _accessKeyLabel = accessKeyLabel; } 	// setter
	
	// [CEReactions] attribute boolean draggable;
	bool _draggable = false;
	virtual const bool& draggable() override									{ return _draggable; }					// getter
	virtual void draggable(const bool& draggable) override					{ _draggable = draggable; } 			// setter
	
	// [CEReactions] attribute boolean spellcheck;
	bool _spellcheck = false;
	virtual const bool& spellcheck() override								{ return _spellcheck; }					// getter
	virtual void spellcheck(const bool& spellcheck) override					{ _spellcheck = spellcheck; } 			// setter
	
	// [CEReactions] attribute DOMString autocapitalize;
	DOMString _autocapitalize = "";
	virtual const DOMString& autocapitalize() override						{ return _autocapitalize; }				// getter
	virtual void autocapitalize(const DOMString& autocapitalize) override	{ _autocapitalize = autocapitalize; } 	// setter

	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerText;
	DOMString _innerText = "";
	virtual const DOMString& innerText() override							{ return _innerText; }					// getter
	virtual void innerText(const DOMString& innerText) override				{ _innerText = innerText; } 			// setter
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString outerText;
	DOMString _outerText = "";
	virtual const DOMString& outerText() override							{ return _outerText; }					// getter
	virtual void outerText(const DOMString& outerText) override				{ _outerText = outerText; } 			// setter

	// ElementInternals attachInternals();
	DKString _attachInternals = "";
	virtual const DKString& attachInternals() override {
		DKDEBUGFUNC();
		return _attachInternals;
	}

	// The popover API
	// undefined showPopover();
	virtual void showPopover() override {
		DKDEBUGFUNC();
	}
	
	// undefined hidePopover();
	virtual void hidePopover() override {
		DKDEBUGFUNC();
	}
	
	// undefined togglePopover(optional boolean force);
	virtual void togglePopover(const bool& force) override {
		DKDEBUGFUNC(force);
	}
	
	// [CEReactions] attribute DOMString? popover;
	DOMString _popover = "";
	virtual const DOMString& popover() override					{ return _popover; }		// getter
	virtual void popover(const DOMString& popover) override		{ _popover = popover; } 	// setter
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