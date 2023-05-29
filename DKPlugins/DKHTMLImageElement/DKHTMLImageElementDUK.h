// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlimageelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement
#if HAVE_DKDuktape

#pragma once
#ifndef DKHTMLImageElementDUK_H
#define DKHTMLImageElementDUK_H

#include "DKDuktape/DKDuktape.h"


class DKHTMLImageElementDUK : public DKObjectT<DKHTMLImageElementDUK>
{
public:
	bool Init(){

		DKDuktape::AttachFunction("CPP_DKHTMLImageElementDUK", DKHTMLImageElementDUK::constructor);

		// TODO

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

	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKHTMLImageElementDUK()\n");
		DKHTMLImageElement* htmlImageElement = new DKHTMLImageElement();
		DKString eventTargetAddress = pointerToAddress(htmlImageElement);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	// TODO
		
};
REGISTER_OBJECT(DKHTMLImageElementDUK, true)


#endif //DKHTMLImageElementDUK_H
#endif //HAVE_DKDuktape