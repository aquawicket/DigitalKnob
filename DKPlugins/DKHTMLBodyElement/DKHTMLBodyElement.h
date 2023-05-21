// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLBodyElement
#pragma once
#ifndef DKHTMLBodyElement_H
#define DKHTMLBodyElement_H

#include "DKHTMLElement/DKHTMLElement.h"


// [Exposed=Window]
// interface HTMLBodyElement : HTMLElement {
class DKHTMLBodyElement : public DKHTMLElement
{
public:
	// [HTMLConstructor] constructor();
	DKHTMLBodyElement() : DKHTMLElement() {
		DKDEBUGFUNC();
		interfaceName = "DKHTMLBodyElement";
		interfaceAddress = pointerToAddress(this);
	}

	// also has obsolete members
//};
	
	// Source: Compatibility Standard (https://compat.spec.whatwg.org/)
	// partial interface HTMLBodyElement {
	//		attribute EventHandler onorientationchange;
			virtual DKString onorientationchange()				{ return ""; }		// getter
			virtual void onorientationchange(const DKString&)	{ } 				// setter
	//};
	
	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// HTMLBodyElement includes WindowEventHandlers;
	// TODO

	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// partial interface HTMLBodyElement {
	// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString text;
			virtual DOMString text()							{ return ""; }		// getter
			virtual void text(const DOMString&)					{ } 				// setter
	//
	// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString link;
			virtual DOMString link()							{ return ""; }		// getter
			virtual void link(const DOMString&)					{ } 				// setter
	//
	// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString vLink;
			virtual DOMString vLink()							{ return ""; }		// getter
			virtual void vLink(const DOMString&)				{ } 				// setter
	//
	// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString aLink;
			virtual DOMString aLink()							{ return ""; }		// getter
			virtual void aLink(const DOMString&)				{ } 				// setter
	//
	// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString bgColor;
			virtual DOMString bgColor()							{ return ""; }		// getter
			virtual void bgColor(const DOMString&)				{ } 				// setter
	//
	// 		[CEReactions] attribute DOMString background;
			virtual DOMString background()						{ return ""; }		// getter
			virtual void background(const DOMString&)			{ } 				// setter
	//};
};


#endif //DKHTMLBodyElement_H