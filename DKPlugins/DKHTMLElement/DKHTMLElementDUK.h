// [IDL] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
#if HAVE_DKDuktape

#pragma once
#ifndef DKHTMLElementDUK_H
#define DKHTMLElementDUK_H

#include "DKDuktape/DKDuktape.h"

// [Exposed=Window]
// interface HTMLElement : Element {
class DKHTMLElementDUK : public DKObjectT<DKHTMLElementDUK>
{
public:
	bool Init(){
		
		// [HTMLConstructor] constructor();
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK", DKHTMLElementDUK::constructor);
		
		// metadata attributes
		// [CEReactions] attribute DOMString title;
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_title", DKHTMLElementDUK::title);

		// [CEReactions] attribute DOMString lang;
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_title", DKHTMLElementDUK::title);
		
		// [CEReactions] attribute boolean translate;
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_translate", DKHTMLElementDUK::translate);
		
		// [CEReactions] attribute DOMString dir;
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_dir", DKHTMLElementDUK::dir);
		
		// user interaction
		// [CEReactions] attribute (boolean or unrestricted double or DOMString)? hidden;
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_hidden", DKHTMLElementDUK::hidden);
	
		// [CEReactions] attribute boolean inert;
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_inert", DKHTMLElementDUK::inert);
		
		// undefined click();
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_click", DKHTMLElementDUK::click);
		
		// [CEReactions] attribute DOMString accessKey;
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_accessKey", DKHTMLElementDUK::accessKey);
		
		// readonly attribute DOMString accessKeyLabel;
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_accessKeyLabel", DKHTMLElementDUK::accessKeyLabel);
		
		// [CEReactions] attribute boolean draggable;
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_draggable", DKHTMLElementDUK::draggable);
		
		// [CEReactions] attribute boolean spellcheck;
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_spellcheck", DKHTMLElementDUK::spellcheck);
		
		// [CEReactions] attribute DOMString autocapitalize;
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_autocapitalize", DKHTMLElementDUK::autocapitalize);
		
		// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerText;
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_innerText", DKHTMLElementDUK::innerText);
		
		// [CEReactions] attribute [LegacyNullToEmptyString] DOMString outerText;
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_outerText", DKHTMLElementDUK::outerText);
		
		// ElementInternals attachInternals();
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_attachInternals", DKHTMLElementDUK::attachInternals);
		
		// The popover API
		// undefined showPopover();
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_showPopover", DKHTMLElementDUK::showPopover);
		
		// undefined hidePopover();
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_hidePopover", DKHTMLElementDUK::hidePopover);
		
		// undefined togglePopover(optional boolean force);
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_togglePopover", DKHTMLElementDUK::togglePopover);
		
		// [CEReactions] attribute DOMString? popover;
		//DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_popover", DKHTMLElementDUK::popover);
	//};
	
		// HTMLElement includes GlobalEventHandlers;
		// HTMLElement includes ElementContentEditable;
		// HTMLElement includes HTMLOrSVGElement;
		
		// [Exposed=Window]
		// interface HTMLUnknownElement : HTMLElement {
			// Note: intentionally no [HTMLConstructor]
		// };
	
	
		////// Load .js files //////
		DKClass::DKCreate("DKHTMLElement/DKHTMLElementDUK.js");
		
		return true;
	}
	
	static DKHTMLElement* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKHTMLElement*)addressToPointer(eventTargetAddress);
	}

	// [HTMLConstructor] constructor();
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKHTMLElementDUK()\n");
		DKHTMLElement* _htmlelement = new DKHTMLElement();
		DKString eventTargetAddress = pointerToAddress(_htmlelement);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	// metadata attributes
	// [CEReactions] attribute DOMString title;
	// TODO
	
	// [CEReactions] attribute DOMString lang;
	// TODO
	
	// [CEReactions] attribute boolean translate;
	// TODO
	
	// [CEReactions] attribute DOMString dir;
	// TODO
	
	// user interaction
	// [CEReactions] attribute (boolean or unrestricted double or DOMString)? hidden;
	// TODO
	
	// [CEReactions] attribute boolean inert;
	// TODO
	
	// undefined click();
	// TODO
	
	// [CEReactions] attribute DOMString accessKey;
	// TODO
	
	// readonly attribute DOMString accessKeyLabel;
	// TODO
	
	// [CEReactions] attribute boolean draggable;
	// TODO
	
	// [CEReactions] attribute boolean spellcheck;
	// TODO
	
	// [CEReactions] attribute DOMString autocapitalize;
	// TODO
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerText;
	// TODO
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString outerText;
	// TODO
	
	// ElementInternals attachInternals();
	// TODO
	
	// The popover API
	// undefined showPopover();
	// TODO
	
	// undefined hidePopover();
	// TODO
	
	// undefined togglePopover(optional boolean force);
	// TODO
	
	// [CEReactions] attribute DOMString? popover;
	// TODO
	
//};

	// HTMLElement includes GlobalEventHandlers;
	// HTMLElement includes ElementContentEditable;
	// HTMLElement includes HTMLOrSVGElement;
	
	// [Exposed=Window]
	// interface HTMLUnknownElement : HTMLElement {
		// Note: intentionally no [HTMLConstructor]
	// };	
};
REGISTER_OBJECT(DKHTMLElementDUK, true)


#endif //DKHTMLElementDUK_H
#endif //HAVE_DKDuktape