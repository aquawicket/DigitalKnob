// [IDL] https://drafts.csswg.org/cssom/#the-elementcssinlinestyle-mixin
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/style
#if HAVE_DKDuktape

#pragma once
#ifndef DKElementCSSInlineStyleDUK_H
#define DKElementCSSInlineStyleDUK_H

#include "DKDuktape/DKDuktape.h"
#include "DKElement/DKElement.h"

// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
// interface mixin ElementCSSInlineStyle {
class DKElementCSSInlineStyleDUK : public DKObjectT<DKElementCSSInlineStyleDUK>
{
public:
	bool Init(){
		
		// [SameObject, PutForwards=cssText] readonly attribute CSSStyleDeclaration style;
		DKDuktape::AttachFunction("CPP_DKElementCSSInlineStyleDUK_style", DKElementCSSInlineStyleDUK::style);
		
		DKClass::DKCreate("DKElementCSSInlineStyle/DKElementCSSInlineStyleDUK.js");
		
		return true;
	}
	
	//FIXME: since this is a mixin, we need to know which base class called
	static DKElement* element(duk_context* ctx){		
		DKString interfaceAddress = duk_require_string(ctx, 0);
		DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
		DKASSERT(interface);
		
		DKString elementAddress = interface->address["Element"];			
		DKElement* _element = (DKElement*)addressToPointer(elementAddress);
		DKASSERT(_element);
		
		return _element;
	}
	
	// [SameObject, PutForwards=cssText] readonly attribute CSSStyleDeclaration style;
	static int style(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("DKElementCSSInlineStyleDUK::style()\n");
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = duk_require_string(ctx, 1);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKASSERT(interface);
			
			DKString cssStyleDeclarationAddress = interface->address["CSSStyleDeclaration"];
			DKCSSStyleDeclaration* cssStyleDeclaration = (DKCSSStyleDeclaration*)addressToPointer(cssStyleDeclarationAddress);
			DKASSERT(cssStyleDeclaration);
			
			element(ctx)->style(cssStyleDeclaration);
		}
		else {
			dukglue_push(ctx, element(ctx)->style()->interfaceAddress);
		}
		return true;
	}
	
	// Source: CSS Typed OM Level 1 (https://www.w3.org/TR/css-typed-om-1/)
	// partial interface mixin ElementCSSInlineStyle {
	//	[SameObject] readonly attribute StylePropertyMap attributeStyleMap;
		// TODO
	// };
};
REGISTER_OBJECT(DKElementCSSInlineStyleDUK, true)

#endif //DKElementCSSInlineStyleDUK_H
#endif //HAVE_DKDuktape