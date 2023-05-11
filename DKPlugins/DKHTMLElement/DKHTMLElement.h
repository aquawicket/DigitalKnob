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
	virtual bool title(DOMString&, bool) { return false; }
	
	// [CEReactions] attribute DOMString lang;
	virtual bool lang(DOMString&, bool) { return false; }
	
	// [CEReactions] attribute boolean translate;
	virtual bool translate(bool&, bool) { return false; }
	
	// [CEReactions] attribute DOMString dir;
	virtual bool dir(DOMString&, bool) { return false; }

	// user interaction
	
	// [CEReactions] attribute (boolean or unrestricted double or DOMString)? hidden;
	virtual bool inert(DKString&, bool) { return false; }
	
	// [CEReactions] attribute boolean inert;
	virtual bool inert(bool&, bool) { return false; }
	
	// undefined click();
	// TODO
	
	// [CEReactions] attribute DOMString accessKey;
	virtual bool accessKey(DOMString&, bool) { return false; }
	
	// readonly attribute DOMString accessKeyLabel;
	virtual bool accessKeyLabel(DOMString&, bool) { return false; }
	
	// [CEReactions] attribute boolean draggable;
	virtual bool draggable(bool&, bool) { return false; }
	
	// [CEReactions] attribute boolean spellcheck;
	virtual bool spellcheck(bool&, bool) { return false; }
	
	// [CEReactions] attribute DOMString autocapitalize;
	virtual bool autocapitalize(DOMString&, bool) { return false; }

	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerText;
	virtual bool innerText(DOMString&, bool) { return false; }
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString outerText;
	virtual bool outerText(DOMString&, bool) { return false; }

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
	virtual bool popover(DOMString&, bool) { return false; }
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