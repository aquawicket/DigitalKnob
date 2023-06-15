// [IDL] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
#pragma once
#ifndef DKHTMLElement_H
#define DKHTMLElement_H

#include "DKElement/DKElement.h"
#include "DKElementCSSInlineStyle/DKElementCSSInlineStyle.h"

// [Exposed=Window]
// interface HTMLElement : Element {
class DKHTMLElement : public DKElement
{
public:
	// [HTMLConstructor] constructor();
	DKHTMLElement() : DKElement() {
		DKDEBUGFUNC();
		interfaceName = "HTMLElement";
		interfaceAddress = pointerToAddress(this);		
	}
	
	// metadata attributes
	// [CEReactions] attribute DOMString title;
	DOMString _title = "";
	virtual const DOMString& title()					{ return _title; }				// getter
	virtual void title(const DOMString& title)			{ _title = title; } 			// setter
	
	// [CEReactions] attribute DOMString lang;
	DOMString _lang = "";
	virtual const DOMString& lang()						{ return _lang; }				// getter
	virtual void lang(const DOMString& lang)			{ _lang = lang; } 				// setter
	
	// [CEReactions] attribute boolean translate;
	bool _translate = false;
	virtual const bool& translate()						{ return _translate; }			// getter
	virtual void translate(const bool& translate)		{ _translate = translate; } 	// setter
	
	// [CEReactions] attribute DOMString dir;
	DOMString _dir = "";
	virtual const DOMString& dir()						{ return _dir; }				// getter
	virtual void dir(const DOMString& dir)				{ _dir = dir; } 				// setter

	// user interaction
	// [CEReactions] attribute (boolean or unrestricted double or DOMString)? hidden;
	DOMString _hidden = "";
	virtual const DOMString& hidden()					{ return _hidden; }				// getter
	virtual void hidden(const DOMString& hidden)		{ _hidden = hidden; } 			// setter
	
	// [CEReactions] attribute boolean inert;
	bool _inert = false;
	virtual const bool& inert()							{ return _inert; }				// getter
	virtual void inert(const bool& inert)				{ _inert = inert; } 			// setter
	
	// undefined click();
	virtual void click() {
		DKDEBUGFUNC();
	}
	
	// [CEReactions] attribute DOMString accessKey;
	DOMString _accessKey = "";
	virtual const DOMString& accessKey()							{ return _accessKey; }					// getter
	virtual void accessKey(const DOMString& accessKey)				{ _accessKey = accessKey; } 			// setter
	
	// readonly attribute DOMString accessKeyLabel;
	DOMString _accessKeyLabel = "";
	virtual const DOMString& accessKeyLabel()						{ return _accessKeyLabel; }				// getter
	virtual void accessKeyLabel(const DOMString& accessKeyLabel)	{ _accessKeyLabel = accessKeyLabel; } 	// setter
	
	// [CEReactions] attribute boolean draggable;
	bool _draggable = false;
	virtual const bool& draggable()									{ return _draggable; }					// getter
	virtual void draggable(const bool& draggable)					{ _draggable = draggable; } 			// setter
	
	// [CEReactions] attribute boolean spellcheck;
	bool _spellcheck = false;
	virtual const bool& spellcheck()								{ return _spellcheck; }					// getter
	virtual void spellcheck(const bool& spellcheck)					{ _spellcheck = spellcheck; } 			// setter
	
	// [CEReactions] attribute DOMString autocapitalize;
	DOMString _autocapitalize = "";
	virtual const DOMString& autocapitalize()						{ return _autocapitalize; }				// getter
	virtual void autocapitalize(const DOMString& autocapitalize)	{ _autocapitalize = autocapitalize; } 	// setter

	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerText;
	DOMString _innerText = "";
	virtual const DOMString& innerText()							{ return _innerText; }					// getter
	virtual void innerText(const DOMString& innerText)				{ _innerText = innerText; } 			// setter
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString outerText;
	DOMString _outerText = "";
	virtual const DOMString& outerText()							{ return _outerText; }					// getter
	virtual void outerText(const DOMString& outerText)				{ _outerText = outerText; } 			// setter

	// ElementInternals attachInternals();
	DKString _attachInternals = "";
	virtual const DKString& attachInternals() {
		DKDEBUGFUNC();
		return _attachInternals;
	}

	// The popover API
	// undefined showPopover();
	virtual void showPopover() {
		DKDEBUGFUNC();
	}
	
	// undefined hidePopover();
	virtual void hidePopover() {
		DKDEBUGFUNC();
	}
	
	// undefined togglePopover(optional boolean force);
	virtual void togglePopover(const bool& force) {
		DKDEBUGFUNC(force);
	}
	
	// [CEReactions] attribute DOMString? popover;
	DOMString _popover = "";
	virtual const DOMString& popover()					{ return _popover; }		// getter
	virtual void popover(const DOMString& popover)		{ _popover = popover; } 	// setter
//};

	// HTMLElement includes GlobalEventHandlers;
	// HTMLElement includes ElementContentEditable;
	// HTMLElement includes HTMLOrSVGElement;
	
	// [Exposed=Window]
	// interface HTMLUnknownElement : HTMLElement {
		// Note: intentionally no [HTMLConstructor]
	// };
};


#endif //DKHTMLElement_H