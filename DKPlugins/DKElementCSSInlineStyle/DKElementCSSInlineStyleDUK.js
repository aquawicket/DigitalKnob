// [IDL] https://drafts.csswg.org/cssom/#the-elementcssinlinestyle-mixin
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/style
console.log("DKElementCSSInlineStyleDUK.js")

// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
// interface mixin ElementCSSInlineStyle {
	
// [SameObject, PutForwards=cssText] readonly attribute CSSStyleDeclaration style;
Object.defineProperty(Element.prototype, 'style', {
    get: function style()			{ 
			console.log("ElementCSSInlineStyle.prototype.style()");
			return new CSSStyleDeclaration(CPP_DKElementCSSInlineStyleDUK_style(this.address));
		},
		set: function style(data)		{
			console.log("ElementCSSInlineStyle.prototype.style("+data+")");
			CPP_DKElementCSSInlineStyleDUK_style(this.address, data.address);	
		},
		configurable: true
});

// };

// Source: CSS Typed OM Level 1 (https://www.w3.org/TR/css-typed-om-1/)
// partial interface mixin ElementCSSInlineStyle {
// [SameObject] readonly attribute StylePropertyMap attributeStyleMap;
	// TODO
// };