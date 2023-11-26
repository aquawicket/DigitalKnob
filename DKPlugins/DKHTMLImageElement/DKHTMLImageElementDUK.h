// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlimageelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement
#if HAVE_DKDuktape

#pragma once
#ifndef DKHTMLImageElementDUK_H
#define DKHTMLImageElementDUK_H

#include "DKDuktape/DKDuktape.h"


// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Exposed=Window,
// LegacyFactoryFunction=Image(optional unsigned long width, optional unsigned long height)]
// interface HTMLImageElement : HTMLElement {
class DKHTMLImageElementDUK : public DKObjectT<DKHTMLImageElementDUK>
{
public:
	bool Init(){
		
		// [HTMLConstructor] constructor();
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_constructor", 		DKHTMLImageElementDUK::constructor);

		// [CEReactions] attribute DOMString alt;
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_alt", 				DKHTMLImageElementDUK::alt);
		
		// [CEReactions] attribute USVString src;
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_src", 				DKHTMLImageElementDUK::src);
		
		// [CEReactions] attribute USVString srcset;
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_srcset", 			DKHTMLImageElementDUK::srcset);
		
		// [CEReactions] attribute DOMString sizes;
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_sizes", 			DKHTMLImageElementDUK::sizes);
		
		// [CEReactions] attribute DOMString? crossOrigin;
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_crossOrigin", 		DKHTMLImageElementDUK::crossOrigin);
		
		// [CEReactions] attribute DOMString useMap;
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_useMap", 			DKHTMLImageElementDUK::useMap);
		
		// [CEReactions] attribute boolean isMap;
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_isMap", 			DKHTMLImageElementDUK::isMap);
		
		// [CEReactions] attribute unsigned long width;
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_width", 			DKHTMLImageElementDUK::width);
		
		// [CEReactions] attribute unsigned long height;
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_height", 			DKHTMLImageElementDUK::height);
		
		// readonly attribute unsigned long naturalWidth;
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_naturalWidth", 	DKHTMLImageElementDUK::naturalWidth);
		
		// readonly attribute unsigned long naturalHeight;
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_naturalHeight", 	DKHTMLImageElementDUK::naturalHeight);
		
		// readonly attribute boolean complete;
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_complete", 		DKHTMLImageElementDUK::complete);
		
		// readonly attribute USVString currentSrc;
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_currentSrc", 		DKHTMLImageElementDUK::currentSrc);
		
		// [CEReactions] attribute DOMString referrerPolicy;
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_referrerPolicy", 	DKHTMLImageElementDUK::referrerPolicy);
		
		// [CEReactions] attribute DOMString decoding;
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_decoding", 		DKHTMLImageElementDUK::decoding);
		
		// [CEReactions] attribute DOMString loading;
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_loading", 			DKHTMLImageElementDUK::loading);
		
		// [CEReactions] attribute DOMString fetchPriority;
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_fetchPriority", 	DKHTMLImageElementDUK::fetchPriority);
		
		// Promise<undefined> decode();
		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_decode", 			DKHTMLImageElementDUK::decode);
		
		// also has obsolete members
		//};

		// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
		// partial interface HTMLImageElement {
			// [CEReactions] attribute DOMString name;
			DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_name", 		DKHTMLImageElementDUK::name);
		
			// [CEReactions] attribute USVString lowsrc;
			DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_lowsrc", 		DKHTMLImageElementDUK::lowsrc);
		
			// [CEReactions] attribute DOMString align;
			DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_align", 		DKHTMLImageElementDUK::align);
			
			// [CEReactions] attribute unsigned long hspace;
			DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_hspace", 		DKHTMLImageElementDUK::hspace);
			
			// [CEReactions] attribute unsigned long vspace;
			DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_vspace", 		DKHTMLImageElementDUK::vspace);
			
			// [CEReactions] attribute USVString longDesc;
			DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_longDesc", 	DKHTMLImageElementDUK::longDesc);
			
			// [CEReactions] attribute [LegacyNullToEmptyString] DOMString border;
			DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_border", 		DKHTMLImageElementDUK::border);
		// };

		// Source: Attribution Reporting (https://wicg.github.io/attribution-reporting-api/)
		// HTMLImageElement includes HTMLAttributionSrcElementUtils;
		
		// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
		// partial interface HTMLImageElement {
			// readonly attribute long x;
			DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_x", 		DKHTMLImageElementDUK::x);
			
			// readonly attribute long y;
			DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK_y", 		DKHTMLImageElementDUK::y);
		//};
		
		
		////// Load .js files //////
		DKClass::DKCreate("DKHTMLImageElement/DKHTMLImageElementDUK.js");
		
		return true;
	}
	
	static DKHTMLImageElement* eventTarget(duk_context* ctx){
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKHTMLImageElement*)addressToPointer(eventTargetAddress);
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
		
