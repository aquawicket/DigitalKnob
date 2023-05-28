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
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK", 					DKHTMLElementDUK::constructor);
		
		// metadata attributes
		// [CEReactions] attribute DOMString title;
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_title", 			DKHTMLElementDUK::title);

		// [CEReactions] attribute DOMString lang;
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_title", 			DKHTMLElementDUK::title);
		
		// [CEReactions] attribute boolean translate;
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_translate", 		DKHTMLElementDUK::translate);
		
		// [CEReactions] attribute DOMString dir;
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_dir",				DKHTMLElementDUK::dir);
		
		// user interaction
		// [CEReactions] attribute (boolean or unrestricted double or DOMString)? hidden;
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_hidden", 			DKHTMLElementDUK::hidden);
	
		// [CEReactions] attribute boolean inert;
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_inert",				DKHTMLElementDUK::inert);
		
		// undefined click();
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_click", 			DKHTMLElementDUK::click);
		
		// [CEReactions] attribute DOMString accessKey;
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_accessKey", 		DKHTMLElementDUK::accessKey);
		
		// readonly attribute DOMString accessKeyLabel;
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_accessKeyLabel", 	DKHTMLElementDUK::accessKeyLabel);
		
		// [CEReactions] attribute boolean draggable;
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_draggable", 		DKHTMLElementDUK::draggable);
		
		// [CEReactions] attribute boolean spellcheck;
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_spellcheck", 		DKHTMLElementDUK::spellcheck);
		
		// [CEReactions] attribute DOMString autocapitalize;
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_autocapitalize", 	DKHTMLElementDUK::autocapitalize);
		
		// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerText;
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_innerText", 		DKHTMLElementDUK::innerText);
		
		// [CEReactions] attribute [LegacyNullToEmptyString] DOMString outerText;
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_outerText", 		DKHTMLElementDUK::outerText);
		
		// ElementInternals attachInternals();
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_attachInternals", 	DKHTMLElementDUK::attachInternals);
		
		// The popover API
		// undefined showPopover();
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_showPopover", 		DKHTMLElementDUK::showPopover);
		
		// undefined hidePopover();
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_hidePopover", 		DKHTMLElementDUK::hidePopover);
		
		// undefined togglePopover(optional boolean force);
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_togglePopover", 	DKHTMLElementDUK::togglePopover);
		
		// [CEReactions] attribute DOMString? popover;
		DKDuktape::AttachFunction("CPP_DKHTMLElementDUK_popover", 			DKHTMLElementDUK::popover);
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
	static bool GetBool(duk_context* ctx, int index = 1){
		if (duk_is_boolean(ctx, index))
			return duk_to_boolean(ctx, index);
		return false;
	}
	static double GetDouble(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_number(ctx, index);
		return 0.0;
	}
	static int GetInt(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_int(ctx, index);
		return 0;
	}
	static DKString GetString(duk_context* ctx, int index = 1){
		if (duk_is_string(ctx, index))
			return duk_to_string(ctx, index);
		return "";
	}
	static unsigned int GetUint(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_uint(ctx, index);
		return 0;
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
	static int title(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->title(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->title());
		return true;
	}
	
	// [CEReactions] attribute DOMString lang;
	static int lang(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->lang(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->lang());
		return true;
	}
	
	// [CEReactions] attribute boolean translate;
	static int translate(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->translate(GetBool(ctx));
		dukglue_push(ctx, eventTarget(ctx)->translate());
		return true;
	}
	
	// [CEReactions] attribute DOMString dir;
	static int dir(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->dir(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->dir());
		return true;
	}
	
	// user interaction
	// [CEReactions] attribute (boolean or unrestricted double or DOMString)? hidden;
	static int hidden(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->hidden(GetBool(ctx));
		dukglue_push(ctx, eventTarget(ctx)->hidden());
		return true;
	}
	
	// [CEReactions] attribute boolean inert;
	static int inert(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->inert(GetBool(ctx));
		dukglue_push(ctx, eventTarget(ctx)->inert());
		return true;
	}
	
	// undefined click();
	static int click(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// [CEReactions] attribute DOMString accessKey;
	static int accessKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->accessKey(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->accessKey());
		return true;
	}
	
	// readonly attribute DOMString accessKeyLabel;
	static int accessKeyLabel(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->accessKeyLabel(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->accessKeyLabel());
		return true;
	}
	
	// [CEReactions] attribute boolean draggable;
	static int draggable(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->draggable(GetBool(ctx));
		dukglue_push(ctx, eventTarget(ctx)->draggable());
		return true;
	}
	
	// [CEReactions] attribute boolean spellcheck;
	static int spellcheck(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->spellcheck(GetBool(ctx));
		dukglue_push(ctx, eventTarget(ctx)->spellcheck());
		return true;
	}
	
	// [CEReactions] attribute DOMString autocapitalize;
	static int autocapitalize(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->autocapitalize(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->autocapitalize());
		return true;
	}
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerText;
	static int innerText(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->innerText(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->innerText());
		return true;
	}
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString outerText;
	static int outerText(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->outerText(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->outerText());
		return true;
	}
	
	// ElementInternals attachInternals();
	static int attachInternals(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// The popover API
	// undefined showPopover();
	static int showPopover(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// undefined hidePopover();
	static int hidePopover(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// undefined togglePopover(optional boolean force);
	static int togglePopover(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// [CEReactions] attribute DOMString? popover;
	static int popover(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->popover(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->popover());
		return true;
	}
	
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