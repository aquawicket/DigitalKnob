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
			DKString _onorientationchange = "";
			virtual const DKString& onorientationchange()							{ return _onorientationchange; }					// getter
			virtual void onorientationchange(const DKString& onorientationchange)	{ _onorientationchange = onorientationchange; } 	// setter
	//};
	
	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// HTMLBodyElement includes WindowEventHandlers;
	// TODO

	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// partial interface HTMLBodyElement {
	// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString text;
			DOMString _text = "";
			virtual const DOMString& text()							{ return _text; }				// getter
			virtual void text(const DOMString& text)				{ _text = text; } 				// setter
	//
	// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString link;
			DOMString _link = "";
			virtual const DOMString& link()							{ return _link; }				// getter
			virtual void link(const DOMString& link)				{ _link = link; } 				// setter
	//
	// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString vLink;
			DOMString _vLink = "";
			virtual const DOMString& vLink()						{ return _vLink; }				// getter
			virtual void vLink(const DOMString& vLink)				{ _vLink = vLink; } 			// setter
	//
	// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString aLink;
			DOMString _aLink = "";
			virtual const DOMString& aLink()						{ return _aLink; }				// getter
			virtual void aLink(const DOMString& aLink)				{ _aLink = aLink; } 			// setter
	//
	// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString bgColor;
			DOMString _bgColor = "";
			virtual const DOMString& bgColor()						{ return _bgColor; }			// getter
			virtual void bgColor(const DOMString& bgColor)			{ _bgColor= bgColor; } 			// setter
	//
	// 		[CEReactions] attribute DOMString background;
			DOMString _background = "";
			virtual const DOMString& background()					{ return _background; }			// getter
			virtual void background(const DOMString& background)	{ _background = background; } 	// setter
	//};
};


#endif //DKHTMLBodyElement_H