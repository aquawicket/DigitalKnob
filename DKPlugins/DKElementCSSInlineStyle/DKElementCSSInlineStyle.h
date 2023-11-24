// [IDL] https://drafts.csswg.org/cssom/#the-elementcssinlinestyle-mixin
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/style
#pragma once
#ifndef DKElementCSSInlineStyle_H
#define DKElementCSSInlineStyle_H

#include "DKCSSStyleDeclaration/DKCSSStyleDeclaration.h"


// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
// interface mixin ElementCSSInlineStyle {
class DKElementCSSInlineStyle
{
public:
	
	// [SameObject, PutForwards=cssText] readonly attribute CSSStyleDeclaration style;
	DKCSSStyleDeclaration* _style = NULL;
	virtual DKCSSStyleDeclaration* style() { 			// getter
		DKINFO("DKElementCSSInlineStyle::style()\n");
		return _style; 
	}		
	virtual void style(DKCSSStyleDeclaration* style) {	// setter
		DKINFO("DKElementCSSInlineStyle::style(style)\n");
		_style = style; 
	}

// };

	// Source: CSS Typed OM Level 1 (https://www.w3.org/TR/css-typed-om-1/)
	// partial interface mixin ElementCSSInlineStyle {
	//	[SameObject] readonly attribute StylePropertyMap attributeStyleMap;
		/*
		// TODO
		DKStylePropertyMap* _attributeStyleMap = NULL;
		virtual DKStylePropertyMap*	attributeStyleMap()											{ return _attributeStyleMap; }					// getter
		virtual void 				attributeStyleMap(DKStylePropertyMap* attributeStyleMap) 	{ _attributeStyleMap = attributeStyleMap; } 	// setter
		*/
	// };
};

#endif //DKElementCSSInlineStyle_H