// [IDL] https://drafts.csswg.org/cssom/#the-elementcssinlinestyle-mixin
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/style
#pragma once
#ifndef DKRmlElementCSSInlineStyle_H
#define DKRmlElementCSSInlineStyle_H

#include "DKElementCSSInlineStyle/DKElementCSSInlineStyle.h"
#include "DKRmlCSSStyleDeclaration/DKRmlCSSStyleDeclaration.h"
//#include "DKMixin/DKMixin.h"


// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
// interface mixin ElementCSSInlineStyle {
class DKRmlElementCSSInlineStyle : public DKElementCSSInlineStyle
{
public:
	Rml::Element* __rmlElement;
	
	DKRmlElementCSSInlineStyle(Rml::Element* rmlElement) : DKElementCSSInlineStyle() {
		DKDEBUGFUNC();
		__rmlElement = rmlElement;
	}
	
	// [SameObject, PutForwards=cssText] readonly attribute CSSStyleDeclaration style;
	DKCSSStyleDeclaration* 	style() override							{ return _style ? _style : DKRmlCSSStyleDeclaration::instance(__rmlElement);  }	// getter
	//void 					style(DKCSSStyleDeclaration* style) override{ _style = style; } 															// setter

// };

	// Source: CSS Typed OM Level 1 (https://www.w3.org/TR/css-typed-om-1/)
	// partial interface mixin ElementCSSInlineStyle {
	//	[SameObject] readonly attribute StylePropertyMap attributeStyleMap;
		/*
		DKStylePropertyMap*	attributeStyleMap()	override												{ return _attributeStyleMap; }					// getter
		virtual void 				attributeStyleMap(DKStylePropertyMap* attributeStyleMap) override 	{ _attributeStyleMap = attributeStyleMap; } 	// setter
		*/
	// };
};

#endif //DKRmlElementCSSInlineStyle_H