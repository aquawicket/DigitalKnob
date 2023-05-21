// [IDL] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
#pragma once
#ifndef DKHTMLElement_H
#define DKHTMLElement_H

#include "DKElement/DKElement.h"

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
	virtual DOMString title()						{ return ""; }		// getter
	virtual void title(const DOMString&)			{ } 				// setter
	
	// [CEReactions] attribute DOMString lang;
	virtual DOMString lang()						{ return ""; }		// getter
	virtual void lang(const DOMString&)				{ } 				// setter
	
	// [CEReactions] attribute boolean translate;
	virtual bool translate()						{ return false; }	// getter
	virtual void translate(const bool&)				{ } 				// setter
	
	// [CEReactions] attribute DOMString dir;
	virtual DOMString dir()							{ return ""; }		// getter
	virtual void dir(const DOMString&)				{ } 				// setter

	// user interaction
	// [CEReactions] attribute (boolean or unrestricted double or DOMString)? hidden;
	virtual DOMString hidden()						{ return ""; }		// getter
	virtual void hidden(const DOMString&)			{ } 				// setter
	
	// [CEReactions] attribute boolean inert;
	virtual bool inert()							{ return false; }	// getter
	virtual void inert(const bool&)					{ } 				// setter
	
	// undefined click();
	virtual bool click() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// [CEReactions] attribute DOMString accessKey;
	virtual DOMString accessKey()					{ return ""; }		// getter
	virtual void accessKey(const DOMString&)		{ } 				// setter
	
	// readonly attribute DOMString accessKeyLabel;
	virtual DOMString accessKeyLabel()				{ return ""; }		// getter
	virtual void accessKeyLabel(const DOMString&)	{ } 				// setter
	
	// [CEReactions] attribute boolean draggable;
	virtual bool draggable()						{ return false; }	// getter
	virtual void draggable(const bool&)				{ } 				// setter
	
	// [CEReactions] attribute boolean spellcheck;
	virtual bool spellcheck()						{ return false; }	// getter
	virtual void spellcheck(const bool&)				{ } 			// setter
	
	// [CEReactions] attribute DOMString autocapitalize;
	virtual DOMString autocapitalize()				{ return ""; }		// getter
	virtual void autocapitalize(const DOMString&)	{ } 				// setter

	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerText;
	virtual DOMString innerText()					{ return ""; }		// getter
	virtual void innerText(const DOMString&)		{ } 				// setter
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString outerText;
	virtual DOMString outerText()					{ return ""; }		// getter
	virtual void outerText(const DOMString&)		{ } 				// setter

	// ElementInternals attachInternals();
	virtual bool attachInternals(DKString& _attachInternals) {
		DKDEBUGFUNC(_attachInternals);
		return DKTODO();
	}

	// The popover API
	// undefined showPopover();
	virtual bool showPopover() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// undefined hidePopover();
	virtual bool hidePopover() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// undefined togglePopover(optional boolean force);
	virtual bool togglePopover(bool& _force) {
		DKDEBUGFUNC(_force);
		return DKTODO();
	}
	
	// [CEReactions] attribute DOMString? popover;
	virtual DOMString popover()					{ return ""; }		// getter
	virtual void popover(const DOMString&)		{ } 				// setter
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