		DKINFO("CPP_DKHTMLImageElementDUK_constructor()\n");
		DKHTMLImageElement* _htmlImageElement = new DKHTMLImageElement();
		dukglue_push(ctx, _htmlImageElement->interfaceAddress);
		return true;
	}
	
	// [CEReactions] attribute DOMString alt;
	static int alt(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->alt(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->alt());
		return true;
	}
	
	// [CEReactions] attribute USVString src;
	static int src(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->src(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->src());
		return true;
	}
	
	// [CEReactions] attribute USVString srcset;
	static int srcset(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->srcset(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->srcset());
		return true;
	}
	
	// [CEReactions] attribute DOMString sizes;
	static int sizes(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->sizes(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->sizes());
		return true;
	}
	
	// [CEReactions] attribute DOMString? crossOrigin;
	static int crossOrigin(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->crossOrigin(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->crossOrigin());
		return true;
	}
	
	// [CEReactions] attribute DOMString useMap;
	static int useMap(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->useMap(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->useMap());
		return true;
	}
	
	// [CEReactions] attribute boolean isMap;
	static int isMap(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->isMap(GetBool(ctx));
		dukglue_push(ctx, eventTarget(ctx)->isMap());
		return true;
	}
	
	// [CEReactions] attribute unsigned long width;
	static int width(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->width(GetUint(ctx));
		dukglue_push(ctx, eventTarget(ctx)->width());
		return true;
	}
	
	// [CEReactions] attribute unsigned long height;
	static int height(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->height(GetUint(ctx));
		dukglue_push(ctx, eventTarget(ctx)->height());
		return true;
	}
	
	// readonly attribute unsigned long naturalWidth;
	static int naturalWidth(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->naturalWidth(GetUint(ctx));
		dukglue_push(ctx, eventTarget(ctx)->naturalWidth());
		return true;
	}
	
	// readonly attribute unsigned long naturalHeight;
	static int naturalHeight(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->naturalHeight(GetUint(ctx));
		dukglue_push(ctx, eventTarget(ctx)->naturalHeight());
		return true;
	}
	
	// readonly attribute boolean complete;
	static int complete(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->complete(GetBool(ctx));
		dukglue_push(ctx, eventTarget(ctx)->complete());
		return true;
	}
	
	// readonly attribute USVString currentSrc;
	static int currentSrc(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->currentSrc(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->currentSrc());
		return true;
	}
	
	// [CEReactions] attribute DOMString referrerPolicy;
	static int referrerPolicy(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->referrerPolicy(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->referrerPolicy());
		return true;
	}
	
	// [CEReactions] attribute DOMString decoding;
	static int decoding(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->decoding(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->decoding());
		return true;
	}
	
	// [CEReactions] attribute DOMString loading;
	static int loading(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->loading(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->loading());
		return true;
	}
	
	// [CEReactions] attribute DOMString fetchPriority;
	static int fetchPriority(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->fetchPriority(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->fetchPriority());
		return true;
	}
	
	// Promise<undefined> decode();
	static int decode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// also has obsolete members
	//};
	
	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// partial interface HTMLImageElement {
	// [CEReactions] attribute DOMString name;
	static int name(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->name(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->name());
		return true;
	}
	
	// [CEReactions] attribute USVString lowsrc;
	static int lowsrc(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->lowsrc(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->lowsrc());
		return true;
	}
	
	// [CEReactions] attribute DOMString align;
	static int align(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->align(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->align());
		return true;
	}
	
	// [CEReactions] attribute unsigned long hspace;
	static int hspace(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->hspace(GetUint(ctx));
		dukglue_push(ctx, eventTarget(ctx)->hspace());
		return true;
	}
	
	// [CEReactions] attribute unsigned long vspace;
	static int vspace(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->vspace(GetUint(ctx));
		dukglue_push(ctx, eventTarget(ctx)->vspace());
		return true;
	}
	
	// [CEReactions] attribute USVString longDesc;
	static int longDesc(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->longDesc(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->longDesc());
		return true;
	}
	
	// [CEReactions] attribute [LegacyNullToEmptyString] DOMString border;
	static int border(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->border(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->border());
		return true;
	}
	// };
	
	// Source: Attribution Reporting (https://wicg.github.io/attribution-reporting-api/)
	// HTMLImageElement includes HTMLAttributionSrcElementUtils;

	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface HTMLImageElement {
		// readonly attribute long x;
		static int x(duk_context* ctx){
			DKDEBUGFUNC(ctx);
			if(duk_is_valid_index(ctx, 1))
				eventTarget(ctx)->x(GetInt(ctx));
			dukglue_push(ctx, eventTarget(ctx)->x());
			return true;
		}
		
		// readonly attribute long y;
		static int y(duk_context* ctx){
			DKDEBUGFUNC(ctx);
			if(duk_is_valid_index(ctx, 1))
				eventTarget(ctx)->y(GetInt(ctx));
			dukglue_push(ctx, eventTarget(ctx)->y());
			return true;
		}
	//};
	
};
REGISTER_OBJECT(DKHTMLImageElementDUK, true)


#endif //DKHTMLImageElementDUK_H
#endif //HAVE_DKDuktape