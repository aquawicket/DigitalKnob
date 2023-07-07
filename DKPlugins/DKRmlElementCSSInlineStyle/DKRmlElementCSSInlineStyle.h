// [IDL] https://drafts.csswg.org/cssom/#the-elementcssinlinestyle-mixin
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/style
#pragma once
#ifndef DKRmlElementCSSInlineStyle_H
#define DKRmlElementCSSInlineStyle_H

#include "DKElementCSSInlineStyle/DKElementCSSInlineStyle.h"
#include "DKElement/DKElement.h"


// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
// interface mixin ElementCSSInlineStyle {
class DKRmlElementCSSInlineStyle : virtual public DKElement
{
public:
	Rml::Element* __rmlElement;
	
	DKRmlElementCSSInlineStyle(Rml::Element* rmlElement) : DKElement() 
	{
		DKDEBUGFUNC();
		DKASSERT(rmlElement);
		
		__rmlElement = rmlElement;
	}
	
	// [SameObject, PutForwards=cssText] readonly attribute CSSStyleDeclaration style;
	DKCSSStyleDeclaration* style() override {						// getter
		//DKDEBUGFUNC();
		DKINFO("DKRmlElementCSSInlineStyle::style()\n");
		_style = DKRmlCSSStyleDeclaration::instance(__rmlElement);
		return _style;
	}
	void style(DKCSSStyleDeclaration* style) override {				// setter
		DKDEBUGFUNC(style);
		DKINFO("DKRmlElementCSSInlineStyle::style(CSSStyleDeclaration)\n");
		//__rmlElement->SetStyle(style);
	}

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