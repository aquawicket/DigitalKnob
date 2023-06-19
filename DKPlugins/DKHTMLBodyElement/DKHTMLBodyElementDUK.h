// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLBodyElement
#if HAVE_DKDuktape

#pragma once
#ifndef DKHTMLBodyElementDUK_H
#define DKHTMLBodyElementDUK_H

#include "DKDuktape/DKDuktape.h"



class DKHTMLBodyElementDUK : public DKObjectT<DKHTMLBodyElementDUK>
{
public:
	bool Init(){
		// [Exposed=Window]
		// interface HTMLBodyElement : HTMLElement {
			// [HTMLConstructor] constructor();
			DKDuktape::AttachFunction("CPP_DKHTMLBodyElementDUK_constructor", 			DKHTMLBodyElementDUK::constructor);
			
			//	 also has obsolete members
		//};
			
		// partial interface HTMLBodyElement {
			// attribute EventHandler onorientationchange;
			DKDuktape::AttachFunction("CPP_DKHTMLBodyElementDUK_onorientationchange", 	DKHTMLBodyElementDUK::onorientationchange);
		// };

		// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
		// HTMLBodyElement includes WindowEventHandlers;
			
		// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
		// partial interface HTMLBodyElement {
			// [CEReactions] attribute [LegacyNullToEmptyString] DOMString text;
			DKDuktape::AttachFunction("CPP_DKHTMLBodyElementDUK_text", 					DKHTMLBodyElementDUK::text);

			// [CEReactions] attribute [LegacyNullToEmptyString] DOMString link;
			DKDuktape::AttachFunction("CPP_DKHTMLBodyElementDUK_link", 					DKHTMLBodyElementDUK::link);

			// [CEReactions] attribute [LegacyNullToEmptyString] DOMString vLink;
			DKDuktape::AttachFunction("CPP_DKHTMLBodyElementDUK_vLink", 				DKHTMLBodyElementDUK::vLink);

			// [CEReactions] attribute [LegacyNullToEmptyString] DOMString aLink;
			DKDuktape::AttachFunction("CPP_DKHTMLBodyElementDUK_aLink", 				DKHTMLBodyElementDUK::aLink);

			// [CEReactions] attribute [LegacyNullToEmptyString] DOMString bgColor;
			DKDuktape::AttachFunction("CPP_DKHTMLBodyElementDUK_bgColor", 				DKHTMLBodyElementDUK::bgColor);

			// [CEReactions] attribute DOMString background;
			DKDuktape::AttachFunction("CPP_DKHTMLBodyElementDUK_background", 			DKHTMLBodyElementDUK::background);
		// };


		////// Load .js files //////
		DKClass::DKCreate("DKHTMLBodyElement/DKHTMLBodyElementDUK.js");
		
		return true;
	}
	
	static DKHTMLBodyElement* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKHTMLBodyElement*)addressToPointer(eventTargetAddress);
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
		DKINFO("CPP_DKHTMLBodyElementDUK_constructor()\n");
		DKHTMLBodyElement* _htmlBodyElement = new DKHTMLBodyElement();
		DKString eventTargetAddress = pointerToAddress(_htmlBodyElement);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	// attribute EventHandler onorientationchange;
	static int onorientationchange(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->onorientationchange(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->onorientationchange());
		return true;
	}
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString text;
	static int text(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->text(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->text());
		return true;
	}
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString link;
	static int link(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->link(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->link());
		return true;
	}
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString vLink;
	static int vLink(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->vLink(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->vLink());
		return true;
	}
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString aLink;
	static int aLink(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->aLink(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->aLink());
		return true;
	}
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString bgColor;
	static int bgColor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->bgColor(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->bgColor());
		return true;
	}
	
	// [CEReactions] attribute DOMString background;
	static int background(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->background(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->background());
		return true;
	}
		
};
REGISTER_OBJECT(DKHTMLBodyElementDUK, true)


#endif //DKHTMLBodyElementDUK_H
#endif //HAVE_DKDuktape